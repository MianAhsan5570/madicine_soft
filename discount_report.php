<!DOCTYPE html>
<html lang="en">
<?php include_once 'includes/head.php'; ?>

<style type="text/css">
    @media print {
        .d-print-none {
            display: none !important;
        }

        body {
            background: white;
            margin: 0;
        }

        .card {
            border: none;
            box-shadow: none;
        }

        @page {
            size: A4 landscape;
            margin: 8mm;
        }

        .table {
            font-size: 9px !important;
            width: 100%;
        }

        .table th,
        .table td {
            padding: 3px 5px !important;
            font-size: 9px !important;
            line-height: 1.2;
        }

        .total-row td {
            font-size: 11px !important;
        }

        .header-company {
            font-size: 20px !important;
        }

        .header-title {
            font-size: 15px !important;
        }

        .header-subtitle {
            font-size: 13px !important;
        }

        tr {
            page-break-inside: avoid;
        }

        thead {
            display: table-header-group;
            /* Keep this to repeat headers on every page */
        }

        tfoot {
            display: table-row-group;
            /* Change from table-footer-group to table-row-group */
        }

        /* Ensure the footer doesn't get split across pages awkwardly */
        tfoot tr {
            page-break-inside: avoid;
            page-break-after: auto;
        }
    }

    thead tr th {
        font-size: 15px !important;
        font-weight: bold !important;
        color: #000 !important;
        background-color: #f8f9fa !important;
        text-align: center;
        vertical-align: middle;
        padding: 8px 6px !important;
        white-space: nowrap;
    }

    tbody tr td {
        font-size: 14px !important;
        vertical-align: middle;
        color: #000 !important;
        padding: 6px !important;
    }

    .total-row td {
        font-weight: bold !important;
        font-size: 15px !important;
        background-color: #f1f3f5 !important;
    }

    .text-right {
        text-align: right !important;
    }

    .text-center {
        text-align: center !important;
    }

    .text-left {
        text-align: left !important;
    }

    .badge-return {
        background: #dc3545;
        color: #fff;
        padding: 2px 6px;
        border-radius: 4px;
        font-size: 11px;
    }

    .badge-sale {
        background: #198754;
        color: #fff;
        padding: 2px 6px;
        border-radius: 4px;
        font-size: 11px;
    }

    .summary-box {
        border: 1px solid #dee2e6;
        border-radius: 8px;
        padding: 14px 20px;
        margin-bottom: 16px;
        background: #fdfdfd;
    }

    .summary-box h6 {
        font-size: 13px;
        color: #6c757d;
        margin-bottom: 4px;
    }

    .summary-box .val {
        font-size: 20px;
        font-weight: bold;
    }

    .highlight-neg {
        color: #dc3545 !important;
    }

    .highlight-pos {
        color: #198754 !important;
    }
</style>

