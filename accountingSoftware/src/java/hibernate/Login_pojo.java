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
@Table(name="Login")
public class Login_pojo {
    @Id
    @Column(name="email")
    private String email;
    
    @Column(name="password")
    private String password;
    
    @Column(name="contact")
    private String contact;
    
    @Column(name="name")
    private String name;
    
    @Column(name="username")
    private String uname;
    
    @Column(name="category")
    private String category;
    
    @Column(name="domain")
    private String domain;
    
    @Column(name="sgst")
    private int sgst;
    
    @Column(name="igst")
    private int igst;
    
    @Column(name="cgst")
    private int cgst;
    
    
    public String getemail(){
        return email;
    }
    public String getpassword(){
        return password;
    }
    public String getcontact(){
        return contact;
    }
    public String getname(){
        return name;
    }
    public String getuname(){
        return uname;
    }
    public String getdomain(){
        return domain;
    }
    public String getcategory(){
        return category;
    }
    public int getsgst(){
        return sgst;
    }
    public int getcgst(){
        return cgst;
    }
    public int getigst(){
        return igst;
    }
    
    public void setemail(String email){
        this.email = email;
    }
    public void setpassword(String password){
        this.password = password; 
    }
    public void setcontact(String contact){
        this.contact = contact;
    }
    public void setname(String name){
        this.name = name;
    }
    public void setuname(String uname){
        this.uname = uname;
    }
    public void setcategory(String category){
        this.category = category;
    }
    public void setsgst(int sgst){
        this.sgst = sgst;
    }
    public void setigst(int igst){
        this.igst = igst;
    }
    public void setcgst(int cgst){
        this.cgst = cgst;
    }
    public void setdomain(String domain){
        this.domain = domain;
    }
    
    
}
