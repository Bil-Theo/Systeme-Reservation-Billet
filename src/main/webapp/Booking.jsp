<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Book Flight</title>
		
		<link rel="icon" href="./assets/img/teteLogo.png">

        <!-- CSS -->        
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
        <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="assets/css/form-elements.css">
        <link rel="stylesheet" href="assets/css/style.css">
		
    </head>
	
	
<%@page import="java.sql.*"%>
<%@page import="utilitaires.Utilisateur" %>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <body style="background: -webkit-radial-gradient(rgb(136, 15, 159), rgb(6, 19, 31));  background: radial-gradient(rgb(136, 15, 159), rgb(6, 19, 31)); background:url('./assets/img/main.jpg');">  

      <jsp:include page="Templates/CustomerHeader.jsp"/>
      <jsp:include page="Templates/HeadMetaInfo.jsp"/>


<%			
		   String url = "jdbc:mysql://localhost:3306/reservationvols";
		   String user_name = "root";
		   String mdps =  "root";
		   String query =  "SELECT * FROM vol where villeDep = ? AND villeArr = ? AND ";
		   
		   int i = 1;
		   
		   if(request.getParameter("departure")==null){
			   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
              	request.setAttribute("alert", "You do not have the rights to access this page. Please authenticate first");  
              	rd.forward(request, response);
		   }

			String dep = request.getParameter("departure");
			String arr = request.getParameter("arrival");
			String date = request.getParameter("depart");
			String classe = request.getParameter("class");
			String seats = request.getParameter("seats");
			
			if(classe.equals("Economy")) query = query + "nbrEco >= ? ;";
			else if(classe.equals("Business")) query = query + "nbrBuz >= ? ;";
			else query = query + "nbr1ereClasse >= ? ;";
			
			String _id = "";
			
			Cookie[] cookies = request.getCookies();
			
			for(Cookie cookie: cookies){
				if(cookie.getName().equals("_id")){
					_id = cookie.getValue(); break;
				}
			}
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn = DriverManager.getConnection(url, user_name, mdps);
				//System.out.println(query);
				PreparedStatement stm = conn.prepareStatement(query);
				stm.setString(1, dep);
				stm.setString(2, arr);
				stm.setInt(3, Integer.parseInt(seats));
				
				ResultSet rs = stm.executeQuery();%>
				
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
                                      <th scope="col">Class</th>
                                      <th scope="col">Total Seats</th>
                                      <th scope="col" colspan="2">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
				
				<% 
				
					while(rs.next()){%>
						 <tr>
                                                <td><%= i%></td>
                                                <td><%= rs.getString("volNom")%></td>
                                                <td><%= rs.getString("villeDep")%></td>
                                                <td><%= rs.getString("villeArr")%></td>
                                                <td><%= rs.getString("dateDep")%></td>
                                                <td><%= rs.getString("dateArr")%></td>
                                                <td><%= classe %></td>
                                                <td><%= seats%></td>
                                                <td>
                                                <td>
                                                    <form action="bookflight" method="post">
                                                        <input value="<%= rs.getString("_id")+","+classe+","+seats+","+_id %>" name="info" type="hidden">
                                                        <button class="bg-transparent" type="submit" style="border: none">
                                                        	<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 576 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#1e1e1e}</style><path d="M96 80c0-26.5 21.5-48 48-48H432c26.5 0 48 21.5 48 48V384H96V80zm313 47c-9.4-9.4-24.6-9.4-33.9 0l-111 111-47-47c-9.4-9.4-24.6-9.4-33.9 0s-9.4 24.6 0 33.9l64 64c9.4 9.4 24.6 9.4 33.9 0L409 161c9.4-9.4 9.4-24.6 0-33.9zM0 336c0-26.5 21.5-48 48-48H64V416H512V288h16c26.5 0 48 21.5 48 48v96c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V336z"/></svg>
                                                        </button>
                                                     </form>
                                           		 </td>
                                           		 <td>
                                           		 	    <button onclick="history.back()" class="bg-transparent"  style="border: none">
                                                        	<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#161616}</style><path d="M367.2 412.5L99.5 144.8C77.1 176.1 64 214.5 64 256c0 106 86 192 192 192c41.5 0 79.9-13.1 111.2-35.5zm45.3-45.3C434.9 335.9 448 297.5 448 256c0-106-86-192-192-192c-41.5 0-79.9 13.1-111.2 35.5L412.5 367.2zM0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256z"/></svg>
                                                        </button>
                                           		 </td>
                                            </tr>
                                    
					
				
				<% i++;}
				stm.close();
				conn.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				RequestDispatcher r = request.getRequestDispatcher("Error.jsp");
				request.setAttribute("error", "Error 404");
				r.forward(request, response);}
	

%>
		 						</tbody>
                            </table>
                        <div class="card-footer small text-muted"><!---  clients--->Total : <%= i-1 %> flights found</div>
                        
                        
                        <% if((i-1)==0){
                         %>
                         <div  style = "margin-left: auto; margin-right: auto; margin-top: 6%; margin-bottom: 4%;">
                         	<svg xmlns="http://www.w3.org/2000/svg" height="8em" viewBox="0 0 640 512"><!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#1f1f1f}</style><path d="M514.3 192c34.2 0 93.7 29 93.7 64c0 36-59.5 64-93.7 64H440.6L630.8 469.1c10.4 8.2 12.3 23.3 4.1 33.7s-23.3 12.3-33.7 4.1L9.2 42.9C-1.2 34.7-3.1 19.6 5.1 9.2S28.4-3.1 38.8 5.1L238.1 161.3 197.8 20.4C194.9 10.2 202.6 0 213.2 0h56.2c11.5 0 22.1 6.2 27.8 16.1L397.7 192l116.6 0zM41.5 128.7l321 252.9L297.2 495.9c-5.7 10-16.3 16.1-27.8 16.1l-56.2 0c-10.6 0-18.3-10.2-15.4-20.4l49-171.6H144l-43.2 57.6c-3 4-7.8 6.4-12.8 6.4H46c-7.8 0-14-6.3-14-14c0-1.3 .2-2.6 .5-3.9L64 256 32.5 145.9c-.4-1.3-.5-2.6-.5-3.9c0-6.2 4-11.4 9.5-13.3z"/></svg>
                         </div>
                         <%} %>
                      </div>
                   </div>


 <jsp:include page="Templates/Footer.jsp"/>

   <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
  
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="assets/autocompleter.js"></script>
     
  </body>

</html>