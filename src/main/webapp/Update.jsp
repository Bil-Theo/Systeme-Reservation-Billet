
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>

<%@page import="utilitaires.Utilisateur"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Update Flight</title>
		
		<link rel="icon" href="./assets/img/teteLogo.png">

        <!-- CSS -->        
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
        <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="assets/css/form-elements.css">
        <link rel="stylesheet" href="assets/css/style.css">
       	<jsp:include page="Templates/HeadMetaInfo.jsp"/>
		
    </head>
	
	

  <body style="background: -webkit-radial-gradient(rgb(136, 15, 159), rgb(6, 19, 31));  background: radial-gradient(rgb(136, 15, 159), rgb(6, 19, 31)); background:url('./assets/img/milky.jpg');">  
	  <jsp:include page="Templates/AdminPanel.jsp"/>	
      <jsp:include page="Templates/AdminPanel.jsp"/>
      <%

			   String url = "jdbc:mysql://localhost:3306/reservationvols";
			   String user_name = "root";
			   String mdps =  "root";
			   String query =  "SELECT * FROM vol WHERE _id = ?";
			   if(request.getParameter("_id")==null){
           		
           		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
               	request.setAttribute("alert", "You do not have the rights to access this page. Please authenticate first");  
               	rd.forward(request, response);
           	}
			   else{
      %>
      
      <% 
      		String message =(String) request.getAttribute("alert");
      		if(message !=null){
                            %>
                     <span class = "alert alert-danger" role="alert"> <%= message%></span>
              <%} %>
      
      <%
      	String[] cities = {
    		    "Tokyo",
    		    "Delhi",
    		    "Shanghai",
    		    "São Paulo",
    		    "Mumbai",
    		    "Beijing",
    		    "Cairo",
    		    "Lyon",
    		    "Dhaka",
    		    "Mexico City",
    		    "Osaka",
    		    "Karachi",
    		    "Chongqing",
    		    "Istanbul",
    		    "Buenos Aires",
    		    "Kolkata",
    		    "Brazzaville",
    		    "Pointe-Noire",
    		    "Ndjamena",
    		    "Alger",
    		    "Oran",
    		    "Annaba",
    		    "Rabat",
    		    "Cair",
    		    "Lagos",
    		    "Kinshasa",
    		    "Manila",
    		    "Rio de Janeiro",
    		    "Guangzhou",
    		    "Lahore",
    		    "Shenzhen",
    		    "Bangalore",
    		    "Moscow",
    		    "Tianjin",
    		    "Jakarta",
    		    "London",
    		    "Paris",
    		    "Lima",
    		    "Bangkok",
    		    "New York City",
    		    "Chennai",
    		    "Bogotá",
    		    "Hyderabad",
    		    "Hong Kong",
    		    "Lahore",
    		    "Ho Chi Minh City",
    		    "Ahmedabad",
    		    "Kuala Lumpur",
    		    "Santiago",
    		    "Hangzhou",
    		    "Riyadh",
    		    "Madrid",
    		    "Toronto",
    		    "Chicago",
    		    "Miami",
    		    "Washington, D.C.",
    		    "Boston",
    		    "Philadelphia",
    		    "Los Angeles",
    		    "Dallas",
    		    "Houston"
    		};

      %>
      

                <!-- Top content -->
                
                <% 
                	String alert = (String) request.getAttribute("alert");
                	if(alert !=null){
                            %>
                            			<span class = "alert alert-danger" role="alert" style ="margin: 30%;"> <%= alert%></span>
                            		<%} 
                    
                	int _id = Integer.parseInt(request.getParameter("_id"));
                	
                	Class.forName("com.mysql.cj.jdbc.Driver");
                	Connection conn = DriverManager.getConnection(url, "root", "root");
                	PreparedStatement stmt = conn.prepareStatement(query);
                	stmt.setInt(1, _id);
                	ResultSet rs = stmt.executeQuery();       
                	
                	rs.next();
                            		
             %>
                
        <div class="top-content" >
            <div class="inner-bg" style="padding:0px 0px 80px 0;">
                <div class="container">
                    <div class="row" style="margin-left:17%; margin-right:17%;">
                        
                        <div>
                        	<div class="form-box">
	                        	<div class="form-top">
	                        		<div class="form-top-left">
	                        			<h3 style ="color:white;">Complete the Following</h3>
	                        		</div>
	                        		<div class="form-top-right">
	                        			<i class="fa fa-plane"></i>
	                        		</div>
	                            </div>
	                            <div class="form-bottom" style="color:white;">
				                    <form role="form" action="updateflight" method="post" class="flight-search-form">
                                                        
                                      <div class="row">  
                                      <div class="form-group col-lg-4">
				                    		<label for="depart">Name Flight</label>
				                        	<input required type="text" value="<%= rs.getString("volNom") %>" name="nameFlight" class="form-control" placeholder="fk-wxyz" style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;">											
				                        </div>                                                          
				                    	<div class="form-group col-lg-4 ui-widget">
				                    		<label for="from">From</label>
                            					<select class="form-control form-select" name="departure" required>
                                					<option disabled selected style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;">city</option> 
				                    		<%
				                    			for(String city: cities){
				                    		%>
                                					<option value="<%= city %>" style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;"> <%= city %> </option>
                                				<%} %>
                            					</select>
                                                                              
				                        </div>
				                        <div class="form-group col-lg-4 ui-widget">
				                        	<label for="to">To</label>
				                        		
                            					<select class="form-control form-select" name="arrival" required>
                                					<option disabled selected style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;">city</option> 
				                    		<%
				                    			for(String city: cities){
				                    		%>
                                					<option value="<%= city %>" style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;"> <%= city %> </option>
                                				<%} %>
                            					</select>
				                        </div>
				                     </div>
				                     <div class="row">
				                    	<div class="form-group col-lg-4">
				                    		<label for="depart">Departure Date</label>
				                        	<input required type="date" value="<%= rs.getString("dateDep") %>" name="departDate" class="form-control" id="form-depart" style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;">											
				                        </div>
				                        <div class="form-group col-lg-4">
				                    		<label for="depart">Arrival Date</label>
				                        	<input required type="date" value="<%= rs.getString("dateArr") %>" name="arriveDate" class="form-control" id="form-depart" style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;">											
				                        </div>
									</div>
									
									<div class="row">
				                    	
				                        <div class="form-group col-lg-4">
				                        	<label for="people">Economy</label>
				                        	<input required type="number" value="<%= rs.getString("nbrEco") %>" min="1" max="60" placeholder="Number of People.." name="seatsEco" class="form-control" id="form-adults" style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;">
				                        </div>
				                        <div class="form-group col-lg-4">
				                        	<label for="people">Business</label>
				                        	<input required type="number" value="<%= rs.getString("nbrBuz") %>" min="1" max="60" placeholder="Number of People.." name="seatsBuz" class="form-control" id="form-adults" style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;">
				                        </div>
				                        <div class="form-group col-lg-4">
				                        	<label for="people">First Class</label>
				                        	<input required type="number" value="<%= rs.getString("nbr1ereClasse") %>" min="0" max="60" placeholder="Number of People.." name="seatsFclass" class="form-control" id="form-adults" style = "height: 50px;    margin: 0;    padding: 0 20px;    vertical-align: middle;    background: #fff;    border: 3px solid #fff;    font-family: 'Roboto', sans-serif;    font-size: 16px;    font-weight: 300;    line-height: 50px;    color: #888;    -moz-border-radius: 4px;    -webkit-border-radius: 4px;    border-radius: 4px;    -moz-box-shadow: none;    -webkit-box-shadow: none;    box-shadow: none;    -o-transition: all .3s;    -moz-transition: all .3s;    -webkit-transition: all .3s;    -ms-transition: all .3s;    transition: all .3s;">
				                        </div>

                                     </div>
										<div style="text-align:center;">
											<button style="margin-top:5%;" type="submit"  class="btn col-xs-5 col-md-5">Validate Update</button>
										</div>
									</form>
			                    </div>
		                    </div>
		            
                        </div>

                    </div>
                    
                </div>
            </div>
            
        </div>
        
        <%} %>

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


