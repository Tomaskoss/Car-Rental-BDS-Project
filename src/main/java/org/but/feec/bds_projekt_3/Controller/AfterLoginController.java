package org.but.feec.bds_projekt_3.Controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.image.ImageView;
import org.but.feec.bds_projekt_3.App;
import org.but.feec.bds_projekt_3.config.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AfterLoginController {


        @FXML
        private Button catalog;

        @FXML
        private Button CustomerView;

        @FXML
        private ImageView logoImageView;

        @FXML
        private Button logout;

        @FXML
        private Button dummy_table;




        public void logOutOnAction (ActionEvent event) throws IOException {
        App m = new App();
        m.changeScene("login.fxml",600,400);
        }
        public void CatalogOnAction(ActionEvent event) throws IOException{
                App m = new App();
                m.changeScene("CarRental.fxml",800,600);
        }

        public void CustomerViewOnAction(ActionEvent event) throws IOException {
                App m = new App();
                m.changeScene("CustomerView.fxml",800,600);

        }

        @FXML
        void DummyOnAction(ActionEvent event) throws IOException, SQLException {
                App m = new App();
                m.changeScene("DummyTable.fxml",800,600);

        }
}
