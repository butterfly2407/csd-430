<%@ page import="java.sql.*" %>
<%@ page import="beans.StateInfo" %>
<!DOCTYPE html>
<html>
<head>
    <title>State Details</title>
</head>
<body>
    <h1>Selected State Record</h1>
<%
    String stateIdParam = request.getParameter("state_id");

    if (stateIdParam != null && !stateIdParam.isEmpty()) {
        try {
            int stateId = Integer.parseInt(stateIdParam);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/CSD430", "student1", "pass");

            String sql = "SELECT * FROM katie_states_data WHERE state_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, stateId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
%>
    <table border="1">
        <thead>
            <tr>
                <th>State ID</th>
                <th>State Name</th>
                <th>Capital</th>
                <th>Population (millions)</th>
                <th>Abbreviation</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%= rs.getInt("state_id") %></td>
                <td><%= rs.getString("state_name") %></td>
                <td><%= rs.getString("capital") %></td>
                <td><%= rs.getDouble("population_millions") %></td>
                <td><%= rs.getString("abbreviation") %></td>
            </tr>
        </tbody>
    </table>
<%
            } else {
                out.println("<p>No state found for ID: " + stateId + "</p>");
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>No state ID selected.</p>");
    }
%>
    <p><a href="select-state.jsp">Back to State Selection</a></p>
</body>
</html>
