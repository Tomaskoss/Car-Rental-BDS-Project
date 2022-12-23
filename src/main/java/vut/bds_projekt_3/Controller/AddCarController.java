package vut.bds_projekt_3.Controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import vut.bds_projekt_3.DatabaseConnection;
import vut.bds_projekt_3.App;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddCarController {

    @FXML
    private Button Add;
    @FXML
    private Button Back;

    @FXML
    private Button Update;

    @FXML Button Delete;

    @FXML
    private TextField brand_name_id;

    @FXML
    private TextField color_id;

    @FXML
    private TextField fuel_type_id;

    @FXML
    private TextField rented_car_id_vin_number_;

    @FXML
    private Label status_message;

    @FXML
    private TextField vehicle_type_id;

    @FXML
    void AddOnAction(ActionEvent event) throws SQLException {
        String rentedCarId = rented_car_id_vin_number_.getText();
        if(rentedCarId.length()!=17){
            status_message.setText("Error:Vin ID must be exactly 17 characters long!");
            return;
        }
        int brandNameId;
        int colorId;
        int fuelTypeId;
        int vehicleTypeId;

        try {
            brandNameId = Integer.parseInt(brand_name_id.getText());
            colorId = Integer.parseInt(color_id.getText());
            fuelTypeId = Integer.parseInt(fuel_type_id.getText());
            vehicleTypeId = Integer.parseInt(vehicle_type_id.getText());
        } catch (NumberFormatException e) {
            status_message.setText("Error: Invalid input for brand name, color, fuel type, or vehicle type!");
            return;
        }

         colorId = Integer.parseInt(color_id.getText());
         fuelTypeId = Integer.parseInt(fuel_type_id.getText());
         vehicleTypeId = Integer.parseInt(vehicle_type_id.getText());

        DatabaseConnection databaseConnection = new DatabaseConnection();
        Connection connection = databaseConnection.getConnection();

        String insertSql = "INSERT INTO mydb.rented_car (rented_car_id_vin_number_, brand_name_id, color_id, fuel_type_id, vehicle_type_id) VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(insertSql);
            preparedStatement.setString(1, rentedCarId);
            preparedStatement.setInt(2, brandNameId);
            preparedStatement.setInt(3, colorId);
            preparedStatement.setInt(4, fuelTypeId);
            preparedStatement.setInt(5, vehicleTypeId);

            int row = preparedStatement.executeUpdate();

            if (row > 0) {
                status_message.setText("Car added successfully!");
            } else {
                status_message.setText("Error adding car!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @FXML
    void BackOnAction(ActionEvent event) throws IOException {
        App m = new App();
        m.changeScene("CarRental.fxml",800,600);
    }
    @FXML
    void DeleteOnAction(ActionEvent event) throws SQLException {
        String rentedCarId = rented_car_id_vin_number_.getText();
        if (rentedCarId.length() != 17) {
            status_message.setText("Error: Vin ID must be exactly 17 characters long!");
            return;
        }

        DatabaseConnection databaseConnection = new DatabaseConnection();
        Connection connection = databaseConnection.getConnection();
        String deleteSql = "DELETE FROM mydb.rented_car WHERE rented_car_id_vin_number_=?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(deleteSql)) {
            preparedStatement.setString(1, rentedCarId);
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                status_message.setText("Successfully deleted rented car with ID: " + rentedCarId);
            } else {
                status_message.setText("No rented car found with ID: " + rentedCarId);
            }
        } catch (SQLException e) {
            status_message.setText("Error deleting rented car: " + e.getMessage());
        }
    }
    @FXML
    void UpdateOnAction(ActionEvent event) throws SQLException {
        String rentedCarId = rented_car_id_vin_number_.getText();
        if(rentedCarId.length()!=17){
            status_message.setText("Error:Vin ID must be exactly 17 characters long!");
            return;
        }
        int brandNameId;
        int colorId;
        int fuelTypeId;
        int vehicleTypeId;

        try {
            brandNameId = Integer.parseInt(brand_name_id.getText());
            colorId = Integer.parseInt(color_id.getText());
            fuelTypeId = Integer.parseInt(fuel_type_id.getText());
            vehicleTypeId = Integer.parseInt(vehicle_type_id.getText());
        } catch (NumberFormatException e) {
            status_message.setText("Error: Invalid input for brand name, color, fuel type, or vehicle type!");
            return;
        }

        DatabaseConnection databaseConnection = new DatabaseConnection();
        Connection connection = databaseConnection.getConnection();

        String updateSql = "UPDATE mydb.rented_car SET brand_name_id = ?, color_id = ?, fuel_type_id = ?, vehicle_type_id = ? WHERE rented_car_id_vin_number_ = ?";

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(updateSql);
            preparedStatement.setInt(1, brandNameId);
            preparedStatement.setInt(2, colorId);
            preparedStatement.setInt(3, fuelTypeId);
            preparedStatement.setInt(4, vehicleTypeId);
            preparedStatement.setString(5, rentedCarId);

            int row = preparedStatement.executeUpdate();

            if (row > 0) {
                status_message.setText("Car updated successfully!");
            } else {
                status_message.setText("Error updating car!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
