<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select a State</title>
</head>
<body>
    <h1>Module 5</h1>
    <p>Select a state ID from the dropdown:</p>

    <form action="display-state.jsp" method="get">
        <label for="state_id">State ID:</label>
        <select name="state_id" id="state_id">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/CSD430", "student1", "pass");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT state_id FROM katie_states_data");

                while (rs.next()) {
                    int id = rs.getInt("state_id");
        %>
                    <option value="<%= id %>"><%= id %></option>
        <%
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        %>
        </select><br><br>
        <input type="submit" value="View State Info">
    </form>
</body>
</html>

