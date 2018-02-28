<div class="modal" tabindex="-1" id="addBookModal" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5>新增產品</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="addBookForm" method="post">
          <div class="form-group addBook">
            <input type="number" name="id" value="0" disabled hidden>
            <label for="addBook_name">書名</label>
            <input type="text" name="name" id="addBook_name" class="form-control">
          </div>
          <div class="form-row">
            <div class="col">
              <div class="form-group addBook">
                <label>作者</label>
                <input type="text" name="author" id="addBook_author" class="form-control">
              </div>
            </div>
            <div class="col">
              <div class="form-group addBook">
                <label>出版社</label>
                <input type="text" name="publisher" id="addBook_publisher" class="form-control">
              </div>
            </div>
          </div>
          <div class="form-row">
            <div class="col">
              <div class="form-group addBook">
                <label>出版年</label>
                <input type="number" name="publish_in" id="addBook_publishIn" class="form-control">
              </div>
            </div>
            <div class="col">
              <div class="form-group addBook">
                <label>冊數</label>
                <input type="number" name="volume" id="addBook_volume" class="form-control">
              </div>
            </div>
            <div class="col">
              <div class="form-group addBook">
                <label>銷量</label>
                <input type="number" name="sold" id="addBook_sold" class="form-control">
              </div>
            </div>
          </div>
          <div class="form-row">
            <div class="col">
              <div class="form-group addBook">
                <label>定價￥</label>
                <input type="number" name="cover_price_RMB" id="addBook_coverPriceRMB" class="form-control">
              </div>
            </div>
            <div class="col">
              <div class="form-group addBook">
                <label>定價＄</label>
                <input type="number" name="cover_price_NT" id="addBook_coverPriceNT" class="form-control">
              </div>
            </div>
            <div class="col">
              <div class="form-group addBook">
                <label>進價＄</label>
                <input type="number" name="stock_price_NT" id="addBook_stockPriceNT" class="form-control">
              </div>
            </div>
          </div>
          <div class="form-group addBook">
            <label>備註</label>
            <textarea name="note" id="addBook_note" 
                        class="form-control" rows="3" maxlength="50" 
                        placeholder="內容最多不超過50字"></textarea>
          </div>
          <div class="form-row">
            <button type="submit" form="addBookForm" id="addBookForm_save" class="btn btn-success ml-auto">新增</button>
            <button type="reset" form="addBookForm" class="btn ml-1">重設</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>