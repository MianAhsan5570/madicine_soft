<!DOCTYPE html>
<html lang="en">
<?php include_once 'includes/head.php'; ?>

<head>
    <meta charset="UTF-8">
    <title>Sale Invoice - Form 2A</title>
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap');

        @page {
            size: A4;
            margin: 10mm;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
            color: #000;
            font-size: 11pt;
            line-height: 1.3;
        }

        .page-container {
            width: 210mm;
            min-height: 297mm;
            margin: 10mm auto;
            background: #fff;
            padding: 15mm;
            position: relative;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        @media print {
            body {
                background: none;
                margin: 0;
                padding: 0;
            }

            .no-print {
                display: none;
            }
        }

        /* Copy Label */
        .copy-label {
            position: absolute;
            top: 8mm;
            left: 8mm;
            font-size: 9pt;
            font-weight: 700;
            text-transform: uppercase;
            color: #666;
            letter-spacing: 0.5px;
        }

        /* Company Header */
        .company-header {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #000;
        }

        .company-name {
            text-align: center;
            line-height: 0.8;
            margin: 0;
            font-family: "Times New Roman", serif;
        }

        .company-name .amg {
            font-size: 64px;
            font-weight: bold;
            color: #b22222;
            /* deep red like logo */
            letter-spacing: 3px;
        }

        .company-name .enterprises {
            font-size: 26px;
            font-weight: bold;
            color: #222;
            letter-spacing: 6px;
        }

        .company-name .distributors {
            font-size: 14px;
            color: #333;
            letter-spacing: 2px;
        }

        .company-details {
            font-size: 10pt;
            font-weight: 500;
            line-height: 1.5;
            color: #222;
        }

        /* Header Section */
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .customer-section {
            width: 60%;
        }

        .customer-section table {
            width: 100%;
            border-collapse: collapse;
        }

        .customer-section th {
            text-align: left;
            width: 90px;
            font-weight: 700;
            padding: 3px 0;
            vertical-align: top;
            font-size: 10pt;
        }

        .customer-section td {
            text-align: left;
            padding: 3px 0;
            font-size: 10pt;
            vertical-align: top;
        }

        .invoice-meta-right {
            text-align: right;
            font-size: 10pt;
            font-weight: 500;
        }

        .invoice-meta-right div {
            margin-bottom: 8px;
        }

        .invoice-meta-right strong {
            font-weight: 700;
        }

        /* Legal Section */
        .legal-section {
            margin: 20px 0;
            padding: 12px 0;
            border-top: 2px solid #000;
        }

        .legal-title {
            font-weight: 700;
            font-size: 9pt;
            margin-bottom: 8px;
            display: block;
        }

        .warranty-text {
            font-size: 8pt;
            line-height: 1.4;
            text-align: justify;
            color: #222;
        }

        /* Products Table */
        .products-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        .products-table thead th {
            border-top: 2px solid #000;
            border-bottom: 2px solid #000;
            padding: 10px 6px;
            font-size: 9pt;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 0.3px;
        }

        .products-table tbody td {
            padding: 12px 6px;
            border-bottom: 1px solid #e0e0e0;
            font-size: 10pt;
        }

        .products-table tbody tr:last-child td {
            border-bottom: 2px solid #000;
        }

        .text-center {
            text-align: center;
        }

        .text-right {
            text-align: right;
        }

        .text-left {
            text-align: left;
        }

        /* Summary Section */
        .summary-section {
            margin-top: 25px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .items-count {
            font-weight: 700;
            font-size: 11pt;
            padding-top: 10px;
        }

        .totals-box {
            text-align: right;
            min-width: 280px;
        }

        .net-payable-header {
            font-size: 20pt;
            font-weight: 900;
            margin-top: 12px;
            padding-top: 8px;
            border-top: 2px solid #000;
        }

        .totals-breakdown {
            margin-left: auto;
            width: 100%;
        }

        .totals-breakdown table {
            width: 100%;
            border-collapse: collapse;
        }

        .totals-breakdown td {
            padding: 6px 0;
            font-weight: 700;
            font-size: 10pt;
        }

        .totals-breakdown .label {
            text-align: left;
        }

        .totals-breakdown .amount {
            text-align: right;
        }

        /* Footer Notes */
        .footer-notes {
            margin-top: 40px;
            padding-top: 15px;
            border-top: 1px solid #000;
        }

        .note-line {
            font-weight: 700;
            font-size: 9pt;
            margin-bottom: 6px;
            line-height: 1.5;
        }

        /* Footer Bottom */
        .footer-bottom {
            margin-top: 50px;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .computerized-info {
            font-size: 8pt;
            color: #555;
            width: 55%;
            font-style: italic;
        }

        .signature-box {
            text-align: center;
            width: 200px;
        }

        .signature-img {
            width: 180px;
            /* increase width */
            height: 90px;
            /* increase height */
            object-fit: contain;
            display: block;
            margin: 0 auto 8px;
        }

        .signature-line {
            border-top: 1px solid #000;
            padding-top: 4px;
            font-size: 12px;
        }

        .signature-line {
            border-top: 2px solid #000;
            padding-top: 8px;
            font-weight: 700;
            font-size: 11pt;
        }

        /* Print buttons */
        .print-buttons {
            text-align: center;
            margin: 10px 0;
        }

        .print-buttons button {
            margin: 0 10px;
            padding: 6px 12px;
            font-size: 11pt;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <!-- PRINT BUTTONS -->
    <div class="print-buttons no-print">
        <button onclick="printInvoice(true)">Print with Legal Section</button>
        <button onclick="printInvoice(false)">Print without Legal Section</button>
    </div>

    <?php
    for ($i = 0; $i < 1; $i++):
        $totalQTY = 0;
        $copy = ($i > 0) ? "Company Copy" : "Customer Copy";

        if ($_REQUEST['type'] == "purchase") {
            $nameSHow = 'Supplier';
            $id = $_REQUEST['id'];

            $sql = "SELECT p.*, c.*
                    FROM purchase p
                    INNER JOIN customers c 
                    ON p.customer_account = c.customer_id
                    WHERE p.purchase_id = '$id'
                  ";

            $order = mysqli_fetch_assoc(mysqli_query($dbc, $sql));
            $comment = $order['purchase_narration'];
            $getDate = $order['purchase_date'];
            $order_type = ($order['payment_type'] == "credit_purchase") ? "Credit Purchase" : "Cash Purchase";

            $order_item = mysqli_query($dbc, "
                SELECT purchase_item.*, product.* 
                FROM purchase_item 
                INNER JOIN product ON purchase_item.product_id = product.product_id 
                WHERE purchase_item.purchase_id = '" . $_REQUEST['id'] . "'
            ");

        } else if ($_REQUEST['type'] == "purchase_return") {
            $nameSHow = 'Supplier';
           $id = $_REQUEST['id'];

            $sql = "SELECT p.*, c.*
                    FROM purchase_return p
                    INNER JOIN customers c 
                    ON p.customer_account = c.customer_id
                    WHERE p.purchase_id = '$id'
                   ";

            $order = mysqli_fetch_assoc(mysqli_query($dbc, $sql));
            $comment = $order['narration'] ?? '';
            $getDate = $order['return_date'] ?? '';
            $order_type = ($order['payment_type'] == "credit_purchase") ? "Credit Purchase" : "Cash Purchase";

            $order_item = mysqli_query($dbc, "
                SELECT purchase_return_item.*, product.*, product_batches.batch_no, product_batches.expiry_date 
                FROM purchase_return_item 
                INNER JOIN product ON purchase_return_item.product_id = product.product_id 
                LEFT JOIN product_batches ON purchase_return_item.batch_id = product_batches.batch_id 
                WHERE purchase_return_item.purchase_id = '" . $_REQUEST['id'] . "'
            ");

        } else if ($_REQUEST['type'] == "order_return") {
            $nameSHow = 'Customer';
            $id = (int) $_REQUEST['id'];
            $sql = "SELECT o.*, c.*
                    FROM orders_return o
                    INNER JOIN customers c
                    ON o.customer_account = c.customer_id
                    WHERE o.order_id = '$id'
                  ";
            $order = mysqli_fetch_assoc(mysqli_query($dbc, $sql));
            $comment = $order['narration'] ?? '';
            $getDate = $order['return_date'] ?? '';

            $order_item = mysqli_query($dbc, "
                SELECT order_return_item.*, product.*, product_batches.batch_no, product_batches.expiry_date 
                FROM order_return_item 
                INNER JOIN product ON order_return_item.product_id = product.product_id 
                LEFT JOIN product_batches ON order_return_item.batch_id = product_batches.batch_id 
                WHERE order_return_item.order_id = '" . $_REQUEST['id'] . "'
            ");

            $order_type = ($order['payment_type'] == "credit") ? "Credit Sale Return" : "Cash Sale Return";

        } else {
            $nameSHow = 'Customer';
            $id = (int) $_REQUEST['id'];
            $sql = "SELECT o.*, c.*
                    FROM orders o
                    INNER JOIN customers c
                    ON o.customer_account = c.customer_id
                    WHERE o.order_id = '$id'
                  ";

            $order = mysqli_fetch_assoc(mysqli_query($dbc, $sql));
            $getDate = $order['order_date'];
            $comment = $order['order_narration'];

            $order_item = mysqli_query($dbc, "
                SELECT order_item.*, product.*, product_batches.batch_no, product_batches.expiry_date as b_exp
                FROM order_item
                INNER JOIN product ON order_item.product_id = product.product_id
                LEFT JOIN product_batches ON order_item.batch_id = product_batches.batch_id
                WHERE order_item.order_id = '" . $_REQUEST['id'] . "'
            ");

            $order_type = ($order['payment_type'] == "credit_sale") ? $order['credit_sale_type'] . " (Credit)" : "Cash Sale";
        }

        $id = in_array($_REQUEST['type'] ?? '', ['purchase', 'purchase_return'])
            ? $order['purchase_id']
            : $order['order_id'];
        ?>

        <div class="page-container">
            <span class="copy-label"><?= $copy ?></span>

            <div class="company-header">
                <h1 class="company-name">
                    <span class="amg">AMG</span><br>
                    <span class="enterprises">ENTERPRISES <br>
                        <div class="distributors">(DISTRIBUTORS)</div>
                    </span>

                </h1>
                <div class="company-details">
                    <?= $get_company['address'] ?><br>
                    PH:
                    <?= $get_company['company_phone'] ?>
                    <?= !empty($get_company['personal_phone']) ? ' | ' . $get_company['personal_phone'] : '' ?>
                </div>
            </div>

            <div class="invoice-header">
                <div class="customer-section">
                    <table>
                        <tr>
                            <th><?= strtoupper($nameSHow) ?></th>
                            <td style="font-weight: 900;">: <?= strtoupper($order['customer_name']) ?></td>

                        </tr>
                        <tr>
                            <th>PHONE</th>
                            <td>: <?= !empty($order['customer_phone']) ? strtoupper($order['customer_phone']) : '_____' ?>
                            </td>
                        </tr>
                        <tr>
                            <th>ADDRESS</th>
                            <td>:
                                <?= !empty($order['customer_address']) ? strtoupper($order['customer_address']) : '____' ?>
                            </td>
                        </tr>
                        <!-- <tr>
                            <th>AREA</th>
                            <td>: <?= !empty($order['customer_area']) ? strtoupper($order['customer_area']) : '____' ?>
                            </td>
                        </tr> -->
                    </table>
                </div>
                <div class="invoice-meta-right">
                    <div><strong>DATE:</strong> <?= date('d/m/Y', strtotime($order['timestamp'])) ?></div>
                    <div><strong>INVOICE NO:</strong> <?= sprintf(" %05d", $id) ?></div>
                </div>
            </div>

            <table class="products-table">
                <thead>
                    <tr>
                        <th width="60" class="text-center">QTY</th>
                        <th class="text-left">PRODUCTS</th>
                        <th width="130" class="text-left">FORM PACK</th>
                        <th width="110" class="text-center">BATCH NO.</th>
                        <th width="90" class="text-right">RATE</th>
                        <th width="70" class="text-right">%AGE</th>
                        <th width="110" class="text-right">AMOUNT</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $c = 0;
                    $rowCount = mysqli_num_rows($order_item);
                    while ($r = mysqli_fetch_assoc($order_item)) {
                        $c++;
                        $totalQTY += $r['quantity'];
                        ?>
                        <tr>
                            <td class="text-center"><?= $r['quantity'] ?></td>
                            <td class="text-left"><?= strtoupper($r['product_name']) ?></td>
                            <td class="text-left"><?= !empty($r['product_pack']) ? $r['product_pack'] : '---' ?></td>
                            <td class="text-center"><?= $r['batch_no'] ?? '---' ?></td>
                            <td class="text-right"><?= number_format($r['rate'], 2) ?></td>
                            <td class="text-right">0.00</td>
                            <td class="text-right"><?= number_format($r['rate'] * $r['quantity'], 2) ?></td>
                        </tr>
                    <?php } ?>
                </tbody>
            </table>

            <div class="summary-section">
                <div class="items-count">
                    ITEMS: &nbsp;&nbsp;<?= $rowCount ?>
                </div>
                <div class="totals-box">
                    <div class="totals-breakdown">
                        <table>
                            <tr>
                                <td class="label">Amount</td>
                                <td class="amount"><?= number_format($order['grand_total'], 2) ?></td>
                            </tr>
                            <tr>
                                <td class="label">Total value</td>
                                <td class="amount"><?= number_format($order['total_amount'], 2) ?></td>
                            </tr>
                            <?php if (isset($order['freight']) && $order['freight'] > 0): ?>
                                <tr>
                                    <td class="label">Freight</td>
                                    <td class="amount"><?= number_format($order['freight'], 2) ?></td>
                                </tr>
                            <?php endif; ?>
                        </table>
                    </div>
                    <div class="net-payable-header">Net Payable
                        &nbsp;&nbsp;&nbsp;&nbsp;<?= number_format($order['grand_total'], 0) ?></div>
                </div>
            </div>

            <div class="legal-section">
                <span class="legal-title">Form 2A (See Rule 19 and 30)</span>
                <span class="legal-title">WARRANTY Under section 23(1) of Drugs Act 1976.</span>
                <div class="warranty-text">
                    I MUHAMMAD AFZAL being a person resident in Pakistan carrying on business at P-160 Rachna Town # 1
                    Satyana Road Faisalabad, under the name of AMG ENTERPRISES DIS. and being an authorised
                    agent do hereby give this warranty that drugs here-under described and/sold by me, specified and
                    contained in the bill of sale, invoices, bill of lading or other documents describing goods referred to
                    here in do not contravenes in any way the provision of section 23 of drugs Act 1976.
                    <br><br>
                    WARRANTY UNDER ALTERNATIVE MEDICINES & HEALTH PRODUCTS (Enlistment) Rules. 2014. [See rule 10 (3) & (5)]
                    I MUHAMMAD AFZAL, as the authorized distributors / agents and on behalf of the principals /
                    Manufacturers / Importers hereby give warranty that the supplied alternative medicines and health
                    products mentioned here in do not contravene any provision of the prevailing DRAP Act and rules framed
                    thereunder.
                    Confirm that I have read and I agree with Terms & Conditions printed overleaf
                </div>
            </div>

            <div class="footer-notes">
                <div class="note-line">NOTE: Date items must be informed 6 months before expiry</div>
                <div class="note-line">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No claim will be accepted
                    for leakage, breakage or shortage</div>
            </div>

            <div class="footer-bottom">
                <div class="computerized-info"></div>

                <div class="signature-box">
                    <img src="signature.jpeg" alt="Signature" class="signature-img">
                    <div class="signature-line">Signature</div>
                </div>
            </div>
        </div>
        <div style="text-align: center;">
            Software Developed by TheWebConcept (+92 313 7573667)
        </div>
    <?php endfor; ?>

    <script type="text/javascript">
        function printInvoice(showLegal) {
            const legalSection = document.querySelector('.legal-section');
            const legalSignature = document.querySelector('.footer-bottom');
            if (legalSection) {
                legalSection.style.display = showLegal ? 'block' : 'none';
                legalSignature.style.display = showLegal ? 'flex' : 'none';
            }

            window.print();

            // Restore visibility
            if (legalSection) {
                legalSection.style.display = 'block';
                legalSignature.style.display = 'flex';
            }
        }
    </script>
</body>

</html>