package com.bookPurchase.database;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ClientInserter extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String table = "clients";
        String username = "salvezzas";
        String password = "pwsalvezzas";
        
        try {
            if ( !request.getParameter("name").isEmpty() && !request.getParameter("region").isEmpty() && !request.getParameter("region_num").isEmpty() ) {
              // 加載數據庫驅動，註冊到驅動管理器
              Class.forName("com.mysql.jdbc.Driver");
              // 數據庫連接字符串
              String url = getServletContext().getInitParameter("databaseUrl") + "?useUnicode=true&characterEncoding=utf-8";
              // 創建Connection連接
              Connection conn = DriverManager.getConnection(url, username, password);
              // 根據請求建立Client物件
              Client client = new Client();
              client.setName(request.getParameter("name"));
              client.setRegion(request.getParameter("region"));
              client.setRegion_num(Integer.valueOf(request.getParameter("region_num")));
              // 根據Client物件創建values字串
              String values = "0, '" + client.getName() + "', '" +client.getRegion() + "', '" + client.getRegion_num() + "', 0";
              // 添加客戶信息的SQL語句並執行
              String sql = "INSERT INTO " + table + " VALUES (" + values + ")";
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
