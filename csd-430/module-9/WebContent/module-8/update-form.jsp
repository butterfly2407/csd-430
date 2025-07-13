<%@ page import="java.util.*, beans.StateDataBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
    Katie Hilliard
    07/02/2025
    Module 8 Assignment - Project Part 3
    The purpose of this JSP is to display a dropdown menu of state IDs for the user to select one to update.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>Update State Record</title>
</head>
<body>
    <h2>Select a State Record to Update</h2>

    <form action="edit-record.jsp" method="get">
        <label for="state_id">State ID:</label>
        <select name="state_id" id="state_id">
            <%
                // Create JavaBean instance
                StateDataBean bean = new StateDataBean();

                // Get all state IDs
                List<Integer> stateIds = bean.getAllStateIds();

                // Loop through IDs and create option in the dropdown
                for (Integer id : stateIds) {
            %>
                <option value="<%= id %>"><%= id %></option>
            <%
                }
            %>
        </select>
        <br><br>
        <input type="submit" value="Edit Record">
    </form>
</body>
</html>
