package com.bookPurchase.database;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ClientDeleter extends HttpServlet {
  protected void doGet(HttpServletRequest request,
                  HttpServletResponse response) throws ServletException, IOException {
    int id = Integer.valueOf(request.getParameter("id"));
    String table = "clients";
    String username = "salvezzas";
    String password = "pwsalvezzas";
    try {
          // 加載數據庫驅動，註冊到驅動管理器
          Class.forName("com.mysql.jdbc.Driver");
          // 數據庫連接字符串
          String url = getServletContext().getInitParameter("databaseUrl") + "?useUnicode=true&characterEncoding=utf-8";
          // 創建Connection連接
          Connection conn = DriverManager.getConnection(url, username, password);
          // 刪除圖書信息的SQL語句
          //String sql = "delete from " + table + " where id=?";
          String sql = "UPDATE " + table + " SET hidden=1 WHERE id=?;";
          // 獲取PreparedStatement
          PreparedStatement ps = conn.prepareStatement(sql);
          // 對SQL語句中的第一個占位符賦值
          ps.setInt(1, id);
          // 執行更新操作
          ps.executeUpdate();
          // 關閉PreparedStatement
          ps.close();
          // 關閉Connection
          conn.close();

    } catch (Exception e) {
            e.printStackTrace();
    }

  }

  protected void doPost(HttpServletRequest request,
                  HttpServletResponse response) throws ServletException, IOException {
          doGet(request, response);
  }

}