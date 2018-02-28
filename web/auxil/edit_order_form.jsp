<%@page import="com.bookPurchase.database.Book"%>
<%@page import="java.util.List"%>
<script>
//  var booksBuffer = {};
  <%-- 
    List<Book> bookList = (List) request.getAttribute("bookList");
    for (Book book : bookList) { 
      int bookId = book.getId();
      String name = book.getName();
      String author = book.getAuthor();
      String publisher = book.getPublisher();
      int publish_in = book.getPublish_in();
      int volume = book.getVolume();
      float cover_price_RMB = book.getCover_price_RMB();
      int cover_price_NT = book.getCover_price_NT();
      int stock_price_NT = book.getStock_price_NT();
      int sold = book.getSold();
      String note = book.getNote(); %>
  booksBuffer
              .id<%= bookId %> = { id: <%= bookId %>,
                                    name: '<%= name %>',
                                    author: '<%= author%>',
                                    publisher: '<%= publisher%>',
                                    publish_in: <%= publish_in %>,
                                    volume: <%= volume %>,
                                    cover_price_RMB: <%= cover_price_RMB %>,
                                    cover_price_NT: <%= cover_price_NT%>,
                                    stock_price_NT: <%= stock_price_NT%>,
                                    sold: <%= sold%>,
                                    note: '<%= note%>' }
  <% } --%>
