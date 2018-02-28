<%@ page contentType="text/html;charset=UTF-8"%> 
<%@ page import="java.sql.*,com.google.gson.Gson"%> 
<html> 
<body> 

<%
Class.forName("com.mysql.jdbc.Driver"); 
// --------- variables for authentication -----------\\
String user=new String("test"); 
String password=new String("test");
String database=new String("store");
String url=new String("jdbc:mysql://localhost:3306/" + database); 

// -------- statement to be executed --------- \\
String sql="select * from counselor"; 

Connection conn= DriverManager.getConnection(url,user,password); 
Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE); 
ResultSet rs=stmt.executeQuery(sql); 
%>


<%--callback: print JSON
String json = new Gson().toJson(rs.getString(1)); // anyObject = List<Bean>, Map<K, Bean>, Bean, String, etc..
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(json);
--%>

<%--default content
while(rs.next()) {%> 
您的第一個字段內容為：<%=rs.getString(1)%> <br>
您的第二個字段內容為：<%=rs.getString(2)%> <br>
<%}%> 
<%out.print("資料庫操作成功，恭喜你<br>");
--%>

<%
rs.close(); 
stmt.close(); 
conn.close(); 
%>
</body> 
</html>