var bookCol = ['name', 'author', 'publisher', 'note', 'id', 'publish_in', 'volume',
  'cover_price_RMB', 'cover_price_NT', 'stock_price_NT', 'sold'];
var orderCol = ['client', 'shipping', 'est_shipping', 'act_shipping', 'discount', 
  'amount', 'date', 'books'];

// Listener & Submit
window.onload = function() 
{$('#estShippingCost').keyup(amountRefresh);
$('#discount').keyup(amountRefresh);
$('#addOrderModal').on('show.bs.modal', showInputTab);
$('#amount-tab').on('show.bs.tab', checkInputTab);
$('#confirm-tab').on('show.bs.tab', checkInputTab);
// onShow: detailBookModal: 書籍細目模態視圖
$('a[data-bookId]').click( function(event) {
  $('#detailBookModal').modal('show');
  var td = '#book-detail-table td.book-'; 
  var id = $(event.target).closest('[data-bookId]').attr('data-bookId');
  for ( i = 0; i < bookCol.length; i++ ) {
    $(td + bookCol[i]).text(booksBuffer[id][bookCol[i]]);
  }  
  $('button.to-edit').show();
  $('#editBookForm_save').hide();
});
// onShow: detailOrderModal: 訂單細目模態視圖
$('.toolkit .to-detail').click( function(event) {
  $('#detailOrderModal').modal('show');
  // 填入訂單基本資訊
  var td = '#detailOrderModal td.order-'; 
  var id = $(event.target).closest('[data-id]').attr('data-id');
  for ( i = 0; i < orderCol.length; i++ ) {
    if ( !Array.isArray(ordersBuffer[id][orderCol[i]]) ) {
      $(td + orderCol[i]).text(ordersBuffer[id][orderCol[i]]);
    } 
  }
  // 遞歸生成訂單的書單
  $('#bookListInOrderDetail').html('');
  for ( i = 0; i < ordersBuffer[id].books.length; i++ ) {
    var book = ordersBuffer[id].books[i];
    var tr = $('<tr></tr>');
    var tds = [];
    tds.push($('<td>' + book.name + '</td>'));
    tds.push($('<td>' + book.publisher + '</td>'));
    tds.push($('<td>' + book.cover_price_RMB + '</td>'));
    tds.push($('<td>' + book.qt + '</td>'));
    for ( j = 0; j < tds.length; j++  ) {
      $(tr).append(tds[j]);
    }
    $('#bookListInOrderDetail').append(tr);
  }
  //  附加訂單ID於[修改]按鈕
    $('#toEditBtn').click(function(){
      $('#detailOrderModal').modal('hide');
      initEditOrderForm(id);
    });
});
$('#addOrderForm button[type="submit"]').on('click', function () {
  var disabled = $('#addOrderForm input[disabled]');
  $(disabled).prop('disabled', false);
  $.ajax({
    'url': 'OrderInserter',
    'method': 'POST',
    'data': $('#addOrderForm').serialize(),
    'success':
            function () {
              alert('您已新增「' + $('#addOrderForm input[name="client"]').val() + '」的訂單');
              $(disabled).prop('disabled', true);
              window.location.replace('order.list');
            }
  });
});
$("#addOrderForm").submit(function () {
  return false;
});
};

/* ----------------------------------------------------*\
 *             Order List  瀏覽訂單清單
 \* -------------------------------------------------- */
/* ---- Reduced Order  List 訂單簡表 ----*/
function showOrderList() {
  var orders = [];
//  var col = [ 'date', 'client',  'amount', 'books'];
//  var book = ['name', 'qt', 'status'];
  for ( var order in ordersBuffer ) {
    orders.push(order);
  }
  for ( i = 0; i < orders.length; i++ ) {
    var order = ordersBuffer[orders[i]];
    var row = $('<tr data-id="id'+ order.id +'"  data-name="'+ order.client +'"></tr>');
    var tool = $('<td rowspan="'+ order.books.length +'">\
                            <div class="toolkit">\
                            <button class="btn btn-secondary to-detail m-1">\
                            <i class="fas fas fa-info-circle"></i>\
                          </button>\
                          <button class="btn btn-secondary to-delete m-1">\
                            <i class="far fa-trash-alt"></i>\
                          </button>\
                          </div>\
                        </td>');
    var td1 = $('<td rowspan="'+ order.books.length +'">' + order.date + '</td>');
    var td2 = $('<td rowspan="'+ order.books.length +'">' + order.client + '</td>');
    var td3 = $('<td rowspan="'+ order.books.length +'">' + order.amount + '</td>');
    (i % 2 == 0) && $(row).addClass('table-colored');
    $(row).append(tool);
    $(row).append(td1);
    $(row).append(td2);
    $(row).append(td3);
    for ( j = 0; j < order.books.length; j++ ) {
      var tr = $('<tr></tr>');
      var td4 = $('<td><a data-bookId="id'+ order.books[j].id +'">' + order.books[j].name + '</a></td>');
      var td5 = $('<td>' + order.books[j].qt + '</td>');
      var td6 = $('<td>' + order.books[j].status + '</td>');
      if ( j == 0) {
        $(row).append(td4);
        $(row).append(td5);
        $(row).append(td6);
        $('#orderData').append(row);
      } else {
        (i % 2 == 0 && j % 2 == 0) && $(tr).addClass('table-colored');
        (i % 2 == 1 && j % 2 == 1) && $(tr).addClass('table-colored');
        $(tr).append(td4);
        $(tr).append(td5);
        $(tr).append(td6);
        $('#orderData').append(tr);
      }
    }
  }
}

