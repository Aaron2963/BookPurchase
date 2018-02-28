<!-- Book Detail Modal -->
<div class="modal" tabindex="-1" id="detailBookModal">
  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header mx-auto">
          <h5>產品詳細資訊</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form id="editBookForm" method="post">
            <table id="book-detail-table">
              <tr class="d-none">
                <td>ID</td>
                <td class="book-id"></td>
              </tr>
              <tr>
                <td>書名</td>
                <td class="book-name"></td>
              </tr>
              <tr>
                <td>作者</td>
                <td class="book-author"></td>
              </tr>
              <tr>
                <td>出版社</td>
                <td class="book-publisher"></td>
              </tr>
              <tr>
                <td>出版年</td>
                <td class="book-publish_in"></td>
              </tr>
              <tr>
                <td>冊數</td>
                <td class="book-volume"></td>
              </tr>
              <tr>
                <td>定價￥</td>
                <td class="book-cover_price_RMB"></td>
              </tr>
              <tr>
                <td>定價＄</td>
                <td class="book-cover_price_NT"></td>
              </tr>
              <tr>
                <td>進價＄</td>
                <td class="book-stock_price_NT"></td>
              </tr>
              <tr>
                <td>銷量</td>
                <td class="book-sold"></td>
              </tr>
              <tr>
                <td>備註</td>
                <td class="book-note"></td>
              </tr>
            </table>
            <hr>
            <div class="text-right">
              <button class="btn btn-danger" type="submit" id="editBookForm_save">覆寫</button>
              <button class="btn btn-warning to-edit" type="button">修改</button>
              <button class="btn" type="button" data-dismiss="modal">取消</button>
            </div>
          </form>
        </div>
    </div>
  </div>
</div>