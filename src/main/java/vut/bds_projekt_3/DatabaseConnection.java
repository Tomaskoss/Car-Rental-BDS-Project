package vut.bds_projekt_3;
import java.sql.*;

public class DatabaseConnection {
    public Connection databaseLink;
    public Connection getConnection() throws SQLException {

        String url = "jdbc:postgresql://localhost:5432/postgres";
        String user = "db-rental"; //postgres (original prihlasovanie) // db-renal
        String password = "test123"; //(admin123 heslo k postgres)      //test123

        databaseLink= DriverManager.getConnection(url, user, password);

        return databaseLink;
    }

}
