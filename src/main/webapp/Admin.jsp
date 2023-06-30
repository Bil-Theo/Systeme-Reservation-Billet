
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>

<%@page import="utilitaires.Utilisateur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
	<head>
            <jsp:include page="./Templates/HeadMetaInfo.jsp"/>
            
            <title>Admin Portal</title>
        </head>

	<body style="background-color:black;  background: url('./assets/img/dashboard.jpg'); background-size:cover;">
		<jsp:include page="./Templates/AdminPanel.jsp"/>
  	
                <%
                	session = request.getSession(false);
                %>
                    
                                <% if( session.getAttribute("user") == null ){
                                	
                                	RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                                	request.setAttribute("alert", "You do not have the rights to access this page. Please authenticate first");  
                                	rd.forward(request, response);
                            }
                                else{
                            		int i = 1;
                            		Utilisateur user = (Utilisateur) session.getAttribute("user");
                                	Cookie cookie = new Cookie("_id", user._id);
                                	cookie.setMaxAge(60*30);
                                	response.addCookie(cookie);
                            		String message = (String) request.getAttribute("succes");
                            		if(message !=null){
                            %>
                            			<span class = "alert alert-success" role="alert"> <%= message%></span>
                            		<%} %>
                            		
                            <div class="card mb-4" style="margin-top:15%; position: relative; z-index: 1;">
		                        <div class="card-header caption">Flights</div>
		                        <div class="card-body">
                            </div>
                            
                            <table class="table table-sm">
                                <thead>
                                    <tr>
                                      <th scope="col">#</th>
                                      <th scope="col">Name Flight</th>
                                      <th scope="col">Departure</th>
                                      <th scope="col">Arrival</th>
                                      <th scope="col">Departure Date</th>
                                      <th scope="col">Arrival Date</th>
                                      <th scope="col">Seats Economic</th>
                                      <th scope="col">Seats Business</th>
                                      <th scope="col">Seats First-Class</th>
                                      <th scope="col">Total Seats</th>
                                      <th scope="col" colspan="2">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        try {
                                            	Class.forName("com.mysql.cj.jdbc.Driver");
                                            	String query = "SELECT * FROM vol ;";
                                            	String url = "jdbc:mysql://localhost:3306/reservationvols";
                                            	Connection conn = DriverManager.getConnection(url, "root", "root");
                                            	PreparedStatement stmt = conn.prepareStatement(query);
                                            	ResultSet rs = stmt.executeQuery();
                                        while (rs.next()) {
                                    %>		
                                    		<%int total =  Integer.parseInt(rs.getString("nbrEco")) + Integer.parseInt(rs.getString("nbrBuz")) + Integer.parseInt(rs.getString("nbr1ereClasse")) ; %>
                                            <tr>
                                                <td><%= i%></td>
                                                <td><%= rs.getString("volNom")%></td>
                                                <td><%= rs.getString("villeDep")%></td>
                                                <td><%= rs.getString("villeArr")%></td>
                                                <td><%= rs.getString("dateDep")%></td>
                                                <td><%= rs.getString("dateArr")%></td>
                                                <td><%= rs.getString("nbrEco")%></td>
                                                <td><%= rs.getString("nbrBuz")%></td>
                                                <td><%= rs.getString("nbr1ereClasse")%></td>
                                                <td><%= total %></td>
                                                <td>
                                                    <form action="Update.jsp" method="post">
                                                        <input value="<%= rs.getString("_id")%>" name="_id" type="hidden">
                                                        <button class="bg-transparent" type="submit" style="border: none"> <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#2a2a2a}</style><path d="M471.6 21.7c-21.9-21.9-57.3-21.9-79.2 0L362.3 51.7l97.9 97.9 30.1-30.1c21.9-21.9 21.9-57.3 0-79.2L471.6 21.7zm-299.2 220c-6.1 6.1-10.8 13.6-13.5 21.9l-29.6 88.8c-2.9 8.6-.6 18.1 5.8 24.6s15.9 8.7 24.6 5.8l88.8-29.6c8.2-2.7 15.7-7.4 21.9-13.5L437.7 172.3 339.7 74.3 172.4 241.7zM96 64C43 64 0 107 0 160V416c0 53 43 96 96 96H352c53 0 96-43 96-96V320c0-17.7-14.3-32-32-32s-32 14.3-32 32v96c0 17.7-14.3 32-32 32H96c-17.7 0-32-14.3-32-32V160c0-17.7 14.3-32 32-32h96c17.7 0 32-14.3 32-32s-14.3-32-32-32H96z"/></svg> </button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <form method="POST" action="delete">
                                                        <input value="<%= rs.getString("_id")%>" name="_id" type="hidden">
                                                        <button class="bg-transparent" type="submit" style="border: none"> <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#232323}</style><path d="M135.2 17.7C140.6 6.8 151.7 0 163.8 0H284.2c12.1 0 23.2 6.8 28.6 17.7L320 32h96c17.7 0 32 14.3 32 32s-14.3 32-32 32H32C14.3 96 0 81.7 0 64S14.3 32 32 32h96l7.2-14.3zM32 128H416V448c0 35.3-28.7 64-64 64H96c-35.3 0-64-28.7-64-64V128zm96 64c-8.8 0-16 7.2-16 16V432c0 8.8 7.2 16 16 16s16-7.2 16-16V208c0-8.8-7.2-16-16-16zm96 0c-8.8 0-16 7.2-16 16V432c0 8.8 7.2 16 16 16s16-7.2 16-16V208c0-8.8-7.2-16-16-16zm96 0c-8.8 0-16 7.2-16 16V432c0 8.8 7.2 16 16 16s16-7.2 16-16V208c0-8.8-7.2-16-16-16z"/></svg> </i></button>
                                                    </form>
                                                </td>
                                            </tr>
                                    <%      i++;
                                        }
                                    }catch (ClassNotFoundException e) {
						// TODO Auto-generated catch block
										e.printStackTrace();
									} catch (SQLException e) {
						// TODO Auto-generated catch block
									    e.printStackTrace();
										RequestDispatcher r = request.getRequestDispatcher("Error.jsp");
										request.setAttribute("error", "Error 404");
										r.forward(request, response);
									}%>
                                

                                </tbody>
                            </table>
                        <div class="card-footer small text-muted"><!---  clients--->Total : <%= i-1%> flight</div>
                        </div>
                    </div>
	
	</body>
	<% }
     %>

	
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
  </body>
</html>