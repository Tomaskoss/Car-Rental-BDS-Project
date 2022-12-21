package vut.bds_projekt_3;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import java.io.IOException;

public class AfterLogin {


        @FXML
        private Button logout;



        public void logOutOnAction (ActionEvent event) throws IOException {
        Main m = new Main();
        m.changeScene("login.fxml");
        }
}
