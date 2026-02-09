<!DOCTYPE html>
<html lang="en">
<?php include_once 'includes/head.php'; ?>
<head>
    <meta charset="UTF-8">
    <title>Sale Invoice - Form 2A</title>
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap');

        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            color: #000;
            background-color: #f1f1f1;
            font-size: 11pt;
            line-height: 1.2;
        }

        .container {
            width: 210mm;
            min-height: 297mm;
            margin: 10mm auto;
            background: #fff;
            padding: 10mm;
            box-sizing: border-box;
            position: relative;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        @media print {
            body { background: none; margin: 0; padding: 0; }
            .container { 
                margin: 0; 
                box-shadow: none; 
                page-break-after: always;
            }
            .no-print { display: none; }
        }

        /* Header Layout: Customer on Left, Company on Right */
        .header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .customer-info {
            width: 50%;
        }

        .customer-info table {
            width: 100%;
            border-collapse: collapse;
        }

        .customer-info th {
            text-align: left;
            width: 80px;
            font-weight: 700;
            padding: 2px 0;
        }
        
        .customer-info td {
            text-align: left;
            padding: 2px 0;
        }

        .company-branding {
            text-align: right;
            width: 50%;
        }

        .company-name {
            font-size: 26pt;
            font-weight: 900;
            color: #000;
            margin: 0;
            line-height: 1;
        }

        .company-details {
            font-size: 9pt;
            margin-top: 5px;
            font-weight: 500;
        }

        /* Meta Section (Date/Invoice) */
        .meta-row {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
            font-weight: 700;
        }

        .meta-row span {
            margin-left: 20px;
        }

        /* Legal Context */
        .legal-context {
            margin-top: 20px;
            font-size: 9pt;
            border-top: 1px solid #000;
            padding-top: 10px;
        }

        .legal-title {
            font-weight: 700;
            text-decoration: underline;
            margin-bottom: 5px;
            display: block;
        }

        .warranty-text {
            font-size: 8pt;
            line-height: 1.3;
            text-align: justify;
        }

        /* Table Design */
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .items-table th {
            border-top: 2px solid #000;
            border-bottom: 2px solid #000;
            padding: 8px 5px;
            font-size: 10pt;
            text-transform: uppercase;
        }

        .items-table td {
            padding: 10px 5px;
            border-bottom: 1px dotted #ccc;
            font-size: 10pt;
        }

        .text-center { text-align: center; }
        .text-right { text-align: right; }
        .text-left { text-align: left; }

        /* Totals / Net Payable */
        .totals-container {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .count-info {
            font-weight: 700;
        }

        .net-payable-box {
            text-align: right;
        }

        .net-payable-title {
            font-size: 18pt;
            font-weight: 900;
            margin-bottom: 5px;
        }

        .totals-table {
            margin-left: auto;
            width: 250px;
        }

        .totals-table td {
            padding: 5px 0;
            font-weight: 700;
        }

        /* Footer */
        .footer-notes {
            margin-top: 40px;
            font-size: 9pt;
            border-top: 1px solid #000;
            padding-top: 10px;
        }

        .note-item {
            font-weight: 700;
            margin-bottom: 5px;
        }

        .footer-bottom {
            margin-top: 40px;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .signature-area {
            width: 200px;
            border-top: 1px solid #000;
            text-align: center;
            padding-top: 5px;
            font-weight: 700;
        }

        .computerized-note {
            font-size: 8pt;
            color: #555;
            width: 60%;
        }

        .copy-tag {
            position: absolute;
            top: 5mm;
            left: 5mm;
            font-size: 8pt;
            font-weight: 700;
            text-transform: uppercase;
            color: #888;
        }
    </style>
</head>
<body>
    <?php for ($i = 0; $i < 2; $i++) :
        $totalQTY = 0;
        $copy = ($i > 0) ? "Company Copy" : "Customer Copy";

        if ($_REQUEST['type'] == "purchase") {
            $nameSHow = 'Supplier';
            $order = fetchRecord($dbc, "purchase", "purchase_id", $_REQUEST['id']);
            $comment = $order['purchase_narration'];
            $getDate = $order['purchase_date'];
            $order_type = ($order['payment_type'] == "credit_purchase") ? "Credit Purchase" : "Cash Purchase";
            $order_item = mysqli_query($dbc, "SELECT purchase_item.*,product.* FROM purchase_item INNER JOIN product ON purchase_item.product_id=product.product_id WHERE purchase_item.purchase_id='" . $_REQUEST['id'] . "'");
        } else {
            $nameSHow = 'Customer';
            $order = fetchRecord($dbc, "orders", "order_id", $_REQUEST['id']);
            $getDate = $order['order_date'];
            $comment = $order['order_narration'];
            $order_item = mysqli_query($dbc, "SELECT order_item.*, product.*, product_batches.batch_no as b_no, product_batches.expiry_date as b_exp 
                                              FROM order_item 
                                              INNER JOIN product ON order_item.product_id=product.product_id 
                                              LEFT JOIN product_batches ON order_item.batch_id=product_batches.batch_id 
                                              WHERE order_item.order_id='" . $_REQUEST['id'] . "'");
            if ($order['payment_type'] == "credit_sale") {
                $order_type = ($order['payment_type'] == "none") ? "Credit Sale" : $order['credit_sale_type'] . " (Credit)";
            } else {
                $order_type = "Cash Sale";
            }
        }
    ?>

    <div class="container">
        <span class="copy-tag"><?= $copy ?></span>
        
        <div class="header">
            <div class="customer-info">
                <table>
                    <tr><th>CUSTOMER</th><td>: <?= strtoupper($order['client_name']) ?></td></tr>
                    <tr><th>ADDRESS</th><td>: <?= !empty($order['client_address']) ? strtoupper($order['client_address']) : '---' ?></td></tr>
                    <tr><th>CITY</th><td>: <?= !empty($order['client_city']) ? strtoupper($order['client_city']) : 'FSD' ?></td></tr>
                </table>
            </div>
            <div class="company-branding">
                <h1 class="company-name"><?= $get_company['name'] ?></h1>
                <div class="company-details">
                    PH: <?= $get_company['company_phone'] ?> | <?= $get_company['personal_phone'] ?><br>
                    <?= $get_company['address'] ?>
                </div>
            </div>
        </div>

        <div class="meta-row">
            <span>DATE: <?= date('d/m/Y', strtotime($order['timestamp'])) ?></span>
            <span>INVOICE NO: <?= sprintf("%05d", $_REQUEST['id']) ?></span>
        </div>

        <div class="legal-context">
            <span class="legal-title">Form 2A (See Rule 19 and 30)</span>
            <span class="legal-title">WARRANTY Under section 23(1) of Drugs Act 1976.</span>
            <div class="warranty-text">
                I MUHAMMAD IDREES being a person resident in Pakistan carrying on business at Doctor plaza main satyana road Main bazar Jaddah market Faisalabd, under the 
                name of ADNAN MEDICINE CO. and being an authorised agent do hereby give this warranty that drugs here-under described and/sold by me. specified and contained in 
                the bill of sale, invoices, bill of lading or other documents describing goods referred to here in do not contravenes in any way the provision of section 23 of drugs Act 1976.
                <br><br>
                WARRANTY UNDER ALTERNATIVE MEDICINES & HEALTH PRODUCTS(Enlistment) Rules. 2014. [See rule 10 (3) & (5)]
                I MUHAMMAD IDREES, as the authorized distributors / agents and on behalf of the principals / Manufacturers / Importers hereby give warranty that the supplied alternative 
                medicines and health products mentioned here in do not contravene any provision of the prevailing DRAP Act and rules framed thereunder.
                Confirm that I have read and I agree with Terms & Conditions printed overleaf
            </div>
        </div>

        <table class="items-table">
            <thead>
                <tr>
                    <th width="50" class="text-center">QTY</th>
                    <th class="text-left">PRODUCTS</th>
                    <th width="120" class="text-left">FORM PACK</th>
                    <th width="100" class="text-left">BATCH NO.</th>
                    <th width="80" class="text-right">RATE</th>
                    <th width="60" class="text-right">%AGE</th>
                    <th width="100" class="text-right">AMOUNT</th>
                </tr>
            </thead>
            <tbody>
                <?php $c = 0;
                $rowCount = mysqli_num_rows($order_item);
                while ($r = mysqli_fetch_assoc($order_item)) {
                    $c++;
                    $totalQTY += $r['quantity'];
                    $item_discount = ($order['total_amount'] > 0) ? ($order['discount'] / $order['total_amount'] * 100) : 0;
                    // Note: %AGE in ref image is product-wise, but we use order-wise discount usually. 
                    // Showing 0 if not explicitly defined per product.
                ?>
                <tr>
                    <td class="text-center"><?= $r['quantity'] ?></td>
                    <td class="text-left"><?= strtoupper($r['product_name']) ?></td>
                    <td class="text-left"><?= !empty($r['product_detail']) ? $r['product_detail'] : '---' ?></td>
                    <td class="text-center"><?= $r['b_no'] ?? '---' ?></td>
                    <td class="text-right"><?= number_format($r['rate'], 2) ?></td>
                    <td class="text-right">0.00</td>
                    <td class="text-right"><?= number_format($r['rate'] * $r['quantity'], 2) ?></td>
                </tr>
                <?php } ?>
            </tbody>
        </table>

        <div class="totals-container">
            <div class="count-info">
                ITEMS: &nbsp;&nbsp; <?= $rowCount ?>
            </div>
            <div class="net-payable-box">
                <div class="net-payable-title">Net Payable &nbsp;&nbsp;&nbsp;&nbsp; <?= number_format($order['grand_total'], 0) ?></div>
                <table class="totals-table">
                    <tr>
                        <td class="text-left">Total value</td>
                        <td class="text-right"><?= number_format($order['total_amount'], 2) ?></td>
                    </tr>
                    <?php if($order['freight'] > 0): ?>
                    <tr>
                        <td class="text-left">Freight</td>
                        <td class="text-right"><?= number_format($order['freight'], 2) ?></td>
                    </tr>
                    <?php endif; ?>
                    <tr>
                        <td class="text-left">Amount</td>
                        <td class="text-right"><?= number_format($order['grand_total'], 2) ?></td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="footer-notes">
            <div class="note-item">NOTE: Date items must be informed 6 months before expiry</div>
            <div class="note-item">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No claim will be accepted for leakage, breakage or shortage</div>
        </div>

        <div class="footer-bottom">
            <div class="computerized-note">
                Computerized By Punjab Computer Center Sargodha 0333-6796415
            </div>
            <div class="signature-area">
                Signature
            </div>
        </div>
    </div>
    <?php endfor; ?>

    <script type="text/javascript">
        window.print();
    </script>
</body>
</html>