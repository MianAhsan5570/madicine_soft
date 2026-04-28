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

	.qty-sum  { color: #000;  font-weight: bold; }
	.qty-part { color: #444; }

	.disc-pct  { font-size: 12px; color: #888; display: block; }
	.disc-amt  { font-size: 15px; color: #c0392b; font-weight: bold; }
	.bonus-qty { font-size: 15px; color: #1a7a4a; font-weight: bold; }

	@media print {
    /* Prevents the footer from repeating on every page */
    tfoot {
        display: table-row-group;
    }

    /* Optional: If you want the header to also only appear on the first page, 
       uncomment the line below */
    /* thead { display: table-row-group; } */
    
    /* Ensures the table doesn't break inside a row awkwardly */
    tr {
        page-break-inside: avoid;
    }
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
										<option value="credit_sale"  <?= (@$_REQUEST['sale_type'] == 'credit_sale')  ? 'selected' : '' ?>>Credit Sale</option>
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

				$q     = "SELECT * FROM orders $whereSql ORDER BY order_date DESC";
				$query = mysqli_query($dbc, $q);

				$cashTotal      = 0;
				$creditTotal    = 0;
				$grandTotal     = 0;
				$totalOrderDisc = 0;  // sum of order-level discount amounts
				$totalItemDisc  = 0;  // sum of item-level discount amounts
				$totalBonusQty  = 0;  // sum of all bonus units
				$i = 1;
				?>

				<div class="card">
					<div class="card-header card-bg text-center" style="color:white">
						<h4 style="color:white">
							<b>Sale Report</b>
							<button onclick="window.print()" class="btn btn-admin btn-sm float-right">Print</button>
						</h4>
						<?php
						if (!empty($_GET['from_date']) && !empty($_GET['to_date'])) {
							echo "From <b>" . date('d-m-Y', strtotime($_GET['from_date'])) . "</b> To <b>" . date('d-m-Y', strtotime($_GET['to_date'])) . "</b>";
						} else {
							echo "<i>Showing all available records (no date filter applied)</i>";
						}
						?>
					</div>

					<div class="card-body">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Date</th>
									<th>Bill#</th>
									<th>Item</th>
									<th>Qty<br><small style="font-weight:normal">(reg + bonus = total)</small></th>
									<th>Rate</th>
									<th>Total</th>
									<th>Order Disc.<br><small style="font-weight:normal">(% of order)</small></th>
									<th>Item Disc.<br><small style="font-weight:normal">(% per item)</small></th>
									<th>Payment</th>
									<th>Customer</th>
									<th>Type</th>
								</tr>
							</thead>

							<tbody>
								<?php while ($r = mysqli_fetch_assoc($query)):

									/* ---- per-order item aggregates ---- */
									$oid = $r['order_id'];

									/* order-level discount % → amount */
									$o_disc_pct = (float)($r['discount'] ?? 0);
									$o_disc_amt = 0;

									/* item-level: sum each item's own discount % */
									$i_disc_amt  = 0;
									$order_bonus = 0;

									$items_q = mysqli_query($dbc,
										"SELECT oi.*, p.product_name
										 FROM order_item oi
										 LEFT JOIN product p ON p.product_id = oi.product_id
										 WHERE oi.order_id='$oid'");

									$items_data      = [];
									$sub_total_items = 0;

									while ($it = mysqli_fetch_assoc($items_q)) {
										$items_data[] = $it;

										$qty         = (float)$it['quantity'];
										$rate        = (float)$it['rate'];
										$disc_pct    = (float)($it['discount'] ?? 0);

										/*
										 * Item discount amount (matches backend):
										 *   item_total_without_tax = qty × rate × (1 − disc%/100)
										 *   so disc_amount         = qty × rate × (disc%/100)
										 */
										$gross         = $qty * $rate;
										$i_disc_amt   += $gross * ($disc_pct / 100);

										/* collect item totals (post-item-disc + item tax, as stored) */
										$sub_total_items += (float)$it['total'];

										$order_bonus += (int)($it['bonus_qty'] ?? 0);
									}

									/*
									 * Order discount: base = SUM(stored item totals) × order_disc% / 100
									 * (matches previous working logic — no order tax added to base)
									 */
									$o_disc_amt = ($o_disc_pct > 0)
										? round($sub_total_items * $o_disc_pct / 100, 2)
										: 0;

									/* accumulate grand totals */
									$grandTotal     += $r['grand_total'];
									$totalOrderDisc += $o_disc_amt;
									$totalItemDisc  += $i_disc_amt;
									$totalBonusQty  += $order_bonus;

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

									<!-- Item names -->
									<th>
										<?php foreach ($items_data as $it): ?>
											<p><?= htmlspecialchars($it['product_name']) ?></p>
										<?php endforeach; ?>
									</th>

									<!-- Qty: reg + bonus = total -->
									<th>
										<?php foreach ($items_data as $it):
											$qty   = (int)$it['quantity'];
											$bonus = (int)($it['bonus_qty'] ?? 0);
											$tot   = $qty + $bonus;
											if ($bonus > 0): ?>
												<p>
													<span class="qty-part"><?= $qty ?></span>
													+
													<span class="qty-part bonus-qty"><?= $bonus ?></span>
													= <span class="qty-sum"><?= $tot ?></span>
												</p>
											<?php else: ?>
												<p><?= $tot ?></p>
											<?php endif; ?>
										<?php endforeach; ?>
									</th>

									<!-- Rate -->
									<th>
										<?php foreach ($items_data as $it): ?>
											<p><?= $it['rate'] ?></p>
										<?php endforeach; ?>
									</th>

									<!-- Item total -->
									<th>
										<?php foreach ($items_data as $it): ?>
											<p><?= $it['total'] ?></p>
										<?php endforeach; ?>
									</th>

									<!-- Order-level discount -->
									<th style="text-align:center; vertical-align:middle;">
										<?php if ($o_disc_pct > 0): ?>
											<span class="disc-pct"><?= number_format($o_disc_pct, 2) ?>%</span>
											<span class="disc-amt"><?= number_format($o_disc_amt, 2) ?></span>
										<?php else: ?>
											—
										<?php endif; ?>
									</th>

									<!-- Item-level discount (per line) -->
									<th>
										<?php foreach ($items_data as $it):
											$pct  = (float)($it['discount'] ?? 0);
											$amt  = ($pct > 0)
												? (float)$it['quantity'] * (float)$it['rate'] * ($pct / 100)
												: 0;
											if ($pct > 0): ?>
												<p>
													<span class="disc-pct"><?= number_format($pct, 2) ?>%</span>
													<span class="disc-amt"><?= number_format($amt, 2) ?></span>
												</p>
											<?php else: ?>
												<p>—</p>
											<?php endif; ?>
										<?php endforeach; ?>
									</th>

									<!-- Payment -->
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

							<!-- TOTALS -->
							<tfoot>
								<tr class="total-row">
									<td colspan="6" class="text-center"><h4>Cash Sale</h4></td>
									<td><h4><?= number_format($cashTotal, 2) ?></h4></td>
									<td class="text-center"><h4>Credit Sale</h4></td>
									<td><h4><?= number_format($creditTotal, 2) ?></h4></td>
									<td colspan="3"></td>
								</tr>
								<tr class="total-row">
									<td colspan="6" class="text-center"><h4>Total Sale Amount</h4></td>
									<td><h4><?= number_format($grandTotal, 2) ?></h4></td>
									<td colspan="5"></td>
								</tr>
								<!-- Discount row: Order Disc | Item Disc | Total Disc -->
								<tr class="total-row">
									<td colspan="3" class="text-center"><h4>Order Discount</h4></td>
									<td colspan="2"><h4 style="color:#c0392b;"><?= number_format($totalOrderDisc, 2) ?></h4></td>
									<td colspan="2" class="text-center"><h4>Item Discount</h4></td>
									<td colspan="2"><h4 style="color:#c0392b;"><?= number_format($totalItemDisc, 2) ?></h4></td>
									<td class="text-center"><h4>Total Discount</h4></td>
									<td colspan="2"><h4 style="color:#c0392b;"><?= number_format($totalOrderDisc + $totalItemDisc, 2) ?></h4></td>
								</tr>
								<!-- Bonus row: Bonus Qty | Bonus Amount -->
								<?php
								/* compute bonus amount = sum of (bonus_qty × rate) across all orders in this result */
								/* re-run the same filtered query to get bonus value */
								$bonus_q = mysqli_query($dbc,
									"SELECT SUM(oi.bonus_qty * oi.rate) AS bonus_val
									 FROM order_item oi
									 INNER JOIN orders o ON o.order_id = oi.order_id
									 $whereSql");
								$bonus_row = mysqli_fetch_assoc($bonus_q);
								$totalBonusVal = (float)($bonus_row['bonus_val'] ?? 0);
								?>
								<tr class="total-row">
									<td colspan="3" class="text-center"><h4>Total Bonus Qty</h4></td>
									<td colspan="2"><h4 style="color:#1a7a4a;"><?= number_format($totalBonusQty, 0) ?></h4></td>
									<td colspan="2" class="text-center"><h4>Bonus Amount</h4></td>
									<td colspan="5"><h4 style="color:#1a7a4a;"><?= number_format($totalBonusVal, 2) ?></h4></td>
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