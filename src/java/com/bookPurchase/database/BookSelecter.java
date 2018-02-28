package com.bookPurchase.database;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BookSelecter extends HttpServlet {

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
            // 添加客戶信息的SQL語句
            String sql = "select * from " + table + " WHERE hidden=0;";
            // 獲取Statement
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            List<Book> list = new ArrayList<Book>();
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
              list.add(book);
            }
            request.setAttribute("list", list);
            resultSet.close();
            statement.close();
            conn.close();

        } catch (Exception e) {
                e.printStackTrace();
        }

        request.getRequestDispatcher("book_manage.jsp")
                    .forward(request, response);
    }
}