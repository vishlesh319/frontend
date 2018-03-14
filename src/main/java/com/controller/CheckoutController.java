package com.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dao.AddressDAO;
import com.dao.CartDAO;
import com.dao.CategoryDAO;
import com.dao.OrdersDAO;
import com.dao.PaymentDAO;
import com.dao.ProductDAO;
import com.model.Address;
import com.model.Cart;
import com.model.Orders;
import com.model.Payment;
import com.model.Product;
import com.model.User;

@Controller
public class CheckoutController 
{

	@Autowired
	CartDAO cartDAO;
	
	@Autowired
	AddressDAO addressDAO;
	
	@Autowired
	ProductDAO productDAO;
	
	@Autowired
	PaymentDAO paymentDAO;
	
	@Autowired
	OrdersDAO orderDAO;
	

	@Autowired
    CategoryDAO categoryDAO;
	
	
	@RequestMapping(value="checkout",method = RequestMethod.GET)
	public String showShippingPage(@ModelAttribute("address") Address address,BindingResult result, HttpSession session,Model model){
		
		User user = (User) session.getAttribute("user");
		List<Cart> cartList = cartDAO.listCartbyUserId((Integer) session.getAttribute("userid"));
		
		model.addAttribute("cartList", cartList);
		model.addAttribute("addressList", addressDAO.getAllAddressOfUser((Integer) session.getAttribute("userid")));
						
		
		return "shipping";
	}
	
	@RequestMapping(value="selectShippingAddress",method = RequestMethod.POST)
	public String selectShippingAddress(@RequestParam("shipaddress") int id,HttpSession session,Model m,RedirectAttributes attributes){
		
		User user = (User) session.getAttribute("user");
		
		Address address = addressDAO.getAddressById(id);
		session.setAttribute("address", address);
		attributes.addFlashAttribute("address", address);
		attributes.addFlashAttribute("cartTotalAmount", cartDAO.CartPrice((Integer) session.getAttribute("userid")));
		
		return "redirect:/showpaymentPage";
	}
	@RequestMapping(value="saveShippingAddress",method = RequestMethod.POST)
	public String saveShippingPage(@Valid @ModelAttribute("address") Address address,BindingResult result, HttpSession session,Model m,RedirectAttributes attributes){
		if(result.hasErrors()){
			System.out.println(result.getAllErrors().toString());
			return "shipping";
		}else{
		User user = (User) session.getAttribute("user");
		address.setCreatedBy("SYSTEM");
		address.setCreatedTimestamp(new Timestamp(System.currentTimeMillis()));
		address.setPersonId((Integer) session.getAttribute("userid"));
		
		addressDAO.saveOrUpdate(address);
		session.setAttribute("address", address);
		attributes.addFlashAttribute("address", address);
		attributes.addFlashAttribute("cartTotalAmount", cartDAO.CartPrice((Integer) session.getAttribute("userid")));
		
		return "redirect:/showpaymentPage";
		}
	}

