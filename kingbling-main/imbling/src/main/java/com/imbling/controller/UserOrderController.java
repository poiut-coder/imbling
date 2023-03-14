package com.imbling.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.imbling.dto.AccountDto;
import com.imbling.dto.CartDto;
import com.imbling.dto.OrderDetailDto;
import com.imbling.dto.OrderDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.service.MypageService;
import com.imbling.service.UserOrderService;

@Controller @RequestMapping(path= {"/userOrder"})
public class UserOrderController {
	
	@Autowired
	@Qualifier("userOrderService")
	private UserOrderService userOrderService;
	
	@Autowired
	@Qualifier("mypageService")
	private MypageService mypageService;
	
	@RequestMapping(path= {"/jusoPopup"})
	public String showJusoPopup() {
		
		return "/modules/jusoPopup";
	}
	
	@PostMapping(path= {"/addToCart"}) @ResponseBody
	public String addToCart(int productNo,int productPrice, PropertyDto property, HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		
		CartDto cart = new CartDto();
		cart.setCartEA(property.getProductEA());
		cart.setCartTotalPrice(productPrice*property.getProductEA());
		cart.setPropertyNo(userOrderService.getPropertyNo(productNo));
		cart.setUserId(loginUser.getUserId());
		
		userOrderService.addProductToCart(cart);
		
		return "success";
	}
	
	@GetMapping(path= {"/deleteFromCart"}) @ResponseBody
	public String deleteFromCart(int propertyNo, HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		
		userOrderService.deleteFromCart(loginUser.getUserId(), propertyNo);
		
		return "success";
	}
	
	@GetMapping(path= {"/deleteCheckedFromCart"}) @ResponseBody
	public String deletecheckedFromCart(HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		
		userOrderService.deleteCheckedFromCart(loginUser.getUserId());
		
		return "success";
	}
	
	@PostMapping(path= {"/updateCartInfo"}) @ResponseBody
	public String updateCartInfo(int propertyNo,int cartEA,int productPrice, HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		
		CartDto cart = new CartDto();
		cart.setCartEA(cartEA);
		cart.setCartTotalPrice(productPrice*cartEA);
		cart.setPropertyNo(propertyNo);
		cart.setUserId(loginUser.getUserId());
		userOrderService.updateCartInfo(cart);
		
		return "success";
	}
	
	@PostMapping(path= {"/updateCartChk"}) @ResponseBody
	public String updateCartChk(int propertyNo, HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		
		CartDto cart = new CartDto();
		cart.setPropertyNo(propertyNo);
		cart.setUserId(loginUser.getUserId());
		userOrderService.updateCartChk(cart);
		
		return "success";
	}
	
	@PostMapping(path= {"/setUnChkAll"}) @ResponseBody
	public String setUnChkAll(HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		String chkOrUnchk = "unchk";
		userOrderService.setChkAll(loginUser.getUserId(),chkOrUnchk);
		
		return "success";
	}
	
	@PostMapping(path= {"/setChkAll"}) @ResponseBody
	public String setChkAll(HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		String chkOrUnchk = "chk";
		userOrderService.setChkAll(loginUser.getUserId(),chkOrUnchk);
		
		return "success";
	}
	
	@GetMapping(path= {"/doOrder"})
	public String ShowOrderPage(HttpSession session, Model model, 
		int productNo, String productSize, String productColor, int productEA ) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		ProductDto product = userOrderService.getProductInfo(productNo);
		PropertyDto property = userOrderService.getPropertyInfoByProductNo(productNo,productSize,productColor);
		
		model.addAttribute("product",product);
		model.addAttribute("property",property);
		model.addAttribute("productEA",productEA);
		model.addAttribute("userId",loginUser.getUserId());
		return "/userOrder/order";
	}
	
	@GetMapping(path= {"/doCartOrder"})
	public String ShowCartOrderPage(HttpSession session, Model model) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		
		List<CartDto> carts = mypageService.getCartInfo(loginUser.getUserId());
		int cartTotalPrice = 0;
		for(int i=0;i<carts.size();i++) {
			cartTotalPrice = cartTotalPrice + carts.get(i).getCartTotalPrice();
		}
		
		model.addAttribute("carts", carts);
		model.addAttribute("cartTotalPrice", cartTotalPrice);
		
		return "/userOrder/cart-order";
	}
	
	@GetMapping(path= {"/doOrderCheckedCart"})
	public String showCheckedCartPage(HttpSession session, Model model) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		List<CartDto> carts = userOrderService.getCheckedCartInfo(loginUser.getUserId());
		int cartTotalPrice = 0;
		for(int i=0;i<carts.size();i++) {
			cartTotalPrice = cartTotalPrice + carts.get(i).getCartTotalPrice();
		}
		model.addAttribute("carts", carts);
		model.addAttribute("cartTotalPrice", cartTotalPrice);
		
		return "userOrder/checked-order";
	}
	
	@PostMapping(path= {"/completeCartOrder"})
	public String completeCartOrder(OrderDto order) {
	
		userOrderService.insertCartOrderInfo(order);
		
		return "redirect:/mypage/orderList";
	}
	
	@PostMapping(path= {"/completeCheckedCartOrder"})
	public String completeCheckedCartOrder(OrderDto order) {
	
		userOrderService.insertcheckedCartOrderInfo(order);
		
		return "redirect:/mypage/orderList";
	}
	
	@PostMapping(path= {"/completeOrder"})
	public String completeOrder(OrderDto order, OrderDetailDto orderDetail) {
		userOrderService.insertOrder(order,orderDetail);
		
		return "redirect:/mypage/orderList";
	}
	
	@GetMapping(path= {"/cancelOrder"})
	public String cancelOrder(int orderNo) {
		userOrderService.cancelOrder(orderNo);
		
		return "redirect:/mypage/orderList";
	}
	
	@PostMapping(path= {"/updateOrderInfo"})
	public String updateOrderInfo(OrderDto order) {
		userOrderService.updateOrderInfo(order);
		
		return "redirect:/mypage/orderList";
	}
	
	@PostMapping(path= {"/cartOrnot"}) @ResponseBody
	public String cartOrnot(HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		int cartProductEA = userOrderService.cartOrnot(loginUser.getUserId());
		if(cartProductEA==0) {
			return "nothing";
		}else {
			return "good";
		}
	}
	
	@GetMapping(path= {"/deleteAllCart"}) @ResponseBody
	public String deleteAllCart(HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		userOrderService.deleteAllCart(loginUser.getUserId());
		return "success";
	}
	
}