/* ----------------------------------------------------*\
 *         add_book_form  新增書籍
 \* -------------------------------------------------- */
// onSubmit
$('#addBookForm_save').on('click', function () {
  var disabled = $('#addBookForm input[disabled]');
  $(disabled).prop('disabled', false);
  $.ajax({
    'url': 'BookInserter',
    'method': 'post',
    'data': $('#addBookForm').serialize(),
    'success':
            function () {
              alert('您已新增書籍：' + $('#addBookForm input[name="name"]').val());
              $(disabled).prop('disabled', true);
              window.location.replace('book.list');
            }
  });
});

/* ----------------------------------------------------*\
 *         add_order_form  新增訂單
 \* -------------------------------------------------- */
// 建立訂單分頁
var hasChosen = [false, false];
var bookArrayList = [];
function showInputTab() {
  $('#allBookListDropdown > a').remove();
  var k = [];
  for ( var i in booksBuffer) {
    k.push(i);
  }
  for ( i = 0; i < k.length; i++ ) {
    var el = '<a data-bookId="" class="dropdown-item" data-dropdown="bookList" onclick="addToBookList(this)"></a>';
    el = el.replace('bookId="', 'bookId="' + booksBuffer[k[i]].id).replace('</a>', booksBuffer[k[i]].name + '</a>');
    $('#allBookListDropdown').append(el);
  }
}
function filterFunction(e) {
  var className, filter, items;
  className = $(e).attr('data-dropdown');
  filter = $(e).val().toUpperCase();
  items = $('a.dropdown-item[data-dropdown="' + className + '"]');
  for (i = 0; i < items.length; i++) {
    if ($(items[i]).html().toUpperCase().indexOf(filter) > -1) {
      $(items[i]).show();
    } else {
      $(items[i]).hide();
    }
  }
}
function showChosen(e) {
  var btn = $(e).closest('.dropdown').find('button.dropdown-toggle');
  btn.text($(e).text());
  var toChoose = ['clientsList', 'shippingList'];
  switch (toChoose.indexOf(btn.attr('data-dropdown'))) {
    case 0:
      hasChosen[0] = true;
      break;
    case 1:
      hasChosen[1] = true;
      break;
  }
}
function addToBookList(e) {
  var id = 'id' + $(e).attr('data-bookId');
  var book = booksBuffer[id];
  var delBtn = '<button type="button" class="close" onclick="delFromBooklist(this)">'
          + '<span aria-hidden="true">&times;</span>'
          + '</button>';
  var qtInput = '<input class="books_qt form-control" type="number" value="1">';
  var col = [delBtn, book.name, book.publisher, book.volume, book.note, qtInput];
  var row = "";
  bookArrayList.push(book);
  row += '<tr data-bookId="' + book.id + '">';
  for (i = 0; i < col.length; i++) {
    row += '<td>' + col[i] + '</td>';
  }
  row += '</tr>';
  $('#addBookList_tbody').append(row);
}
function delFromBooklist(e) {
  var index = bookArrayList.findIndex(function (book) {
    book.id == $(e).attr('data-bookId');
  });
  $(e).closest('tr').remove();
  bookArrayList.splice(index, 1);
}

