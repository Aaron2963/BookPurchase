package com.bookPurchase.database;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BooksOfOrderSelecter extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      handleRequest(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      handleRequest(request, response);
    }
    
    private void handleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      response.setContentType("text/html;charset=UTF-8");
        String table = "products";
        String username = "salvezzas";
        String password = "pwsalvezzas";
        
        try {
          // 加載數據庫驅動，註冊到驅動管理器
          Class.forName("com.mysql.jdbc.Driver");
          // 數據庫連接字符串
          String url = getServletContext().getInitParameter("databaseUrl") + "?useUnicode=true&characterEncoding=utf-8";
          // 創建Connection連接
          Connection conn = DriverManager.getConnection(url, username, password);
          // 取得從OrderSelecter傳來的Order物件
          List list =  (List) request.getAttribute("orderList");
          // 遞迴取得請求中Order物件的books數組，並據此從數據庫取得各書籍的更多資料
          for ( int i=0; i < list.size(); i++ ) {
            Order order = (Order) list.get(i);
            List books = order.getBooks();
            for ( int j=0; j < books.size(); j++) {
              String sql =  "select * from " + table + " WHERE id=" + books.get(j) + ";";
              Statement statement = conn.createStatement();
              ResultSet resultSet = statement.executeQuery(sql);
              resultSet.first();
              Book book = new Book();
              book.setId(resultSet.getInt("id"));
              book.setName(resultSet.getString("name"));
              book.setAuthor(resultSet.getString("author"));
              book.setPublisher(resultSet.getString("publisher"));
              book.setPublish_in(resultSet.getInt("publish_in"));
              book.setCover_price_RMB(resultSet.getFloat("cover_price_RMB"));
              book.setCover_price_NT(resultSet.getInt("cover_price_NT"));
              book.setStock_price_NT(resultSet.getInt("stock_price_NT"));
              book.setSold(resultSet.getInt("sold"));
              book.setNote(resultSet.getString("note"));
              book.setStatus((String) order.getStatus().get(j));
              book.setQt((int) Integer.valueOf((String) order.getBooks_qt().get(j)));
              books.set(j, book);
              resultSet.close();
              statement.close(); 
            }
            order.setBooks(books);
          }
          // 從數據庫取得全部的書籍資料
          String sql2 = "select * from " + table + " WHERE hidden=0;";
          // 獲取Statement
          Statement statement = conn.createStatement();
          ResultSet resultSet = statement.executeQuery(sql2);
          List<Book> allBookList = new ArrayList<Book>();
          while (resultSet.next()) {
            Book book = new Book();
            book.setId(resultSet.getInt("id"));
            book.setName(resultSet.getString("name"));
            book.setAuthor(resultSet.getString("author"));
            book.setPublisher(resultSet.getString("publisher"));
            book.setPublish_in(resultSet.getInt("publish_in"));              
            book.setVolume(resultSet.getInt("volume"));
            book.setCover_price_RMB(resultSet.getFloat("cover_price_RMB"));
            book.setCover_price_NT(resultSet.getInt("cover_price_NT"));
            book.setStock_price_NT(resultSet.getInt("stock_price_NT"));
            book.setSold(resultSet.getInt("sold"));
            book.setNote(resultSet.getString("note"));
            allBookList.add(book);
          }
          resultSet.close();
          statement.close();
          request.setAttribute("list", list);
          request.setAttribute("bookList", allBookList);
          conn.close();

        } catch (Exception e) {
                e.printStackTrace();
        }

        request.getRequestDispatcher("order_manage.jsp")
                    .forward(request, response);
    }
}
