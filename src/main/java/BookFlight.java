

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

import utilitaires.Utilisateur;

/**
 * Servlet implementation class BookFlight
 */
@WebServlet("/bookflight")
public class BookFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String url = "jdbc:mysql://localhost:3306/reservationvols";
	private static final String user_name = "root";
	private static final String mdps =  "root";
	private  String query =  " select reserver(?, ?, ?, ?) as status;";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookFlight() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String[] info = request.getParameter("info").split(",\\s*");
		HttpSession session = request.getSession(false);
	
		
		
		if(!info[3].equals("")) {
			
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection conn = DriverManager.getConnection(url, user_name, mdps);
					PreparedStatement stm = conn.prepareStatement(query);					
					stm.setInt(1, Integer.parseInt(info[2]));
					stm.setString(2, info[1]);
					stm.setInt(3, Integer.parseInt(info[0]));
					stm.setInt(4, Integer.parseInt(info[3]));
					ResultSet rs = stm.executeQuery();
					
					rs.next();
					
					if(rs.getInt("status")==0) {

						RequestDispatcher r = request.getRequestDispatcher("Customer.jsp");
						request.setAttribute("succes", "Flight successfully added");
						r.forward(request, response);
						stm.close();
						conn.close();
					}
					else {
						RequestDispatcher r = request.getRequestDispatcher("BookFlight.jsp");
						request.setAttribute("alert", "there is not enough seats for the requested flight. Try to reduce the number of seats");
						r.forward(request, response);
						stm.close();
						conn.close();
					}
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

			RequestDispatcher r = request.getRequestDispatcher("login.jsp");
			request.setAttribute("alert", "You do not have the rights to access this page. Please authenticate first");
			r.forward(request, response);
		}
		
	}
	

}
