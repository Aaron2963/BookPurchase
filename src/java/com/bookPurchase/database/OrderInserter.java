package com.bookPurchase.database;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class OrderInserter extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String table = "order_history";
        String username = "salvezzas";
        String password = "pwsalvezzas";
        
        try {
            if ( !request.getParameter("client").isEmpty() ) {
              // 加載數據庫驅動，註冊到驅動管理器
              Class.forName("com.mysql.jdbc.Driver");
              // 數據庫連接字符串
              String url = getServletContext().getInitParameter("databaseUrl") + "?useUnicode=true&characterEncoding=utf-8";
              // 創建Connection連接
              Connection conn = DriverManager.getConnection(url, username, password);
              // 根據請求建立Order物件
              Order order = new Order(request);
              // 根據Book物件創建values字串
              String values = order.orderValues();
              // 添加客戶信息的SQL語句並執行
              String sql = "INSERT INTO " + table + " VALUES " + values + ";";
              Statement statement = conn.createStatement();
              statement.executeUpdate(sql);
              // 關閉SQL語句及數據庫連接
              statement.close();
              conn.close();
            }
        } catch (Exception e) {
                e.printStackTrace();
        }
    }
}