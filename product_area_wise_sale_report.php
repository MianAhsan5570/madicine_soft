<!DOCTYPE html>
<html lang="en">
<?php include_once 'includes/head.php'; ?>

<style type="text/css">
    @media screen {
        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
    }

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
            margin: 6mm;
        }

        .table {
            font-size: 9px !important;
            width: 100%;
        }

        .table th,
        .table td {
            padding: 3px 4px !important;
            font-size: 9px !important;
            line-height: 1.1;
        }

        .product-name {
            width: 20% !important;
            font-size: 10px !important;
        }

        .pack-cell {
            width: 6% !important;
            font-size: 10px !important;
            text-align: center !important;
        }

        .qty-cell,
        .value-cell {
            font-size: 9px !important;
            /* min-width: 40px; */
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
        }

        tfoot {
            display: table-footer-group;
        }
    }

    thead tr th {
        font-size: 16px !important;
        font-weight: bold !important;
        color: #000 !important;
        background-color: #f8f9fa !important;
        text-align: center;
        vertical-align: middle;
        padding: 8px 6px !important;
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
        background-color: #f8f9fa !important;
    }

    .product-name {
        text-align: left !important;
        white-space: normal;
        word-wrap: break-word;
    }

    .pack-cell {
        text-align: center !important;
    }

    .qty-cell,
    .value-cell {
        text-align: right !important;
    }

    .header-company {
        font-size: 26px;
        font-weight: bold;
    }

    .header-title {
        font-size: 20px;
        font-weight: bold;
        margin: 8px 0;
    }

    .header-subtitle {
        font-size: 16px;
        margin: 4px 0;
    }

    .print-btn {
        position: absolute;
        top: 12px;
        right: 140px;
    }
</style>

