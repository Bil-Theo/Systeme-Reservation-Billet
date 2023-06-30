

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.mysql.cj.jdbc.Driver;

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
 * Servlet implementation class Login
 */

@WebServlet(urlPatterns = {"/Login"})
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String url = "jdbc:mysql://localhost:3306/reservationvols";
	private static final String user_name = "root";
	private static final String mdps =  "root";
	private static final String query =  "SELECT * FROM utilisateur WHERE email = ? AND motpass = ?";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		String email =  request.getParameter("j_email");
		
		if(Check.isValidEmail(email)) {
			
			String password = request.getParameter("j_password");
			if(Check.isValidPassword(password)) {
				
				try
				{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection connection = DriverManager.getConnection(url, user_name, mdps);
					PreparedStatement statement = connection.prepareStatement(query);
					statement.setString(1, email);
					statement.setString(2, password);
					ResultSet result = statement.executeQuery();
					
					
					if(result.next()) {
						
						HttpSession session = request.getSession();
						
						Utilisateur user = new Utilisateur(result.getString("_id"), result.getString("nom"), result.getString("prenom"), result.getString("email"), result.getString("motpass"), result.getString("type"));
						
						session.setAttribute("user", user);
						
						if(result.getString("type").equals("admin")) {
							response.sendRedirect("Admin.jsp");
						}
						else{
							response.sendRedirect("Customer.jsp");
						}
						
					}
					else {
						request.setAttribute("alert", "Email or Password incorrect");
						rd.forward(request, response);
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
				}
				
			}
			else {
				request.setAttribute("alert", "Email or Password incorrect");
				rd.forward(request, response);
			}
		}
		else {
			request.setAttribute("alert", "Email or Password incorrect");
			rd.forward(request, response);
		}
	}

}
