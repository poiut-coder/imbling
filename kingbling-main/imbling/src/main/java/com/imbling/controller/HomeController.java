package com.imbling.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.imbling.dto.OrderDto;
import com.imbling.service.HomeService;

@Controller
public class HomeController {
	
	@Autowired
	@Qualifier("homeService")
	private HomeService homeService;
	
	@GetMapping(path = { "/", "/home" })
	public String home() {
		
		return "home";
	}
	
	@GetMapping(path= {"admin-home"})
	public String adminHome(Model model) {
		int joinedUser = homeService.findAllUserAmount();
		int productAmount = homeService.findProductAmount();
		int unPreparedOrder = homeService.findUnPreparedOrder();
		int needReply = homeService.findNeedReply();

		model.addAttribute("joinedUser", joinedUser);
		model.addAttribute("productAmount", productAmount);
		model.addAttribute("unPreparedOrder", unPreparedOrder);
		model.addAttribute("needReply", needReply);
		return "admin-home";
	}
	
	@GetMapping(path= {"/sales-data-by-date"}) @ResponseBody
	public List<OrderDto> getSalesData(){
		
		List<OrderDto> order = homeService.findSalesData();
		
		return order;
	}
	
	@GetMapping(path= {"/purchase-data"}) @ResponseBody
	public List<Integer> purchaseData(){
		
		List<Integer> purchase = homeService.findPurchaseData();
		
		return purchase;
	}
	
	@GetMapping(path= {"/valid-user-data"}) @ResponseBody
	public List<Integer> validUserData(){
		
		List<Integer> purchase = homeService.findValidUserData();
		
		return purchase;
	}
	
	@GetMapping(path= {"/order-data"}) @ResponseBody
	public List<Integer> orserData(){
		
		List<Integer> order = homeService.findOrderData();
		
		return order;
	}

}

