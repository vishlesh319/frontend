package com.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dao.CategoryDAO;
import com.dao.ProductDAO;
import com.dao.SupplierDAO;
import com.dao.UserDAO;
import com.daoimpl.CategoryDAOImpl;
import com.daoimpl.ProductDAOImpl;
import com.model.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
@Controller
public class IndexController 
{
	 static Logger logger = LoggerFactory.getLogger(IndexController.class);
	@Autowired
	  UserDAO userDAO;
		@Autowired
		ProductDAO  productDAO;
		@Autowired
		CategoryDAO categoryDAO;
		
		
		@RequestMapping("/")
		public String index()
		{
		
			return "index";
		}
		
		@RequestMapping("Login")
		public String log()
		{
		
			return "Login";
		}

		@RequestMapping("/index")
		public String home()
		{
		
			return "index";
		}
		@RequestMapping(value="/goToRegister",method=RequestMethod.GET)
		public ModelAndView goToRegister()
		{
			ModelAndView mv= new ModelAndView();
			mv.addObject("user",new User());

			mv.setViewName("Register");
			return mv;
			
			
		}
		@RequestMapping(value="/saveUser",method=RequestMethod.POST)
		public ModelAndView saveUserData(@ModelAttribute("user")User user,BindingResult result)
		{
			ModelAndView mv=new ModelAndView();
			if(result.hasErrors())
			{
				mv.setViewName("SignUp");
				return mv;
			}
			else{
				user.setRole("ROLE_USER");
				user.setEnable(true);
				userDAO.insertUser(user);
				mv.setViewName("index");
				}
			return mv;
		}
		
		@RequestMapping(value="/productCustList")
		public ModelAndView getCustTable(@RequestParam("cid")int cid)
		{
			ModelAndView mv=new ModelAndView();
			mv.addObject("productList",productDAO.getProductByCategoryID(cid));
			mv.setViewName("productCustList");
			return mv;
		}
		@ModelAttribute
		public void getData(Model m)
		{
			m.addAttribute("catList",categoryDAO.list());
	    }
		@RequestMapping(value="/goToLogin",method=RequestMethod.GET)
		public ModelAndView goTOLogin()
		{
			ModelAndView mv= new ModelAndView();

			mv.setViewName("Login");
			return mv;
			
			
		}
		
		@RequestMapping("/userLogged")
	      public String login(){
			return "redirect:/index";
		}
	      
		
		@RequestMapping("/error")
		public String userError()
		{
			return "error";
		}
		@RequestMapping("/reLogin")
		public String relogin()
		{
			return "redirect:/goToLogin";
		}
		/*@RequestMapping(value ="nav/{id}" )
		public String ShowProductByCategory(@PathVariable("id") int id,RedirectAttributes attributes,Model m) {
			
			logger.info("Listing the Product by Category ID:");
			
		  attributes.addFlashAttribute("ListProduct", productDAO.getProductByCategoryID(id));
		    logger.info("Listed the product by Category ID:"+id);
		    return "redirect:/";
		}
		*/
	}