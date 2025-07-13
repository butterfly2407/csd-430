<%-- 
  Katie Hilliard  
  07/13/2025  
  Module 9 Assignment - Project Part 4
  The purpose of this JSP is for the user to be able to delete a selected record from the database and update the display with the saved records.
--%>

<%@ page import="beans.StateDataBean" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Get selected state_id from the submitted form
    String idParam = request.getParameter("state_id");
    int stateId = Integer.parseInt(idParam);

    // Create a JavaBean instance
    StateDataBean bean = new StateDataBean();

    // Delete the selected record
    bean.deleteRecordById(stateId);

    // Get the updated list of records and state IDs
    List<Map<String, String>> records = bean.getAllRecords();
    List<Integer> stateIds = bean.getAllStateIds();
%>

<!DOCTYPE html>
<html>
<head>
    <title>State Records - Record Deleted</title>
    <style>
        table, th, td { border: 1px solid black; border-collapse: collapse; padding: 8px; }
    </style>
</head>
<body>

    <h1>Updated State Records</h1>
    <p>The selected record has been deleted. Here is the updated data.</p>

    <!-- Table with remaining records -->
    <table>
        <thead>
            <tr>
                <th>State ID</th>
                <th>State Name</th>
                <th>Capital</th>
                <th>Population</th>
                <th>Abbreviation</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (records.isEmpty()) {
            %>
                <tr><td colspan="5">No records found.</td></tr>
            <%
                } else {
                    for (Map<String, String> row : records) {
            %>
                <tr>
                    <td><%= row.get("state_id") %></td>
                    <td><%= row.get("state_name") %></td>
                    <td><%= row.get("capital") %></td>
                    <td><%= row.get("population") %></td>
                    <td><%= row.get("abbreviation") %></td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>

    <!-- Dropdown form to delete another record -->
    <%
        if (!stateIds.isEmpty()) {
    %>
        <h3>Delete Another Record</h3>
        <form action="delete-record.jsp" method="post">
            <label for="state_id">Select State ID to Delete:</label>
            <select name="state_id" id="state_id" required>
                <option value="" disabled selected>Select an ID</option>
                <%
                    for (int id : stateIds) {
                %>
                    <option value="<%= id %>"><%= id %></option>
                <%
                    }
                %>
            </select>
            <input type="submit" value="Delete Record">
        </form>
    <%
        }
    %>

</body>
</html>
