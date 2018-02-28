<%@page import="java.util.List"%>
<%@page import="com.bookPurchase.database.Book"%>
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
    var booksBuffer = {};
  </script>
</head>

<body>
  <div class="container pt-3">
    <p class="toolbar float-right">
      <button class="btn btn-success" data-toggle="modal" data-target="#addBookModal">新增書籍</button>
    </p>
    <h2 class="text-center">書籍管理</h2>

    <div>
      <table class="table text-center tablesorter">
        <thead class="thead-dark">
          <tr>
            <th class="sorter">書名</th>
            <th class="sorter">出版社</th>
            <th class="sorter">出版年</th>
            <th class="sorter">定價￥</th>
            <th class="sorter">備註</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody id="productData">
          <% List<Book> list = (List<Book>) request.getAttribute("list");
          for (Book book : list) { 
            int id = book.getId();
            String name = book.getName();
            String author = book.getAuthor();
            String publisher = book.getPublisher();
            int publish_in = book.getPublish_in();
            int volume = book.getVolume();
            float cover_price_RMB = book.getCover_price_RMB();
            int cover_price_NT = book.getCover_price_NT();
            int stock_price_NT = book.getStock_price_NT();
            int sold = book.getSold();
            String note = book.getNote();
          %>
          <tr>
            <td>
              <%= name %>
            </td>
            <td><%= publisher %></td>
            <td><%= publish_in%></td>
            <td><%= cover_price_RMB %></td>
            <td><%= note %></td>
            <td>
              <button class="btn btn-secondary to-detail"
                        data-id="id<%= id %>"
                        data-toggle="modal"
                        data-target="#detailBookModal">
                <i class="fas fas fa-info-circle"></i>
              </button>
              <button class="btn btn-secondary to-delete" 
                        value="<%= id %>"
                        data-name="<%= name %>">
                <i class="far fa-trash-alt"></i>
              </button>
            </td>
          </tr>
          <script>
            booksBuffer
              .id<%= id %> = { id: <%= id %>,
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
          </script>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Book Detail Modal with Edit Book Form -->
  <%@include file="auxil/detail_book_modal.jsp" %>

  <!-- Add Book Form -->
  <%@include file="auxil/add_book_form.jsp" %>

  <script src="js/custom_book.js"></script>
  <script src="js/jquery.tablesort.min.js"></script>
  <script>
    $('table').tablesort();
  </script>

</body>

</html>