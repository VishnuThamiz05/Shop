package com.moxman.controllers;

import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.moxman.Dao.CartDAO;
import com.moxman.Dao.UserDao;
import com.moxman.model.Coupons;
import com.moxman.model.Shipment;
import com.moxman.model.User;


@Controller
public class UserController {

	@Autowired
	UserDao userDAO;

	@Autowired
	CartDAO cartdao;

	@RequestMapping(value = "adduser", method = RequestMethod.POST)
	public String adduser(@ModelAttribute("user") User user85, Model m) {

		System.out.println("user Controller instaniated----" + user85);
		userDAO.createuser(user85);
		return "redirect:user";
	}

	@RequestMapping("user")
	public String showuser(Model m) {

		User user = new User();
		m.addAttribute(user);
		return "user";
	}

	@RequestMapping("/login_success")
	public ModelAndView loginSuccess(HttpSession session, Model m) {

		System.out.println("entering the login security");

		String page = null;

		boolean loggedIn = true;
		// Retrieving the userId;
		String email = SecurityContextHolder.getContext().getAuthentication().getName();
		session.setAttribute("email", email);
		session.setAttribute("loggedIn", loggedIn);

		// Retrieving the role
		@SuppressWarnings("unchecked")
		Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) SecurityContextHolder.getContext()
				.getAuthentication().getAuthorities();

		String role = "Role_User";
		for (GrantedAuthority authority : authorities) {
			System.out.println(authority.getAuthority());
			if (authority.getAuthority().equals(role)) {
				session.setAttribute("UserLoggedIn", "true");
				session.setAttribute("email", email);
				System.out.println("EMail :" + email);
				System.out.println("ROlE :" + role);
				m.addAttribute("role", authority.getAuthority());
				session.setAttribute("role", authority.getAuthority());
				System.out.println(authority.getAuthority());
				page = "admin";
				break;
			} else {
				session.setAttribute("LoggedIn", "true");
				session.setAttribute("Administrator", "true");
				m.addAttribute("role", authority.getAuthority());
				session.setAttribute("role", authority.getAuthority());
				page = "admin";
				break;
			}
		}

		return new ModelAndView(page, "email", email);

	}

	@RequestMapping(value = "/login")
	public String login() {
		return "login";
	}

	@RequestMapping(value = "/loginf")
	public String loginf() {

		return "loginf";
	}

	@RequestMapping(value = "/shipment")
	public String insertship(Model m, HttpSession session) {

		String email = (String) session.getAttribute("email");
		User user = userDAO.getemail(email);
		if (user.getRole().equals("Role_User") || user.getRole().equals("Role_Admin")) {
			System.out.println("--Shipment Page--");
			Shipment ship = new Shipment();
			m.addAttribute(ship);
			return "shipment";
		}
		return "login";
	}

	@RequestMapping(value = "/shipadd", method = RequestMethod.POST)
	public String gotoshipment(@ModelAttribute("ship") Shipment ship, Model m, HttpSession session) {

		String email = (String) session.getAttribute("email");
		User user = userDAO.getemail(email);

		cartdao.retrive(email);

		Shipment ship1 = new Shipment();
		ship1.setEmail(email);

		if (user.getRole().equals("Role_User") || user.getRole().equals("Role_Admin")) {

			m.addAttribute("Shipment", new Shipment());
			userDAO.creatshipadd(ship);

			return "redirect:/Billing_Recipet";
		}

		return "login";

	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String updatepersondetails(Model m) {
		User user = new User();
		userDAO.getemail("email");
		userDAO.updateuser(user);
		return "";
	}

	@RequestMapping(value = "/addcoup", method = RequestMethod.POST)
	public String gotoshipmen(@ModelAttribute("coupons") Coupons coupons, HttpSession session, Model m) {

		String email = (String) session.getAttribute("email");
		User user = userDAO.getemail(email);
		if (user.getRole().equals("Role_Admin")) {
			userDAO.addcoupons(coupons);
			return "redirect:/coupons";
		}
		return "admin";
	}

	 
	@RequestMapping(value = "/coupons")
	public String coupons(HttpSession session, Model m) { 

		String email = (String) session.getAttribute("email");
		User user = userDAO.getemail(email);
		if (user.getRole().equals("Role_Admin")) {

			Coupons coupons = new Coupons();

			List<Coupons> list = userDAO.getallcoups();
			m.addAttribute("couplist", list);
			m.addAttribute(coupons);
			return "coupons";
		}
		return "admin";
                                     
	}

	@RequestMapping(value = "deletecouponid/{id}", method = RequestMethod.GET)
	public String deletecouponns(@PathVariable("id") String id, Model m, HttpSession session) {

		String email = (String) session.getAttribute("email");
		User user = userDAO.getemail(email);
//		if (user.getRole().equals("Role_Admin")) {
//			Coupons coupons = userDAO.getcouponid(id);
//			userDAO.deletecoup(coupons);
//
//			List<Coupons> list = userDAO.getallcoups();
//			m.addAttribute("couplist", list);
//			m.addAttribute(coupons);
//			return "redirect:/coupons";
//
//		}
		return "admin";
	}

}


