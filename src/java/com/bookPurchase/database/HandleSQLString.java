package com.bookPurchase.database;

import static com.bookPurchase.database.Order.joinToString;
import org.apache.commons.lang.StringUtils;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


public class HandleSQLString {
  List resultList = new ArrayList();
  String resultString;
  
  public static void main(String[] args) {
  }
  public String quote( Object string ) {
    StringBuilder result = new StringBuilder();
    string = string.toString();
    result.append("'").append(string).append("'");
    resultString = result.toString();
    return resultString;
  }
  public static List quote( List list ) {
    for ( int i = 0; i < list.size(); i++ ) {
     String result = "";
     if ( list.get(i) instanceof List ) {
       result = "'" + joinToString((List) list.get(i)) + "'";
     } else {
       result = "'" + list.get(i).toString() + "'";
     }      
     list.set(i, result);
    }
    return list;
  }
}