</script>
<div class="modal" tabindex="-1" id="editOrderModal" data-backdrop="static">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5>修改訂單</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <button class="btn btn-success btn-sm float-right" data-toggle="modal" data-target="#addBookModal">新增書籍到資料庫</button>
        <ul class="nav nav-tabs" id="editOrderTab" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" id="edit-input-tab" data-toggle="tab" href="#editOrderInput">建立訂單</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="edit-amount-tab" data-toggle="tab" href="#editOrderAmount"">金額試算</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="edit-confirm-tab" data-toggle="tab" href="#editOrderConfirm">確認訂單</a>
          </li>
        </ul>
        <div class="tab-content" id="editOrderTabContent">
          <div class="tab-pane fade show active" id="editOrderInput" role="tabpanel" aria-labelledby="input-tab">
            <div class="mt-3">
              <div class="form-row mb-3">
                <div>
                  <div class="dropdown">
                    <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" data-dropdown="clientsList">
                      選取客戶
                    </button>
                    <div class="dropdown-menu">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text"><i class="fas fa-search"></i></span>
                        </div>
                        <input type="text" class="dropdown-item form-control" data-dropdown="clientsList" onkeyup="filterFunction(this)">
                      </div>
                      <a class="dropdown-item" data-clientId="1" data-dropdown="clientsList" onclick="showChosen(this)">自干五</a>
                      <a class="dropdown-item" data-clientId="12" data-dropdown="clientsList" onclick="showChosen(this)">自干十</a>
                      <a class="dropdown-item" data-clientId="16" data-dropdown="clientsList" onclick="showChosen(this)">自干劉‧改</a>
                    </div>
                  </div>
                </div>
                <div>
                  <div class="dropdown">
                    <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" data-dropdown="shippingList">
                      寄送方式
                    </button>
                    <div class="dropdown-menu">
                      <a class="dropdown-item" onclick="showChosen(this)">合運分寄</a>
                      <a class="dropdown-item" onclick="showChosen(this)">郵政小包</a>
                      <a class="dropdown-item" onclick="showChosen(this)">貨運寄送</a>
                      <a class="dropdown-item" onclick="showChosen(this)">其他方式</a>
                    </div>
                  </div>
                </div>
                <div>
                  <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" data-dropdown="bookList">
                      <i class="fas fa-list-ul"></i> 新增書單
                    </button>
                    <div class="dropdown-menu">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text"><i class="fas fa-search"></i></span>
                        </div>
                        <input type="text" class="dropdown-item form-control" data-dropdown="bookList" onkeyup="filterFunction(this)">
                      </div>
                      <a class="dropdown-item" data-bookId="1" data-dropdown="bookList" onclick="addToBookList(this)">李商隱詩選</a>
                      <a class="dropdown-item" data-bookId="2" data-dropdown="bookList" onclick="addToBookList(this)">誰在銀閃閃的地方，等你</a>
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <table class="table text-center tablesorter">
                  <thead class="thead">
                    <tr>
                      <th></th>
                      <th class="sorter">書名</th>
                      <th class="sorter">出版社</th>
                      <th class="sorter">冊數</th>
                      <th class="sorter">備註</th>
                      <th class="sorter" style="width: 4rem;">數量</th>
                    </tr>
                  </thead>
                  <tbody id="editBookList_tbody">
                    
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="tab-pane fade" id="editOrderAmount" role="tabpanel" aria-labelledby="amount-tab">
            <div>
              <table class="table text-center tablesorter">
                <thead class="thead">
                  <tr>
                    <th class="sorter">書名</th>
                    <th class="sorter">出版社</th>
                    <th class="sorter">冊數</th>
                    <th class="sorter">單價￥</th>
                    <th class="sorter">數量</th>
                    <th class="sorter">金額￥</th>
                  </tr>
                </thead>
                <tbody id="editBookList_tbody_amount"></tbody>
                <tfoot>
                  <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <th>小計</th>
                    <td id="subtotal">0</td>
                  </tr>
                </tfoot>
              </table>
            </div>
            <div class="form-row col-6 ml-auto">
              <div class="form-group col">
                <label>運費</label>
                <input class="form-control" id="shippingCost" type="number" value="0" placeholder="0">
              </div>
              <div class="form-group col">
                <label>折扣</label>
                <input class="form-control" id="discount" type="number" value="0">
              </div>
              <div class="form-group col">
                <label>總計</label>
                <input class="form-control" id="amount" type="number" disabled>
              </div>
            </div>
          </div>
          <div class="tab-pane fade" id="editOrderConfirm" role="tabpanel" aria-labelledby="confirm-tab">
            <form id="editOrderForm" mehod="post">
              <table class="table table-bordered my-1">
                <tbody>
                  <tr>
                    <th>客戶名稱</th>
                    <td><input class="form-control" name="client" type="text" value="自干五" disabled></td>
                  </tr>
                </tbody>
              </table>
              <table class="table text-center">
                <thead>
                  <input name="id" type="number" value="0" disabled hidden>
                  <input name="books" type="text" value="1,2" disabled hidden>
                  <input name="books_qt" type="text" value="1,1" disabled hidden>
                  <input name="status" type="text" value="未付款,未付款" disabled hidden>
                  <input name="date" type="text" value="20180226" disabled hidden>
                  <tr>
                    <th>項目</th>
                    <th>出版社</th>
                    <th>備註</th>
                    <th>單價￥</th>
                    <th>數量</th>
                    <th>金額￥</th>
                  </tr>
                </thead>
                <tbody id="confirmBooksList"></tbody>
                <tfoot>
                  <tr>
                    <td>運費：<input class="form-control shipping" name="shipping" type="text" value="郵政小包" disabled></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                      <input class="form-control" name="est_shipping" type="text" value="90" disabled>
                      <input class="form-control" name="act_shipping" type="number" value="0" disabled hidden>
                    </td>
                  </tr>
                  <tr>
                    <td>折扣</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><input class="form-control" name="discount" type="text" value="50" disabled></td>
                  </tr>
                  <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <th>總計</th>
                    <th><input class="form-control font-weight-bold" name="amount" type="text" value="200" disabled></th>
                  </tr>
                </tfoot>
              </table>
              <div class="text-right pr-5">
                <button class="btn btn-success" type="submit">送出</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<style type="text/css">
  input.books_qt {
    padding: 0.25rem;
  }
  table.table-bordered {
    width: 40%;
  }
  table.table-bordered th {
    background-color: #f3f3f3;
  }
  #editOrderConfirm table input.form-control {
    width: 7rem;
    padding: 0;
    background-color: #fff;
    border: 0 solid #fff;
    text-align: center;
  }
  #editOrderConfirm table input.form-control.shipping {
    width: 4rem;
    text-align: left;
    display: inline;
    color: #000;
  }
  #editOrderConfirm table tfoot input.form-control {
    width: 8rem;
  }
</style>

<%@include file="add_book_form.jsp" %>