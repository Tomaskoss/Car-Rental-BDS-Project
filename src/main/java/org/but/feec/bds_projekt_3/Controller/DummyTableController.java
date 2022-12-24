package org.but.feec.bds_projekt_3.Controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import org.but.feec.bds_projekt_3.App;

import java.io.IOException;

public class DummyTableController {

    @FXML
    private Button BackToMenu;

    @FXML
    private Button confirm;

    @FXML
    private TableView<?> dummy_customer_view;

    @FXML
    private TableColumn<?, ?> email;

    @FXML
    private TableColumn<?, ?> first_name;

    @FXML
    private TextField inputField;

    @FXML
    private TableColumn<?, ?> last_name;

    @FXML
    void BackToMenuOnAction(ActionEvent event) throws IOException {
        App m = new App();
        m.changeScene("AfterLogin.fxml", 600, 400);
    }
    @FXML
    void ConfirmOnAction(ActionEvent event){

    }


}

