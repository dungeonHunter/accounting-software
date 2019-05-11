/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package configuration;

import hibernate.Items_pojo;
import hibernate.Login_pojo;
import hibernate.Contact_pojo;
import hibernate.Purchases_pojo;
import hibernate.Sales_pojo;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

/**
 *
 * @author winayak
 */
public class App {
    
    public String login_validate(String email, String password){
     
            Login_pojo obj = new Login_pojo();

            Session session = Hibernateutil.getSession();

            Transaction tx = session.beginTransaction();
        try{
            Query qry = session.createQuery("from Login_pojo e where e.email='"+email+"' and e.password='"+password+"'");
            
            List l =qry.list();
            Iterator i  = l.iterator();
            if(l.size() == 1){
                obj = (Login_pojo)i.next();
                String user = obj.getuname();
                String cat = obj.getcategory();
                return user+"."+cat;
            }
            else{
                return "false";
            }
        }
        catch(Exception e){
            e.printStackTrace();
            return "false";
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
            
        }
    }  
    
    public int set_category(String category,String email){
     
            Login_pojo obj = new Login_pojo();

            Session session = Hibernateutil.getSession();

            Transaction tx = session.beginTransaction();
        try{
            Query qry = session.createQuery("update Login_pojo set category= :category where email= :email");
            qry.setParameter("category",category);
            qry.setParameter("email",email);
            int res = qry.executeUpdate();
            return res;
        }
        catch(Exception e){
            e.printStackTrace();
            return 999;
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    } 
    
    public List fetch_category(String email){
        Login_pojo obj = new Login_pojo();

        Session session = Hibernateutil.getSession();
        Transaction tx = session.beginTransaction();
        
        try{
            Query qry = session.createQuery("from Login_pojo e where e.email='"+email+"'");
            List l =qry.list();     
            return l;
        }
        catch(Exception e){
            String error = e.toString();
            List l = new ArrayList();
            l.add(error);
            return l;
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    } 
    
    public void insert_login(String email, String password,String name,String contact,String username){
     
        Login_pojo obj = new Login_pojo();
        
        Session session = Hibernateutil.getSession();
        
        Transaction tx = session.beginTransaction();
        try{
            obj.setemail(email);
            obj.setpassword(password);
            obj.setname(name);
            obj.setcontact(contact);
            obj.setuname(username);
            obj.setcategory("");
            obj.setdomain("");
            session.save(obj);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
            
        }
    }
    
    public void insert_items(String name, String sp,String cp,String code,int stock,String desc,String cat,String scat){
     
        Items_pojo obj = new Items_pojo();
        
        Session session = Hibernateutil.getSession();
        
        Transaction tx = session.beginTransaction();
        
        try{
            obj.setname(name);
            obj.setsp(sp);
            obj.setcp(cp);
            obj.setcode(code);
            obj.setstock(stock);
            obj.setdesc(desc);
            obj.setcat(cat);
            obj.setscat(scat);
            obj.setisold(0);
        
            session.save(obj);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    }
    
    public List fetch_items(){
     
        Items_pojo obj = new Items_pojo();
        
        Session session = Hibernateutil.getSession();
        
        Transaction tx = session.beginTransaction();
        try{
            Query qry = session.createQuery("from Items_pojo");

            List l =qry.list();   
            return l;
        }
        catch(Exception e){
            String error = e.toString();
            List l = new ArrayList();
            l.add(error);
            return l;
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();

        }
    }
    
     public String[] check_stock(String products){
     
        Items_pojo obj = new Items_pojo();

        Session session = Hibernateutil.getSession();
        Transaction tx = session.beginTransaction();
        try{
            String[] pro = products.split("\\,");
            String[] co = {"",""};
            int j = 0;
            int qt= 0 ;
            String[] res = {"",""};
            res[0] = "0";
            while(j!=pro.length){
                co = pro[j].split("\\(");
                String co2 = co[1].replaceAll("[()]", "");
                
                Query qry = session.createQuery("from Items_pojo where code='"+co[0]+"'");  
                
                List l =qry.list();       
                Iterator i= l.iterator();
                Items_pojo obj2 = (Items_pojo)i.next();               
                qt = obj2.getstock() - Integer.parseInt(co2);
                if(qt<0){ 
                    res[0] = "1";
                    if(res[1].equals("")){
                        res[1]=obj2.getname();
                    }
                    else{
                        res[1]=res[1]+","+obj2.getname();
                    }
                }
                j++;
            }    
            j=0;
            if(res[0].equals("0")){
                 while(j!=pro.length){
                    co = pro[j].split("\\(");
                    String co2 = co[1].replaceAll("[()]", "");
                    Query qry2 = session.createQuery("update Items_pojo set stock= stock - :stock,items_sold= isold + :isold where code= :code");
                    qry2.setParameter("code",co[0]);
                    qry2.setParameter("stock",Integer.parseInt(co2));
                    qry2.setParameter("isold",Integer.parseInt(co2));
                    qry2.executeUpdate();
                    j++;
                 }
            }
            return res;
        }
        
        catch(Exception e){
            String res[] = {"",""};
            res[0] = "1";
            res[1] = e.toString();
            return res;
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    }
    
    public void insert_contact(String name, String email,String comp,String phone,String address,String scode,String state,String city,String accno,String ifsc,String pno){
     
        Contact_pojo obj = new Contact_pojo();
        
        Session session = Hibernateutil.getSession(); 
        
        Transaction tx = session.beginTransaction();
        try{ 
            obj.setname(name);
            obj.setemail(email);
            obj.setcomp(comp);
    //        Query qry = session.createQuery("from Sales_pojo where name='"++"'");
    //        List l = qry.list();
    //        Iterator i = l.iterator();
    //        Sales_pojo obj2 = null;
    //        while(i.hasNext()){
    //            obj2 = (Sales_pojo)i.next();
    //        }
    //        int orderno = 0;
    //        if(obj2!=null){
    //            orderno = obj2.getorderno();
    //            orderno++;
    //        }
    //        else{
    //            orderno = 1;
    //        }
            obj.setbalance("");
            obj.setaddress(address);
            obj.setpanno(pno);
            obj.setstatecode(scode);
            obj.setstate(state);
            obj.setcity(city);
            obj.setbifsc(ifsc);
            obj.setacc_no(accno);
            obj.setphone(phone);

            session.save(obj);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    }
    
    public List fetch_contact(){
     
        Contact_pojo obj = new Contact_pojo();
        
        Session session = Hibernateutil.getSession(); 
        
        Transaction tx = session.beginTransaction();
        try{
            Query qry = session.createQuery("from Contact_pojo");
            List l =qry.list();      
            return l;
        }
        catch(Exception e){
            String error = e.toString();
            List l = new ArrayList();           
            l.add(error);
            return l;
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    }
    
    public void insert_sales(String name,String ddate,String status,String amount,String products,String mode,String damount){
     
        Sales_pojo obj = new Sales_pojo();
        
        Session session = Hibernateutil.getSession();       
        
        Transaction tx = session.beginTransaction();
        Date date= new Date();
        long time = date.getTime();
        Timestamp ts = new Timestamp(time);
        try{
            Query qry = session.createQuery("from Sales_pojo");
            List l = qry.list();
            Iterator i = l.iterator();
            Sales_pojo obj2 = null;
            while(i.hasNext()){
                obj2 = (Sales_pojo)i.next();
            }
            int orderno = 0;
            if(obj2!=null){
                orderno = obj2.getorderno();
                orderno++;
            }
            else{
                orderno = 1;
            }
            obj.setname(name);
            obj.setddate(ddate);
            obj.setstatus(status);
            obj.setdate(ts);
            obj.setamount(amount);
            obj.setproducts(products);
            obj.setmode(mode);
            obj.setdamount(damount);
            obj.setorderno(orderno);
            session.save(obj);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    }
    
    public List fetch_sales(){
     
        Sales_pojo obj = new Sales_pojo();
        
        Session session = Hibernateutil.getSession();
        
        Transaction tx = session.beginTransaction();
        try{
            Query qry = session.createQuery("from Sales_pojo");

            List l =qry.list();
            return l;
        }
        catch(Exception e){
            String error = e.toString();
            List l = new ArrayList();
            l.add(error);
            return l;
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    }
    
    public String insert_purchases(String name,String damount,String amount,String status,String ddate,String products,String mode){
     
            Purchases_pojo obj = new Purchases_pojo();

            Session session = Hibernateutil.getSession();       

            Transaction tx = session.beginTransaction();

            Date date= new Date();
            long time = date.getTime();
            Timestamp ts = new Timestamp(time);
        try{
            Query qry = session.createQuery("from Purchases_pojo");
            List l = qry.list();
            Iterator i = l.iterator();
            Purchases_pojo obj2 = null;
            while(i.hasNext()){
                obj2 = (Purchases_pojo)i.next();
            }
            int pid = 0;
            if(obj2!=null){
                pid = obj2.getpid();
                pid++;
            }
            else{
                pid = 1;
            }
            obj.setname(name);
            obj.setddate(ddate);
            obj.setdate(ts);
            obj.setstatus(status);
            obj.setamount(amount);
            obj.setdamount(damount);
            obj.setproducts(products);
            obj.setmode(mode);     
            obj.setpid(pid);     
            session.save(obj);
            return "success";
        }
        catch(Exception e){
            return "error";
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    }
    
    public String add_stock(String products){
            Items_pojo obj = new Items_pojo();

            Session session = Hibernateutil.getSession();       

            Transaction tx = session.beginTransaction();
            String[] pro = products.split("\\,");
            String[] co = {"",""};
            int j = 0;
        try{
            while(j!=pro.length){
                co = pro[j].split("\\(");
                String co2 = co[1].replaceAll("[()]", "");
                Query qry2 = session.createQuery("update Items_pojo set stock= stock + :stock where code= :code");

                qry2.setParameter("code",co[0]);
                qry2.setParameter("stock",Integer.parseInt(co2));
                qry2.executeUpdate();
                j++;
            }
            return "success!!";
        }
        catch(Exception e){
            return e.toString();
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    }
    
    public List fetch_purchases(){
     
        Purchases_pojo obj = new Purchases_pojo();
        
        Session session = Hibernateutil.getSession();       
        Transaction tx = session.beginTransaction();
        try{
            Query qry = session.createQuery("from Purchases_pojo");

            List l =qry.list();       
            return l;
        }
        catch(Exception e){
            String error = e.toString();
            List l = new ArrayList();
            l.add(error);
            return l;
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    }
    
    public int update_gst(int cgst,int igst,int sgst,String email){
        Login_pojo obj = new Login_pojo();

        Session session = Hibernateutil.getSession();

        Transaction tx = session.beginTransaction();
        try{
            Query qry = session.createQuery("update Login_pojo as b set cgst= :cgst,"+"igst= :igst,"+"sgst= :sgst"+" where email= :email");
            qry.setParameter("cgst",cgst);
            qry.setParameter("igst",igst);
            qry.setParameter("sgst",sgst);
            qry.setParameter("email",email);
            int res = qry.executeUpdate();
            return res;
        }
        catch(Exception e){
            e.printStackTrace();
            return 999;
        }
        finally{
            tx.commit();
            Hibernateutil.closeSession();
        }
    } 
}