// 金額試算分頁
function checkInputTab() {
  if ((hasChosen.indexOf(false) < 0) && bookArrayList.length > 0) {
    showAmountTab();
    showConfirmTab();
  } else {
    alert('請選取客戶、寄送方式及書籍');
    $('#addOrderTab li:nth-child(2) a').one('shown.bs.tab', function () {
      $('#addOrderTab li:nth-child(1) a').tab('show');
    });
    $('#addOrderTab li:nth-child(3) a').one('shown.bs.tab', function () {
      $('#addOrderTab li:nth-child(1) a').tab('show');
    });
  }
}
function showAmountTab() {
  var total = 0;
  setBooks_qt();
  $('#addBookList_tbody_amount').html('');
  for (i = 0; i < bookArrayList.length; i++) {
    var book = bookArrayList[i];
    var col = [book.name, book.publisher, book.volume, book.cover_price_RMB, 
                    book.qt, (book.cover_price_RMB * book.qt), book.status];
    var row = "<tr>";
    for (j = 0; j < col.length - 1; j++) {
      row += '<td>' + col[j] + '</td>';
    }
    row += '<td class="d-none inEdit">' + book.status + '</td>';
    row += ('<tr>');
    $('#addBookList_tbody_amount').append(row);
    total += col[5];
  }
  $('#subtotal').text(total);
  setShippingTotal();
  amountRefresh();
}
function amountRefresh() {
  var subtotal = parseInt($('#subtotal').text());
  var estShippingCost = parseInt($('#estShippingCost').val());
  var discount = parseInt($('#discount').val());
  $('#amount').val(subtotal + estShippingCost - discount);
}
function setBooks_qt() {
  var books_qt = $('input.books_qt');
  for (i = 0; i < books_qt.length; i++) {
    var index = bookArrayList
            .findIndex(function (book) {
              return book.id == $(books_qt[i]).closest('tr').attr('data-bookId');
            });
    bookArrayList[index].qt = $(books_qt[i]).val();
  }
}
function setShippingTotal() {
  var shippingWay = ['合運分寄', '郵政小包', '貨運寄送', '其他方式'];
  var r = shippingWay.indexOf($('button[data-dropdown="shippingList"]').text());
  var count = 0;
  for (i = 0; i < bookArrayList.length; i++) {
    count += (bookArrayList[i].qt * bookArrayList[i].volume);
  }
  switch (r) {
    case 0:
      count = (count * 15) + 12;
      break;
    case 1:
      count = (count * 45);
      break;
    case 2:
      count = (count * 55);
      break;
    case 3:
      count = 0;
      break;
  }
  $('#estShippingCost').val(count).attr('placeholder', count);
}

// 確認訂單分頁
function showConfirmTab() {
  $('#addOrderForm input[name="client"]').val($('button[data-dropdown="clientsList"]').text());
  $('#addOrderForm input[name="id"]').val(0);
  var books = [];
  var books_qt = [];
  var status = [];
  var d = new Date();
  var today;
  $('#confirmBooksList').html('');
  for (i = 0; i < bookArrayList.length; i++) {
    var b = bookArrayList[i];
    var col = [b.name, b.publisher, b.note, b.cover_price_RMB, b.qt, (b.cover_price_RMB * b.qt)];
    var row = '<tr>';
    for (j = 0; j < col.length; j++) {
      row += (j === col.length - 1) ? '<td><input class="form-control" type=text value="' + col[j] + '" disabled></td>' : '<td>' + col[j] + '</td>';
    }
    row += '</tr>';
    $('#confirmBooksList').append(row);
    books.push(b.id);
    books_qt.push(b.qt);
    status.push("未付款");
  }
  today = d.getFullYear() * 10000 + (d.getMonth() + 1) * 100 + d.getDate();
  $('#addOrderForm input[name="books"]').val(books.join(","));
  $('#addOrderForm input[name="books_qt"]').val(books_qt.join(","));
  $('#addOrderForm input[name="status"]').val(status.join(","));
  $('#addOrderForm input[name="date"]').val(today);
  $('#addOrderForm input[name="shipping"]').val($('button[data-dropdown="shippingList"]').text());
  $('#addOrderForm input[name="est_shipping"]').val($('#estShippingCost').val());
  $('#addOrderForm input[name="discount"]').val($('#discount').val());
  $('#addOrderForm input[name="amount"]').val($('#amount').val());
}



/* ---- edit_book_form ----*/
// onShow
$('button.to-edit').on('click', function () {
  var t = '#book-detail-table td.book-';
  for (i = 0; i < bookCol.length; i++) {
    var h = '<input class="form-control" name="' + bookCol[i] + '" type="text" value="' + $(t + bookCol[i]).text() + '">';
    var n = '<input class="form-control" name="' + bookCol[i] + '" type="number" value="' + $(t + bookCol[i]).text() + '">';
    if (i <= 3) {
      $(t + bookCol[i]).html(h);
    } else {
      $(t + bookCol[i]).html(n);
    }
  }
  $('#editBookForm input[name="name"]').prop('required', true);
  var noteValue = $('#editBookForm input[name="note"]').val();
  $('#editBookForm *[name="note"]')
          .replaceWith('<textarea class="form-control" name="note" placeholder="最多不超過50字">' + noteValue + '</textarea>');
  $('button.to-edit').hide();
  $('#editBookForm_save').show();
});
// onSubmit
$('#editBookForm_save').on('click', function () {
  var r = confirm('確定覆寫「' + $('#editBookForm input[name="name"]').val() + '」的原有資料？');
  if (r) {
    var disabled = $('#editBookForm input[disabled]');
    $(disabled).prop('disabled', false);
    $.ajax({
      'url': 'BookUpdater',
      'method': 'post',
      'data': $('#editBookForm').serialize(),
      'success':
              function () {
                $(disabled).prop('disabled', true);
                alert('您已修改書籍：' + $('#editBookForm input[name="name"]').val());
                window.location.replace('order.list');
              }
    });
  }
});

