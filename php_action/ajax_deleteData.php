<?php
header('Content-Type: application/json');

include_once 'db_connect.php';
require_once '../includes/functions.php';
/*Delete*/
if (!empty($_REQUEST['delete_id'])) {
	# code...
	$id = $_REQUEST['delete_id'];
	$table = $_REQUEST['table'];
	$fld = $_REQUEST['fld'];
	if (mysqli_query($dbc, "DELETE FROM $table WHERE $fld='$id'")) {
		$msg = "Data Has been deleted...";
		$sts = "success";
	} else {
		$msg = mysqli_error($dbc);
		$sts = "danger";
	}
	echo json_encode(['msg' => $msg, "sts" => $sts]);
	exit;
}
if (isset($_REQUEST['delete_bymanually'])) {
	# code...
	$id = $_REQUEST['delete_bymanually'];
	$table = $_REQUEST['table'];
	$row = $_REQUEST['row'];

	if ($table == "vouchers") {
		$vouchers = fetchRecord($dbc, "vouchers", "voucher_id", $id);
		@deleteFromTable($dbc, "transactions", 'transaction_id', $vouchers['transaction_id1']);
		@deleteFromTable($dbc, "transactions", 'transaction_id', $vouchers['transaction_id2']);
		if (mysqli_query($dbc, "DELETE FROM vouchers WHERE voucher_id='$id'")) {
			$msg = "Data Has been deleted...";
			$sts = "success";
		} else {
			$msg = mysqli_error($dbc);
			$sts = "error";
		}

	} elseif ($table == "orders") {
		$orders = fetchRecord($dbc, 'orders', $row, $id);
		$get_company = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT * FROM company ORDER BY id DESC LIMIT 1"));

		if ($get_company['stock_manage'] == 1) {
			$proQ = get($dbc, "order_item WHERE order_id='" . $id . "' ");

			while ($proR = mysqli_fetch_assoc($proQ)) {
				$newqty = 0;
				$quantity_instock = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT quantity_instock FROM  product WHERE product_id='" . $proR['product_id'] . "' "));
				$newqty = (int) $quantity_instock['quantity_instock'] + (int) $proR['quantity'];
				$quantity_update = mysqli_query($dbc, "UPDATE product SET  quantity_instock='$newqty' WHERE product_id='" . $proR['product_id'] . "' ");

				// ============================================================================
				// REVERSE BATCH QUANTITIES when deleting sale/order
				// ============================================================================
				$batch_id = $proR['batch_id'] ?? null;
				$quantity = (float) $proR['quantity'];

				if ($batch_id && $quantity > 0) {
					// Restore the batch quantity (add back what was sold)
					mysqli_query($dbc, "UPDATE product_batches 
					                    SET available_qty = available_qty + $quantity,
					                        qty_out = GREATEST(0, qty_out - $quantity),
					                        updated_at = NOW()
					                    WHERE batch_id = '$batch_id'");
				}
			}
		}
		deleteFromTable($dbc, "transactions", 'transaction_id', $orders['transaction_paid_id']);
		deleteFromTable($dbc, "transactions", 'transaction_id', $orders['transaction_id']);
		if (mysqli_query($dbc, "DELETE FROM orders WHERE $row='$id'")) {
			$msg = "Data Has been deleted...";
			$sts = "success";
		} else {
			$msg = mysqli_error($dbc);
			$sts = "error";
		}


	} elseif ($table == "purchase") {

		$get_company = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT * FROM company ORDER BY id DESC LIMIT 1"));

		if ($get_company['stock_manage'] == 1) {
			$proQ = get($dbc, "purchase_item WHERE purchase_id='" . $id . "' ");

			while ($proR = mysqli_fetch_assoc($proQ)) {
				$newqty = 0;
				$quantity_instock = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT quantity_instock FROM  product WHERE product_id='" . $proR['product_id'] . "' "));
				$newqty = (int) $quantity_instock['quantity_instock'] - (int) $proR['quantity'];
				$quantity_update = mysqli_query($dbc, "UPDATE product SET  quantity_instock='$newqty' WHERE product_id='" . $proR['product_id'] . "' ");

				// ============================================================================
				// REVERSE BATCH QUANTITIES when deleting purchase
				// ============================================================================
				$batch_no = trim($proR['batch_no'] ?? '');
				$expiry_date = $proR['expiry_date'] ?? null;
				$quantity = (float) $proR['quantity'];

				if (!empty($batch_no) && $quantity > 0) {
					$batch_condition = "product_id = '" . $proR['product_id'] . "' 
					                    AND batch_no = '" . mysqli_real_escape_string($dbc, $batch_no) . "'";
					
					if ($expiry_date) {
						$batch_condition .= " AND expiry_date = '$expiry_date'";
					} else {
						$batch_condition .= " AND expiry_date IS NULL";
					}

					// Decrease qty_in and available_qty (reverse the purchase)
					mysqli_query($dbc, "UPDATE product_batches 
					                    SET qty_in = GREATEST(0, qty_in - $quantity),
					                        available_qty = GREATEST(0, available_qty - $quantity),
					                        updated_at = NOW()
					                    WHERE $batch_condition");
				}

			}
		}
		$vouchers = fetchRecord($dbc, 'purchase', $row, $id);
		@deleteFromTable($dbc, "transactions", 'transaction_id', $vouchers['transaction_paid_id']);
		@deleteFromTable($dbc, "transactions", 'transaction_id', $vouchers['transaction_id']);
		// Delete purchase return and items
		$delete_return = mysqli_query($dbc, "DELETE FROM purchase WHERE $row = '$id'");
		$delete_items = mysqli_query($dbc, "DELETE FROM purchase_item WHERE purchase_id = '$id'");

		if ($delete_return && $delete_items) {
			$msg = "Purchase return has been deleted...";
			$sts = "success";
		} else {
			$msg = mysqli_error($dbc);
			$sts = "error";
		}


	} elseif ($table == "purchase_return") {
		$purchaseReturn = fetchRecord($dbc, 'purchase_return', $row, $id);
		$get_company = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT * FROM company ORDER BY id DESC LIMIT 1"));

		if ($get_company['stock_manage'] == 1) {
			$proQ = get($dbc, "purchase_return_item WHERE purchase_id = '$id'");
			while ($proR = mysqli_fetch_assoc($proQ)) {
				$quantity_instock = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT quantity_instock FROM product WHERE product_id = '" . $proR['product_id'] . "'"));
				$newqty = (float) $quantity_instock['quantity_instock'] + (float) $proR['quantity']; // Reverse stock for return
				mysqli_query($dbc, "UPDATE product SET quantity_instock = '$newqty' WHERE product_id = '" . $proR['product_id'] . "'");

				// REVERSE BATCH: Deleting Purchase Return -> Add stock back to batch
				$batch_id = $proR['batch_id'] ?? null; 
				$batch_no = trim($proR['batch_no'] ?? '');

				if ($batch_id) {
					// Restore by ID
					mysqli_query($dbc, "UPDATE product_batches 
										SET qty_in = qty_in + {$proR['quantity']},
											available_qty = available_qty + {$proR['quantity']}
										WHERE batch_id = '$batch_id'");
				} elseif (!empty($batch_no)) {
					// Restore by Name
					$b_cond = "product_id = '" . $proR['product_id'] . "' AND batch_no = '" . mysqli_real_escape_string($dbc, $batch_no) . "'";
					$check = mysqli_query($dbc, "SELECT batch_id, available_qty FROM product_batches WHERE $b_cond LIMIT 1");
					
					if (mysqli_num_rows($check) > 0) {
						$b_row = mysqli_fetch_assoc($check);
						$bid = $b_row['batch_id'];
						mysqli_query($dbc, "UPDATE product_batches 
											SET qty_in = qty_in + {$proR['quantity']},
												available_qty = available_qty + {$proR['quantity']}
											WHERE batch_id = '$bid'");
					}
				}
			}
		}

		// Delete related transactions
		deleteFromTable($dbc, "transactions", 'transaction_id', $purchaseReturn['transaction_paid_id']);
		deleteFromTable($dbc, "transactions", 'transaction_id', $purchaseReturn['transaction_id']);

		// Delete purchase return and items
		$delete_return = mysqli_query($dbc, "DELETE FROM purchase_return WHERE $row = '$id'");
		$delete_items = mysqli_query($dbc, "DELETE FROM purchase_return_item WHERE purchase_id = '$id'");

		if ($delete_return && $delete_items) {
			$msg = "Purchase return has been deleted...";
			$sts = "success";
		} else {
			$msg = mysqli_error($dbc);
			$sts = "error";
		}
	} elseif ($table == "orders_return") {
		$orderReturn = fetchRecord($dbc, 'orders_return', $row, $id);
		$get_company = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT * FROM company ORDER BY id DESC LIMIT 1"));

		if ($get_company['stock_manage'] == 1) {
			$proQ = get($dbc, "order_return_item WHERE order_id='" . $id . "'");

			while ($proR = mysqli_fetch_assoc($proQ)) {
				$p_id = $proR['product_id'];
				$quantity = (float) $proR['quantity'];

				$quantity_instock = mysqli_fetch_assoc(mysqli_query($dbc, "SELECT quantity_instock FROM product WHERE product_id='$p_id'"));
				$newqty = max(0, (float)$quantity_instock['quantity_instock'] - $quantity); // Decrease stock since return is being deleted
				mysqli_query($dbc, "UPDATE product SET quantity_instock='$newqty' WHERE product_id='$p_id'");

				// REVERSE BATCH: Deleting Sale Return -> Remove stock from batch
				$batch_id = $proR['batch_id'] ?? null; 
				$batch_no = trim($proR['batch_no'] ?? '');

				if ($batch_id && $quantity > 0) {
					$check = mysqli_query($dbc, "SELECT available_qty FROM product_batches WHERE batch_id = '$batch_id'");
					if (mysqli_num_rows($check) > 0) {
						$b_row = mysqli_fetch_assoc($check);
						$new_avail = max(0, (float)$b_row['available_qty'] - $quantity);
						
						mysqli_query($dbc, "UPDATE product_batches 
											SET qty_out = qty_out + $quantity,
												available_qty = '$new_avail',
												updated_at = NOW()
											WHERE batch_id = '$batch_id'");
					}
				} elseif (!empty($batch_no) && $quantity > 0) {
					$b_cond = "product_id = '$p_id' AND batch_no = '" . mysqli_real_escape_string($dbc, $batch_no) . "'";
					$check = mysqli_query($dbc, "SELECT batch_id, available_qty FROM product_batches WHERE $b_cond LIMIT 1");
					if (mysqli_num_rows($check) > 0) {
						$b_row = mysqli_fetch_assoc($check);
						$bid = $b_row['batch_id'];
						$new_avail = max(0, (float)$b_row['available_qty'] - $quantity);
						mysqli_query($dbc, "UPDATE product_batches SET qty_out = qty_out + $quantity, available_qty = '$new_avail', updated_at = NOW() WHERE batch_id = '$bid'");
					}
				}
			}
		}

		deleteFromTable($dbc, "transactions", 'transaction_id', $orderReturn['transaction_paid_id']);
		deleteFromTable($dbc, "transactions", 'transaction_id', $orderReturn['transaction_id']);

		$delete_order = mysqli_query($dbc, "DELETE FROM orders_return WHERE $row='$id'");
		$delete_items = mysqli_query($dbc, "DELETE FROM order_return_item WHERE $row='$id'");

		if ($delete_items && $delete_order) {
			$msg = "Data has been deleted...";
			$sts = "success";
		} else {
			$msg = mysqli_error($dbc);
			$sts = "error";
		}
	} elseif ($table == "product") {
		if (mysqli_query($dbc, "UPDATE product SET status=0 WHERE $row='$id'")) {
			$msg = "Product Has been deleted...";
			$sts = "success";
		} else {
			$msg = mysqli_error($dbc);
			$sts = "error";
		}
	} else {
		if (deleteFromTable($dbc, $table, $row, $id)) {
			$msg = $table . "Has been deleted...";
			$sts = "success";
		} else {
			$msg = mysqli_error($dbc);
			$sts = "error";
		}
	}


	echo json_encode(['msg' => $msg, "sts" => $sts]);
	exit;
}
?>