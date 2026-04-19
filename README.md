# 🚗 Car Rental BDS Project

A desktop GUI application for managing a car rental service, built with **Java 19 + JavaFX 19** and backed by a **PostgreSQL** database. Developed as Assignment 3 for the BDS (Database Systems) course at BUT FEEC.

---

## 📋 Table of Contents

- [About](#about)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Database Schema](#database-schema)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Database Setup](#database-setup)
- [Build & Run](#build--run)
- [Usage](#usage)
- [Known Limitations](#known-limitations)

---

## About

This project connects a previously designed relational database (from Assignment 1) to a functional JavaFX desktop application. The app provides a basic GUI for car rental operations: user login, browsing available cars, renting a car, managing the car inventory, and viewing customer information.

> ⚠️ Note: The project is not fully implemented. Some tables exist in the database but are not yet wired up to the UI.

---

## Features

| Feature | Description |
|---|---|
| 🔐 **Secure Login** | Username/password authentication with **Argon2** password hashing |
| 🚘 **Car Browser** | View all rentable cars in a searchable, sortable table |
| 🔍 **Live Search** | Filter cars by VIN, brand, color, fuel type or vehicle type |
| ➕ **Manage Cars** | Add, update and delete cars from the fleet (by 17-char VIN) |
| 📅 **Rent a Car** | Create a rental record with availability check and DB transaction |
| 👥 **Customer View** | Browse customers with their rental history and payments |

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Java 19 |
| UI Framework | JavaFX 19 (FXML) |
| Database | PostgreSQL 15 |
| DB Connection | JDBC + HikariCP 5.0.1 |
| Password Hashing | Argon2 (argon2-jvm 2.11) |
| Logging | SLF4J 2.0 + Logback 1.4 |
| UI Components | ControlsFX 11.1.2, FontAwesomeFX 8.9 |
| Build Tool | Maven 3 (with Maven Shade Plugin – fat JAR) |

---

## Database Schema

The application connects to a PostgreSQL database using schema `mydb`. The backup SQL files are located in the `backup/` directory.

**Main tables:**

```
mydb
├── customer           – users who can log in and rent cars
├── customer_contact   – contact details
├── address / street / city / country  – address hierarchy
├── rented_car         – current car fleet (identified by 17-char VIN)
├── brand_of_vehicle   – car brands
├── color_of_vehicle   – car colors
├── fuel_type          – fuel types
├── type_of_vehicle    – vehicle categories
├── rental             – rental transactions (car + customer + dates)
├── payment            – payment records
├── car                – general car info
├── expired_car        – archived/expired vehicles
├── staff              – employees
├── staff_store / store – store/branch management
└── dummy_customer     – test/dummy data table
```

A **database view** `mydb.customer_info_view` is used to display customer rental summaries (name, email, phone, rental ID, amount).

---

## Project Structure

```
Car-Rental-BDS-Project-main/
│
├── src/main/java/org/but/feec/bds_projekt_3/
│   ├── App.java                        # JavaFX Application entry, scene switcher
│   ├── Main.java                       # JVM entry point (launches App)
│   ├── module-info.java                # Java module descriptor
│   │
│   ├── Controller/
│   │   ├── LoginController.java        # Login screen logic + Argon2 verification
│   │   ├── AfterLoginController.java   # Main menu after login
│   │   ├── CarRentalController.java    # Car list table + search + navigation
│   │   ├── ManageCarController.java    # Add / Update / Delete car
│   │   ├── RentCarController.java      # Rent a car with transaction
│   │   ├── CustomerViewController.java # Customer list table + search
│   │   └── DummyTableController.java   # Auxiliary/test table view
│   │
│   ├── Data/
│   │   ├── Car.java                    # Car data model (VIN, brand, type, color, fuel, availability)
│   │   ├── CustomerView.java           # Customer view data model
│   │   └── DummyCustomer.java          # Dummy data model
│   │
│   └── config/
│       └── DatabaseConnection.java     # JDBC connection factory
│
├── src/main/resources/org/but/feec/bds_projekt_3/
│   ├── login.fxml
│   ├── AfterLogin.fxml
│   ├── CarRental.fxml
│   ├── ManageCar.fxml
│   ├── RentCar.fxml
│   ├── CustomerView.fxml
│   ├── DummyTable.fxml
│   ├── logo.png / logo+.png
│   └── logback.xml                     # Logging configuration
│
├── backup/
│   ├── backup-2022-12-22.sql           # PostgreSQL database dump
│   ├── backup-2022-12-25.sql           # PostgreSQL database dump (latest)
│   ├── backup.bat / backup.sh / backup.ps1  # Backup scripts
│   └── backupAdmina.json               # Backup admin config
│
├── pom.xml
├── mvnw / mvnw.cmd                     # Maven wrapper
├── Bds_asssignment3.pdf               # Assignment specification
├── bds_projekt_3-1.0.0-shaded.jar     # Pre-built executable JAR
└── LICENSE
```

---

## Prerequisites

- **Java 19** (JDK)
- **Maven 3.8+** (or use the included `mvnw` wrapper)
- **PostgreSQL 15** running locally on port `5432`

---

## Database Setup

1. Start your PostgreSQL server.

2. Restore the database from the provided backup:

```bash
psql -U postgres -f backup/backup-2022-12-25.sql
```

3. The application expects the following connection details (hardcoded in `DatabaseConnection.java`):

```
Host:     localhost
Port:     5432
Database: postgres
Schema:   mydb
User:     db-rental
Password: test123
```

> To use different credentials, edit `src/main/java/org/but/feec/bds_projekt_3/config/DatabaseConnection.java` before building.

---

## Build & Run

### Option A – Build from source

```bash
# 1. Clone the repository
git clone https://github.com/Tomaskoss/Car-Rental-BDS-Project.git
cd Car-Rental-BDS-Project

# 2. Build the fat JAR
mvn clean package
# or using the wrapper:
./mvnw clean package

# 3. Run the application
java -jar my-bds-app.jar
```

### Option B – Run the pre-built JAR

A pre-built shaded JAR is already included in the repository:

```bash
java -jar bds_projekt_3-1.0.0-shaded.jar
```

---

## Usage

After launching the app you will see the **Login screen**. Default credentials are stored in the `mydb.customer` table (hashed with Argon2).

```
Login:    j
Password: t
```

### Navigation flow

```
Login
  └── Main Menu (AfterLogin)
        ├── Car Rental  ──► Browse & search all cars
        │       ├── Manage Car  ──► Add / Update / Delete a car by VIN
        │       └── Rent Car    ──► Create a rental (VIN + dates + customer ID)
        └── Customer View  ──► Browse customers and their rental history
```

### Renting a car

1. Go to **Car Rental → Rent Car**
2. Enter the 17-character VIN of the car
3. Enter the customer ID, rental date and return date (format `YYYY-MM-DD`)
4. Click **Rent** — the app checks availability and inserts the rental record atomically

### Managing cars

1. Go to **Car Rental → Manage Car**
2. Enter a 17-character VIN and the numeric IDs for brand, color, fuel type and vehicle type
3. Use **Add**, **Update** or **Delete** accordingly

---

## ⚠️ Security Issues

This is a university assignment and **should not be used in production**. Several security problems exist in the codebase:

### 1. Hardcoded database credentials
`DatabaseConnection.java` stores the database URL, username and password directly in source code as plain-text string literals. Anyone with access to the source or the compiled JAR can extract them.

```java
// DatabaseConnection.java — DO NOT do this in production
String url      = "jdbc:postgresql://localhost:5432/postgres";
String user     = "db-rental";
String password = "test123";
```

**Fix:** Use a `.properties` / `.env` file, environment variables, or a secrets manager. Never commit credentials to version control.

---

### 2. `DriverManager` used instead of the declared connection pool
`HikariCP` is listed as a Maven dependency but is never actually used. Instead, every controller instantiates a raw `DriverManager.getConnection()` call directly, and connections are **never explicitly closed**. This causes connection leaks — each action that hits the database opens a new connection that is left open until the JVM's garbage collector (eventually) cleans it up.

```java
// LoginController.java — two separate connections opened, neither closed
DatabaseConnection connectNow = new DatabaseConnection();
Connection connectDB = connectNow.getConnection();   // leak #1

String storedHash = retrieveHashFromDatabase();      // leak #2 inside this method
```

**Fix:** Use `HikariCP` (already a dependency) to manage a connection pool, and wrap every `Connection`, `Statement` and `ResultSet` in a `try-with-resources` block so they are always closed.

---

### 3. No SQL injection protection in the login query
`retrieveHashFromDatabase()` in `LoginController` does use a `PreparedStatement`, which is correct. However, the connection lifecycle around it is fragile — if the query fails before returning, the partially-open connection is leaked. The rest of the controllers also use `PreparedStatement` for writes, which is good practice.

---

### 4. Sensitive data in logs
The SLF4J/Logback setup logs the full exception stack trace on any database error (e.g. `logger.error("Error connecting... {}", e)`). In a misconfigured deployment this could expose the database URL, username, or internal schema details in log files.

---

## Known Limitations

- Database credentials are hardcoded — no config file or environment variable support
- Not all database tables are connected to the UI (e.g. `payment`, `expired_car`, `staff`)
- No input validation beyond VIN length check
- HikariCP is declared as a dependency but plain `DriverManager` is used (see Security Issues above)
- The app uses an UNDECORATED window style (no native title bar)

---

## License

This project is licensed under the terms found in the [LICENSE](LICENSE) file.
