package com.bookPurchase.database;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import javax.servlet.RequestDispatcher;

public class Controller extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //confirm user authentication
        
        //redirect to corresponding database operator servlet
        List<String> queryTypes = new ArrayList<>(Arrays.asList("order", "book", "client", "setting"));
        switch (queryTypes.indexOf(request.getParameter("queryType"))) {
            case 0:
                request.getRequestDispatcher("order.list")
                            .forward(request, response);
                break;
            case 1:
                request.getRequestDispatcher("book.list")
                            .forward(request, response);
                break;
            case 2:
                request.getRequestDispatcher("client.list")
                            .forward(request, response);
                break;
            case 3:
                request.getRequestDispatcher("setting.option")
                            .forward(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         doGet(request, response);
    }
}
