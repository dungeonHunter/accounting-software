package configuration;

import hibernate.Contact_pojo;
import hibernate.Items_pojo;
import hibernate.Login_pojo;
import hibernate.Purchases_pojo;
import hibernate.Sales_pojo;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author winayak
 */
public class Hibernateutil {
    private static SessionFactory sessionFactory;
    private static ServiceRegistry serviceRegistry;
    private static final ThreadLocal<Session> threadLocal;

    static {
        try {
            Configuration configuration = new Configuration();
            configuration.configure().addAnnotatedClass(Login_pojo.class);
            configuration.configure().addAnnotatedClass(Sales_pojo.class);
            configuration.configure().addAnnotatedClass(Purchases_pojo.class);
            configuration.configure().addAnnotatedClass(Items_pojo.class);
            configuration.configure().addAnnotatedClass(Contact_pojo.class);
            serviceRegistry = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties()).build();
            sessionFactory = configuration.buildSessionFactory(serviceRegistry);
            threadLocal = new ThreadLocal<Session>();

        } catch(Throwable t){
            t.printStackTrace();
            throw new ExceptionInInitializerError(t);
        }
    }
    public static Session getSession() {
        Session session = threadLocal.get();
        if(session == null){
            session = sessionFactory.openSession();
            threadLocal.set(session);
        }
        return session;
    }

    public static void closeSession() {
        Session session = threadLocal.get();
        if(session != null){
            session.close();
            threadLocal.set(null);
        }
    }

    public static void closeSessionFactory() {
        sessionFactory.close();
        StandardServiceRegistryBuilder.destroy(serviceRegistry);
      }
}
