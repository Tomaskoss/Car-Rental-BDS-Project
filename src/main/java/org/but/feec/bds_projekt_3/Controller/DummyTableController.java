package org.but.feec.bds_projekt_3.Controller;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import org.but.feec.bds_projekt_3.App;
import org.but.feec.bds_projekt_3.Data.DummyCustomer;
import org.but.feec.bds_projekt_3.config.DatabaseConnection;


import java.sql.PreparedStatement;
import java.io.IOException;
import java.net.URL;
import java.sql.*;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DummyTableController implements Initializable {

    @FXML
    private Button BackToMenu;

    @FXML
    private Button confirm;

    @FXML
    private TableView<DummyCustomer> dummy_customer_view;

    @FXML
    private TableColumn<DummyCustomer, String> email;

    @FXML
    private TableColumn<DummyCustomer, String> name;

    @FXML
    private TableColumn<DummyCustomer, String> surname;
    @FXML
    private TextField inputField;

    ObservableList<DummyCustomer> dummyCustomersObservableList = FXCollections.observableArrayList();

    @FXML
    void BackToMenuOnAction(ActionEvent event) throws IOException {
        App m = new App();
        m.changeScene("AfterLogin.fxml", 600, 400);
    }

    @FXML
    void ConfirmOnAction(ActionEvent event) throws SQLException {
        DatabaseConnection connectNow = new DatabaseConnection();
        String input = inputField.getText();
        String query = "SELECT * FROM mydb.dummy_customer WHERE name = ?";
        try {Connection connection = connectNow.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, input);
            ResultSet resultSet = preparedStatement.executeQuery();
            // process the result set
        }catch (SQLException e) {
            Logger.getLogger(DummyTableController.class.getName()).log(Level.SEVERE, null, e);
        }
    }




    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        DatabaseConnection connectNow = new DatabaseConnection();
        Connection connectDB = null;
        try{
            connectDB = connectNow.getConnection();
            String dummycustomerQuery="SELECT name,surname,email FROM mydb.dummy_customer";
            Statement statement = connectDB.createStatement();
            ResultSet queryOutput = statement.executeQuery(dummycustomerQuery);
            
            while ( queryOutput.next()){
                String queryName = queryOutput.getString("name");
                String querySurname = queryOutput.getString("surname");
                String queryEmail = queryOutput.getString("email");

                //Populate the ObservableList
                dummyCustomersObservableList.add(new DummyCustomer(queryName,querySurname,queryEmail));
            }

            // PropertyValueFactory corresponds to the new DummyCustomer fields
            // The table column is the one you annotate above
            name.setCellValueFactory(new PropertyValueFactory<>("name"));
            surname.setCellValueFactory(new PropertyValueFactory<>("surname"));
            email.setCellValueFactory(new PropertyValueFactory<>("email"));

            dummy_customer_view.setItems(dummyCustomersObservableList);

        }catch(SQLException e){
            Logger.getLogger(DummyTableController.class.getName()).log(Level.SEVERE,null,e);
            e.printStackTrace();
        }
    }
}

