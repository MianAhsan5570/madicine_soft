<!DOCTYPE html>
<html lang="en">
<?php include_once 'includes/head.php'; ?>

<style type="text/css">
	thead tr th {
		font-size: 19px !important;
		font-weight: bolder !important;
		color: #000 !important;
	}

	tbody tr th,
	tbody tr th p {
		font-size: 18px !important;
		font-weight: bolder !important;
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

				<!-- ================= FILTER FORM ================= -->
				<div class="card d-print-none">
					<div class="card-header card-bg text-center">
						<h4 style="color:white"><b>Sale Report</b></h4>
					</div>

					<div class="card-body">
						<form method="get">
							<div class="row">
								<div class="col-sm-3">
									<label>Customer Account</label>
									<select class="form-control searchableSelect" name="customer_id">
										<option value="">All</option>
										<?php
										$res = mysqli_query($dbc, "SELECT * FROM customers WHERE customer_status=1 AND customer_type='customer'");
										while ($c = mysqli_fetch_assoc($res)) {
											$sel = (@$_REQUEST['customer_id'] == $c['customer_id']) ? 'selected' : '';
											echo "<option value='{$c['customer_id']}' $sel>{$c['customer_name']}</option>";
										}
										?>
									</select>
								</div>

								<div class="col-sm-3">
									<label>From</label>
									<input type="text" class="form-control" id="from" name="from_date"
										value="<?= @$_REQUEST['from_date'] ?>" autocomplete="off"
										placeholder="Start Date">
								</div>

								<div class="col-sm-3">
									<label>To</label>
									<input type="text" class="form-control" id="to" name="to_date"
										value="<?= @$_REQUEST['to_date'] ?>" autocomplete="off" placeholder="End Date">
								</div>

								<div class="col-sm-2">
									<label>Sale Type</label>
									<select class="form-control" name="sale_type">
										<option value="all">All</option>
										<option value="cash_in_hand" <?= (@$_REQUEST['sale_type'] == 'cash_in_hand') ? 'selected' : '' ?>>Cash Sale</option>
										<option value="credit_sale" <?= (@$_REQUEST['sale_type'] == 'credit_sale') ? 'selected' : '' ?>>Credit Sale</option>
									</select>
								</div>

								<div class="col-sm-1">
									<label style="visibility:hidden">a</label><br>
									<button class="btn btn-admin2" name="search_sale">Search</button>
								</div>
							</div>
						</form>
					</div>
				</div>

				<!-- ================= REPORT ================= -->
				<?php if (isset($_REQUEST['search_sale'])): ?>

					<?php
					$where = [];

					if (!empty($_REQUEST['customer_id'])) {
						$where[] = "customer_account='" . mysqli_real_escape_string($dbc, $_REQUEST['customer_id']) . "'";
					}

					if (!empty($_REQUEST['sale_type']) && $_REQUEST['sale_type'] != 'all') {
						$where[] = "payment_type='" . mysqli_real_escape_string($dbc, $_REQUEST['sale_type']) . "'";
					}

					if (!empty($_REQUEST['from_date']) && !empty($_REQUEST['to_date'])) {
						$where[] = "order_date BETWEEN '{$_REQUEST['from_date']}' AND '{$_REQUEST['to_date']}'";
					}

					$whereSql = (!empty($where)) ? 'WHERE ' . implode(' AND ', $where) : '';

					$q = "SELECT * FROM orders $whereSql ORDER BY order_date DESC";
					$query = mysqli_query($dbc, $q);

					$cashTotal = 0;
					$creditTotal = 0;
					$grandTotal = 0;
					$i = 1;
					?>

					<div class="card">
						<div class="card-header card-bg text-center">
							<h4 style="color:white">
								<b>Sale Report</b>
								<button onclick="window.print()" class="btn btn-admin btn-sm float-right">Print</button>
							</h4>
							<?php
							$dateDisplay = '';
							if (!empty($_GET['from_date']) && !empty($_GET['to_date'])) {
								$dateDisplay = "From <b>" . date('d-m-Y', strtotime($_GET['from_date'])) . "</b> 
                                               To <b>" . date('d-m-Y', strtotime($_GET['to_date'])) . "</b>";
							} else {
								$dateDisplay = "<i>Showing all available records (no date filter applied)</i>";
							}
							?>
							<div class="report-subtitle mt-2"><?= $dateDisplay ?></div>
						</div>

						<div class="card-body">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>#</th>
										<th>Date</th>
										<th>Bill#</th>
										<th>Item</th>
										<th>Qty</th>
										<th>Rate</th>
										<th>Total</th>
										<th>Payment</th>
										<th>Customer</th>
										<th>Type</th>
									</tr>
								</thead>

								<tbody>
									<?php while ($r = mysqli_fetch_assoc($query)): ?>

										<?php
										$grandTotal += $r['grand_total'];

										if ($r['payment_type'] == 'cash_in_hand') {
											$cashTotal += $r['grand_total'];
										} else {
											$creditTotal += $r['grand_total'];
										}
										?>

										<tr>
											<th><?= $i++ ?></th>
											<th><?= date('d-m-Y', strtotime($r['order_date'])) ?></th>
											<th><?= $r['order_id'] ?></th>

											<th>
												<?php
												$items = mysqli_query($dbc, "SELECT * FROM order_item WHERE order_id='{$r['order_id']}'");
												while ($it = mysqli_fetch_assoc($items)) {
													$p = fetchRecord($dbc, 'product', 'product_id', $it['product_id']);
													echo "<p>{$p['product_name']}</p>";
												}
												?>
											</th>

											<th>
												<?php
												$items = mysqli_query($dbc, "SELECT * FROM order_item WHERE order_id='{$r['order_id']}'");
												while ($it = mysqli_fetch_assoc($items)) {
													echo "<p>{$it['quantity']}</p>";
												}
												?>
											</th>

											<th>
												<?php
												$items = mysqli_query($dbc, "SELECT * FROM order_item WHERE order_id='{$r['order_id']}'");
												while ($it = mysqli_fetch_assoc($items)) {
													echo "<p>{$it['rate']}</p>";
												}
												?>
											</th>

											<th>
												<?php
												$items = mysqli_query($dbc, "SELECT * FROM order_item WHERE order_id='{$r['order_id']}'");
												while ($it = mysqli_fetch_assoc($items)) {
													echo "<p>{$it['total']}</p>";
												}
												?>
											</th>

											<th>
												Grand: <?= $r['grand_total'] ?><br>
												Paid: <?= $r['paid'] ?><br>
												Due: <?= $r['due'] ?>
											</th>

											<th><?= $r['client_name'] ?><br><?= $r['client_contact'] ?></th>
											<th><?= $r['payment_type'] ?></th>
										</tr>

									<?php endwhile; ?>
								</tbody>

								<!-- TOTALS ROW -->
								<tfoot>
									<tr class="total-row">
										<td colspan="6" class="text-center">
											<h4>Cash Sale</h4>
										</td>
										<td>
											<h4><?= number_format($cashTotal, 2) ?></h4>
										</td>
										<td>
											<h4>Credit Sale</h4>
										</td>
										<td>
											<h4><?= number_format($creditTotal, 2) ?></h4>
										</td>
									</tr>
									<tr class="total-row">
										<td colspan="6" class="text-center">
											<h4>Total Sale Amount</h4>
										</td>
										<td>
											<h4><?= number_format($grandTotal, 2) ?></h4>
										</td>
										<td colspan="3"></td>
									</tr>
								</tfoot>

							</table>
						</div>
					</div>

				<?php endif; ?>

			</div>
		</main>
	</div>

	<?php include_once 'includes/foot.php'; ?>

	<script>
		$(function () {
			$("#from,#to").datepicker({
				dateFormat: "yy-mm-dd",
				changeMonth: true,
				changeYear: true
			});
		});
	</script>

</body>

</html>