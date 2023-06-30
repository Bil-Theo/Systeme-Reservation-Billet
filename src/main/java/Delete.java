

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Delete
 */
@WebServlet("/delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String url = "jdbc:mysql://localhost:3306/reservationvols";
	private static final String user_name = "root";
	private static final String mdps =  "root";
	private static final String query =  "DELETE FROM vol WHERE _id = ? ;";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int _id = Integer.parseInt(request.getParameter("_id"));
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection  =  DriverManager.getConnection(url, user_name, mdps);
			PreparedStatement stm = connection.prepareStatement(query);
			stm.setInt(1, _id);
			stm.executeUpdate();
			connection.close();
			RequestDispatcher r = request.getRequestDispatcher("Admin.jsp");
			request.setAttribute("succes", "Successfully removed theft");
			r.forward(request, response);
			
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

}
