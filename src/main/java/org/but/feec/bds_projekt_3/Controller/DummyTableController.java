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
import javafx.scene.control.Label;
import javafx.scene.control.cell.PropertyValueFactory;
import org.but.feec.bds_projekt_3.App;
import org.but.feec.bds_projekt_3.Data.DummyCustomer;
import org.but.feec.bds_projekt_3.config.DatabaseConnection;


import java.sql.PreparedStatement;
import java.io.IOException;
import java.net.URL;
import java.sql.*;
import java.util.ResourceBundle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
public class DummyTableController implements Initializable {

    @FXML
    private Button BackToMenu;

    @FXML
    private Button confirm;

    @FXML
    private Label status_message;

    @FXML
    private TableView<DummyCustomer> dummy_customer_view;

    @FXML
    private TableColumn<DummyCustomer, Integer> id;

    @FXML
    private TableColumn<DummyCustomer, String> name;

    @FXML
    private TableColumn<DummyCustomer, String> surname;
    @FXML
    private TextField inputField;

    ObservableList<DummyCustomer> dummyCustomersObservableList = FXCollections.observableArrayList();

    private static final Logger logger = LoggerFactory.getLogger(DummyTableController.class);

    @FXML
    void BackToMenuOnAction(ActionEvent event) throws IOException {
        App m = new App();
        m.changeScene("AfterLogin.fxml", 600, 400);
    }

    @FXML
    void ConfirmOnAction(ActionEvent event) throws SQLException {

        String input = inputField.getText();

        try {
            DatabaseConnection connectNow = new DatabaseConnection();
            Connection connection = connectNow.getConnection();
            String query = "SELECT * FROM mydb.dummy_customer "+"WHERE id ="+input;
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            ObservableList<DummyCustomer> filteredCustomers = FXCollections.observableArrayList();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String surname = resultSet.getString("surname");
                Integer id = resultSet.getInt("id");
                filteredCustomers.add(new DummyCustomer(name, surname, id));
            }
            dummy_customer_view.setItems(filteredCustomers);
            status_message.setText("Executed Query");
        } catch (SQLException e) {
            logger.error("Error connecting to the database or executing the query {}", e);
        }
    }




    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        status_message.setText("ready for your statement");
        DatabaseConnection connectNow = new DatabaseConnection();
        Connection connectDB = null;
        try{
            connectDB = connectNow.getConnection();
            String dummycustomerQuery="SELECT name,surname,id FROM mydb.dummy_customer";
            Statement statement = connectDB.createStatement();
            ResultSet queryOutput = statement.executeQuery(dummycustomerQuery);
            
            while ( queryOutput.next()){
                String queryName = queryOutput.getString("name");
                String querySurname = queryOutput.getString("surname");
                Integer queryId = queryOutput.getInt("id");

                //Populate the ObservableList
                dummyCustomersObservableList.add(new DummyCustomer(queryName,querySurname,queryId));
            }

            // PropertyValueFactory corresponds to the new DummyCustomer fields
            // The table column is the one you annotate above
            name.setCellValueFactory(new PropertyValueFactory<>("name"));
            surname.setCellValueFactory(new PropertyValueFactory<>("surname"));
            id.setCellValueFactory(new PropertyValueFactory<>("id"));

            dummy_customer_view.setItems(dummyCustomersObservableList);

        }catch(SQLException e){
            logger.error("Error connecting to the database or executing the query {}", e);
        }
    }
}