<body class="horizontal light">
    <div class="wrapper">
        <?php include_once 'includes/header.php'; ?>

        <main role="main" class="main-content">
            <div class="container-fluid">

                <!-- ========== FILTER CARD ========== -->
                <div class="card d-print-none">
                    <div class="card-header card-bg text-center">
                        <h4 style="color:white"><b>Sales Summary Report (with Discounts, Bonus & Returns)</b></h4>
                    </div>
                    <div class="card-body">
                        <form method="post">
                            <div class="row align-items-end">
                                <div class="col-sm-4 col-md-3">
                                    <label>From Date <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" name="from_date"
                                        value="<?= isset($_POST['from_date']) ? htmlspecialchars($_POST['from_date']) : '' ?>"
                                        required>
                                </div>
                                <div class="col-sm-4 col-md-3">
                                    <label>To Date <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" name="to_date"
                                        value="<?= isset($_POST['to_date']) ? htmlspecialchars($_POST['to_date']) : '' ?>"
                                        required>
                                </div>
                                <div class="col-sm-4 col-md-3">
                                    <label style="visibility:hidden;">Search</label><br>
                                    <button type="submit" name="show_details" class="btn btn-danger">Show
                                        Details</button>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-12">
                                    <small class="text-muted">
                                        Shows sales + returns in the selected date range.<br>
                                        <strong>Discount 1:</strong> Order-level discount % &nbsp;|&nbsp;
                                        <strong>Discount 2:</strong> Item-level discount % &nbsp;|&nbsp;
                                        <strong>Bonus:</strong> Free units given &nbsp;|&nbsp;
                                        <strong>Returns:</strong> Deducted from net figures.
                                    </small>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- ========== REPORT ========== -->
                <?php if (isset($_POST['show_details'])): ?>
                    <?php
                    $from_date = $_POST['from_date'];
                    $to_date = $_POST['to_date'];

                    if (strtotime($from_date) > strtotime($to_date)):
                        ?>
                        <div class="alert alert-danger mt-4">From date cannot be greater than To date.</div>
                    <?php else: ?>

                        <?php
                        /* ====================== 1. SALES ====================== */
                        $sql_sales = "SELECT 
                        o.order_id, o.order_date, o.bill_no, o.client_name, o.customer_account,
                        CAST(NULLIF(TRIM(o.discount),'') AS DECIMAL(15,4)) AS order_discount_pct,
                        o.grand_total,

                        SUM(oi.quantity) AS sale_qty,
                        SUM(oi.bonus_qty) AS bonus_qty,
                        SUM(oi.quantity + oi.bonus_qty) AS effective_qty,
                        SUM(oi.total) AS item_subtotal,                    /* After item discount */
                        
                        SUM(
                            CASE 
                                WHEN oi.discount IS NOT NULL AND oi.discount != '' AND oi.discount != '0' 
                                THEN (oi.quantity * oi.rate) * (CAST(oi.discount AS DECIMAL(10,4)) / 100)
                                ELSE 0 
                            END
                        ) AS item_discount_amount,

                        SUM(oi.bonus_qty * oi.rate) AS bonus_value

                    FROM orders o 
                    INNER JOIN order_item oi ON oi.order_id = o.order_id 
                    WHERE o.order_date BETWEEN '$from_date' AND '$to_date'
                      AND o.order_status = '1' 
                      AND oi.order_item_status = 1 
                    GROUP BY o.order_id, o.order_date, o.bill_no, o.client_name, 
                             o.customer_account, o.discount, o.grand_total
                    ORDER BY o.order_date ASC, o.order_id ASC";

                        $result_sales = $connect->query($sql_sales);

                        $sales_rows = [];
                        $g_sale_qty = $g_bonus_qty = $g_eff_qty = 0;
                        $g_item_subtotal = 0;
                        $g_order_disc = 0;
                        $g_item_disc = 0;
                        $g_bonus_val = 0;
                        $g_net_sale = 0;

                        if ($result_sales) {
                            while ($r = $result_sales->fetch_assoc()) {
                                $o_disc_pct = (float) ($r['order_discount_pct'] ?? 0);
                                $o_disc_amt = ($o_disc_pct > 0)
                                    ? round((float) $r['item_subtotal'] * $o_disc_pct / 100, 2)
                                    : 0;

                                $r['order_discount_amount'] = $o_disc_amt;

                                $sales_rows[] = $r;

                                $g_sale_qty += (float) $r['sale_qty'];
                                $g_bonus_qty += (float) $r['bonus_qty'];
                                $g_eff_qty += (float) $r['effective_qty'];
                                $g_item_subtotal += (float) $r['item_subtotal'];
                                $g_order_disc += $o_disc_amt;
                                $g_item_disc += (float) $r['item_discount_amount'];
                                $g_bonus_val += (float) $r['bonus_value'];
                                $g_net_sale += (float) $r['grand_total'];
                            }
                        }

                        /* ====================== 2. RETURNS ====================== */
                        $sql_returns = "SELECT 
                        r.order_id, r.order_date, r.bill_no, r.client_name, r.customer_account,
                        CAST(NULLIF(TRIM(r.discount),'') AS DECIMAL(15,4)) AS order_discount_pct,
                        r.grand_total,

                        SUM(ri.quantity) AS sale_qty,
                        SUM(ri.bonus_qty) AS bonus_qty,
                        SUM(ri.quantity + ri.bonus_qty) AS effective_qty,
                        SUM(ri.total) AS item_subtotal,

                        SUM(
                            CASE 
                                WHEN ri.discount IS NOT NULL AND ri.discount != '' AND ri.discount != '0' 
                                THEN (ri.quantity * ri.rate) * (CAST(ri.discount AS DECIMAL(10,4)) / 100)
                                ELSE 0 
                            END
                        ) AS item_discount_amount,

                        SUM(ri.bonus_qty * ri.rate) AS bonus_value

                    FROM orders_return r 
                    INNER JOIN order_return_item ri ON ri.order_id = r.order_id 
                    WHERE r.order_date BETWEEN '$from_date' AND '$to_date'
                      AND r.order_status = '1' 
                      AND ri.order_item_status = 1 
                    GROUP BY r.order_id, r.order_date, r.bill_no, r.client_name, 
                             r.customer_account, r.discount, r.grand_total
                    ORDER BY r.order_date ASC, r.order_id ASC";

                        $result_returns = $connect->query($sql_returns);

                        $return_rows = [];
                        $r_sale_qty = $r_bonus_qty = $r_eff_qty = 0;
                        $r_item_subtotal = 0;
                        $r_order_disc = 0;
                        $r_item_disc = 0;
                        $r_bonus_val = 0;
                        $r_net_return = 0;

                        if ($result_returns) {
                            while ($r = $result_returns->fetch_assoc()) {
                                $o_disc_pct = (float) ($r['order_discount_pct'] ?? 0);
                                $o_disc_amt = ($o_disc_pct > 0)
                                    ? round((float) $r['item_subtotal'] * $o_disc_pct / 100, 2)
                                    : 0;

                                $r['order_discount_amount'] = $o_disc_amt;

                                $return_rows[] = $r;

                                $r_sale_qty += (float) $r['sale_qty'];
                                $r_bonus_qty += (float) $r['bonus_qty'];
                                $r_eff_qty += (float) $r['effective_qty'];
                                $r_item_subtotal += (float) $r['item_subtotal'];
                                $r_order_disc += $o_disc_amt;
                                $r_item_disc += (float) $r['item_discount_amount'];
                                $r_bonus_val += (float) $r['bonus_value'];
                                $r_net_return += (float) $r['grand_total'];
                            }
                        }

                        /* Net Figures */
                        $net_qty = $g_eff_qty - $r_eff_qty;
                        $net_amount = $g_item_subtotal - $r_item_subtotal;
                        $net_disc = ($g_order_disc + $g_item_disc) - ($r_order_disc + $r_item_disc);
                        $net_bonus_val = $g_bonus_val - $r_bonus_val;
                        $net_grand = $g_net_sale - $r_net_return;
                        ?>

                        <!-- ===== REPORT CARD ===== -->
                        <div class="card mt-4 position-relative">
                            <div class="card-header d-flex justify-content-between align-items-center pt-4"
                                style="background-color:#343a40; color:white;">
                                <div style="width: 80px;" class="d-print-none"></div>

                                <div class="text-center">
                                    <div class="header-company">AMG</div>
                                    <div class="header-title">Sales Summary Report</div>
                                    <div class="header-subtitle">
                                        From <?= date('d/m/Y', strtotime($from_date)) ?> To
                                        <?= date('d/m/Y', strtotime($to_date)) ?>
                                    </div>
                                </div>

                                <div class="d-print-none" style="width: 80px; text-align: right;">
                                    <button onclick="window.print()" class="btn btn-light btn-sm">🖨 Print</button>
                                </div>
                            </div>

                            <div class="card-body">

                                <!-- ===== SUMMARY BOXES ===== -->
                                <div class="row d-print-none mb-4">
                                    <div class="col-6 col-md-2">
                                        <div class="summary-box">
                                            <h6>Gross Sales</h6>
                                            <div class="val highlight-pos"><?= number_format($g_net_sale, 2) ?></div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-md-2">
                                        <div class="summary-box">
                                            <h6>Total Returns</h6>
                                            <div class="val highlight-neg">-<?= number_format($r_net_return, 2) ?></div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-md-2">
                                        <div class="summary-box">
                                            <h6>Net Sales</h6>
                                            <div class="val"><?= number_format($net_grand, 2) ?></div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-md-2">
                                        <div class="summary-box">
                                            <h6>Total Discounts</h6>
                                            <div class="val highlight-neg"><?= number_format($g_order_disc + $g_item_disc, 2) ?>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-md-2">
                                        <div class="summary-box">
                                            <h6>Bonus Qty</h6>
                                            <div class="val"><?= number_format($g_bonus_qty, 0) ?></div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-md-2">
                                        <div class="summary-box">
                                            <h6>Bonus Value</h6>
                                            <div class="val"><?= number_format($g_bonus_val, 2) ?></div>
                                        </div>
                                    </div>
                                </div>

                                <!-- ===== DETAIL TABLE ===== -->
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Type</th>
                                                <th>Date</th>
                                                <th>Bill No</th>
                                                <th>Customer</th>
                                                <th>Sale Qty</th>
                                                <th>Bonus Qty</th>
                                                <th>Eff. Qty<br><small>(Sale+Bonus)</small></th>
                                                <th>Item Total<br><small>(after item disc)</small></th>
                                                <th>Order Disc.<br><small>(% of order)</small></th>
                                                <th>Item Disc.<br><small>(% per item)</small></th>
                                                <th>Total Disc.</th>
                                                <th>Bonus Value</th>
                                                <th>Grand Total<br><small>(invoiced)</small></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                            function renderRow($idx, $row, $type)
                                            {
                                                $is_return = ($type === 'return');
                                                $badge = $is_return ? '<span class="badge-return">RETURN</span>' : '<span class="badge-sale">SALE</span>';
                                                $sign = $is_return ? '-' : '';

                                                $o_disc_pct = (float) ($row['order_discount_pct'] ?? 0);
                                                $o_disc = (float) ($row['order_discount_amount'] ?? 0);
                                                $i_disc = (float) $row['item_discount_amount'];
                                                $t_disc = $o_disc + $i_disc;

                                                $o_disc_display = $o_disc_pct > 0
                                                    ? "<small class='text-muted'>{$o_disc_pct}%</small><br>{$sign}" . number_format($o_disc, 2)
                                                    : "0.00";

                                                $i_disc_pct_display = ($row['item_subtotal'] > 0 && $i_disc > 0)
                                                    ? "<small class='text-muted'>" . number_format($i_disc / $row['item_subtotal'] * 100, 2) . "%</small><br>{$sign}" . number_format($i_disc, 2)
                                                    : "0.00";

                                                echo "<tr class='" . ($is_return ? 'table-danger' : '') . "'>";
                                                echo "<td class='text-center'>{$idx}</td>";
                                                echo "<td class='text-center'>{$badge}</td>";
                                                echo "<td class='text-center'>" . date('d/m/Y', strtotime($row['order_date'])) . "</td>";
                                                echo "<td class='text-center'>" . htmlspecialchars($row['bill_no'] ?: '—') . "</td>";
                                                echo "<td>" . htmlspecialchars($row['client_name']) . "</td>";
                                                echo "<td class='text-right'>{$sign}" . number_format($row['sale_qty'], 0) . "</td>";
                                                echo "<td class='text-right'>{$sign}" . number_format($row['bonus_qty'], 0) . "</td>";
                                                echo "<td class='text-right'><strong>{$sign}" . number_format($row['effective_qty'], 0) . "</strong></td>";
                                                echo "<td class='text-right'>{$sign}" . number_format($row['item_subtotal'], 2) . "</td>";
                                                echo "<td class='text-right highlight-neg'>{$o_disc_display}</td>";
                                                echo "<td class='text-right highlight-neg'>{$i_disc_pct_display}</td>";
                                                echo "<td class='text-right highlight-neg'><strong>{$sign}" . number_format($t_disc, 2) . "</strong></td>";
                                                echo "<td class='text-right'>{$sign}" . number_format($row['bonus_value'], 2) . "</td>";
                                                echo "<td class='text-right'><strong>{$sign}" . number_format($row['grand_total'], 2) . "</strong></td>";
                                                echo "</tr>";
                                            }

                                            $idx = 1;

                                            if (empty($sales_rows) && empty($return_rows)) {
                                                echo '<tr><td colspan="14" class="text-center text-muted py-4">No records found for the selected date range.</td></tr>';
                                            } else {
                                                foreach ($sales_rows as $row) {
                                                    renderRow($idx++, $row, 'sale');
                                                }
                                                foreach ($return_rows as $row) {
                                                    renderRow($idx++, $row, 'return');
                                                }
                                            }
                                            ?>
                                        </tbody>

                                        <?php if (!empty($sales_rows) || !empty($return_rows)): ?>
                                            <tfoot>
                                                <!-- Sales Total -->
                                                <tr class="total-row" style="background:#d4edda!important;">
                                                    <td colspan="5"><strong>Sales Total</strong></td>
                                                    <td class="text-right"><?= number_format($g_sale_qty, 0) ?></td>
                                                    <td class="text-right"><?= number_format($g_bonus_qty, 0) ?></td>
                                                    <td class="text-right"><strong><?= number_format($g_eff_qty, 0) ?></strong></td>
                                                    <td class="text-right"><?= number_format($g_item_subtotal, 2) ?></td>
                                                    <td class="text-right highlight-neg"><?= number_format($g_order_disc, 2) ?></td>
                                                    <td class="text-right highlight-neg"><?= number_format($g_item_disc, 2) ?></td>
                                                    <td class="text-right highlight-neg">
                                                        <strong><?= number_format($g_order_disc + $g_item_disc, 2) ?></strong>
                                                    </td>
                                                    <td class="text-right"><?= number_format($g_bonus_val, 2) ?></td>
                                                    <td class="text-right"><strong><?= number_format($g_net_sale, 2) ?></strong>
                                                    </td>
                                                </tr>

                                                <!-- Returns Total -->
                                                <tr class="total-row" style="background:#f8d7da!important;">
                                                    <td colspan="5"><strong>Returns Total (-)</strong></td>
                                                    <td class="text-right highlight-neg">-<?= number_format($r_sale_qty, 0) ?></td>
                                                    <td class="text-right highlight-neg">-<?= number_format($r_bonus_qty, 0) ?></td>
                                                    <td class="text-right highlight-neg">
                                                        <strong>-<?= number_format($r_eff_qty, 0) ?></strong>
                                                    </td>
                                                    <td class="text-right highlight-neg">-<?= number_format($r_item_subtotal, 2) ?>
                                                    </td>
                                                    <td class="text-right">-<?= number_format($r_order_disc, 2) ?></td>
                                                    <td class="text-right">-<?= number_format($r_item_disc, 2) ?></td>
                                                    <td class="text-right">
                                                        <strong>-<?= number_format($r_order_disc + $r_item_disc, 2) ?></strong>
                                                    </td>
                                                    <td class="text-right">-<?= number_format($r_bonus_val, 2) ?></td>
                                                    <td class="text-right highlight-neg">
                                                        <strong>-<?= number_format($r_net_return, 2) ?></strong>
                                                    </td>
                                                </tr>

                                                <!-- Net Total -->
                                                <tr class="total-row" style="background:#cce5ff!important;">
                                                    <td colspan="5"><strong>NET TOTAL</strong></td>
                                                    <td class="text-right">
                                                        <strong><?= number_format($g_sale_qty - $r_sale_qty, 0) ?></strong>
                                                    </td>
                                                    <td class="text-right">
                                                        <strong><?= number_format($g_bonus_qty - $r_bonus_qty, 0) ?></strong>
                                                    </td>
                                                    <td class="text-right"><strong><?= number_format($net_qty, 0) ?></strong></td>
                                                    <td class="text-right"><strong><?= number_format($net_amount, 2) ?></strong>
                                                    </td>
                                                    <td class="text-right">
                                                        <strong><?= number_format($g_order_disc - $r_order_disc, 2) ?></strong>
                                                    </td>
                                                    <td class="text-right">
                                                        <strong><?= number_format($g_item_disc - $r_item_disc, 2) ?></strong>
                                                    </td>
                                                    <td class="text-right"><strong><?= number_format($net_disc, 2) ?></strong></td>
                                                    <td class="text-right"><strong><?= number_format($net_bonus_val, 2) ?></strong>
                                                    </td>
                                                    <td class="text-right"><strong
                                                            style="font-size:16px;"><?= number_format($net_grand, 2) ?></strong>
                                                    </td>
                                                </tr>
                                            </tfoot>
                                        <?php endif; ?>
                                    </table>
                                </div>
                            </div>
                        </div>

                    <?php endif; /* date check */ ?>
                <?php endif; /* show_details */ ?>

            </div>
        </main>
    </div>

    <?php include_once 'includes/foot.php'; ?>
</body>

</html>