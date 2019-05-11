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
@Table(name="Contacts")
public class Contact_pojo {
    @Id
    @Column(name="name")
    private String name;
    
    @Column(name="email")
    private String email;
    
    @Column(name="companyName")
    private String comp;
    
    @Column(name="balance")
    private String balance;
    
    @Column(name="phoneNo")
    private String phone;
    
    @Column(name="address")
    private String address;
    
    @Column(name="city")
    private String city;
    
    @Column(name="pan_no")
    private String pno;
    
    @Column(name="state")
    private String state;
    
    @Column(name="state_code")
    private String scode;
    
    @Column(name="acc_no")
    private String accno;
    
    @Column(name="branch_ifsc")
    private String bifsc;
    
    public String getname(){
        return name;
    }
    public String getemail(){
        return email;
    }
    public String getcomp(){
        return comp;
    }
    public String getbalance(){
        return balance;
    }
    public String getphone(){
        return phone;
    }
    public String getaddress(){
        return address;
    }
    public String getcity(){
        return city;
    }
    public String getpanno(){
        return pno;
    }
    public String getstate(){
        return state;
    }
    public String getstatecode(){
        return scode;
    }
    public String getacc_no(){
        return accno;
    }
    public String getbifsc(){
        return bifsc;
    }
    
    public void setname(String name){
        this.name =  name;
    }
    public void setemail(String email){
        this.email = email;
    }
    public void setcomp(String comp){
        this.comp = comp;
    }
    public void setbalance(String balance){
        this.balance = balance;
    }
    public void setphone(String phone){
        this.phone =  phone;
    }
    
    public void setaddress(String address){
        this.address =  address;
    }
    public void setcity(String city){
        this.city =  city;
    }
    public void setpanno(String pno){
        this.pno =  pno;
    }
    public void setstate(String state){
        this.state =  state;
    }
    public void setstatecode(String scode){
        this.scode = scode;
    }
    public void setacc_no(String accno){
        this.accno = accno;
    }
    public void setbifsc(String bifsc){
        this.bifsc =  bifsc;
    }
    
}
