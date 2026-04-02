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
        }

        .product-name {
            width: 16% !important;
            font-size: 10px !important;
        }

        .pack-cell {
            width: 5% !important;
            text-align: center !important;
        }

        .stock-cell,
        .qty-cell,
        .value-cell {
            font-size: 9px !important;
            text-align: right !important;
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
        font-size: 15px !important;
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
        padding: 6px !important;
        color: #000 !important;
    }

    .total-row {
        font-weight: bold !important;
        font-size: 15px !important;
        background-color: #f8f9fa !important;
    }

    .total-row td {
        padding: 8px 6px !important;
    }

    .product-name {
        text-align: left !important;
        white-space: normal;
        word-wrap: break-word;
    }

    .pack-cell {
        text-align: center !important;
    }

    .stock-cell,
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
                        <h4 style="color:white"><b>Area Wise Product Wise Sales & Stock Report</b></h4>
                    </div>

                    <div class="card-body">
                        <form method="post">
                            <div class="row align-items-end">
                                <div class="col-sm-3">
                                    <label>Products (Hold Ctrl/Cmd for multiple - leave empty for all)</label>
                                    <select class="form-control searchableSelect" name="product_id[]" multiple
                                        style="height: 140px;">
                                        <?php
                                        $prodSql = "SELECT product_id, product_name FROM product WHERE status = 1 ORDER BY product_name ASC";
                                        $prodData = $connect->query($prodSql);
                                        while ($pr = $prodData->fetch_assoc()) {
                                            $selected = (isset($_POST['product_id']) && in_array($pr['product_id'], (array) $_POST['product_id'])) ? 'selected' : '';
                                            echo "<option value='{$pr['product_id']}' $selected>{$pr['product_name']}</option>";
                                        }
                                        ?>
                                    </select>
                                </div>
                                <div class="col-sm-3">
                                    <label>Areas (Hold Ctrl/Cmd for multiple)</label>
                                    <select class="form-control searchableSelect" name="area_id[]" multiple
                                        style="height: 140px;">
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
                                <div class="col-sm-2">
                                    <label>From Date <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" name="from_date"
                                        value="<?= isset($_POST['from_date']) ? htmlspecialchars($_POST['from_date']) : '' ?>"
                                        required>
                                </div>
                                <div class="col-sm-2">
                                    <label>To Date <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" name="to_date"
                                        value="<?= isset($_POST['to_date']) ? htmlspecialchars($_POST['to_date']) : '' ?>"
                                        required>
                                </div>



                                <div class="col-2 mt-3">
                                    <button type="submit" name="show_details" class="btn btn-danger">Generate
                                        Report</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <?php if (isset($_POST['show_details'])): ?>
                    <?php
                    $from_date = $_POST['from_date'];
                    $to_date = $_POST['to_date'];

                    if (strtotime($from_date) > strtotime($to_date)) {
                        echo '<div class="alert alert-danger mt-4">From date cannot be later than To date.</div>';
                    } else {

                        $area_ids = array_filter(array_map('intval', (array) ($_POST['area_id'] ?? [])));
                        $product_ids = array_filter(array_map('intval', (array) ($_POST['product_id'] ?? [])));

                        $has_areas = !empty($area_ids);
                        $has_products = !empty($product_ids);

                        $prod_filter = $has_products ? " AND prod.product_id IN (" . implode(',', $product_ids) . ")" : "";

                        // ==================== AREAS ====================
                        $area_list = [];
                        $area_totals = [];

                        if ($has_areas) {
                            $placeholders = implode(',', array_fill(0, count($area_ids), '?'));
                            $stmt = $connect->prepare("SELECT area_id, area_name FROM areas WHERE area_id IN ($placeholders) ORDER BY area_name ASC");
                            $stmt->bind_param(str_repeat('i', count($area_ids)), ...$area_ids);
                            $stmt->execute();
                            $res = $stmt->get_result();
                            while ($ar = $res->fetch_assoc()) {
                                $area_list[$ar['area_id']] = $ar['area_name'];
                                $area_totals[$ar['area_id']] = 0;
                            }
                            $stmt->close();
                        } else {
                            $prod_join = "";
                            $prod_condition = "";
                            if ($has_products) {
                                $prod_join = " INNER JOIN order_item oi ON oi.order_id = o.order_id 
                                               INNER JOIN product prod ON oi.product_id = prod.product_id ";
                                $prod_condition = " AND oi.product_id IN (" . implode(',', $product_ids) . ") 
                                                   AND oi.order_item_status = 1";
                            }

                            $sql_areas = "SELECT DISTINCT a.area_id, a.area_name 
                                          FROM areas a 
                                          INNER JOIN customers c ON c.customer_area = a.area_id
                                          INNER JOIN orders o ON o.customer_account = c.customer_id
                                          $prod_join
                                          WHERE o.order_date BETWEEN '$from_date' AND '$to_date' 
                                            AND o.order_status = '1' 
                                            $prod_condition
                                          ORDER BY a.area_name ASC";

                            $res = $connect->query($sql_areas);
                            while ($ar = $res->fetch_assoc()) {
                                $area_list[$ar['area_id']] = $ar['area_name'];
                                $area_totals[$ar['area_id']] = 0;
                            }
                        }

                        $where_area = $has_areas ? "cust.customer_area IN (" . implode(',', $area_ids) . ")" : "1=1";

                        // ==================== PRODUCTS ====================
                        $products = [];
                        $product_packs = [];
                        $prod_sql = "SELECT product_id, product_name, product_pack 
                                     FROM product 
                                     WHERE status = 1 " . ($has_products ? " AND product_id IN (" . implode(',', $product_ids) . ")" : "") . "
                                     ORDER BY product_name ASC";
                        $prod_res = $connect->query($prod_sql);
                        while ($p = $prod_res->fetch_assoc()) {
                            $products[$p['product_id']] = $p['product_name'];
                            $product_packs[$p['product_id']] = $p['product_pack'] ?? '';
                        }

                        // ==================== AREA-WISE SALES ====================
                        $area_sales = [];
                        $prod_totals = [];
                        $total_all_qty = 0;
                        $grand_amount = 0;

                        $sql_sales = "SELECT prod.product_id, a.area_id,
                                             SUM(oi.quantity) AS raw_qty,
                                             SUM(oi.bonus_qty) AS bonus_qty,
                                             SUM(oi.quantity + oi.bonus_qty) AS effective_qty,
                                             SUM(oi.total) AS amount
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
                                        $prod_filter
                                      GROUP BY prod.product_id, a.area_id";

                        $result = $connect->query($sql_sales);
                        while ($row = $result->fetch_assoc()) {
                            $pid = $row['product_id'];
                            $aid = $row['area_id'];

                            $raw = (float) ($row['raw_qty'] ?? 0);
                            $bonus = (float) ($row['bonus_qty'] ?? 0);
                            $total = (float) ($row['effective_qty'] ?? 0);
                            $amt = (float) ($row['amount'] ?? 0);

                            if (isset($area_list[$aid])) {
                                $area_sales[$pid][$aid] = ['raw' => $raw, 'bonus' => $bonus, 'total' => $total];
                                $area_totals[$aid] += $amt;

                                if (!isset($prod_totals[$pid])) {
                                    $prod_totals[$pid] = ['qty' => 0, 'amount' => 0];
                                }
                                $prod_totals[$pid]['qty'] += $total;
                                $prod_totals[$pid]['amount'] += $amt;

                                $total_all_qty += $total;
                                $grand_amount += $amt;
                            }
                        }

                        // Stock calculations (unchanged - kept as is)
                        $opening_date = date('Y-m-d', strtotime($from_date . ' -1 day'));

                        $opening_stock = $received = $purchase_return = $company_sales_qty = $bonus_qty = $sales_return_qty = [];

                        $stock_prod_filter = $has_products ? " AND prod.product_id IN (" . implode(',', $product_ids) . ")" : "";

                        $sql_open = "SELECT prod.product_id,
                            COALESCE(purch.qty,0) - COALESCE(pret.qty,0) - COALESCE(sale.qty,0) + COALESCE(sret.qty,0) AS opening_qty
                        FROM product prod
                        LEFT JOIN (SELECT pi.product_id, SUM(pi.quantity) qty FROM purchase_item pi 
                                   INNER JOIN purchase p ON pi.purchase_id = p.purchase_id 
                                   WHERE p.purchase_date <= '$opening_date' GROUP BY pi.product_id) purch ON purch.product_id = prod.product_id
                        LEFT JOIN (SELECT pri.product_id, SUM(pri.quantity) qty FROM purchase_return_item pri 
                                   INNER JOIN purchase_return pr ON pri.purchase_id = pr.purchase_id 
                                   WHERE pr.purchase_date <= '$opening_date' GROUP BY pri.product_id) pret ON pret.product_id = prod.product_id
                        LEFT JOIN (SELECT oi.product_id, SUM(oi.quantity + oi.bonus_qty) qty FROM order_item oi 
                                   INNER JOIN orders o ON oi.order_id = o.order_id 
                                   WHERE o.order_date <= '$opening_date' AND o.order_status='1' AND oi.order_item_status=1 
                                   GROUP BY oi.product_id) sale ON sale.product_id = prod.product_id
                        LEFT JOIN (SELECT ori.product_id, SUM(ori.quantity) qty FROM order_return_item ori 
                                   INNER JOIN orders_return orr ON ori.order_id = orr.order_id 
                                   WHERE orr.order_date <= '$opening_date' GROUP BY ori.product_id) sret ON sret.product_id = prod.product_id
                        WHERE prod.status = 1 $stock_prod_filter";

                        $res_open = $connect->query($sql_open);
                        while ($row = $res_open->fetch_assoc()) {
                            $opening_stock[$row['product_id']] = (float) $row['opening_qty'];
                        }

                        $sql_rec = "SELECT pi.product_id, SUM(pi.quantity) AS qty 
                                    FROM purchase_item pi INNER JOIN purchase p ON pi.purchase_id = p.purchase_id
                                    WHERE p.purchase_date BETWEEN '$from_date' AND '$to_date' 
                                    " . ($has_products ? " AND pi.product_id IN (" . implode(',', $product_ids) . ")" : "") . "
                                    GROUP BY pi.product_id";
                        $res = $connect->query($sql_rec);
                        while ($r = $res->fetch_assoc())
                            $received[$r['product_id']] = (float) $r['qty'];

                        $sql_pret = "SELECT pri.product_id, SUM(pri.quantity) AS qty 
                                     FROM purchase_return_item pri INNER JOIN purchase_return pr ON pri.purchase_id = pr.purchase_id
                                     WHERE pr.purchase_date BETWEEN '$from_date' AND '$to_date' 
                                     " . ($has_products ? " AND pri.product_id IN (" . implode(',', $product_ids) . ")" : "") . "
                                     GROUP BY pri.product_id";
                        $res = $connect->query($sql_pret);
                        while ($r = $res->fetch_assoc())
                            $purchase_return[$r['product_id']] = (float) $r['qty'];

                        $sql_cs = "SELECT oi.product_id, SUM(oi.quantity) AS qty, SUM(oi.bonus_qty) AS bonus 
                                   FROM order_item oi INNER JOIN orders o ON oi.order_id = o.order_id
                                   WHERE o.order_date BETWEEN '$from_date' AND '$to_date' 
                                     AND o.order_status = '1' AND oi.order_item_status = 1 
                                     " . ($has_products ? " AND oi.product_id IN (" . implode(',', $product_ids) . ")" : "") . "
                                   GROUP BY oi.product_id";
                        $res = $connect->query($sql_cs);
                        while ($r = $res->fetch_assoc()) {
                            $company_sales_qty[$r['product_id']] = (float) $r['qty'];
                            $bonus_qty[$r['product_id']] = (float) $r['bonus'];
                        }

                        $sql_sret = "SELECT ori.product_id, SUM(ori.quantity) AS qty 
                                     FROM order_return_item ori INNER JOIN orders_return orr ON ori.order_id = orr.order_id
                                     WHERE orr.order_date BETWEEN '$from_date' AND '$to_date' 
                                     " . ($has_products ? " AND ori.product_id IN (" . implode(',', $product_ids) . ")" : "") . "
                                     GROUP BY ori.product_id";
                        $res = $connect->query($sql_sret);
                        while ($r = $res->fetch_assoc())
                            $sales_return_qty[$r['product_id']] = (float) $r['qty'];

                        $stock_data = [];
                        foreach ($products as $pid => $name) {
                            $open = $opening_stock[$pid] ?? 0;
                            $rec = $received[$pid] ?? 0;
                            $pret = $purchase_return[$pid] ?? 0;
                            $sales_qty = $company_sales_qty[$pid] ?? 0;
                            $sret = $sales_return_qty[$pid] ?? 0;
                            $bonus = $bonus_qty[$pid] ?? 0;

                            $net_rec = $rec - $pret;
                            $total_stock = $open + $net_rec;
                            $net_sale = $sales_qty - $sret;
                            $closing = $total_stock - $net_sale - $bonus;

                            $stock_data[$pid] = [
                                'opening' => $open,
                                'received' => $rec,
                                'net_sales' => $net_sale,
                                'bonus' => $bonus,
                                'closing' => $closing
                            ];
                        }
                        ?>

                        <div class="card mt-4 position-relative">
                            <div class="card-header text-center pt-4"
                                style="background-color: #343a40; color: white; position: relative;">
                                <div class="header-company">AMG</div>
                                <div class="header-title">Area Wise Product Wise Sales & Stock Report</div>
                                <div class="header-subtitle">
                                    FROM <?= date('d/m/Y', strtotime($from_date)) ?> TO
                                    <?= date('d/m/Y', strtotime($to_date)) ?>
                                </div>
                                <button onclick="window.print()"
                                    class="btn btn-light btn-sm print-btn d-print-none">Print</button>
                            </div>

                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="product-name">Product Name</th>
                                                <th class="pack-cell">Pack</th>
                                                <th class="stock-cell">Opening Stock</th>
                                                <th class="stock-cell">Received</th>
                                                <th class="stock-cell">Available Stock</th>
                                                <?php foreach ($area_list as $aname): ?>
                                                    <th><?= htmlspecialchars($aname) ?><br><small>Qty + Bonus</small></th>
                                                <?php endforeach; ?>
                                                <th class="qty-cell">Total Qty</th>
                                                <th class="value-cell">Total Value</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if (empty($products) || empty($area_list)): ?>
                                                <tr>
                                                    <td colspan="<?= count($area_list) + 10 ?>" class="text-center text-muted py-4">
                                                        No records found for the selected criteria.
                                                    </td>
                                                </tr>
                                            <?php else: ?>
                                                <?php foreach ($products as $pid => $name):
                                                    $pack = $product_packs[$pid] ?? '';
                                                    $s = $stock_data[$pid] ?? ['opening' => 0, 'received' => 0, 'net_sales' => 0, 'bonus' => 0, 'closing' => 0];
                                                    $p_qty = $prod_totals[$pid]['qty'] ?? 0;
                                                    $p_amt = $prod_totals[$pid]['amount'] ?? 0;
                                                    ?>
                                                    <tr>
                                                        <td class="product-name"><?= htmlspecialchars($name) ?></td>
                                                        <td class="pack-cell"><?= htmlspecialchars($pack) ?></td>
                                                        <td class="stock-cell"><?= number_format($s['opening'], 0) ?></td>
                                                        <td class="stock-cell"><?= number_format($s['received'], 0) ?></td>
                                                        <td class="stock-cell"><strong><?= number_format($s['closing'], 0) ?></strong>
                                                        </td>

                                                        <?php foreach ($area_list as $aid => $aname):
                                                            $cell = $area_sales[$pid][$aid] ?? ['raw' => 0, 'bonus' => 0, 'total' => 0];
                                                            $display = ($cell['total'] == 0) ? '0' :
                                                                ($cell['bonus'] == 0 ? number_format($cell['total'], 0) :
                                                                    number_format($cell['raw'], 0) . ' + ' . number_format($cell['bonus'], 0) . ' = ' . number_format($cell['total'], 0));
                                                            ?>
                                                            <td class="qty-cell"><?= $display ?></td>
                                                        <?php endforeach; ?>

                                                        <td class="qty-cell"><strong><?= number_format($p_qty, 0) ?></strong></td>
                                                        <td class="value-cell"><strong><?= number_format($p_amt, 2) ?></strong></td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </tbody>

                                        <?php if ($grand_amount > 0): ?>
                                            <tfoot>
                                                <tr class="total-row">
                                                    <!-- Dynamic colspan: Fixed columns + Area columns -->
                                                    <td colspan="5"><strong>Grand Total</strong></td>
                                                    <?php foreach ($area_list as $aid => $name): ?>
                                                        <td class="value-cell text-right">
                                                            <strong><?= number_format($area_totals[$aid], 2) ?></strong>
                                                        </td>
                                                    <?php endforeach; ?>
                                                    <td class="qty-cell text-right">
                                                        <strong><?= number_format($total_all_qty, 0) ?></strong>
                                                    </td>
                                                    <td class="value-cell text-right">
                                                        <strong><?= number_format($grand_amount, 2) ?></strong>
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