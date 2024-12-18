<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Timetable</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Timetable</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>Time</th>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/university", "root", "chinnu");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM Schedules INNER JOIN Courses ON Schedules.course_code = Courses.course_code INNER JOIN Faculties ON Schedules.faculty_id = Faculties.faculty_id");
                        Map<String, Map<String, String>> timetable = new HashMap<>();
                        while (rs.next()) {
                            String time = rs.getString("time");
                            String day = rs.getString("day");
                            String courseName = rs.getString("course_name");
                            String facultyName = rs.getString("faculty_name");
                            if (!timetable.containsKey(time)) {
                                timetable.put(time, new HashMap<>());
                            }
                            timetable.get(time).put(day, courseName + " - " + facultyName);
                        }
                        conn.close();

                        for (String time : timetable.keySet()) {
                            out.println("<tr>");
                            out.println("<td>" + time + "</td>");
                            Map<String, String> schedule = timetable.get(time);
                            for (String day : Arrays.asList("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")) {
                                out.println("<td>" + schedule.getOrDefault(day, "") + "</td>");
                            }
                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
