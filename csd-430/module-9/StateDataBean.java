package beans;

import java.sql.*;
import java.util.*;

/**
 * Katie Hilliard
 * 07/13/2025
 * Project Part 4 – StateDataBean
 * The purpose of this JavaBean is to handle all database operations in relation to state data.
 */

public class StateDataBean {

    // Connect to MySQL database
    private Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/CSD430";
        String username = "student1";
        String password = "pass";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, username, password);
    }

    // Get all state IDs
    public List<Integer> getAllStateIds() {
        List<Integer> ids = new ArrayList<>();
        try {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT state_id FROM katie_states_data");

            while (rs.next()) {
                ids.add(rs.getInt("state_id"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ids;
    }

    // Get full state record by ID and return a StateInfo object
    public StateInfo getStateById(int stateId) {
        StateInfo state = new StateInfo();
        try {
            Connection conn = getConnection();
            String query = "SELECT * FROM katie_states_data WHERE state_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, stateId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                state.setState_id(rs.getInt("state_id"));
                state.setState_name(rs.getString("state_name"));
                state.setCapital(rs.getString("capital"));
                state.setPopulation_millions(rs.getDouble("population_millions"));
                state.setAbbreviation(rs.getString("abbreviation"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return state;
    }

    // Update existing state record based on the provided StateInfo object
    public void updateState(StateInfo state) {
        try {
            Connection conn = getConnection();
            String sql = "UPDATE katie_states_data SET state_name = ?, capital = ?, population_millions = ?, abbreviation = ? WHERE state_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, state.getState_name());
            pstmt.setString(2, state.getCapital());
            pstmt.setDouble(3, state.getPopulation_millions());
            pstmt.setString(4, state.getAbbreviation());
            pstmt.setInt(5, state.getState_id());

            pstmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Get all records from the katie_states_data table as list of maps.
     * Each map has a key-value pair for each field.
     */
    public List<Map<String, String>> getAllRecords() {
        List<Map<String, String>> records = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM katie_states_data")) {

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("state_id", String.valueOf(rs.getInt("state_id")));
                row.put("state_name", rs.getString("state_name"));
                row.put("capital", rs.getString("capital"));
                row.put("population", String.valueOf(rs.getDouble("population_millions")));
                row.put("abbreviation", rs.getString("abbreviation"));
                records.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return records;
    }

    /**
     * Delete selected record from the katie_states_data table by the state_id.
     */
    public void deleteRecordById(int stateId) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM katie_states_data WHERE state_id = ?")) {

            ps.setInt(1, stateId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

