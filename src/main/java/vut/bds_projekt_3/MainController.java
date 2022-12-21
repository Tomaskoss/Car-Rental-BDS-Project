package vut.bds_projekt_3;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;
import java.net.URL;

public class MainController implements Initializable {

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


    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        File logoFile = new File("images/logo.png");
        Image logoImage = new Image(logoFile.toURI().toString());
        logoImageView.setImage(logoImage);
    }

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
        Main m = new Main();
        DatabaseConnection connectNow = new DatabaseConnection();
        Connection connectDB = connectNow.getConnection();

        String verifyLogin = "SELECT count(1) FROM mydb.customer WHERE username ='" + username.getText() + "'AND password ='" + password.getText() + "'";
        try {
            Statement statement = connectDB.createStatement();
            ResultSet queryResult = statement.executeQuery(verifyLogin);

            while(queryResult.next()){
                if (queryResult.getInt(1) ==1 ){
                    status_message.setText("congrats!");
                    m.changeScene("afterLogin.fxml");
                }else{
                    status_message.setText("Invalid Login, please try again");
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
