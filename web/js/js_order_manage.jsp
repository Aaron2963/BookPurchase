<%@page import="com.bookPurchase.database.*"%>
<%@page import="java.util.List"%>
<script>
  var ordersBuffer = {};
  var booksBuffer = {};
  <% 
    /*
    *  all not-hidden book list -> booksBuffer
    */
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
                                    note: '<%= note%>' };
  <% } %>
      
      /*
       *   oder list -> ordersBuffer
       */
  <% List<Order> list = (List<Order>) request.getAttribute("list");
      for (int j = 0; j < list.size(); j++) {
        Order order = list.get(j);
        int id = order.getId();
        String client = order.getClient();
        String shipping  = order.getShipping();
        List books = order.getBooks();
        int est_shipping = order.getEst_shipping();
        int act_shipping = order.getAct_shipping();
        int discount = order.getDiscount();
        int amount = order.getAmount();
        int date = order.getDate();
    %>
  ordersBuffer.id<%= id%> = {id: <%= id%>,
                      client: "<%= client%>",
                      shipping: "<%= shipping%>",
                      books: [],
                      est_shipping: <%= est_shipping%>,
                      act_shipping: <%= act_shipping%>,
                      discount: <%= discount%>,
                      amount: <%= amount%>,
                      date: <%= date%>};
            
  <%
    for (int i = 0; i < books.size(); i++) {
      Book book = (Book) books.get(i);
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
      String note = book.getNote();
      int qt = book.getQt();
      String status = book.getStatus(); %>
  ordersBuffer.id<%= id%>.books.push(
                    {id: <%= bookId%>,
                      name: '<%= name%>',
                      author: '<%= author%>',
                      publisher: '<%= publisher%>',
                      volume: <%= volume %>,
                      publish_in: <%= publish_in%>,
                      cover_price_RMB: <%= cover_price_RMB%>,
                      cover_price_NT: <%= cover_price_NT%>,
                      stock_price_NT: <%= stock_price_NT%>,
                      sold: <%= sold%>,
                      note: '<%= note%>',
                      qt: <%= qt%>,
                      status: '<%= status%>'});
  <%}}%>
</script>