/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hibernate;  

import java.sql.Timestamp;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 *
 * @author winayak
 */
@Entity
@Table(name="Sales")
public class Sales_pojo {
    @Column(name="name")
    private String name;
    
    @Column(name="date")
    private java.sql.Timestamp date;
    
    @Column(name="duedate")
    private String ddate;
    
    @Column(name="status")
    private String status;
    
    @Id
    @Column(name = "orderno")
    private int orderno;
    
    @Column(name="amount")
    private String amount;
    
    @Column(name="products")
    private String products;
        
    @Column(name="dueamount")
    private String damount;
    
    @Column(name="mode")
    private String mode;
    
    @Column(name="invoice")
    private Boolean invoice;
    
    public String getname(){
        return name;
    }
    public java.sql.Timestamp getdate(){
        return date;
    }
    public String getddate(){
        return ddate;
    }
    public String getstatus(){
        return status;
    }
    public int getorderno(){
        return orderno;
    }
    public String getamount(){
        return amount;
    }
    public String getproducts(){
        return products;
    }

    public String getdamount(){
        return damount;
    }
    public String getmode(){
        return mode;
    }
    public Boolean getinvoice(){
        return invoice;
    }
    
    public void setname(String name){
        this.name =  name;
    }
    public void setdate(java.sql.Timestamp date){
        this.date =  date;
    }
    public void setddate(String ddate){
        this.ddate =  ddate;
    }
    public void setstatus(String status){
        this.status =  status;
    }
    public void setorderno(int orderno){
        this.orderno =  orderno;
    }
    public void setamount(String amount){
        this.amount =  amount;
    }
    public void setproducts(String products){
        this.products =  products;
    }
    public void setdamount(String damount){
        this.damount =  damount;
    }
    public void setmode(String mode){
        this.mode =  mode;
    }
    public void setinvoice(Boolean invoice){
        this.invoice =  invoice;
    }
    
}
