<?php
// ────────────────────────────────────────────────
//  Date Range Handling
// ────────────────────────────────────────────────
$today = date('Y-m-d');

$from_date = date('Y-m-01');           // default: 1st of current month
$to_date = $today;                   // default: today

$date_error = '';

if (isset($_GET['from_date']) && isset($_GET['to_date']) && !empty($_GET['from_date']) && !empty($_GET['to_date'])) {
    $input_from = trim($_GET['from_date']);
    $input_to = trim($_GET['to_date']);

    if (
        preg_match('/^\d{4}-\d{2}-\d{2}$/', $input_from) &&
        preg_match('/^\d{4}-\d{2}-\d{2}$/', $input_to) &&
        $input_from <= $input_to &&
        $input_from <= $today && $input_to <= $today
    ) {

        $from_date = $input_from;
        $to_date = $input_to;
    } else {
        $date_error = "Invalid date range. Showing current month instead.";
    }
}

// Format dates for display
$display_from = date('d/m/Y', strtotime($from_date));
$display_to = date('d/m/Y', strtotime($to_date));

// Date for opening stock (day before from_date)
$opening_date = date('Y-m-d', strtotime($from_date . ' -1 day'));
?>

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
            font-size: 10px !important;
            width: 100%;
        }

        .table th,
        .table td {
            padding: 3px 4px !important;
            font-size: 10px !important;
            line-height: 1.2;
        }

        .product-name {
            width: 25% !important;
            font-size: 11px !important;
        }

        .pack-cell {
            width: 8% !important;
            font-size: 11px !important;
            text-align: center !important;
        }

        .num-cell {
            font-size: 10px !important;
            text-align: right !important;
        }

        .total-row td {
            font-size: 12px !important;
        }

        .header-company {
            font-size: 22px !important;
        }

        .header-title {
            font-size: 18px !important;
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
        font-size: 18px !important;
        font-weight: bolder !important;
        color: #000 !important;
        background-color: #f8f9fa !important;
        text-align: center;
        vertical-align: middle;
        padding: 10px 8px !important;
    }

    tbody tr td {
        font-size: 16px !important;
        font-weight: 500 !important;
        vertical-align: middle;
        color: #000 !important;
        padding: 8px !important;
    }

    .total-row td {
        font-weight: bold !important;
        font-size: 17px !important;
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

    .num-cell {
        text-align: right !important;
    }

    .header-company {
        font-size: 28px;
        font-weight: bold;
    }

    .header-title {
        font-size: 24px;
        font-weight: bold;
        margin: 10px 0;
    }

    .print-btn {
        position: absolute;
        top: 15px;
        right: 150px;
    }

    .filter-form .form-control {
        min-width: 160px;
    }
</style>

<body class="horizontal light">
    <div class="wrapper">
        <?php include_once 'includes/header.php'; ?>

        <main role="main" class="main-content">
            <div class="container-fluid">

                <!-- Date Filter -->
                <div class="card mt-4 d-print-none">
                    <div class="card-header bg-dark text-white">
                        <strong class="text-white">SSR Report – Date Range Filter</strong>
                    </div>
                    <div class="card-body">
                        <form method="GET" class="filter-form row g-3 align-items-end">
                            <div class="col-auto">
                                <label class="form-label">From Date</label>
                                <input type="date" name="from_date" class="form-control"
                                    value="<?= htmlspecialchars($from_date) ?>" max="<?= $today ?>" required>
                            </div>
                            <div class="col-auto">
                                <label class="form-label">To Date</label>
                                <input type="date" name="to_date" class="form-control"
                                    value="<?= htmlspecialchars($to_date) ?>" max="<?= $today ?>" required>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary px-4 mt-4">
                                    Generate Report
                                </button>
                            </div>
                            <div class="col-auto">
                                <a href="?" class="btn btn-outline-secondary mt-4">Reset to Current Month</a>
                            </div>
                        </form>

                        <?php if ($date_error): ?>
                            <div class="alert alert-warning mt-3">
                                <?= htmlspecialchars($date_error) ?>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- Report -->
                <div class="card mt-4 position-relative">
                    <div class="card-header text-center pt-4"
                        style="background-color: #343a40; color: white; position: relative;">
                        <div class="header-company">AMG</div>
                        <div class="header-title">SSR Report</div>
                        <div style="font-size: 18px; margin-top: 10px;">
                            FROM <?= $display_from ?> TO <?= $display_to ?>
                        </div>
                        <button onclick="window.print()"
                            class="btn btn-light btn-sm print-btn d-print-none">Print</button>
                    </div>

                    <div class="card-body">

                        <?php
                        // ────────────────────────────────────────────────
                        // Fetch all active products
                        // ────────────────────────────────────────────────
                        $products = $product_packs = [];
                        $all_prod_sql = "SELECT p.product_id, p.product_name, p.product_pack,
                                                c.categories_name, b.brand_name 
                                         FROM product p 
                                         LEFT JOIN categories c ON p.category_id = c.categories_id 
                                         LEFT JOIN brands b ON p.brand_id = b.brand_id 
                                         WHERE p.status = 1 
                                         ORDER BY p.product_name ASC";
                        $all_prod_result = $connect->query($all_prod_sql);
                        if ($all_prod_result) {
                            while ($pr = $all_prod_result->fetch_assoc()) {
                                $pid = $pr['product_id'];
                                $cat = $pr['categories_name'] ? " ({$pr['categories_name']})" : "";
                                $brand = $pr['brand_name'] ? " [{$pr['brand_name']}]" : "";
                                $products[$pid] = $pr['product_name'] . $cat . $brand;
                                $product_packs[$pid] = $pr['product_pack'] ?? '';
                            }
                        }

                        // Opening stock (cumulative up to day before from_date)
                        $opening_stock = [];
                        $sql_opening = "SELECT prod.product_id,
                            COALESCE(purch.qty,0) - COALESCE(pret.qty,0) - COALESCE(sale.qty,0) + COALESCE(sret.qty,0) AS opening_qty
                        FROM product prod
                        LEFT JOIN (SELECT pi.product_id, SUM(pi.quantity) qty 
                                   FROM purchase_item pi 
                                   INNER JOIN purchase p ON pi.purchase_id = p.purchase_id 
                                   WHERE p.purchase_date <= '$opening_date' 
                                   GROUP BY pi.product_id) purch ON purch.product_id = prod.product_id
                        LEFT JOIN (SELECT pri.product_id, SUM(pri.quantity) qty 
                                   FROM purchase_return_item pri 
                                   INNER JOIN purchase_return pr ON pri.purchase_id = pr.purchase_id 
                                   WHERE pr.purchase_date <= '$opening_date' 
                                   GROUP BY pri.product_id) pret ON pret.product_id = prod.product_id
                        LEFT JOIN (SELECT oi.product_id, SUM(oi.quantity + oi.bonus_qty) qty 
                                   FROM order_item oi 
                                   INNER JOIN orders o ON oi.order_id = o.order_id 
                                   WHERE o.order_date <= '$opening_date' 
                                   AND o.order_status = 1 AND oi.order_item_status = 1 
                                   GROUP BY oi.product_id) sale ON sale.product_id = prod.product_id
                        LEFT JOIN (SELECT ori.product_id, SUM(ori.quantity) qty 
                                   FROM order_return_item ori 
                                   INNER JOIN orders_return orr ON ori.order_id = orr.order_id 
                                   WHERE orr.order_date <= '$opening_date' 
                                   GROUP BY ori.product_id) sret ON sret.product_id = prod.product_id
                        WHERE prod.status = 1";
                        $opening_result = $connect->query($sql_opening);
                        if ($opening_result) {
                            while ($row = $opening_result->fetch_assoc()) {
                                $opening_stock[$row['product_id']] = (float) $row['opening_qty'];
                            }
                        }

                        // Historical average cost (up to opening_date)
                        $avg_cost = [];
                        $sql_avg = "SELECT pi.product_id, 
                                    CASE WHEN SUM(pi.quantity) > 0 THEN SUM(pi.total) / SUM(pi.quantity) ELSE 0 END AS avg_rate
                                    FROM purchase_item pi
                                    INNER JOIN purchase p ON pi.purchase_id = p.purchase_id
                                    WHERE p.purchase_date <= '$opening_date'
                                    GROUP BY pi.product_id";
                        $avg_result = $connect->query($sql_avg);
                        if ($avg_result) {
                            while ($row = $avg_result->fetch_assoc()) {
                                $avg_cost[$row['product_id']] = (float) $row['avg_rate'];
                            }
                        }

                        // Period values
                        $rece_value_total = $pret_value_total = 0;

                        $sql_rece_value = "SELECT SUM(pi.total) AS amount
                                           FROM purchase_item pi
                                           INNER JOIN purchase p ON pi.purchase_id = p.purchase_id
                                           WHERE p.purchase_date BETWEEN '$from_date' AND '$to_date'";
                        $rece_v = $connect->query($sql_rece_value);
                        if ($rece_v && $r = $rece_v->fetch_assoc())
                            $rece_value_total = (float) ($r['amount'] ?? 0);

                        $sql_pret_value = "SELECT SUM(pri.total) AS amount
                                           FROM purchase_return_item pri
                                           INNER JOIN purchase_return pr ON pri.purchase_id = pr.purchase_id
                                           WHERE pr.purchase_date BETWEEN '$from_date' AND '$to_date'";
                        $pret_v = $connect->query($sql_pret_value);
                        if ($pret_v && $r = $pret_v->fetch_assoc())
                            $pret_value_total = (float) ($r['amount'] ?? 0);

                        // Period quantities per product
                        $rece = $pret = $sales_qty = $bonus_qty = $sales_value = $sret_qty = $sret_value = [];

                        // Receive qty
                        $sql_rece = "SELECT pi.product_id, SUM(pi.quantity) AS qty
                                     FROM purchase_item pi INNER JOIN purchase p ON pi.purchase_id = p.purchase_id
                                     WHERE p.purchase_date BETWEEN '$from_date' AND '$to_date'
                                     GROUP BY pi.product_id";
                        $res = $connect->query($sql_rece);
                        if ($res) {
                            while ($r = $res->fetch_assoc()) {
                                $rece[$r['product_id']] = (float) $r['qty'];
                            }
                        }

                        // Purchase return qty
                        $sql_pret = "SELECT pri.product_id, SUM(pri.quantity) AS qty
                                     FROM purchase_return_item pri INNER JOIN purchase_return pr ON pri.purchase_id = pr.purchase_id
                                     WHERE pr.purchase_date BETWEEN '$from_date' AND '$to_date'
                                     GROUP BY pri.product_id";
                        $res = $connect->query($sql_pret);
                        if ($res) {
                            while ($r = $res->fetch_assoc()) {
                                $pret[$r['product_id']] = (float) $r['qty'];
                            }
                        }

                        // Sales qty, bonus, value
                        $sql_sales = "SELECT oi.product_id, 
                                             SUM(oi.quantity) AS qty, 
                                             SUM(oi.bonus_qty) AS bonus_qty, 
                                             SUM(oi.total) AS amount
                                      FROM order_item oi 
                                      INNER JOIN orders o ON oi.order_id = o.order_id
                                      WHERE o.order_date BETWEEN '$from_date' AND '$to_date'
                                      AND o.order_status = '1' AND oi.order_item_status = 1
                                      GROUP BY oi.product_id";
                        $res = $connect->query($sql_sales);
                        if ($res) {
                            while ($r = $res->fetch_assoc()) {
                                $sales_qty[$r['product_id']] = (float) $r['qty'];
                                $bonus_qty[$r['product_id']] = (float) $r['bonus_qty'];
                                $sales_value[$r['product_id']] = (float) $r['amount'];
                            }
                        }

                        // Sales return qty & value
                        $sql_sret = "SELECT ori.product_id, SUM(ori.quantity) AS qty, SUM(ori.total) AS amount
                                     FROM order_return_item ori 
                                     INNER JOIN orders_return orr ON ori.order_id = orr.order_id
                                     WHERE orr.order_date BETWEEN '$from_date' AND '$to_date'
                                     GROUP BY ori.product_id";
                        $res = $connect->query($sql_sret);
                        if ($res) {
                            while ($r = $res->fetch_assoc()) {
                                $sret_qty[$r['product_id']] = (float) $r['qty'];
                                $sret_value[$r['product_id']] = (float) $r['amount'];
                            }
                        }

                        $tot_opening_value = $tot_total_value = $tot_closing_value = $tot_sales_value = $tot_bonus_qty = 0;
                        ?>

                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th class="product-name">Name</th>
                                        <th class="pack-cell">Pack</th>
                                        <th>Opening Stock</th>
                                        <th>Stock Receive</th>
                                        <th>Purch Return</th>
                                        <th>Total Stock</th>
                                        <th>Net Sales</th>
                                        <th>Bonus Given</th>
                                        <th>Closed Balanced</th>
                                        <th>Net Sales Value</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (empty($products)): ?>
                                        <tr>
                                            <td colspan="10" class="text-center text-muted py-4">No active products found.
                                            </td>
                                        </tr>
                                    <?php else: ?>
                                        <?php foreach ($products as $pid => $name):
                                            $opening = $opening_stock[$pid] ?? 0;
                                            $rece_qty = $rece[$pid] ?? 0;
                                            $pret_qty = $pret[$pid] ?? 0;
                                            $sales_q = $sales_qty[$pid] ?? 0;
                                            $sret_q = $sret_qty[$pid] ?? 0;
                                            $bonus_q = $bonus_qty[$pid] ?? 0;

                                            $net_sales_q = $sales_q - $sret_q;
                                            $net_receive_q = $rece_qty - $pret_qty;

                                            $total_stock = $opening + $rece_qty - $pret_qty;
                                            $closing_qty = $total_stock - $net_sales_q - $bonus_q;

                                            $net_sales_val = ($sales_value[$pid] ?? 0) - ($sret_value[$pid] ?? 0);

                                            $pack = $product_packs[$pid] ?? '';

                                            // Accumulate totals
                                            $avg = $avg_cost[$pid] ?? 0;
                                            $tot_opening_value += $opening * $avg;
                                            $tot_total_value += $total_stock * $avg;
                                            $tot_closing_value += $closing_qty * $avg;
                                            $tot_sales_value += $net_sales_val;
                                            $tot_bonus_qty += $bonus_q;
                                            ?>
                                            <tr>
                                                <td class="product-name"><?= htmlspecialchars($name) ?></td>
                                                <td class="pack-cell"><?= htmlspecialchars($pack) ?></td>
                                                <td class="num-cell"><?= number_format($opening, 0) ?></td>
                                                <td class="num-cell"><?= number_format($rece_qty, 0) ?></td>
                                                <td class="num-cell"><?= number_format($pret_qty, 0) ?></td>
                                                <td class="num-cell"><?= number_format($total_stock, 0) ?></td>
                                                <td class="num-cell"><?= number_format($net_sales_q, 0) ?></td>
                                                <td class="num-cell"><?= number_format($bonus_q, 0) ?></td>
                                                <td class="num-cell"><strong><?= number_format($closing_qty, 0) ?></strong></td>
                                                <td class="num-cell"><strong><?= number_format($net_sales_val, 2) ?></strong>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tbody>
                                <tfoot>
                                    <tr class="total-row">
                                        <td colspan="2"><strong>Total Value</strong></td>
                                        <td class="num-cell">
                                            <strong><?= number_format($tot_opening_value, 2) ?></strong>
                                        </td>
                                        <td class="num-cell"><strong><?= number_format($rece_value_total, 2) ?></strong>
                                        </td>
                                        <td class="num-cell"><strong><?= number_format($pret_value_total, 2) ?></strong>
                                        </td>
                                        <td class="num-cell"><strong><?= number_format($tot_total_value, 2) ?></strong>
                                        </td>
                                        <td class="num-cell"><strong><?= number_format($tot_sales_value, 2) ?></strong>
                                        </td>
                                        <td class="num-cell"><strong><?= number_format($tot_bonus_qty, 0) ?></strong>
                                        </td>
                                        <td class="num-cell">
                                            <strong><?= number_format($tot_closing_value, 2) ?></strong>
                                        </td>
                                        <td class="num-cell"><strong><?= number_format($tot_sales_value, 2) ?></strong>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                    </div>
                </div>

            </div>
        </main>
    </div>

    <?php include_once 'includes/foot.php'; ?>
</body>

</html>