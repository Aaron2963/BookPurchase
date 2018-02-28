<!-- Order Detail Modal -->
<div class="modal" tabindex="-1" id="detailOrderModal" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header mx-auto">
        <h5>訂單詳細資訊</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table text-center table-striped">
          <tbody>
            <tr>
              <th>客戶</th>
              <td class="order-client">自干五</td>
              <th>寄送方式</th>
              <td class="order-shipping">合運分寄</td>
            </tr>
            <tr>
              <th>日期</th>
              <td class="order-date">20180227</td>
              <th>預估運費</th>
              <td class="order-est_shipping">90</td>
            </tr>
            <tr>
              <th>總金額</th>
              <td class="order-amount">220</td>
              <th>實際運費</th>
              <td class="order-act_shipping">75</td>
            </tr>
            <tr>
              <th>折扣</th>
              <td class="order-discount">30</td>
            </tr>
          </tbody>
        </table>
        <hr>
        <table class="table text-center table-striped">
          <thead class="thead-dark">
            <tr>
              <th>書名</th>
              <th>出版社</th>
              <th>單價￥</th>
              <th>數量</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>李商隱詩選</td>
              <td>五南</td>
              <td>65</td>
              <td>2</td>
            </tr>
            <tr>
              <td>誰在銀閃閃的地方，等你</td>
              <td>印刻</td>
              <td>95</td>
              <td>1</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="modal-footer text-right">
        <button class="btn btn-warning" type="button" id="toEditBtn" >修改</button>
        <button class="btn" type="button" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>

<script>
  $('#toEditBtn').click(function() {
    $('#detailOrderModal').modal('hide');
    $('#editOrderModal').modal('show');
  });
</script>
