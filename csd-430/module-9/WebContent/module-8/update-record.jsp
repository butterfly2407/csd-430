<%@ page import="java.sql.*, beans.StateDataBean, beans.StateInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
    Katie Hilliard
    07/02/2025
    Module 8 Assignment - Project Part 3
    The purpose of this JSP to update a record in the database and display the updated data.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>Updated State Record</title>
</head>
<body>
    <h2>Updated State Record</h2>

<%
    try {
        // Get form data
        int stateId = Integer.parseInt(request.getParameter("state_id"));
        String stateName = request.getParameter("state_name");
        String capital = request.getParameter("capital");
        double population = Double.parseDouble(request.getParameter("population_millions"));
        String abbreviation = request.getParameter("abbreviation");

        // Create StateInfo object
        StateInfo state = new StateInfo();
        state.setState_id(stateId);
        state.setState_name(stateName);
        state.setCapital(capital);
        state.setPopulation_millions(population);
        state.setAbbreviation(abbreviation);

        // Update database
        StateDataBean bean = new StateDataBean();
        bean.updateState(state);
%>

    <table border="1" cellpadding="8">
        <tr>
            <th>State ID</th>
            <th>State Name</th>
            <th>Capital</th>
            <th>Population (millions)</th>
            <th>Abbreviation</th>
        </tr>
        <tr>
            <td><%= state.getState_id() %></td>
            <td><%= state.getState_name() %></td>
            <td><%= state.getCapital() %></td>
            <td><%= state.getPopulation_millions() %></td>
            <td><%= state.getAbbreviation() %></td>
        </tr>
    </table>

<%
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>

</body>
</html>