	@RequestMapping(value="showpaymentPage")
	public String showPaymentPage(@ModelAttribute("payment") Payment payment,BindingResult result,HttpSession session,Model model){
		User user = (User) session.getAttribute("user");
		Address address = (Address) session.getAttribute("address");
		model.addAttribute("address", address);
		model.addAttribute("cartTotalAmount", cartDAO.CartPrice((Integer) session.getAttribute("userid")));
		
		return "paymentPage";
	}
	@RequestMapping(value="selectPaymentMethod")
	public String selectPaymentMethod(@Valid @ModelAttribute("payment") Payment payment,BindingResult result,HttpSession session,Model m,RedirectAttributes attributes){
		if(result.hasErrors()){
			System.out.println(result.getAllErrors().toString());
			return "paymentPage";
		}else{
		User user = (User) session.getAttribute("user");
		String paymentChoice = "";
		if(payment.getPaymentMethod().equals("creditcard")){
			paymentChoice = "Credit Card";
		}else if(payment.getPaymentMethod().equals("debitcard")){
			paymentChoice = "Debit Card";
		}else if(payment.getPaymentMethod().equals("netbanking")){
			paymentChoice = "NetBanking";
		}else if(payment.getPaymentMethod().equals("cod")){
			paymentChoice = "Cash On Delivery";
		}
		
		double totalAmount = cartDAO.CartPrice((Integer) session.getAttribute("userid"));
		payment.setUserId((Integer) session.getAttribute("userid"));
		payment.setTotalAmount(totalAmount);
		paymentDAO.savePaymentInfo(payment);
		
		session.setAttribute("payment", payment);
		attributes.addFlashAttribute("payment", payment);
		attributes.addFlashAttribute("paymentChoice", paymentChoice);
		attributes.addFlashAttribute("cartTotalAmount", totalAmount);
		
		return "redirect:/orderSummary";
		}
	}
	@RequestMapping(value="orderSummary",method = RequestMethod.GET)
	public String showOrderSummary(HttpSession session,Model model){
		
		User user = (User) session.getAttribute("user");
		Address address = (Address) session.getAttribute("address");
		Payment payment = (Payment) session.getAttribute("payment");
		model.addAttribute("address", address);
		model.addAttribute("payment", payment);
		model.addAttribute("cartTotalAmount", cartDAO.CartPrice((Integer) session.getAttribute("userid")));
		model.addAttribute("cartList", cartDAO.listCartbyUserId((Integer) session.getAttribute("userid")));
		model.addAttribute("productList",productDAO.list());
		return "orderSummary";
	}
	@RequestMapping(value="processOrder")
	public String placeOrder(HttpSession session, Model model){
				
		
		User user = (User) session.getAttribute("user");		
		
		Address address = (Address) session.getAttribute("address");
		
		Payment payment = (Payment) session.getAttribute("payment");
		
		List<Cart> cartItemsList = cartDAO.listCartbyUserId((Integer) session.getAttribute("userid"));
				
		double totalAmount = 0;
		
		
		for(Cart cartItem:cartItemsList){
			
			totalAmount += cartItem.getProductPrice() * cartItem.getProductQuantity();
		}
		
		for(Cart cartItem:cartItemsList){
			
			
			Orders order=new Orders();
			String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());
			order.setOrderId(timeStamp);
			order.setUserId((Integer) session.getAttribute("userid"));
			order.setShipAddressId(address.getId());
			order.setPaymentId(payment.getId());
			order.setTotalAmount(totalAmount);
			order.setProductId(cartItem.getProductid());
			order.setProductQuantity(cartItem.getProductQuantity());
			order.setPrice(cartItem.getProductPrice());
			order.setImagName(cartItem.getImagName());
			order.setOrderStatus("PROCESSED");	
			order.setCreatedTimestamp(new Timestamp(System.currentTimeMillis()));
			order.setCreatedBy("SYSTEM");
			
			
			orderDAO.saveOrUpdate(order);
						
			Product product = productDAO.getProductById(cartItem.getProductid());
			int quantityRemaining = product.getInstock() - cartItem.getProductQuantity();
			product.setInstock(quantityRemaining);
			
			productDAO.saveProduct(product);
			
			cartDAO.removeCartById(cartItem.getCartid());
		}
		
		return "redirect:showinvoice";
	}
	@RequestMapping(value="showinvoice")
	public String showInvoiceAcknoledgement(HttpSession session,Model model){
			
		if(session != null){
			
			User user = (User) session.getAttribute("user");
			
			List<Orders> orderList = orderDAO.getAllOrdersOfUser((Integer) session.getAttribute("userid"));
			
			
		    model.addAttribute("orderList", orderList);
		    model.addAttribute("productList", productDAO.list());
		    model.addAttribute("categoryList", categoryDAO.list());
		}
		else{
			
			model.addAttribute("error", "No order detail found");
			
		}
		return "acknowledgement";
	}
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
}