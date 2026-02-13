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
						<h4 style="color:white"><b>Product Purchase Report</b></h4>
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
									<label>Supplier (optional)</label>
									<select class="form-control searchableSelect" name="supplier_id">
										<option value="">All Suppliers</option>
										<?php
										$supSql = "SELECT * FROM customers 
                                                    WHERE customer_status = 1 
                                                    AND customer_type = 'supplier' 
                                                    ORDER BY customer_name ASC";
										$supData = $connect->query($supSql);

										while ($sup = $supData->fetch_assoc()) {
										$selected = (isset($_POST['supplier_id']) && $_POST['supplier_id'] == $sup['customer_id']) ? 'selected' : '';

											echo "<option value='{$sup['customer_id']}' $selected>{$sup['customer_name']}</option>";
										}
										?>
									</select>
								</div>

								<div class="col-sm-4 col-md-3">
									<label style="visibility: hidden;">Search</label><br>
									<button type="submit" name="show_details" class="btn btn-danger">
                                                  Show Details</button>
								</div>

							</div>
						</form>
					</div>
				</div>

				<!-- REPORT DISPLAY -->
				<?php if (isset($_POST['show_details']) && !empty($_POST['productName'])): ?>

					<?php
					$product_id = mysqli_real_escape_string($connect, $_POST['productName']);
					$supplier_id = !empty($_POST['supplier_id']) ? mysqli_real_escape_string($connect, $_POST['supplier_id']) : '';

					// Build WHERE clause
					$where = ["pi.product_id = '$product_id'"];
					if ($supplier_id) {
						$where[] = "p.customer_account = '$supplier_id'";

					}

					$sql = "SELECT pi.*, p.purchase_date, p.purchase_id, 
                                   c.customer_name, c.customer_phone,
                                   prod.product_name
                            FROM purchase_item pi
                            INNER JOIN purchase p ON pi.purchase_id = p.purchase_id
                            INNER JOIN product prod ON pi.product_id = prod.product_id
							LEFT JOIN customers c ON p.customer_account = c.customer_id
                            WHERE " . implode(" AND ", $where) . "
                            ORDER BY p.purchase_date DESC, pi.purchase_item_id DESC";

					$result = $connect->query($sql);

					if (!$result) {
						echo '<div class="alert alert-danger mt-4">Database error: ' . $connect->error . '</div>';
						$total_qty = 0;
						$total_amount = 0;
					} else {
						$total_qty = 0;
						$total_amount = 0;
					}
					?>

					<div class="card mt-4">
						<div class="card-header card-bg text-center">
							<h4 style="color:white">
								<b>Product Purchase Report</b>
								<button onclick="window.print()" class="btn btn-admin btn-sm float-right">Print</button>
							</h4>
							<div class="report-subtitle">
								<?php
								$prod_query = $connect->query("SELECT product_name FROM product WHERE product_id = '$product_id'");
								$prod_name = $prod_query ? $prod_query->fetch_assoc()['product_name'] ?? 'Selected Product' : 'Selected Product';

								echo "<strong style='color:white'>Product:</strong> <span style='color:white'>$prod_name</span> ";

								if ($supplier_id) {
									$sup_query = $connect->query("SELECT customer_name FROM customers WHERE customer_id = '$supplier_id'");
									$sup_name = $sup_query ? $sup_query->fetch_assoc()['customer_name'] ?? '' : '';
									echo " &nbsp; | &nbsp; <strong style='color:white'>Supplier:</strong> <span style='color:white'>$sup_name</span>";
								} else {
									echo " &nbsp; | &nbsp; <em><span style='color:white'>All Suppliers</span></em>";
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
											<th>Purchase #</th>
											<!-- <th>Invoice #</th> -->
											<th>Supplier</th>
											<th>Quantity</th>
											<th>Rate</th>
											<th>Total</th>
										</tr>
									</thead>
									<tbody>
										<?php
										$sl = 1;
										if ($result && $result->num_rows > 0):
											while ($row = $result->fetch_assoc()):
												$total_qty += (float) $row['quantity'];
												$total_amount += (float) $row['total'] ?? (float) $row['quantity'] * (float) $row['rate'];
												?>
												<tr>
													<td><?= $sl++ ?></td>
													<td><?= date('d-m-Y', strtotime($row['purchase_date'])) ?></td>
													<td><?= htmlspecialchars($row['purchase_id']) ?></td>
													<!-- <td><?= htmlspecialchars($row['invoice_number'] ?? '-') ?></td> -->
													<td>
														<?= htmlspecialchars($row['customer_name'] ?: 'N/A') ?>
														<?php if (!empty($row['customer_phone'])): ?>
															<br><small><?= htmlspecialchars($row['customer_phone']) ?></small>
														<?php endif; ?>
													</td>
													<td class="text-right"><?= number_format($row['quantity'], 0) ?></td>
													<td class="text-right"><?= number_format($row['rate'] ?? 0, 2) ?></td>
													<td class="text-right">
														<?= number_format($row['total_amount'] ?? ($row['quantity'] * $row['rate'] ?? 0), 2) ?>
													</td>
												</tr>
												<?php
											endwhile;
										else:
											?>
											<tr>
												<td colspan="8" class="text-center text-muted py-4">
													No purchase records found for this
													product<?= $supplier_id ? ' and supplier' : '' ?>.
												</td>
											</tr>
										<?php endif; ?>
									</tbody>

									<?php if ($result && $result->num_rows > 0): ?>
										<tfoot>
											<tr class="total-row">
												<td colspan="4" class="text-right">Total Quantity Purchased:</td>
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