package org.but.feec.bds_projekt_3.Data;

public class CustomerView {
    String first_name,last_name,email,phone;
    Integer order_id,amount;

    public CustomerView(String first_name, String last_name, String email, String phone, Integer order_id, Integer amount) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.phone = phone;
        this.order_id = order_id;
        this.amount = amount;
    }

    public String getFirst_name() { return first_name; }

    public void setFirst_name(String first_name) { this.first_name = first_name; }

    public String getLast_name() { return last_name; }

    public void setLast_name(String last_name) { this.last_name = last_name; }

    public String getEmail() { return email; }

    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }

    public void setPhone(String phone) { this.phone = phone; }

    public Integer getOrder_id() { return order_id; }

    public void setOrder_id(Integer order_id) { this.order_id = order_id; }

    public Integer getAmount() { return amount; }

    public void setAmount(Integer amount) { this.amount = amount; }
}
