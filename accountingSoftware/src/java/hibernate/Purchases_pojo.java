/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hibernate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author winayak
 */
@Entity
@Table(name="Purchases")
public class Purchases_pojo {
    @Id
    @Column(name="pid")
    private int pid;
    
    @Column(name="name")
    private String name;
    
    @Column(name="duedate")
    private String ddate;
    
    @Column(name="status")
    private String status;
    
    @Column(name="amount")
    private String amount;
    
    @Column(name="damount")
    private String damount;    
    
    @Column(name="products")
    private String products;    
    
    @Column(name="date")
    private java.sql.Timestamp date;  
    
    @Column(name="mode")
    private String mode;
    
    @Column(name="address")
    private String address;
    
    public String getname(){
        return name;
    }
    public java.sql.Timestamp getdate(){
        return date;
    }
    public String getstatus(){
        return status;
    }
    public String getamount(){
        return amount;
    }
    public String getdamount(){
        return damount;
    }
    public String getproducts(){
        return products;
    }
    public String getddate(){
        return ddate;
    }
    public String getmode(){
        return mode;
    }
    public String getaddress(){
        return address;
    }
    public int getpid(){
        return pid;
    }
    
    public void setname(String name){
        this.name =  name;
    }
    public void setdate(java.sql.Timestamp date){
        this.date =  date;
    }
    public void setstatus(String status){
        this.status =  status;
    }
    public void setamount(String amount){
        this.amount =  amount;
    }
    public void setdamount(String damount){
        this.damount =  damount;
    }
    public void setproducts(String products){
        this.products =  products;
    }
    public void setddate(String ddate){
        this.ddate =  ddate;
    }
    public void setaddress(String address){
        this.address =  address;
    }
    public void setmode(String mode){
        this.mode =  mode;
    }
    public void setpid(int pid){
        this.pid =  pid;
    }
    
}
