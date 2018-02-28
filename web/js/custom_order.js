var bookCol = ['name', 'author', 'publisher', 'note', 'id', 'publish_in', 'volume',
  'cover_price_RMB', 'cover_price_NT', 'stock_price_NT', 'sold']

// Listener & Submit
$('#estShippingCost').keyup(amountRefresh);
$('#discount').keyup(amountRefresh);
$('#addOrderModal').on('show.bs.modal', showInputTab);
$('#amount-tab').on('show.bs.tab', checkInputTab);
$('#confirm-tab').on('show.bs.tab', checkInputTab);
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

/* ---- add_book_form ---- */
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

/* ---- detail_book_modal ---- */
// onShow
$('a[data-target="#detailBookModal"]').on('click', function () {
  var t = '#book-detail-table td.book-', d = 'id' +  $(this).attr('data-bookId');
  for (i = 0; i < bookCol.length; i++) {
    $(t + bookCol[i]).text(booksBuffer[d][bookCol[i]]);
  }
  $('button.to-edit').show();
  $('#editBookForm_save').hide();
});

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
  var order = ordersBuffer['id' + orderId];
  hasChosen = [true, true];
  $('button[data-dropdown="clientsList"]').text(order.client);
  $('button[data-dropdown="shippingList"]').text(order.shipping);
  $('#addOrderAmount #discount').val(order.discount);
  $('#estShippingCost').val(order.est_shipping);
  $('#actShippingCost').val(Number(order.act_shipping)).closest('div.col').removeClass('d-none');
  $('#addOrderForm input[name="id"]').val(order.id);
  bookArrayList = [];
  addToBookListFromOrder(order);
}
function addToBookListFromOrder(order) {
  var delBtn = '<button type="button" class="close" onclick="delFromBooklist(this)">'
          + '<span aria-hidden="true">&times;</span>'
          + '</button>';
  var qtInput = '<input class="books_qt form-control" type="number" value="1">';
  for (j = 0; j < order.books.length; j++ ) {
    var book = order.books[j];
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
}