<%@ page import="java.sql.*, beans.StateDataBean, beans.StateInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
    Katie Hilliard
    07/02/2025
   Module 8 Assignment - Project Part 3
    The purpose of this JSP is to display the user's seclection to edit.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit State Record</title>
</head>
<body>
    <h2>Edit State Record</h2>

    <%
        int stateId = Integer.parseInt(request.getParameter("state_id"));
        StateDataBean bean = new StateDataBean();
        StateInfo state = bean.getStateById(stateId);
    %>

    <form action="update-record.jsp" method="post">
        <label>State ID (Read-Only):</label>
        <input type="text" name="state_id" value="<%= state.getState_id() %>" readonly><br><br>

        <label>State Name:</label>
        <input type="text" name="state_name" value="<%= state.getState_name() %>"><br><br>

        <label>Capital:</label>
        <input type="text" name="capital" value="<%= state.getCapital() %>"><br><br>

        <label>Population (in millions):</label>
        <input type="text" name="population_millions" value="<%= state.getPopulation_millions() %>"><br><br>

        <label>Abbreviation:</label>
        <input type="text" name="abbreviation" value="<%= state.getAbbreviation() %>"><br><br>

        <input type="submit" value="Update Record">
    </form>
</body>
</html>
