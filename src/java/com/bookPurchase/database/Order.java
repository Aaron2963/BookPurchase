package com.bookPurchase.database;

import static com.bookPurchase.database.HandleSQLString.quote;
import java.beans.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

public class Order implements Serializable {
    
    private int id;    
    private String client;
    private List books;
    private List books_qt;
    private List status;
    private String shipping;
    private int est_shipping;
    private int act_shipping;
    private int discount;
    private int amount;
    private int date;
    
    // 建構子
    public Order() {}
    public Order(HttpServletRequest request) {
      if ( !request.getParameter("id").isEmpty() ) {
        this.id = Integer.valueOf(request.getParameter("id"));
      }
      if ( !request.getParameter("client").isEmpty() ) {
        this.client = request.getParameter("client");
        this.books = splitToList(request.getParameter("books"));
        this.books_qt = splitToList(request.getParameter("books_qt"));
        this.status = splitToList(request.getParameter("status"));
        this.shipping = request.getParameter("shipping");
        this.est_shipping = Integer.valueOf(request.getParameter("est_shipping"));
        this.act_shipping = Integer.valueOf(request.getParameter("act_shipping"));
        this.discount = Integer.valueOf(request.getParameter("discount"));
        this.amount = Integer.valueOf(request.getParameter("amount"));
        this.date = Integer.valueOf(request.getParameter("date"));
      }
    }
    
    // 以","為分隔，將字串拆分成數組
    public static List<String> splitToList(String s) {
      List<String> list;
      list = new ArrayList<>(Arrays.asList(s.split(",")));
      return list;
    }
    
    // 以","為連結，將數組結合成字串
    public static String joinToString(List list) {
      String result = "";
      for ( Object s : list ) {
        s = s.toString();
        result += s + ",";
      }
      return result.substring(0, result.length() - 1);
    }
    
    // 創建SQL用VALUES字串 (INSERT)
    public String orderValues() {
      // 收集各個屬性集成數組
      List list = new ArrayList<>();
      list.add("0");
      list.add(this.client);
      list.add(joinToString(this.books));
      list.add(joinToString(this.books_qt));
      list.add(this.shipping);
      list.add(this.est_shipping);
      list.add(joinToString(this.status));
      list.add(this.act_shipping);
      list.add(this.discount);
      list.add(this.amount);
      list.add(this.date);
      // 將數組中的各屬性加上單括號
      list = quote(list);

      // 將數組轉為字串，如"( '0', 'name', ... )"
      String values = "";
      for (Object s : list) {
        values += s + ", ";
      }
      values = values.substring(0, values.length() - 2);
      values ="(" + values + ")";
      return values;
    }
    
    // 創建SQL用SET字串 (UPADTE)
    public String orderSet() {
      StringBuilder values = new StringBuilder();
      String q = "', ";
      values.append("client=").append(this.client).append(q);
      values.append("books=").append(this.books).append(q);
      values.append("books_qt=").append(this.books_qt).append(q);
      values.append("status=").append(this.status).append(q);
      values.append("shipping=").append(this.shipping).append(q);
      values.append("est_shipping=").append(this.est_shipping).append(q);
      values.append("act_shipping=").append(this.act_shipping).append(q);
      values.append("discount=").append(this.discount).append(q);
      values.append("amount=").append(this.amount).append(q);
      values.append("date=").append(this.date);
      values.append("'");
      return values.toString();
    }
    
    // JavaBean的GET、SET方法
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    
    public String getClient() {
        return client;
    }
    public void setClient(String client) {
        this.client = client;
    }
    
    public String getShipping() {
        return shipping;
    }
    public void setShipping(String shipping) {
        this.shipping = shipping;
    }
    
    public List getBooks() {
        return books;
    }
    public void setBooks(List books) {
        this.books = books;
    }
    
    public List getBooks_qt() {
        return books_qt;
    }
    public void setBooks_qt(List books_qt) {
        this.books_qt = books_qt;
    }
    
    public List getStatus() {
        return status;
    }
    public void setStatus(List status) {
        this.status = status;
    }
    
    public int getEst_shipping() {
        return est_shipping;
    }
    public void setEst_shipping(int est_shipping) {
        this.est_shipping = est_shipping;
    }
    
    public int getAct_shipping() {
        return act_shipping;
    }
    public void setAct_shipping(int act_shipping) {
        this.act_shipping = act_shipping;
    }
    
    public int getDiscount() {
        return discount;
    }
    public void setDiscount(int discount) {
        this.discount = discount;
    }
    
    public int getAmount() {
        return amount;
    }
    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    public int getDate() {
        return date;
    }
    public void setDate(int date) {
        this.date = date;
    }
}
