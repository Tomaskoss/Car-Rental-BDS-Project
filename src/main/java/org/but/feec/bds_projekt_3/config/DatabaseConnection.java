package org.but.feec.bds_projekt_3.config;
import java.sql.*;

public class DatabaseConnection {
    public Connection databaseLink;
    public Connection getConnection() throws SQLException {

        String url = "jdbc:postgresql://localhost:5432/postgres";
        String user = "db-rental";  //login: j for gui
        String password = "test123";  //  password : t for gui

        databaseLink= DriverManager.getConnection(url, user, password);

        return databaseLink;
    }

}
