<%-- 
  Katie Hilliard  
  07/13/2025  
  Module 9 Assignment - Project Part 4
  The purpose of this JSP is to displays all records in a table format and hold a dropdown with fields so the user can select a record to delete.
--%>

<%@ page import="beans.StateDataBean" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    StateDataBean bean = new StateDataBean();

    // Get all records to display in HTML table
    List<Map<String, String>> records = bean.getAllRecords();

    // Get all available primary keys in the delete dropdown
    List<Integer> stateIds = bean.getAllStateIds();
%>

<!DOCTYPE html>
<html>
<head>
    <title>State Records - Delete Records</title>
    <style>
        table, th, td { border: 1px solid black; border-collapse: collapse; padding: 8px; }
    </style>
</head>
<body>

    <h1>State Records</h1>
    <p>This table shows all state records currently in the database.</p>

    <!-- Display all records in an HTML table -->
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
                // "No records" displays if table is empty
                if (records.isEmpty()) {
            %>
                <tr><td colspan="5">No records found.</td></tr>
            <%
                } else {
                    // Loop through records and print rows
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

    <!-- Form to delete a record based on user selection -->
    <h3>Delete a Record</h3>
    <form action="delete-record.jsp" method="post">
        <label for="state_id">Select State ID to Delete:</label>
        <select name="state_id" id="state_id" required>
            <option value="" disabled selected>Select an ID</option>
            <%
                // Populate dropdown with all state IDs
                for (int id : stateIds) {
            %>
                <option value="<%= id %>"><%= id %></option>
            <%
                }
            %>
        </select>
        <input type="submit" value="Delete Record">
    </form>

</body>
</html>
