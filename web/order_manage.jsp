<%@page import="com.bookPurchase.database.Book"%>
<%@page import="java.util.List"%>
<%@page import="com.bookPurchase.database.Order"%>
<!DOCTYPE html>
<html>

  <head>
    <meta charset="UTF-8">
    <!--<title>書籍代購-產品管理</title>-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.6/css/all.css">
    <link rel="stylesheet" href="css/custom.css">
    <%@include file="js/js_order_manage.jsp" %>
  </head>

  <body>
    <div class="container pt-3">
      <p class="toolbar float-right">
        <button class="btn btn-success" data-toggle="modal" data-target="#addOrderModal">新增訂單</button>
      </p>
      <h2 class="text-center">訂單管理</h2>

      <div>
        <table class="table text-center tablesorter">
          <thead class="thead-dark">
            <tr>
              <th class="sorter">訂單操作</th>
              <th class="sorter">客戶名稱</th>
              <th class="sorter">金額￥</th>
              <th class="sorter">商品名稱</th>
              <th class="sorter">數量</th>
              <th class="sorter">處理狀態</th>
            </tr>
          </thead>
          <tbody id="orderData">
          <tr>
            <td rowspan=">
                <div class="toolkit">
                <button class="btn btn-secondary to-detail"
                    data-id="id>"
                    data-toggle="modal"
                    data-target="#detailOrderModal">
                <i class="fas fas fa-info-circle"></i>
              </button>
              <button class="btn btn-secondary to-delete" 
                      value=">"
                      data-name="">
                <i class="far fa-trash-alt"></i>
              </button>
              </div>
            </td>
            <td rowspan=""></td>
            <td rowspan=""></td>
            
          <script>
            
          </script>
          </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Order Detail Modal with Edit Order Form -->
    <%@include file="auxil/detail_order_modal.jsp" %>

    <!-- Add Order Form -->
    <%@include file="auxil/add_order_form.jsp" %>
    
    <!-- Detail Book Modal -->
    <%@include file="auxil/detail_book_modal.jsp" %>

    <script src="js/custom_order.js"></script>
    <script src="js/jquery.tablesort.min.js"></script>
    <script>
            $('table').tablesort();
    </script>

  </body>

</html>