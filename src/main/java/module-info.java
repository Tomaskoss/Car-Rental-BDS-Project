module vut.bds_projekt_3 {

    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.graphics;
    requires java.sql;


    opens vut.bds_projekt_3 to javafx.fxml;
    exports vut.bds_projekt_3;
}