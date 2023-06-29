<%-- 
    Document   : ErrorPage
    Created on : 28/06/2023
    Author     : Bil Theodore Itoua
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
    
		<%	String error = (String) request.getAttribute("error"); %>
    
        <center></center><h1><%= error%></h1></center>
    </body>
</html>
