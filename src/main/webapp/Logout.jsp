<%
request.getSession(false).invalidate();

response.sendRedirect("login.jsp");
%>