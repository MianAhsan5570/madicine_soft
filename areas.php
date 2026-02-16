<!DOCTYPE html>
<html lang="en">
<?php include_once 'includes/head.php';
if (isset($_REQUEST['edit_area_id'])) {
  $areas = fetchRecord($dbc, "areas", "area_id", base64_decode($_REQUEST['edit_area_id']));


}
$btn_name = isset($_REQUEST['edit_area_id']) ? "Update" : "Add";
?>

<body class="horizontal light  ">
  <div class="wrapper">
    <?php include_once 'includes/header.php'; ?>
    <main role="main" class="main-content">
      <div class="container-fluid">
        <div class="card">
          <div class="card-header card-bg" align="center">

            <div class="row">
              <div class="col-12 mx-auto h4">
                <b class="text-center card-text">Areas</b>


                <a href="areas.php" class="btn btn-admin float-right btn-sm">Add New</a>
              </div>
            </div>

          </div>
          <div class="card-body">

            <form action="php_action/panel.php" method="POST" role="form" id="formData">
              <div class="msg"></div>
              <div class="form-group row">
                <div class="col-sm-6">
                  <label for="">Area</label>
                  <input type="text" class="form-control" value="<?= @$areas['area_name'] ?>" id="add_area_name"
                    name="add_area_name">
                  <input type="hidden" class="form-control " value="<?= @$areas['area_id'] ?>" id="area_id"
                    name="area_id">

                </div>
                <div class="col-sm-6">
                  <label for="">Area Status</label>
                  <select class="form-control" id="area_status" name="area_status">
                    <option value="1" <?= ($areas['area_status'] ?? 1) == 1 ? 'selected' : '' ?>>Active</option>
                    <option value="0" <?= ($areas['area_status'] ?? 1) == 0 ? 'selected' : '' ?>>Inactive</option>
                  </select>
                </div>
              </div>
              <?php if (@$userPrivileges['nav_edit'] == 1 || $fetchedUserRole == "admin" AND isset($_REQUEST['edit_area_id'])): ?>
                <button type="submit" class="btn btn-admin2 float-right" id="formData_btn">Update</button>
              <?php endif ?>
              <?php if (@$userPrivileges['nav_add'] == 1 || $fetchedUserRole == "admin" AND !isset($_REQUEST['edit_area_id'])): ?>
                <button type="submit" class="btn btn-admin float-right" id="formData_btn">Add</button>
              <?php endif ?>
            </form>

          </div>

        </div> <!-- .row -->

        <div class="card">
          <div class="card-header card-bg" align="center">

            <div class="row">
              <div class="col-12 mx-auto h4">
                <b class="text-center card-text">Areas List</b>


              </div>
            </div>

          </div>
          <div class="card-body">
            <table class="table dataTable" id="tableData">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Area Name</th>
                  <th>Status</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>

                <?php $q = mysqli_query($dbc, "SELECT * FROM areas");
                $c = 0;
                while ($r = mysqli_fetch_assoc($q)) {
                  $c++;



                  ?>
                  <tr>
                    <td><?= $c ?></td>
                    <td><?= $r['area_name'] ?></td>
                    <td>
                      <?php if ($r['area_status'] == 1): ?>
                        Active
                      <?php else: ?>
                        Inactive
                      <?php endif ?>
                    </td>
                    <td class="d-flex">
                      <?php if (@$userPrivileges['nav_edit'] == 1 || $fetchedUserRole == "admin"): ?>
                        <form action="areas.php" method="POST">
                          <input type="hidden" name="edit_area_id" value="<?= base64_encode($r['area_id']) ?>">
                          <button type="submit" class="btn btn-admin btn-sm m-1">Edit</button>
                        </form>


                      <?php endif ?>
                      <?php if (@$userPrivileges['nav_delete'] == 1 || $fetchedUserRole == "admin"): ?>

                        <a href="#" onclick="deleteAlert('<?= $r['area_id'] ?>','areas','area_id','tableData')"
                          class="btn btn-admin2 btn-sm m-1">Delete</a>
                      <?php endif ?>
                    </td>
                  </tr>
                <?php } ?>

              </tbody>


            </table>

          </div>

        </div> <!-- .row -->

      </div> <!-- .container-fluid -->

    </main> <!-- main -->
  </div> <!-- .wrapper -->

</body>

</html>
<?php include_once 'includes/foot.php'; ?>