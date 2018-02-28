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
    <script>
      var ordersBuffer = {};
    </script>
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
            <% List<Order> list = (List<Order>) request.getAttribute("list");
              for (int j = 0; j < list.size(); j++) {
                Order order = list.get(j);
                int id = order.getId();
                String client = order.getClient();
                List books = order.getBooks();
                List books_qt = order.getBooks_qt();
                List status = order.getStatus();
                int est_shipping = order.getEst_shipping();
                int act_shipping = order.getAct_shipping();
                int discount = order.getDiscount();
                int amount = order.getAmount();
                int date = order.getDate();
            %>
          <script>
            ordersBuffer
                    .id<%= id%> = {id: <%= id%>,
                      client: "<%= client%>",
                      books: [],
                      est_shipping: <%= est_shipping%>,
                      act_shipping: <%= act_shipping%>,
                      discount: <%= discount%>,
                      amount: <%= amount%>,
                      date: <%= date%>
                    };
          </script>
          <tr <% if (j % 2 == 0) {
              out.print("class=table-colored");
            }%>>
            <td rowspan="<%= books.size()%>>
                <div class="toolkit">
                <button class="btn btn-secondary to-detail"
                    data-id="id<%= id%>"
                    data-toggle="modal"
                    data-target="#detailOrderModal">
                <i class="fas fas fa-info-circle"></i>
              </button>
              <button class="btn btn-secondary to-delete" 
                      value="<%= id%>"
                      data-name="<%= client%>">
                <i class="far fa-trash-alt"></i>
              </button>
              </div>
            </td>
            <td rowspan="<%= books.size()%>"><%= client%></td>
            <td rowspan="<%= books.size()%>"><%= amount%></td>
            <%
              for (int i = 0; i < books.size(); i++) {
                Book book = (Book) books.get(i);
                int bookId = book.getId();
                String name = book.getName();
                String author = book.getAuthor();
                String publisher = book.getPublisher();
                int publish_in = book.getPublish_in();
                float cover_price_RMB = book.getCover_price_RMB();
                int cover_price_NT = book.getCover_price_NT();
                int stock_price_NT = book.getStock_price_NT();
                int sold = book.getSold();
                String note = book.getNote();
                if (i == 0) {
                  out.println("<td>" + name + "</td>");
                  out.println("<td>" + books_qt.get(i) + "</td>");
                  out.println("<td>" + status.get(i) + "</td>");
                } else if (i % 2 == 0) {
                  out.println("<tr class=table-colored>");
                  out.println("<td>" + name + "</td>");
                  out.println("<td>" + books_qt.get(i) + "</td>");
                  out.println("<td>" + status.get(i) + "</td>");
                  out.println("</tr>");
                } else {
                  out.println("<tr >");
                  out.println("<td>" + name + "</td>");
                  out.println("<td>" + books_qt.get(i) + "</td>");
                  out.println("<td>" + status.get(i) + "</td>");
                  out.println("</tr>");
                }%>
          <script>
            ordersBuffer.id<%= id%>.books.push(
                    {id: <%= bookId%>,
                      name: '<%= name%>',
                      author: '<%= author%>',
                      publisher: '<%= publisher%>',
                      publish_in: <%= publish_in%>,
                      cover_price_RMB: <%= cover_price_RMB%>,
                      cover_price_NT: <%= cover_price_NT%>,
                      stock_price_NT: <%= stock_price_NT%>,
                      sold: <%= sold%>,
                      note: '<%= note%>',
                      qt: <%= books_qt.get(i)%>,
                      status: '<%= status.get(i)%>'});
          </script>
          <% }%>
          </tr>
          <% }%>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Order Detail Modal with Edit Order Form -->
    <%--@include file="auxil/detail_order_modal.jsp" --%>

    <!-- Add Order Form -->
    <%@include file="auxil/add_order_form.jsp" %>

    <script src="js/custom_order.js"></script>
    <script src="js/jquery.tablesort.min.js"></script>
    <script>
            $('table').tablesort();
    </script>

  </body>

</html>