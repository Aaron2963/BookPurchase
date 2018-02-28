package com.bookPurchase.database;

import java.beans.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

public class Client implements Serializable {
    
    private int id;    
    private String name;
    private String region;
    private int region_num;
    
    // 建構子
    public Client() {}
    public Client(HttpServletRequest request) {
      if ( !request.getParameter("id").isEmpty() ) {
        this.id = Integer.valueOf(request.getParameter("id"));
      }
      if ( !request.getParameter("name").isEmpty() ) {
        this.name = request.getParameter("name");
        this.region = request.getParameter("region");
        this.region_num = Integer.valueOf(request.getParameter("region_num"));
      }
    }
    
    // 創建SQL用VALUES字串 (INSERT)
    public String clientValues() {
      // 收集各個屬性集成集合
      List list = new ArrayList<>();
      list.add(this.name);
      list.add(this.region);
      list.add(this.region_num);
      HandleSQLString h = new HandleSQLString();
      list = h.quote(list);

      // 將集合轉為字串，如"( '0', 'name', ... )"
      String values = "";
      for (Object s : list) {
        values += ", " + s;
      }
      values = "( '0'" + values + " ,'0' )";
      return values;
    }
    
    // 創建SQL用SET字串 (UPADTE)
    public String clientSet() {
      StringBuilder values = new StringBuilder();
      String q = "', ";
      values.append("name='").append(this.name).append(q);
      values.append("author='").append(this.region).append(q);
      values.append("note='").append(this.region_num);
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
    
    public String getRegion() {
        return region;
    }
    public void setRegion(String region) {
        this.region = region;
    }
    
    public int getRegion_num() {
        return region_num;
    }
    public void setRegion_num(int region_num) {
        this.region_num = region_num;
    }
}
