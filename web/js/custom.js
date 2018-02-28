/* ---- add_client_form ---- */
var region_area = {
    "不明": 0,
    "福建": 1,
    "江西": 1,
    "廣東": 2,
    "浙江": 2,
    "江蘇": 2,
    "安徽": 2,
    "上海": 2,
    "山東": 3,
    "河南": 3,
    "湖北": 3,
    "湖南": 3,
    "貴州": 3,
    "廣西": 3,
    "海南": 3,
    "北京": 4,
    "天津": 4,
    "河北": 4,
    "山西": 4,
    "陜西": 4,
    "四川": 4,
    "重慶": 4,
    "雲南": 4,
    "內蒙古": 4,
    "青海": 5,
    "甘肅": 5,
    "寧夏": 5,
    "遼寧": 5,
    "吉林": 5,
    "黑龍江": 5,
    "西藏": 6,
    "新疆": 6
};
// onLoad
function loadRegion() {
  var e = Object.keys(region_area);
  for (i =0; i < e.length; i++) {
    $('#add_region').append('<option value="' + e[i] + '">' + e[i] + '</option>');
    $('#edit_region').append('<option value="' + e[i] + '">' + e[i] + '</option>')
  }
}
// onChange
$('#add_region').on('change', function() {
  var region = $('#add_region').val();
  $('#addClientForm input[name="region_num"]').val(region_area[region]);
});
// onSubmit
$('#addClientForm_save').on('click', function() {
  var disabled = $('#addClientForm input[disabled]');
  $(disabled).prop('disabled', false);
  $.ajax({
    'url': 'ClientInserter',
    'method': 'post',
    'data': $('#addClientForm').serialize(),
    'success': 
            function() {
              alert( '您已新增客戶：' + $('#addClientForm input[name="name"]').val() );
              $(disabled).prop('disabled', true);
              window.location.replace('client.list');
            }
  });
});

/* ---- remove client ---- */
//onClick
$('button.to-delete').on('click', function() {
  var r = confirm( '確定刪除客戶「' + $(this).attr('data-name') + '」？' );
  if ( r ) {
    $.ajax({
      'url': 'ClientDeleter',
      'method': 'get',
      'data': { id: $(this).val() },
      'success': 
              function() {
                window.location.replace('client.list');
              }
    });
  }
});

/* ---- edit_client_form ----*/
//onShow
$('button.to-edit').on('click', function() {
  $('#edit_id').val( $(this).attr('data-id') );
  $('#edit_name').val( $(this).attr('data-name') );
  $('#edit_region').val( $(this).attr('data-region') );
  $('#edit_region_num').val( $(this).attr('data-region_num') );
});
//onChange
$('#edit_region').on('change', function() {
  var region = $('#edit_region').val();
  $('#editClientForm input[name="region_num"]').val(region_area[region]);
});
//onSubmit
$('#editClientForm_save').on('click', function() {
  var disabled = $('#editClientForm input[disabled]');
  $(disabled).prop('disabled', false);
  $.ajax({
    'url': 'ClientUpdater',
    'method': 'post',
    'data': $('#editClientForm').serialize(),
    'success': 
            function() {
              alert( '您已修改客戶：' + $('#editClientForm input[name="name"]').val() );
              $(disabled).prop('disabled', true);
              window.location.replace('client.list');
            }
  });
});