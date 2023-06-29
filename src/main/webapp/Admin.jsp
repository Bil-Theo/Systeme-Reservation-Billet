
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
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
                    
                                <% if( session.getAttribute("user") ==null ){
                                	
                                	RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                                	request.setAttribute("alert", "You do not have the rights to access this page. Please authenticate first");  
                                	rd.forward(request, response);
                            }
                                else{
                            		int i = 1;
                            %>
                            <div class="card mb-4" style="margin-top:15%; position: relative; z-index: 1;">
		                        <div class="card-header caption"><!--- IcÃ´ne clients --->Flights</div>
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
                                      <th scope="col">Actions</th>
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
                                                <td>
                                                    <form action="update" method="post">
                                                        <input value="<%= rs.getString("_id")%>" name="_id" type="hidden">
                                                        <button class="bg-transparent" type="submit" style="border: none"><i class="fas fa-info-circle link-primary"></i></button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <form method="POST" action="delete">
                                                        <input value="<%= rs.getString("_id")%>" name="_id" type="hidden">
                                                        <button class="bg-transparent" type="submit" style="border: none"><i class="fas fa-trash-alt link-danger"></i></button>
                                                    </form>
                                                </td>
                                                <td>
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