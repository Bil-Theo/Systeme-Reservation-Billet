

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utilitaires.Check;
import utilitaires.Utilisateur;

/**
 * Servlet implementation class Signup
 */
@WebServlet(urlPatterns= {"/signup"})
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String url = "jdbc:mysql://localhost:3306/reservationvols";
	private static final String user_name = "root";
	private static final String mdps =  "root";
	private static final String query =  "INSERT INTO utilisateur values(null, ?, ?, ?, ?, 'customer');";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Signup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		RequestDispatcher rd =  request.getRequestDispatcher("signup.jsp");
		
		String prenom = request.getParameter("prenom");
		String nom = request.getParameter("nom");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		
		if(nom != null && email != null && password != null) {
			
			if(Check.isValidEmail(email)) {
				if(Check.isValidPassword(password)) {
					
					try 
					{
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection connection = DriverManager.getConnection(url, user_name, mdps);
						PreparedStatement statement = connection.prepareStatement(query);
						statement.setString(1, nom);
						statement.setString(2, prenom);
						statement.setString(3, email);
						statement.setString(4, password);
						statement.executeUpdate();
						
						statement  = connection.prepareStatement("SELECT _id FROM utilisateur WHERE email = ? AND motpass = ? ;");
						statement.setString(1, email);
						statement.setString(2, password);
						ResultSet result = statement.executeQuery();
						result.next();
						HttpSession session = request.getSession();
						session.setAttribute("user", new Utilisateur(result.getString("_id"), nom, prenom, email, password, "client"));
						
						result.close();
						connection.close();
						statement.close();
						
						response.sendRedirect("Customer.jsp");
						
						
					} catch (ClassNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						RequestDispatcher r = request.getRequestDispatcher("Error.jsp");
						request.setAttribute("error", "Error 404");
						r.forward(request, response);
					}
				}
				else {

					request.setAttribute("alert", "The password must be alphanumeric");
					rd.forward(request, response);
				}
				
			}
			else {
				request.setAttribute("alert", "The email must be in the form test@example.com");	
				rd.forward(request, response);
			}
			
			
			
		}
		else {
			request.setAttribute("alert", "Fields '*' are required");
			rd.forward(request, response);
			
		}
	}

}
