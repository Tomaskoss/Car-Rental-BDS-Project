package vut.bds_projekt_3.Controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.image.ImageView;
import vut.bds_projekt_3.App;

import java.io.IOException;

public class AfterLoginController {


        @FXML
        private Button catalog;

        @FXML
        private ImageView logoImageView;

        @FXML
        private Button logout;




        public void logOutOnAction (ActionEvent event) throws IOException {
        App m = new App();
        m.changeScene("login.fxml",600,400);
        }
        public void CatalogOnAction(ActionEvent event) throws IOException{
                App m = new App();
                m.changeScene("CarRental.fxml",800,600);

        }
}
