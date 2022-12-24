package org.but.feec.bds_projekt_3.Data;

public class Car {

    String vin_id,brand_name,vehicle_type,fuel_type,color;
    Boolean availability;

    public Car(String vin_id, String brand_name, String vehicle_type, String color,String fuel_type,Boolean availability) {
        this.vin_id = vin_id;
        this.brand_name = brand_name;
        this.vehicle_type = vehicle_type;
        this.fuel_type = fuel_type;
        this.color = color;
        this.availability = availability;
    }

    public Boolean getAvailability() {return availability;}

    public void setAvailability(Boolean availability) {this.availability = availability;}

    public String getVin_id() {
        return vin_id;
    }

    public void setVin_id(String vin_id) {
        this.vin_id = vin_id;
    }

    public String getBrand_name() {
        return brand_name;
    }

    public void setBrand_name(String brand_name) {
        this.brand_name = brand_name;
    }

    public String getVehicle_type() {
        return vehicle_type;
    }

    public void setVehicle_type(String vehicle_type) {
        this.vehicle_type = vehicle_type;
    }

    public String getFuel_type() {
        return fuel_type;
    }

    public void setFuel_type(String fuel_type) {
        this.fuel_type = fuel_type;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
}


