

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateFlight
 */
@WebServlet("/updateflight")
public class UpdateFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String url = "jdbc:mysql://localhost:3306/reservationvols";
	private static final String user_name = "root";
	private static final String mdps =  "root";
	private  String query =  "UPDATE vol SET volNom = ?, villeDep = ?, villeArr = ?, dateDep = ?, dateArr = ?, nbrEco = ?, nbrBuz = ?, nbr1ereClasse = ? WHERE volNom = ? ;";
       
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateFlight() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String dateDep = request.getParameter("departDate");
		String dateArr = request.getParameter("arriveDate");
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date1 = LocalDate.parse(dateArr, formatter);
        LocalDate date2 = LocalDate.parse(dateDep, formatter);

        if (date1.isAfter(date2) || date1.isEqual(date2)) {
        	
        	String name = request.getParameter("nameFlight");
        	String dep = request.getParameter("departure");
        	String arr = request.getParameter("arrival");
        	int eco = Integer.parseInt(request.getParameter("seatsEco"));
        	int buz = Integer.parseInt(request.getParameter("seatsBuz"));
        	int Fclass = Integer.parseInt(request.getParameter("seatsFclass"));
        	
        	try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn = DriverManager.getConnection(url, user_name, mdps);
				PreparedStatement stm = conn.prepareStatement(query);
				
				stm.setString(1, name);
				stm.setString(2, dep);
				stm.setString(3, arr);
				stm.setString(4, dateDep);
				stm.setString(5, dateArr);
				stm.setInt(6, eco);
				stm.setInt(7, buz);
				stm.setInt(8, Fclass);
				stm.setString(9, name);
				
				stm.executeUpdate();
				
				stm.close();
				
				conn.close();
				
				RequestDispatcher r = request.getRequestDispatcher("Admin.jsp");
				request.setAttribute("succes", "Flight successfully updated");
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
            
        } else {
        	RequestDispatcher r = request.getRequestDispatcher("AddFlight.jsp");
			request.setAttribute("alert", "The arrival date must be greater than or equal to that of");
			r.forward(request, response);
			
        }
	}

}
