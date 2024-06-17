package org.but.feec.bds_projekt_3.Controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import org.but.feec.bds_projekt_3.App;
import org.but.feec.bds_projekt_3.config.DatabaseConnection;

import java.io.IOException;
import java.sql.*;

public class  RentCarController {

    @FXML
    private Button Back;

    @FXML
    private Button rent;

    @FXML
    private TextField rental_date;

    @FXML
    private TextField rented_car_id_vin_number_;

    @FXML
    private TextField customer_id;

    @FXML
    private TextField return_date;

    @FXML
    private Label status_message;

    @FXML
    void BackOnAction(ActionEvent event) throws IOException {
        App m = new App();

        m.changeScene("CarRental.fxml", 800, 600);
    }

    @FXML
    void RentOnAction(ActionEvent event) throws SQLException {
        // Get the values entered in the text fields

        String rentedCarId = rented_car_id_vin_number_.getText();
        if(rentedCarId.length()!=17){
            status_message.setText("Error:Vin ID must be exactly 17 characters long!");
            return;
        }
        String rentalDate = rental_date.getText();
        String returnDate = return_date.getText();
        Integer customerID = Integer.valueOf(customer_id.getText());

        // Get the current date as a java.sql.Date object
        java.sql.Date currentDateSQL = new java.sql.Date(new java.util.Date().getTime());

        // Convert the rentalDate string to a java.sql.Date object
        java.sql.Date rentalDateSQL = java.sql.Date.valueOf(rentalDate);
        java.sql.Date returnDateSQL = java.sql.Date.valueOf(returnDate);

        // Create a connection to the database
        Connection conn = null;
        try {
            // Create an instance of the DatabaseConnection class
            DatabaseConnection connectNow = new DatabaseConnection();

            // Get the connection from the DatabaseConnection instance
            conn = connectNow.getConnection();

            // Set the auto-commit mode to false, to enable transactions
            conn.setAutoCommit(false);

            // Create a prepared statement for the first query
            // Check if the car is available
            String sql1 = "SELECT availability FROM mydb.rented_car\n" +
                    "WHERE rented_car_id_vin_number_=?";
            PreparedStatement pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setString(1, rentedCarId);
            // Execute the first query
            ResultSet rs = pstmt1.executeQuery();

            if (rs.next()) {
                boolean availability = rs.getBoolean("availability");
                if (availability) {
                    // The car is available, so proceed with the UPDATE and INSERT queries
                    // Create a prepared statement for the second query
                    String sql2 = "UPDATE mydb.rented_car SET availability = false WHERE rented_car_id_vin_number_ = ?";
                    PreparedStatement pstmt2 = conn.prepareStatement(sql2);
                    pstmt2.setString(1, rentedCarId);
                    // Execute the second query
                    pstmt2.executeUpdate();


                    // Create a prepared statement for the third query
                    String sql3 = "INSERT INTO mydb.rental ( rented_car_id , rental_date , return_date ,customer_id ,last_update) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement pstmt3 = conn.prepareStatement(sql3);
                    pstmt3.setString(1, rentedCarId);
                    pstmt3.setDate(2, rentalDateSQL);
                    pstmt3.setDate(3, returnDateSQL);
                    pstmt3.setInt(4, customerID);
                    pstmt3.setDate(5, currentDateSQL);

                    // Execute the third query
                    pstmt3.executeUpdate();
                    // Process the result set

                    // Commit the transaction
                    conn.commit();

                    // Update the status message
                    status_message.setText("Transaction successful");
                } else {
                    // The car is not available, so update the status message
                    status_message.setText("Car already rented");
                }
            }
        } catch (SQLException e) {
            // If something goes wrong, roll back the transaction
            conn.rollback();

            // Update the status message
            status_message.setText("Transaction failed: " + e.getMessage());

        }
    }
}