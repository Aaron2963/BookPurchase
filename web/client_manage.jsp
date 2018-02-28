<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.List"%>
<%@page import="com.bookPurchase.database.Client"%>
<html>
<head>
  <meta charset="UTF-8">
  <!-- <title>書籍代購-客戶管理</title> -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.6/css/all.css">
  <link rel="stylesheet" href="css/custom.css">
</head>
<body>
  <div class="container pt-3">
    <p class="toolbar float-right">
      <button class="btn btn-success" data-toggle="modal" data-target="#addClientModal">新增客戶</button>
    </p>
    <h2 class="text-center">客戶管理</h2>
    <div>
      <table class="table text-center tablesorter">
        <thead class="thead-dark">
          <tr>
            <th class="sorter">客戶名稱</th>
            <th class="sorter">客戶地區</th>
            <th class="sorter">分區</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody id="clientData">
          <%
            List<Client> list = (List<Client>) request.getAttribute("list");
            for (Client client : list) { %>
            <tr>
                <td><%= client.getName() %></td>
                <td><%= client.getRegion() %></td>
                <td><%= client.getRegion_num() %></td>
                <td>
                  <a class="btn btn-secondary" href=""><i class="fas fa-history"></i></a>
                  <button class="btn btn-secondary to-edit"
                            data-id="<%= client.getId() %>"
                            data-name="<%= client.getName() %>"
                            data-region="<%= client.getRegion() %>"
                            data-region_num="<%= client.getRegion_num() %>"
                            data-toggle="modal"
                            data-target="#editClientModal">
                    <i class="fas fa-edit"></i>
                  </button>
                  <button class="btn btn-secondary to-delete" 
                            value="<%= client.getId() %>"
                            data-name="<%= client.getName() %>">
                    <i class="far fa-trash-alt"></i>
                  </button>
                </td>
            </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Add Client Modal -->
  <%@include file="auxil/add_client_form.jsp" %>
  
  <!-- Edit Client Modal -->
  <%@include file="auxil/edit_client_form.jsp" %>

  <script src="js/custom.js"></script>
  <script src="js/jquery.tablesort.min.js"></script>
  <script>
    loadRegion();
    $('table').tablesort();
  </script>

</body>
</html>