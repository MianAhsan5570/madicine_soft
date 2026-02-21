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
            size: A4;
            margin: 6mm;
        }

        .table {
            font-size: 10px !important;
            width: 100%;
        }

        .table th,
        .table td {
            padding: 3px 5px !important;
            font-size: 10px !important;
            line-height: 1.15;
        }

        .total-row td {
            font-size: 11px !important;
        }
    }

    .header-company {
        font-size: 32px;
        font-weight: bold;
        color: white;
    }

    .header-title {
        font-size: 24px;
        font-weight: bold;
        color: white;
        margin: 8px 0;
    }

    .header-subtitle {
        font-size: 18px;
        color: #e0e0e0;
        margin-bottom: 12px;
    }

    .print-btn {
        position: absolute;
        top: 20px;
        right: 25px;
    }

    thead th {
        background-color: #e9ecef !important;
        font-size: 15px !important;
        font-weight: 700 !important;
        text-align: center;
        vertical-align: middle;
        padding: 8px !important;
        color: #121213 !important;
    }

    tbody td {
        font-size: 14px !important;
        vertical-align: middle;
        padding: 7px !important;
        color: #121213 !important;
    }

    .total-row td {
        font-weight: bold !important;
        font-size: 15px !important;
        background-color: #f1f3f5 !important;
        color: #121213 !important;
    }

    .text-right {
        text-align: right !important;
    }

    .text-center {
        text-align: center !important;
    }
</style>

<body class="horizontal light">
    <div class="wrapper">
        <?php include_once 'includes/header.php'; ?>

        <main role="main" class="main-content">
            <div class="container-fluid">

                <?php
                // Automatically set to today's date
                $from_date = date('Y-m-d');
                $to_date = date('Y-m-d');

                // ────────────────────────────────────────────────
                // Fetch summary + first/last invoice numbers for today
                // ────────────────────────────────────────────────
                $invoices = [];
                $grand_trade_amount = $grand_gold_amount = 0;
                $grand_discount = $grand_late_discount = $grand_payable = 0;

                $min_order_id = null;
                $max_order_id = null;

                $sql = "SELECT 
                            o.order_id,
                            o.total_amount,
                            o.discount,
                            o.grand_total,
                            c.customer_name,
                            COALESCE(a.area_name, 'N/A') as area_name
                        FROM orders o
                        INNER JOIN customers c ON o.customer_account = c.customer_id
                        LEFT JOIN areas a ON c.customer_area = a.area_id
                        WHERE o.order_date = ?
                          AND o.order_status = '1'
                        ORDER BY o.order_id ASC";

                $stmt = $connect->prepare($sql);
                $stmt->bind_param("s", $from_date);
                $stmt->execute();
                $result = $stmt->get_result();

                while ($row = $result->fetch_assoc()) {
                    $total_amount = (float) $row['total_amount'];
                    $grand_total = (float) $row['grand_total'];
                    $discount = (float) $row['discount'];
                    $gold_amount = $grand_total;
                    $late_discount = 0;
                    $payable = $grand_total;

                    $invoices[] = [
                        'invoice_no' => sprintf(" %05d", $row['order_id']),
                        'customer' => $row['customer_name'] . ' - ' . $row['area_name'],
                        'trade_amount' => $total_amount,
                        'gold_amount' => $total_amount,
                        'discount' => $discount,
                        'late_discount' => $late_discount,
                        'payable' => $payable,
                    ];

                    $grand_trade_amount += $total_amount;
                    $grand_gold_amount += $total_amount;
                    $grand_discount += $discount;
                    $grand_late_discount += $late_discount;
                    $grand_payable += $payable;

                    // Track first & last invoice
                    if ($min_order_id === null || $row['order_id'] < $min_order_id) {
                        $min_order_id = $row['order_id'];
                    }
                    if ($max_order_id === null || $row['order_id'] > $max_order_id) {
                        $max_order_id = $row['order_id'];
                    }
                }
                $stmt->close();

                $first_inv = $min_order_id ? sprintf("%05d", $min_order_id) : '-';
                $last_inv = $max_order_id ? sprintf("%05d", $max_order_id) : '-';
                ?>

                <div class="card mt-4 position-relative">
                    <div class="card-header text-center pt-4"
                        style="background-color: #343a40; color: white; position: relative;">
                        <div class="header-company">AMG</div>
                        <div class="header-title">DAILY INVOICE SUMMARY – ALL AREAS</div>
                        <div class="header-subtitle">
                            DATE: <?= date('d/m/Y', strtotime($from_date)) ?>
                            •    
                            INVOICE RANGE: <?= $first_inv ?> – <?= $last_inv ?>
                        </div>
                        <button onclick="window.print()" class="btn btn-light btn-sm print-btn d-print-none">
                            Print Report
                        </button>
                    </div>

                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th style="width:5%">S.No</th>
                                        <th style="width:14%">Invoice No.</th>
                                        <th style="width:28%">Customer</th>
                                        <th style="width:13%">Trade Amount</th>
                                        <th style="width:11%">Sold Amount</th>
                                        <th style="width:9%">Disc.</th>
                                        <!-- <th style="width:9%">Late Disc.</th> -->
                                        <th style="width:11%">Payable</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (empty($invoices)): ?>
                                        <tr>
                                            <td colspan="8" class="text-center py-4 text-muted">
                                                No invoices found for today (<?= date('d/m/Y') ?>).
                                            </td>
                                        </tr>
                                    <?php else: ?>
                                        <?php $sr = 1;
                                        foreach ($invoices as $inv): ?>
                                            <tr>
                                                <td class="text-center"><?= $sr++ ?></td>
                                                <td><?= htmlspecialchars($inv['invoice_no']) ?></td>
                                                <td><?= htmlspecialchars($inv['customer']) ?></td>
                                                <td class="text-right"><?= number_format($inv['trade_amount'], 2) ?></td>
                                                <td class="text-right"><?= number_format($inv['gold_amount'], 2) ?></td>
                                                <td class="text-right"><?= number_format($inv['discount'], 2) ?></td>
                                                <!-- <td class="text-right"><?= number_format($inv['late_discount'], 2) ?></td> -->
                                                <td class="text-right"><?= number_format($inv['payable'], 0) ?></td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tbody>

                                <?php if (!empty($invoices)): ?>
                                    <tfoot>
                                        <tr class="total-row">
                                            <td colspan="3" class="text-right">TOTALS:</td>
                                            <td class="text-right"><?= number_format($grand_trade_amount, 2) ?></td>
                                            <td class="text-right"><?= number_format($grand_gold_amount, 2) ?></td>
                                            <td class="text-right"><?= number_format($grand_discount, 2) ?></td>
                                            <!-- <td class="text-right"><?= number_format($grand_late_discount, 2) ?></td> -->
                                            <td class="text-right"><?= number_format($grand_payable, 0) ?></td>
                                        </tr>
                                    </tfoot>
                                <?php endif; ?>
                            </table>
                        </div>

                        <div class="mt-4 text-center">
                            <strong>VALUE OF RETURNED INVOICES NOT INCLUDED IN TOTAL</strong>
                        </div>

                        <div class="mt-5 text-center">
                            <div style="display:inline-block; width:220px; border-top:1px solid #000; padding-top:6px;">
                                Salesman Signature
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <?php include_once 'includes/foot.php'; ?>
</body>

</html>