<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
    Katie Hilliard
    06/27/2025
    Assignment: Module 7 – Project Plan Pt. 2
    The purpose of this JSP is so users can add a new state to katie_states_data
--%>

<!DOCTYPE html>
<html>
<head>
    <title>Add and Display States</title>
</head>
<body>
    <h1>State Database</h1>
    <h2>Add a New State</h2>

    <form method="post">
        <label>State Name:</label>
        <input type="text" name="state_name" required><br><br>

        <label>Capital:</label>
        <input type="text" name="capital" required><br><br>

        <label>Population (in millions):</label>
        <input type="number" step="0.01" name="population_millions" required><br><br>

        <label>Abbreviation:</label>
        <input type="text" maxlength="2" name="abbreviation" required><br><br>

        <input type="submit" value="Add State">
    </form>

<%
    String url = "jdbc:mysql://localhost:3306/CSD430";
    String user = "student1";
    String pass = "pass";

    // Retrieve submitted form by user
    String stateName = request.getParameter("state_name");
    String capital = request.getParameter("capital");
    String population = request.getParameter("population_millions");
    String abbreviation = request.getParameter("abbreviation");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(url, user, pass);

        // If form was submitted with all required fields, upload the data into table
        if (stateName != null && capital != null && population != null && abbreviation != null) {
            String insertSQL = "INSERT INTO katie_states_data (state_name, capital, population_millions, abbreviation) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(insertSQL);
            ps.setString(1, stateName);
            ps.setString(2, capital);
            ps.setBigDecimal(3, new java.math.BigDecimal(population));
            ps.setString(4, abbreviation.toUpperCase());
            ps.executeUpdate();
            ps.close();
        }

        // Query database to pull existing state records
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM katie_states_data");
%>

    <h2>All States in the Database</h2>
    <table border="1">
        <thead>
            <tr>
                <th>State ID</th>
                <th>State Name</th>
                <th>Capital</th>
                <th>Population (Millions)</th>
                <th>Abbreviation</th>
            </tr>
        </thead>
        <tbody>
        <%
            // Loop through each record and create a table row
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("state_id") %></td>
                <td><%= rs.getString("state_name") %></td>
                <td><%= rs.getString("capital") %></td>
                <td><%= rs.getBigDecimal("population_millions") %></td>
                <td><%= rs.getString("abbreviation") %></td>
            </tr>
        <%
            }
            // Close result set, statement, and connection
            rs.close();
            stmt.close();
            conn.close();
        %>
        </tbody>
    </table>

<%
// Handle errors that may be thrown during database connection or SQL execution
} catch(Exception e) {
    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    e.printStackTrace();
}
%>

</body>
</html>


