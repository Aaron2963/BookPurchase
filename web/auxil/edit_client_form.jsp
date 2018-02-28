<div class="modal" tabindex="-1" id="editClientModal" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5>編輯客戶</h5>
      </div>
      <div class="modal-body">
        <form id="editClientForm" method="post">
          <input type="number" name="id" id="edit_id" value="" hidden>
          <label for="edit_name">客戶名稱</label>
          <input type="text" name="name" id="edit_name" required><br>
          <label for="edit_region">客戶地區</label>
          <select id="edit_region" name="region" class="dropdown"></select><br>
          <label for="edit_region_num">客戶分區</label>
          <input type="number" name="region_num" id="edit_region_num" value="" disabled>
          <hr>
          <input type="submit" class="btn btn-warning" id="editClientForm_save" data-dismiss="modal" value="覆寫">
          <button class="btn btn-secondary" data-dismiss="modal">取消</button>
        </form>
      </div>
    </div>
  </div>
</div>