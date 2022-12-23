package vut.bds_projekt_3;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

import java.io.IOException;

public class App extends Application {

    private static Stage stg;

    @Override
    public void start(Stage stage) throws IOException {
        stg =  stage;
        stage.setResizable(false);

        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource("login.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 600, 400);
        stage.initStyle(StageStyle.UNDECORATED);
        stage.setScene(scene);
        stage.show();
    }

    public void changeScene(String fxml, double width, double height) throws IOException {
        // Load the FXML file
        FXMLLoader loader = new FXMLLoader(getClass().getResource(fxml));
        Parent root = loader.load();

        // Create a new scene with the specified size
        Scene scene = new Scene(root, width, height);

        // Set the scene on the stage
        stg.setScene(scene);
    }

    public static void main(String[] args) {
        launch();
    }
}