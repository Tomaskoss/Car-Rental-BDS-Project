package org.but.feec.bds_projekt_3.Controller;

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
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.but.feec.bds_projekt_3.config.Argon2FactoryService.ARGON2;


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
        ;
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


        char[] originalPassword = password.getText().toCharArray();
        char[] hashedPassword = hashPassword(originalPassword);


        String verifyLogin = "SELECT count(1) FROM mydb.customer WHERE username ='" + username.getText() + "'AND password ='" + password.getText() + "'";
        try {
            Statement statement = connectDB.createStatement();
            ResultSet queryResult = statement.executeQuery(verifyLogin);

            while(queryResult.next()){
                if (queryResult.getInt(1) ==1 ){
                    status_message.setText("congrats!");
                    m.changeScene("AfterLogin.fxml",600,400);}else{
                    status_message.setText("Invalid Login, please try again");
                    System.out.println(hashedPassword);
                }
            }
        } catch (SQLException e) {
            logger.error("Error connecting to the database or executing the query {}", e);

         }
    }
    public char[] hashPassword(char[] password) {
        return ARGON2.hash(10, 65536, 1, password).toCharArray();

    }

}
