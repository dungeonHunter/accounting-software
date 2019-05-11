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
@Table(name="Items")
public class Items_pojo {
    @Id
    @Column(name="name")
    private String name;
    
    @Column(name="sellingprice")
    private String sp;
    
    @Column(name="costprice")
    private String cp;
    
    @Column(name="code")
    private String code;
    
    @Column(name="stock")
    private int stock;
    
    @Column(name="description")
    private String desc;
    
    @Column(name="category")
    private String cat;
    
    @Column(name="sub_category")
    private String scat;
    
    @Column(name="items_sold")
    private int isold;
    
    public String getname(){
        return name;
    }
    public String getcode(){
        return code;
    }
    public String getsp(){
        return sp;
    }
    public String getcp(){
        return cp;
    }
    public String getdesc(){
        return desc;
    }
    public int getstock(){
        return stock;
    }
    public String getcat(){
        return cat;
    }
    public String getscat(){
        return scat;
    }
    public int getisold(){
        return isold;
    }
    
    public void setname(String name){
        this.name =  name;
    }
    public void setcode(String code){
        this.code =  code;
    }
    public void setsp(String sp){
        this.sp =  sp;
    }
    public void setcp(String cp){
        this.cp =  cp;
    }
    public void setdesc(String desc){
        this.desc =  desc;
    }
    public void setstock(int stock){
        this.stock =  stock;
    }
    public void setscat(String scat){
        this.scat =  scat;
    }
    public void setcat(String cat){
        this.cat =  cat;
    }
    public void setisold(int isold){
        this.isold =  isold;
    }
    
}
