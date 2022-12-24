module vut.bds_projekt_3 {

    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.graphics;
    requires java.sql;


    opens org.but.feec.bds_projekt_3 to javafx.fxml;
    exports org.but.feec.bds_projekt_3;
    exports org.but.feec.bds_projekt_3.Controller;
    opens org.but.feec.bds_projekt_3.Controller to javafx.fxml;
    exports org.but.feec.bds_projekt_3.config;
    opens org.but.feec.bds_projekt_3.config to javafx.fxml;
    exports org.but.feec.bds_projekt_3.Data;
    opens org.but.feec.bds_projekt_3.Data to javafx.fxml;
}