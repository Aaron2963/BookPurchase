package com.bookPurchase.database;

import java.beans.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

public class Book implements Serializable {
  
  private int id;
  private String name;
  private String author;
  private String publisher;
  private int publish_in;
  private int volume;
  private float cover_price_RMB;
  private int cover_price_NT;
  private int stock_price_NT;
  private int sold;
  private String note;
  private String status;
  private int qt;
 
  // 建構子：
  public Book() {}
  // 建構子：從請求中建構物件
  public Book(HttpServletRequest request) {
    if ( !request.getParameter("id").isEmpty() ) {
      this.id = Integer.valueOf(request.getParameter("id"));
    }
    if ( !request.getParameter("name").isEmpty() ) {
      this.name = request.getParameter("name");
      this.author = request.getParameter("author");
      this.publisher = request.getParameter("publisher");
      this.publish_in = Integer.valueOf(request.getParameter("publish_in"));
      this.volume = Integer.valueOf(request.getParameter("volume"));
      this.cover_price_RMB = Float.parseFloat(request.getParameter("cover_price_RMB"));
      this.cover_price_NT = Integer.valueOf(request.getParameter("cover_price_NT"));
      this.stock_price_NT = Integer.valueOf(request.getParameter("stock_price_NT"));
      this.sold = Integer.valueOf(request.getParameter("sold"));
      this.note = request.getParameter("note");
    }
  }
  
  // 創建SQL用VALUES字串 (INSERT)
  public String bookValues() {
    // 收集各個屬性集成集合
    List<String> list = new ArrayList<>();
    list.add(quote(this.name));
    list.add(quote(this.author));
    list.add(quote(this.publisher));
    list.add(quote(this.publish_in));
    list.add(quote(this.volume));
    list.add(quote(this.cover_price_RMB));
    list.add(quote(this.cover_price_NT));
    list.add(quote(this.stock_price_NT));
    list.add(quote(this.sold));
    list.add(quote(this.note));
    
    // 將集合轉為字串，如"( '0', 'name', ... )"
    String values = "";
    for (String s : list) {
      values += ", " + s;
    }
    values = "( '0'" + values + " ,'0' )";
    return values;
  }
  
  // 將各屬性轉為字串，並加上單括號
  public String quote( Object string ) {
    StringBuilder result = new StringBuilder();
    string = string.toString();
    result.append("'").append(string).append("'");
    return result.toString();
  }
  
  
  // 創建SQL用SET字串 (UPADTE)
  public String bookSet() {
    StringBuilder values = new StringBuilder();
    String q = "', ";
    values.append("name='").append(this.name).append(q);
    values.append("author='").append(this.author).append(q);
    values.append("publisher='").append(this.publisher).append(q);
    values.append("publish_in='").append(this.publish_in).append(q);
    values.append("volume='").append(this.volume).append(q);
    values.append("cover_price_RMB='").append(this.cover_price_RMB).append(q);
    values.append("cover_price_NT='").append(this.cover_price_NT).append(q);
    values.append("stock_price_NT='").append(this.stock_price_NT).append(q);
    values.append("sold='").append(this.sold).append(q);
    values.append("note='").append(this.note);
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
  
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  
  public String getAuthor() {
    return author;
  }
  public void setAuthor(String author) {
    this.author = author;
  }
  
  public String getPublisher() {
    return publisher;
  }
  public void setPublisher(String publisher) {
    this.publisher = publisher;
  }
  
  public int getPublish_in() {
    return publish_in;
  }
  public void setPublish_in(int publish_in) {
    this.publish_in = publish_in;
  }
  
  public int getVolume() {
    return volume;
  }
  public void setVolume(int volume) {
    this.volume = volume;
  }

  public float getCover_price_RMB() {
    return cover_price_RMB;
  }
  public void setCover_price_RMB(float cover_price_RMB) {
    this.cover_price_RMB = cover_price_RMB;
  }
  
  public int getCover_price_NT() {
    return cover_price_NT;
  }
  public void setCover_price_NT(int cover_price_NT) {
    this.cover_price_NT = cover_price_NT;
  }
  
  public int getStock_price_NT() {
    return stock_price_NT;
  }
  public void setStock_price_NT(int stock_price_NT) {
    this.stock_price_NT = stock_price_NT;
  }
  
  public int getSold() {
    return sold;
  }
  public void setSold(int sold) {
    this.sold = sold;
  }
  
  public String getNote() {
    return note;
  }
  public void setNote(String note) {
    this.note = note;
  }
  
  public String getStatus() {
    return status;
  }
  public void setStatus(String status) {
    this.status = status;
  }

  public int getQt() {
    return qt;
  }
  public void setQt(int qt) {
    this.qt = qt;
  }
}
