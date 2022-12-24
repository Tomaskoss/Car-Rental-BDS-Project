package org.but.feec.bds_projekt_3.Controller;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;
import org.but.feec.bds_projekt_3.Data.Car;
import org.but.feec.bds_projekt_3.config.DatabaseConnection;
import org.but.feec.bds_projekt_3.App;

import java.io.IOException;
import java.net.URL;
import java.sql.*;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CarRentalController implements Initializable {



    @FXML
    private Button AddCar;

    @FXML
    private Button RentCar;

    @FXML
    private Button BackToMenu;

    @FXML
    private Label status_message;

    @FXML
    private TableView<Car> Rentable_car_table;

    @FXML
    private TableColumn<Car,String> vin_id;

    @FXML
    private TableColumn<Car,String> brand_name;

    @FXML
    private TableColumn<Car,String> color;

    @FXML
    private TableColumn<Car,String> fuel_type;

    @FXML
    private TableColumn<Car,String> vehicle_type;
    @FXML
    private TableColumn<Car,Boolean> availability;
    @FXML
    private TextField keywordTextField;

    ObservableList<Car> carObservableList = FXCollections.observableArrayList();

    @FXML
    void AddCarOnAction(ActionEvent event) throws IOException {
        App m = new App();
        m.changeScene("AddCar.fxml",600,400);
    }

    @FXML
    void BackToMenuOnAction(ActionEvent event) throws IOException {

        App m = new App();

        m.changeScene("AfterLogin.fxml",600,400);

    }
    @FXML
    void RentOnAction(ActionEvent event) throws IOException {
        App m = new App();

        m.changeScene("RentCar.fxml",600,400);
    }


    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

        DatabaseConnection connectNow = new DatabaseConnection();
        Connection connectDB = null;
        try {
            connectDB = connectNow.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
            //SQL Query-Executed in the backend database
        String productViewQuery= "SELECT rented_car_id_vin_number_,brand_name,fuel_type,color,vehicle_type,availability FROM mydb.rented_car\n" +
                "LEFT JOIN mydb.brand_of_vehicle\n" +
                "ON brand_of_vehicle.brand_id = rented_car.brand_name_id\n" +
                "LEFT JOIN mydb.fuel_type \n" +
                "ON fuel_type.fuel_type_id = rented_car.fuel_type_id\n" +
                "LEFT JOIN mydb.color_of_vehicle\n" +
                "ON color_of_vehicle.color_id = rented_car.color_id\n" +
                "LEFT JOIN mydb.type_of_vehicle \n" +
                "ON type_of_vehicle.vehicle_type_id = rented_car.vehicle_type_id;";
        try {
            Statement statement = connectDB.createStatement();
            ResultSet queryOutput= statement.executeQuery(productViewQuery);

            while(queryOutput.next()){
                String queryVin_id = queryOutput.getString("rented_car_id_vin_number_");
                String queryBrandName = queryOutput.getString("brand_name");
                String queryFuelType = queryOutput.getString("fuel_type");
                String queryColor = queryOutput.getString("color");
                String queryVehicleType = queryOutput.getString("vehicle_type");
                Boolean queryAvailability= queryOutput.getBoolean("availability");
                    //Populate the ObservableList
                carObservableList.add(new Car(queryVin_id, queryBrandName,queryVehicleType ,queryColor,queryFuelType,queryAvailability));

            }

            // PropertyValueFactory corresponds to the new Car fields
            // The table columns is the one you annotate above
            vin_id.setCellValueFactory(new PropertyValueFactory<>("vin_id"));
            brand_name.setCellValueFactory(new PropertyValueFactory<>("brand_name"));
            vehicle_type.setCellValueFactory(new PropertyValueFactory<>("vehicle_type"));
            fuel_type.setCellValueFactory(new PropertyValueFactory<>("fuel_type"));
            color.setCellValueFactory(new PropertyValueFactory<>("color"));
            availability.setCellValueFactory(new PropertyValueFactory<>("availability"));
            Rentable_car_table.setItems(carObservableList);
            //Initial filtered list
            FilteredList<Car> filteredData = new FilteredList<>(carObservableList, b -> true);
            keywordTextField.textProperty().addListener((observable, oldValue, newValue) -> {
                filteredData.setPredicate(Car -> {
                    // If no search Value then display all record or whatever records it current have . no changes
                    if (newValue.isEmpty() || newValue.isBlank() || newValue == null){
                        return true;
                    }

                    String searchKeyword = newValue.toLowerCase();

                    if (Car.getVin_id().toLowerCase().indexOf(searchKeyword) > -1 ){
                        return true; // Means we found a match in VinID
                    }else if (Car.getBrand_name().toLowerCase().indexOf(searchKeyword) >-1 ){
                        return true; // Means we found a match in Brand Name
                    }else if (Car.getFuel_type().toLowerCase().indexOf(searchKeyword) >-1 ){
                        return true; // Means we found a match in Fuel type
                    }else if (Car.getColor().toLowerCase().indexOf(searchKeyword) >-1 ){
                        return true; // Means we found a match in Color
                    }else if (Car.getVehicle_type().toLowerCase().indexOf(searchKeyword) >-1 ){
                        return true; // Means we found a match in vehicle type
                    }else
                        return false; // no match found
                });
            });

            SortedList<Car> sortedData = new SortedList<>(filteredData);
            //Bind sorted result with Table View
            sortedData.comparatorProperty().bind(Rentable_car_table.comparatorProperty());
            // Aply filtered and sorted data to the Table view
            Rentable_car_table.setItems(sortedData);



        } catch (SQLException e) {
            Logger.getLogger(CarRentalController.class.getName()).log(Level.SEVERE,null,e);
            e.printStackTrace();
        }
    }
}


