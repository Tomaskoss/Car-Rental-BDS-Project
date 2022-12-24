package org.but.feec.bds_projekt_3.Controller;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import org.but.feec.bds_projekt_3.App;
import org.but.feec.bds_projekt_3.Data.CustomerView;
import org.but.feec.bds_projekt_3.config.DatabaseConnection;

import java.io.IOException;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerViewController implements Initializable {

    @FXML
    private Button BackToMenu;

    @FXML
    private TableView<CustomerView> customer_view;

    @FXML
    private TableColumn<CustomerView, Integer> amount;

    @FXML
    private Button confirmButton;

    @FXML
    private TableColumn<CustomerView, String> email;

    @FXML
    private TableColumn<CustomerView, String> first_name;

    @FXML
    private TextField inputField;

    @FXML
    private TableColumn<CustomerView, String> last_name;

    @FXML
    private TableColumn<CustomerView, Integer> order_id;

    @FXML
    private TableColumn<CustomerView, Integer> phone;

    ObservableList<CustomerView> customerViewObservableList = FXCollections.observableArrayList();


    @FXML
    void BackToMenuOnAction(ActionEvent event) throws IOException {
        App m = new App();

        m.changeScene("afterLogin.fxml",600,400);
    }

    @FXML
    void ConfirmOnAction(ActionEvent event) {
        String input = inputField.getText();
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        DatabaseConnection connectNow = new DatabaseConnection();

        // SQL Query - Executed in the backend database
        String customerViewQuery = "SELECT first_name,last_name,email,phone,rental_id,amount FROM mydb.customer_info_view\n";
        try {
            Connection connectDB = connectNow.getConnection();
            Statement statement = connectDB.createStatement();
            ResultSet queryOutput = statement.executeQuery(customerViewQuery);

            while(queryOutput.next()){

                String queryPhone=queryOutput.getString("phone");
                Integer queryOrder_id=queryOutput.getInt("rental_id");
                Integer queryAmount=queryOutput.getInt("amount");
                String  queryFirst_name=queryOutput.getString("first_name");
                String  queryLast_name=queryOutput.getString("last_name");
                String  queryEmail=queryOutput.getString("email");

                // Populate the observable list
                customerViewObservableList.add(new CustomerView(queryFirst_name,queryLast_name,queryEmail,queryPhone,queryOrder_id,queryAmount));

            }
            // PropertyValueFactory corresponds to the new CustomerView fields
            // The table column is the one we annotate above

            first_name.setCellValueFactory(new PropertyValueFactory<>("first_name"));
            last_name.setCellValueFactory(new PropertyValueFactory<>("last_name"));
            email.setCellValueFactory(new PropertyValueFactory<>("email"));
            phone.setCellValueFactory(new PropertyValueFactory<>("phone"));
            order_id.setCellValueFactory(new PropertyValueFactory<>("order_id"));
            amount.setCellValueFactory(new PropertyValueFactory<>("amount"));

            customer_view.setItems(customerViewObservableList);
            //Initial filtered list
            FilteredList<CustomerView> filteredData = new FilteredList<>(customerViewObservableList, b-> true);
            inputField.textProperty().addListener((observable, oldValue,newValue) -> {
                filteredData.setPredicate(CustomerView -> {
                    // IF no search value then display all records or whatever records it currently have. no changes.
                    if (newValue.isEmpty() || newValue.isBlank() || newValue== null){
                        return true;
                    }
                    String searcKeyword = newValue.toLowerCase();

                    if(CustomerView.getFirst_name().toLowerCase().indexOf(searcKeyword) > -1){
                        return true; // Means we found a match in First name

                    }else if (CustomerView.getLast_name().toLowerCase().indexOf(searcKeyword) > -1){
                        return true; // Means we found a match in Last name

                    }else if (CustomerView.getEmail().toLowerCase().indexOf(searcKeyword) > -1){
                        return true; // Means we found a match in Email

                    }else if (CustomerView.getPhone().toLowerCase().indexOf(searcKeyword) > -1) {
                        return true; // Means we found a match in Phone
                    }else if (CustomerView.getOrder_id().toString().indexOf(searcKeyword) > -1 ) {
                        return true; // Means we found a match in OrderID

                    }else if (CustomerView.getAmount().toString().indexOf(searcKeyword) > -1 ) {
                        return true; // Means we found a match in Amount

                    } else
                        return false; // no match found

                });
            });


            SortedList<CustomerView> sortedData= new SortedList<>(filteredData);
            // Bind sorted result with Table view
            sortedData.comparatorProperty().bind(customer_view.comparatorProperty());

            // Aply filtered and sorted Data to the Table view
            customer_view.setItems(sortedData);

        }    catch (SQLException e) {
            Logger.getLogger(CustomerViewController.class.getName()).log(Level.SEVERE,null,e);
            e.printStackTrace();
        }
    }
}