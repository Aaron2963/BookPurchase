var column = ['name', 'author', 'publisher', 'note', 'id', 'publish_in', 'volume',
  'cover_price_RMB', 'cover_price_NT', 'stock_price_NT', 'sold']

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

/* ---- remove book ---- */
//onClick
$('button.to-delete').on('click', function () {
  var r = confirm('確定刪除書籍「' + $(this).attr('data-name') + '」？');
  if (r) {
    $.ajax({
      'url': 'BookDeleter',
      'method': 'get',
      'data': {id: $(this).val()},
      'success':
              function () {
                window.location.replace('book.list');
              }
    });
  }
});

/* ---- detail_book_modal ---- */
// onShow
$('button.to-detail').on('click', function () {
  var t = '#book-detail-table td.book-', d = $(this).attr('data-id');
  for (i = 0; i < column.length; i++) {
    $(t + column[i]).text(booksBuffer[d][column[i]]);
  }
  $('button.to-edit').show();
  $('#editBookForm_save').hide();
});

/* ---- edit_book_form ----*/
// onShow
$('button.to-edit').on('click', function () {
  var t = '#book-detail-table td.book-';
  for (i = 0; i < column.length; i++) {
    var h = '<input class="form-control" name="' + column[i] + '" type="text" value="' + $(t + column[i]).text() + '">';
    var n = '<input class="form-control" name="' + column[i] + '" type="number" value="' + $(t + column[i]).text() + '">';
    if (i <= 3) {
      $(t + column[i]).html(h);
    } else {
      $(t + column[i]).html(n);
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
                window.location.replace('book.list');
              }
    });
  }
});