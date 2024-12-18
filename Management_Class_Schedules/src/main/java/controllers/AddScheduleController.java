package controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddScheduleController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddScheduleController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/university", "root", "chinnu");

            String courseCode = request.getParameter("courseCode");
            String facultyID = request.getParameter("facultyID");
            String day = request.getParameter("day");
            String time = request.getParameter("time");

            String sql = "INSERT INTO Schedules (course_code, faculty_id, day, time) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, courseCode);
            statement.setString(2, facultyID);
            statement.setString(3, day);
            statement.setString(4, time);

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("index.html"); // Redirect to index after adding schedule
            }

            statement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
