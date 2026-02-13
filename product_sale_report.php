<!DOCTYPE html>
<html lang="en">
<?php include_once 'includes/head.php'; ?>

<style type="text/css">
	thead tr th {
		font-size: 19px !important;
		font-weight: bolder !important;
		color: #000 !important;
		background-color: #f8f9fa;
	}

	tbody tr td {
		font-size: 17px !important;
		font-weight: 500 !important;
		vertical-align: middle;
		color: #000 !important;
	}

	.total-row td {
		font-weight: bold !important;
		font-size: 18px !important;
		background-color: #f8f9fa;
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
						<h4 style="color:white"><b>Product Sale Report</b></h4>
					</div>

					<div class="card-body">
						<form method="post">
							<div class="row align-items-end">

								<div class="col-sm-4 col-md-3">
									<label>Product <span class="text-danger">*</span></label>
									<select class="form-control searchableSelect" name="productName" id="productName"
										required>
										<option value="">SELECT PRODUCT</option>
										<?php
										$productSql = "SELECT p.*, c.categories_name, b.brand_name 
                                                       FROM product p 
                                                       LEFT JOIN categories c ON p.category_id = c.categories_id 
                                                       LEFT JOIN brands b ON p.brand_id = b.brand_id 
                                                       ORDER BY p.product_name ASC";
										$productData = $connect->query($productSql);

										while ($row = $productData->fetch_assoc()) {
											$cat = $row['categories_name'] ? " ({$row['categories_name']})" : "";
											$brand = $row['brand_name'] ? " [{$row['brand_name']}]" : "";
											echo "<option value='{$row['product_id']}' " .
												(isset($_POST['productName']) && $_POST['productName'] == $row['product_id'] ? 'selected' : '') .
												">{$row['product_name']}$cat$brand</option>";
										}
										?>
									</select>
								</div>

								<div class="col-sm-4 col-md-3">
									<label>Customer (optional)</label>
									<select class="form-control searchableSelect" name="customer_id">
										<option value="">All Customers</option>
										<?php
										$custSql = "SELECT * FROM customers 
                                                    WHERE customer_status = 1 
                                                    AND customer_type = 'customer' 
                                                    ORDER BY customer_name ASC";
										$custData = $connect->query($custSql);

										while ($cust = $custData->fetch_assoc()) {
											$selected = (isset($_POST['customer_id']) && $_POST['customer_id'] == $cust['customer_id']) ? 'selected' : '';
											echo "<option value='{$cust['customer_id']}' $selected>{$cust['customer_name']}</option>";
										}
										?>
									</select>
								</div>

								<div class="col-sm-4 col-md-3">
									<label style="visibility: hidden;">Search</label><br>
									<button type="submit" name="show_details" class="btn btn-danger">
									 Show Report
									</button>
								</div>

							</div>
						</form>
					</div>
				</div>

				<!-- REPORT DISPLAY -->
				<?php if (isset($_POST['show_details']) && !empty($_POST['productName'])): ?>

					<?php
					$product_id = mysqli_real_escape_string($dbc, $_POST['productName']);
					$customer_id = !empty($_POST['customer_id']) ? mysqli_real_escape_string($dbc, $_POST['customer_id']) : '';

					// Build WHERE clause
					$where = ["oi.product_id = '$product_id'"];
					if ($customer_id) {
						$where[] = "o.customer_account = '$customer_id'";
					}

					$sql = "SELECT oi.*, o.order_date, o.order_id, c.customer_name, c.customer_phone,
                                   p.product_name, c.customer_name AS account_name
                            FROM order_item oi
                            INNER JOIN orders o ON oi.order_id = o.order_id
                            INNER JOIN product p ON oi.product_id = p.product_id
                            LEFT JOIN customers c ON o.customer_account = c.customer_id
                            WHERE " . implode(" AND ", $where) . "
                            ORDER BY o.order_date DESC, oi.order_item_id DESC";

					$result = mysqli_query($dbc, $sql);

					$total_qty = 0;
					$total_amount = 0;
					?>

					<div class="card mt-4">
						<div class="card-header card-bg text-center">
							<h4 style="color:white"><b>Product Sale Report</b>
						<button onclick="window.print()" class="btn btn-admin btn-sm float-right">Print</button></h4>
							<div class="report-subtitle">
								<?php
								$prod_name = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT product_name FROM product WHERE product_id = '$product_id'"))['product_name'] ?? 'Selected Product';
								echo "<strong style='color:white'>Product:</strong><span style='color:white'> $prod_name </span> ";
								if ($customer_id) {
									$cust_name = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT customer_name FROM customers WHERE customer_id = '$customer_id'"))['customer_name'] ?? '';
									echo " &nbsp; | &nbsp; <strong>Customer:</strong> <span style='color:white'> $cust_name </span>";
								} else {
									echo " &nbsp; | &nbsp; <em><span style='color:white'>All Customers</span></em>";
								}
								?>
							</div>
						</div>

						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>#</th>
											<th>Date</th>
											<th>Order #</th>
											<th>Customer</th>
											<th>Quantity</th>
											<th>Rate</th>
											<th>Total</th>
										</tr>
									</thead>
									<tbody>
										<?php
										$sl = 1;
										while ($row = mysqli_fetch_assoc($result)):
											$total_qty += $row['quantity'];
											$total_amount += $row['total'];
											?>
											<tr>
												<td><?= $sl++ ?></td>
												<td><?= date('d-m-Y', strtotime($row['order_date'])) ?></td>
												<td><?= $row['order_id'] ?></td>
												<td>
													<?= htmlspecialchars($row['customer_name'] ?: $row['account_name'] ?: 'Cash / Walk-in') ?>
													<?php if (!empty($row['customer_phone'])): ?>
														<br><small><?= $row['customer_phone'] ?></small>
													<?php endif; ?>
												</td>
												<td class="text-right"><?= number_format($row['quantity'], 0) ?></td>
												<td class="text-right"><?= number_format($row['rate'], 2) ?></td>
												<td class="text-right"><?= number_format($row['total'], 2) ?></td>
											</tr>
										<?php endwhile; ?>

										<?php if (mysqli_num_rows($result) == 0): ?>
											<tr>
												<td colspan="7" class="text-center text-muted py-4">
													No sales found for this product<?= $customer_id ? ' and customer' : '' ?>.
												</td>
											</tr>
										<?php endif; ?>
									</tbody>

									<?php if (mysqli_num_rows($result) > 0): ?>
										<tfoot>
											<tr class="total-row">
												<td colspan="4" class="text-right">Total Quantity Sold:</td>
												<td class="text-right"><?= number_format($total_qty, 0) ?></td>
												<td class="text-right">Total Amount:</td>
												<td class="text-right"><?= number_format($total_amount, 2) ?></td>
											</tr>
										</tfoot>
									<?php endif; ?>
								</table>
							</div>
						</div>
					</div>

				<?php elseif (isset($_POST['show_details'])): ?>
					<div class="alert alert-warning mt-4">
						Please select a product to generate the report.
					</div>
				<?php endif; ?>

			</div> <!-- .container-fluid -->
		</main>
	</div>

	<?php include_once 'includes/foot.php'; ?>
</body>

</html>