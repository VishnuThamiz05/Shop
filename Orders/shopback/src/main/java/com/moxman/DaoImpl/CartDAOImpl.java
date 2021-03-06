
package com.moxman.DaoImpl;

import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.orm.hibernate4.HibernateTransactionManager;

import com.moxman.model.*;
import com.moxman.Dao.*;

@Repository
public class CartDAOImpl implements CartDAO {

	@Autowired
	SessionFactory sessionFac;

	public CartDAOImpl(SessionFactory sessionFactory) {
		super();
		sessionFac = sessionFactory;
	}

	public void insertCart(Cart cart) {
		Session session = sessionFac.openSession();
		session.beginTransaction();
		cart.setCartdate(new Date());
		session.persist(cart);
		session.getTransaction().commit();
		session.close();

	}

	public Cart getCart(int citemid) {
		Session session = sessionFac.openSession();
		Transaction tx = session.beginTransaction();
		Cart p = (Cart) session.load(Cart.class, new Integer(citemid));
		System.out.println("===================> p =" + p);
		tx.commit();
		session.close();
		return p;
	}

	public List<Cart> retrive(String email) {

		Session session1 = sessionFac.openSession();
		@SuppressWarnings("rawtypes")
		Query query = session1.createQuery("from Cart where email=:email "); // and status='N'
		query.setParameter("email", email);
		@SuppressWarnings("unchecked")
		List<Cart> list = query.list();
		return list;
	}

	public void removeCart(Cart cart) {
		Session session = sessionFac.openSession();
		session.beginTransaction();
		session.delete(cart);
		session.getTransaction().commit();
		session.close();
		// Session session=sessionFac.getCurrentSession();
		// session.delete(cart);
	}

	public void updateCart(Cart cart) {
		Session session = sessionFac.openSession();
		session.beginTransaction();
		session.update(cart);
		session.getTransaction().commit();
		session.close();
	}

	public Cart getnCartID(String username) {
		String hql = "cartid FROM Cart c  where c.username = :Name";
		Session session = sessionFac.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("Name", username);
		session.beginTransaction();
		Cart p = (Cart) query.uniqueResult();
		System.out.println("===================> p =" + p);
		session.getTransaction().commit();
		session.close();
		return p;

	}

	public void setQuantity(String email, String name, String qty, int caid) {
		String hql = "UPDATE Cart Set quantity = :quantity "
				+ "WHERE email =:Name AND citemid =:id AND prodname= :pname";
		Session session = sessionFac.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("quantity", qty);
		query.setParameter("Name", email);
		query.setParameter("id", caid);
		query.setParameter("pname", name);
		session.beginTransaction();
		query.executeUpdate();
		System.out.println("QUANTITY SET");
		session.getTransaction().commit();
		session.close();

	}

	public void deletecitems(String email) {
		String hql = "DELETE FROM Cart c WHERE c.email =:Name";
		Session session = sessionFac.openSession();
		Query query = session.createQuery(hql);
		query.setParameter("Name", email);
		session.beginTransaction();
		query.executeUpdate();
		System.out.println("Deleted");
		session.getTransaction().commit();
		session.close();

	}

}