<body class="horizontal light">
    <div class="wrapper">
        <?php include_once 'includes/header.php'; ?>

        <main role="main" class="main-content">
            <div class="container-fluid">

                <!-- FILTER CARD -->
                <div class="card d-print-none">
                    <div class="card-header card-bg text-center">
                        <h4 style="color:white"><b>Area Wise Product Wise Sales Report</b></h4>
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
                                    <label>Areas (Hold Ctrl/Cmd to select multiple)</label>
                                    <select class="form-control searchableSelect" name="area_id[]" multiple="multiple"
                                        style="height: 150px;">
                                        <?php
                                        $areaSql = "SELECT * FROM areas WHERE area_status = 1 ORDER BY area_name ASC";
                                        $areaData = $connect->query($areaSql);
                                        while ($area = $areaData->fetch_assoc()) {
                                            $selected = (isset($_POST['area_id']) && in_array($area['area_id'], (array) $_POST['area_id'])) ? 'selected' : '';
                                            echo "<option value='{$area['area_id']}' $selected>{$area['area_name']}</option>";
                                        }
                                        ?>
                                    </select>
                                </div>

                                <div class="col-sm-4 col-md-3">
                                    <label style="visibility: hidden;">Search</label><br>
                                    <button type="submit" name="show_details" class="btn btn-danger">Show
                                        Details</button>
                                </div>
                            </div>

                            <div class="row mt-2">
                                <div class="col-12">
                                    <small class="text-muted">Date range is required. Areas are optional — if none
                                        selected, only areas with sales will appear.</small><br>
                                    <small class="text-info"><strong>Note:</strong> Quantity shown as
                                        <code>regular + bonus = total</code>. Value is based on invoiced amount
                                        only.</small>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- REPORT DISPLAY -->
                <?php if (isset($_POST['show_details'])): ?>

                    <?php
                    $from_date = $_POST['from_date'];
                    $to_date = $_POST['to_date'];

                    if (strtotime($from_date) > strtotime($to_date)) {
                        echo '<div class="alert alert-danger mt-4">From date cannot be greater than To date.</div>';
                    } else {

                        $area_ids_post = (array) ($_POST['area_id'] ?? []);
                        $area_ids = array_filter(array_map(function ($id) use ($connect) {
                            return mysqli_real_escape_string($connect, trim($id));
                        }, $area_ids_post));

                        $has_selected_areas = !empty($area_ids);

                        // All active products
                        $products = [];
                        $product_packs = [];
                        $all_prod_sql = "SELECT p.product_id, p.product_name, p.product_pack,
                                                c.categories_name, b.brand_name 
                                         FROM product p 
                                         LEFT JOIN categories c ON p.category_id = c.categories_id 
                                         LEFT JOIN brands b ON p.brand_id = b.brand_id 
                                         WHERE p.status = 1 
                                         ORDER BY p.product_name ASC";
                        $all_prod_result = $connect->query($all_prod_sql);
                        while ($pr = $all_prod_result->fetch_assoc()) {
                            $pid = $pr['product_id'];
                            $cat = $pr['categories_name'] ? " ({$pr['categories_name']})" : "";
                            $brand = $pr['brand_name'] ? " [{$pr['brand_name']}]" : "";
                            $products[$pid] = $pr['product_name'];
                            $product_packs[$pid] = $pr['product_pack'] ?? '';
                        }

                        // Areas
                        $area_list = [];
                        $area_totals = [];
                        if ($has_selected_areas) {
                            $placeholders = implode(',', array_fill(0, count($area_ids), '?'));
                            $sql_areas = "SELECT area_id, area_name FROM areas WHERE area_id IN ($placeholders) ORDER BY area_name ASC";
                            $stmt = $connect->prepare($sql_areas);
                            $stmt->bind_param(str_repeat('i', count($area_ids)), ...$area_ids);
                            $stmt->execute();
                            $res = $stmt->get_result();
                            while ($ar = $res->fetch_assoc()) {
                                $area_list[$ar['area_id']] = $ar['area_name'];
                                $area_totals[$ar['area_id']] = 0;
                            }
                            $stmt->close();
                        } else {
                            $sql_areas = "SELECT DISTINCT a.area_id, a.area_name
                                          FROM areas a
                                          INNER JOIN customers cust ON cust.customer_area = a.area_id
                                          INNER JOIN orders o ON o.customer_account = cust.customer_id
                                          INNER JOIN order_item oi ON oi.order_id = o.order_id
                                          WHERE o.order_date BETWEEN '$from_date' AND '$to_date'
                                          AND o.order_status = '1' 
                                          AND oi.order_item_status = 1
                                          ORDER BY a.area_name ASC";
                            $areas_result = $connect->query($sql_areas);
                            while ($ar = $areas_result->fetch_assoc()) {
                                $area_list[$ar['area_id']] = $ar['area_name'];
                                $area_totals[$ar['area_id']] = 0;
                            }
                        }

                        $where_area = $has_selected_areas
                            ? "cust.customer_area IN ('" . implode("','", $area_ids) . "')"
                            : "1=1";

                        // Sales data
                        $sales = [];
                        $prod_totals = [];
                        $total_all_qty = 0;
                        $grand_amount = 0;

                        $sql = "SELECT 
                                    prod.product_id,
                                    a.area_id,
                                    SUM(oi.quantity)     AS raw_qty,
                                    SUM(oi.bonus_qty)    AS bonus_qty,
                                    SUM(oi.quantity + oi.bonus_qty) AS effective_qty,
                                    SUM(oi.total)        AS amount
                                FROM order_item oi
                                INNER JOIN orders o ON oi.order_id = o.order_id
                                INNER JOIN product prod ON oi.product_id = prod.product_id
                                LEFT JOIN customers cust ON o.customer_account = cust.customer_id
                                LEFT JOIN areas a ON cust.customer_area = a.area_id
                                WHERE o.order_date BETWEEN '$from_date' AND '$to_date'
                                AND o.order_status = '1'
                                AND oi.order_item_status = 1
                                AND $where_area
                                AND a.area_id IS NOT NULL
                                GROUP BY prod.product_id, a.area_id";

                        $result = $connect->query($sql);

                        if ($result) {
                            while ($row = $result->fetch_assoc()) {
                                $pid = $row['product_id'];
                                $aid = $row['area_id'];

                                $raw_qty = (float) ($row['raw_qty'] ?? 0);
                                $bonus_qty = (float) ($row['bonus_qty'] ?? 0);
                                $effective_qty = (float) ($row['effective_qty'] ?? 0);
                                $amount = (float) ($row['amount'] ?? 0);

                                if (isset($area_list[$aid])) {
                                    $sales[$pid][$aid] = [
                                        'raw' => $raw_qty,
                                        'bonus' => $bonus_qty,
                                        'total' => $effective_qty
                                    ];

                                    $area_totals[$aid] += $amount;

                                    if (!isset($prod_totals[$pid])) {
                                        $prod_totals[$pid] = ['qty' => 0, 'amount' => 0];
                                    }
                                    $prod_totals[$pid]['qty'] += $effective_qty;
                                    $prod_totals[$pid]['amount'] += $amount;

                                    $total_all_qty += $effective_qty;
                                    $grand_amount += $amount;
                                }
                            }
                        }
                        ?>

                        <div class="card mt-4 position-relative">
                            <div class="card-header text-center pt-4"
                                style="background-color: #343a40; color: white; position: relative;">
                                <div class="header-company">AMG</div>
                                <div class="header-title">Area Wise Product Wise Sales</div>
                                <div class="header-subtitle">
                                    FROM <?= date('d/m/Y', strtotime($from_date)) ?>
                                    TO <?= date('d/m/Y', strtotime($to_date)) ?>
                                    <small style="opacity:0.8;"> (Qty: regular + bonus = total)</small>
                                </div>
                                <button onclick="window.print()"
                                    class="btn btn-light btn-sm print-btn d-print-none">Print</button>
                            </div>

                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="product-name" style="width:22%;">Product Name</th>
                                                <th class="pack-cell" style="width:7%;">Pack</th>
                                                <?php foreach ($area_list as $aid => $aname): ?>
                                                    <th style="min-width:70px;" title="Regular + Bonus = Total">
                                                        <?= htmlspecialchars($aname) ?><br><small>Qty + Bonus</small>
                                                    </th>
                                                <?php endforeach; ?>
                                                <th style="min-width:90px;">Total Qty<br><small>(incl. bonus)</small></th>
                                                <th>Total Value</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if (empty($area_list)): ?>
                                                <tr>
                                                    <td colspan="<?= count($area_list) + 4 ?>" class="text-center text-muted py-4">
                                                        No sales records found for the selected date range.
                                                    </td>
                                                </tr>
                                            <?php elseif (empty($products)): ?>
                                                <tr>
                                                    <td colspan="<?= count($area_list) + 4 ?>" class="text-center text-muted py-4">
                                                        No active products found.
                                                    </td>
                                                </tr>
                                            <?php else: ?>
                                                <?php
                                                uasort($products, 'strcasecmp');
                                                foreach ($products as $pid => $name):
                                                    $p_qty = $prod_totals[$pid]['qty'] ?? 0;
                                                    $p_amount = $prod_totals[$pid]['amount'] ?? 0;
                                                    $pack = $product_packs[$pid] ?? '';
                                                    ?>
                                                    <tr>
                                                        <td class="product-name"><?= htmlspecialchars($name) ?></td>
                                                        <td class="pack-cell"><?= htmlspecialchars($pack) ?></td>

                                                        <?php foreach ($area_list as $aid => $aname):
                                                            $cell = $sales[$pid][$aid] ?? ['raw' => 0, 'bonus' => 0, 'total' => 0];
                                                            $raw = $cell['raw'];
                                                            $bonus = $cell['bonus'];
                                                            $total = $cell['total'];

                                                            if ($total == 0) {
                                                                $display = '0';
                                                            } elseif ($bonus == 0) {
                                                                $display = number_format($total, 0);
                                                            } else {
                                                                $display = number_format($raw, 0) . ' + ' . number_format($bonus, 0) . ' = ' . number_format($total, 0);
                                                            }
                                                            ?>
                                                            <td class="qty-cell"><?= $display ?></td>
                                                        <?php endforeach; ?>

                                                        <td class="qty-cell"><strong><?= number_format($p_qty, 0) ?></strong></td>
                                                        <td class="value-cell"><strong><?= number_format($p_amount, 2) ?></strong></td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </tbody>

                                        <?php if (!empty($area_list) && $grand_amount > 0): ?>
                                            <tfoot>
                                                <tr class="total-row">
                                                    <td colspan="2"><strong>Trade Value</strong></td>
                                                    <?php foreach ($area_list as $aid => $aname): ?>
                                                        <td class="value-cell">
                                                            <strong><?= number_format($area_totals[$aid], 2) ?></strong>
                                                        </td>
                                                    <?php endforeach; ?>
                                                    <td class="qty-cell"><strong><?= number_format($total_all_qty, 0) ?></strong>
                                                    </td>
                                                    <td class="value-cell"><strong><?= number_format($grand_amount, 2) ?></strong>
                                                    </td>
                                                </tr>
                                            </tfoot>
                                        <?php endif; ?>
                                    </table>
                                </div>
                            </div>
                        </div>

                    <?php } ?>

                <?php endif; ?>

            </div>
        </main>
    </div>

    <?php include_once 'includes/foot.php'; ?>
</body>

</html>