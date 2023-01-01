package org.but.feec.bds_projekt_3.Controller;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;
import org.but.feec.bds_projekt_3.App;
import org.but.feec.bds_projekt_3.config.DatabaseConnection;




import java.io.IOException;
import java.sql.*;
import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



public class LoginController /*implements Initializable*/ {

    @FXML
    private Button cancel;

    @FXML
    private Button login;

    @FXML
    private ImageView logoImageView;

    @FXML
    private PasswordField password;

    @FXML
    private Label status_message;

    @FXML
    private TextField username;

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    public void cancelOnAction(ActionEvent event) {
        Stage stage = (Stage) cancel.getScene().getWindow();
        stage.close();

    }

    public void loginOnAction(ActionEvent event) throws IOException, SQLException {
        if (username.getText().isBlank() == false && password.getText().isBlank() == false) {
            validatelogin();
        } else if (username.getText().isBlank() == true && password.getText().isBlank() == true) {
            status_message.setText("please enter credential");
        } else {
            status_message.setText("wrong credential");
        }
    }

    public void validatelogin() throws IOException, SQLException {
        App m = new App();
        DatabaseConnection connectNow = new DatabaseConnection();
        Connection connectDB = connectNow.getConnection();
        // Retrieve the stored hash from the database
        String storedHash = retrieveHashFromDatabase();
         try {
             Argon2 argon2 = Argon2Factory.create();
             boolean isValid = argon2.verify(storedHash, password.getText());
                if (isValid) {
                    // Passwordhash is Valid
                   m.changeScene("AfterLogin.fxml",600,400);
                    status_message.setText("username and password is valid");
                } else {
                    // Password is not valid
                    status_message.setText("Username or password is not valid");
                }

            } catch (Exception e) {
                logger.error("Error connecting to the database or executing the query {}", e);
        }
    }

    public String retrieveHashFromDatabase() throws SQLException {
        String storedHash = null;

        // Connect to the database
        DatabaseConnection connectNow = new DatabaseConnection();
        Connection connectDB = connectNow.getConnection();

        // Prepare the SQL query to retrieve the hash
        String query = "SELECT hashedpassword FROM mydb.customer WHERE username = ?";
        PreparedStatement statement = connectDB.prepareStatement(query);
        statement.setString(1, username.getText());

        // Execute the query and retrieve the hash
        ResultSet queryResult = statement.executeQuery();
        if (queryResult.next()) {
            storedHash = queryResult.getString("hashedpassword");
            return storedHash;
        }else {
            status_message.setText("Username does not exists");
            return null;
        }
    }
}
