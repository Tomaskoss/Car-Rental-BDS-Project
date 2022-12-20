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
import java.util.ResourceBundle;
import java.net.URL;

public class MainController /*implements Initializable */{

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


    /* @Override
    public void initialize(URL url,ResourceBundle resourceBundle){
        File brandingFile = new File ("logo.png");
        Image brandingImage = new Image(brandingFile.toURI().toString());
        brandingImageView.setImage(brandingImage);
    }*/
    public void cancelOnAction(ActionEvent event){
        Stage stage = (Stage) cancel.getScene().getWindow();
        stage.close();;
    }
    public void loginOnAction(ActionEvent event){
        validatelogin();

    }

    public void validatelogin() throws IOException {
        Main m = new Main();
        if (username.getText().toString().equals("test")&& password.getText().toString().equals("test123")){
            status_message.setText("Log In successful");

            m.changeScene("afterLogin.fxml");
        }
        else if (username.getText().isBlank()  && password.getText().isBlank()  ) {
            status_message.setText("Please enter your data");
        }else
        {
            status_message.setText("Wrong username or password!");
        }
    }
}