/*---- Edit Order Form ----*/
function initEditOrderForm( orderId ) {
  var order = ordersBuffer[orderId];
  $('#editOrderModal').modal('show');
  hasChosenInEdit = [true, true];
  $('#editOrderModal button[data-dropdown="clientsList"]').text(order.client);
  $('#editOrderModal button[data-dropdown="shippingList"]').text(order.shipping);
  $('#editOrderModal #editOrderAmount #discountInEdit').val(order.discount);
  $('#editOrderModal #estShippingCostInEdit').val(order.est_shipping);
  $('#editOrderModal #actShippingCostInEdit').val(Number(order.act_shipping));
  $('#editOrderModal #editOrderForm input[name="id"]').val(order.id);
  bookArrayListInEdit = [];
  addToBookListFromOrder(order);
}
function addToBookListFromOrder(order) {
  var delBtn = '<button type="button" class="close" onclick="delFromBooklist(this)">'
          + '<span aria-hidden="true">&times;</span>'
          + '</button>';
  var qtInput = '<input class="books_qtInEdit form-control" type="number" value="1">';
  $('#editBookList_tbody').html('');
  for (j = 0; j < order.books.length; j++ ) {
    var book = order.books[j];
    var col = [delBtn, book.name, book.publisher, book.volume, book.note, qtInput];
    var row = "";
    bookArrayListInEdit.push(book);
    row += '<tr data-bookId="' + book.id + '">';
    for (i = 0; i < col.length; i++) {
      row += '<td>' + col[i] + '</td>';
    }
    row += '</tr>';
    $('#editBookList_tbody').append(row);
  } 
}

// 金額試算分頁(修改訂單)
function showAmountTabInEdit() {
  var total = 0;
  setBooks_qtInEdit();
  $('#editookList_tbody_amount').html('');
  for (i = 0; i < bookArrayListInEdit.length; i++) {
    var book = bookArrayListInEdit[i];
    var col = [book.name, book.publisher, book.volume, book.cover_price_RMB, 
                    book.qt, (book.cover_price_RMB * book.qt), book.status];
    var row = "<tr>";
    for (j = 0; j < col.length - 1; j++) {
      row += '<td>' + col[j] + '</td>';
    }
    row += '<td>' + book.status + '</td>';
    row += ('<tr>');
    $('#editBookList_tbody_amount').append(row);
    total += col[5];
  }
  $('#subtotalInEdit').text(total);
  setShippingTotalInEdit();
  amountRefreshInEdit();
}
function amountRefreshInEdit() {
  var subtotal = parseInt($('#subtotalInEdit').text());
  var estShippingCost = parseInt($('#estShippingCostInEdit').val());
  var discount = parseInt($('#discountInEdit').val());
  $('#amountInEdit').val(subtotal + estShippingCost - discount);
}
function setBooks_qtInEdit() {
  var books_qt = $('input.books_qtInEdit');
  for (i = 0; i < books_qt.length; i++) {
    var index = bookArrayList
            .findIndex(function (book) {
              return book.id == $(books_qt[i]).closest('tr').attr('data-bookId');
            });
    bookArrayList[index].qt = $(books_qt[i]).val();
  }
}
function setShippingTotalInEdit() {
  var shippingWay = ['合運分寄', '郵政小包', '貨運寄送', '其他方式'];
  var r = shippingWay.indexOf($('#editOrderModal button[data-dropdown="shippingList"]').text());
  var count = 0;
  for (i = 0; i < bookArrayList.length; i++) {
    count += (bookArrayList[i].qt * bookArrayList[i].volume);
  }
  switch (r) {
    case 0:
      count = (count * 15) + 12;
      break;
    case 1:
      count = (count * 45);
      break;
    case 2:
      count = (count * 55);
      break;
    case 3:
      count = 0;
      break;
  }
  $('#estShippingCostInEdit').val(count).attr('placeholder', count);
}