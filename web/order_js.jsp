<%@page import="com.bookPurchase.database.Book"%>
<%@page import="java.util.List"%>
<%@page import="com.bookPurchase.database.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script>
      <% List<Order> list = (List<Order>) request.getAttribute("list");
        for ( int j = 0; j < list.size(); j++ ) {
          Order order = list.get(j);
          int id = order.getId();
          String client = order.getClient();
          List books = order.getBooks();
          List books_qt = order.getBooks_qt();
          List status = order.getStatus();
          int est_shipping_o = order.getEst_shipping_o();
          int est_shipping_d = order.getEst_shipping_d();
          int shipping_o = order.getShipping_o();
          int shipping_d = order.getShipping_d();
          int discount = order.getDiscount();
          int amount = order.getAmount();
          
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
            if ( i == 0 ) {
              out.println("<td>" + name + "</td>");
              out.println("<td>" + books_qt.get(i) + "</td>");
              out.println("<td>" + status.get(i) + "</td>");
            } else if ( i % 2 == 0 ) {
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
            } %>
      ordersBuffer
              .id<%= id%> = {id: <%= id%>,
                                  client: "<%= client%>",
                                  books: [],
                                  est_shipping_o: <%= est_shipping_o%>,
                                  est_shipping_d: <%= est_shipping_d%>,
                                  shipping_o: <%= shipping_o%>,
                                  shipping_d: <%= shipping_d%>,
                                  discount: <%= discount%>,
                                  amount: <%= amount%>
                                };
      ordersBuffer
              .id<%= id%>.books
              .push({id: <%= bookId%>,
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
    <% }
        } %>
    </script>
  </head>
</html>
