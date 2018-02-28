<div class="modal" tabindex="-1" id="addClientModal" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5>新增客戶</h5>
        </div>
        <div class="modal-body">
            <form id="addClientForm" action="Inserter" method="post">
                <label for="add_name">客戶名稱</label>
                <input type="text" name="name" id="add_name" required><br>
                <label for="add_region">客戶地區</label>
                <select id="add_region" name="region" class="dropdown"></select><br>
                <label for="add_region_num">客戶分區</label>
                <input type="number" name="region_num" id="add_region_num" value="" disabled>
                <hr>
                <input type="submit" class="btn btn-success" id="addClientForm_save" data-dismiss="modal" value="儲存">
                <button class="btn btn-secondary" data-dismiss="modal">取消</button>
            </form>
        </div>
      </div>
    </div>
  </div>