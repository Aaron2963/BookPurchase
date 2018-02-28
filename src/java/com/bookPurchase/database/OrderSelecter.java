package com.bookPurchase.database;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class OrderSelecter extends HttpServlet {

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
        String table = "order_history";
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
            String sql = "select * from " + table + ";";
            // 獲取Statement
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            List<Order> list = new ArrayList<>();
            while (resultSet.next()) {
              Order order = new Order();
              order.setId(resultSet.getInt("id"));
              order.setClient(resultSet.getString("client"));
              order.setBooks(order.splitToList(resultSet.getString("books")));
              order.setBooks_qt(order.splitToList(resultSet.getString("books_qt")));
              order.setStatus(order.splitToList(resultSet.getString("status")));
              order.setEst_shipping(resultSet.getInt("est_shipping"));
              order.setAct_shipping(resultSet.getInt("act_shipping"));
              order.setDiscount(resultSet.getInt("discount"));
              order.setAmount(resultSet.getInt("amount"));
              order.setDate(resultSet.getInt("date"));
              list.add(order);
            }
            request.setAttribute("orderList", list);
            resultSet.close();
            statement.close();
            conn.close();

        } catch (Exception e) {
                e.printStackTrace();
        }
        
       request.getRequestDispatcher("BooksOfOrderSelecter")
                    .forward(request, response); 
    }
}
