package com.imbling.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.imbling.dto.OrderDetailDto;
import com.imbling.dto.OrderDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.service.UserOrderService;

@Controller @RequestMapping(path="/admin")
public class OrderController {
	

    @Autowired
    @Qualifier("userOrderService")
    private UserOrderService userOrderService;
	
	
	@GetMapping(path= {"order-list"})
	public String showAdminOrderList(Model model) {
		List<OrderDto> orders=userOrderService.findAll();
//		for(OrderDto order:orders ) {
//			System.out.println(order);
//
//		}
		
		model.addAttribute("orders", orders);

		return "admin/order/order-list";
	}

	@PostMapping(path= {"orderDetail"})
	@ResponseBody
	public OrderDto showAdminOrderDetail(int orderNo) {
		OrderDto findOrder=userOrderService.getOrderInfo(orderNo);

		return findOrder;
	}
	@PostMapping(path= {"findPropertyBypropertyNo"})
	@ResponseBody
	public PropertyDto findPropertyBypropertyNo(int propertyNo) {
		PropertyDto findProperty=userOrderService.findPropertyBypropertyNo(propertyNo);

		return findProperty;
	}

	
	
	@PostMapping(path= {"orderEdit"})
	public String orderEdit(String orderState,int orderNo) {
		OrderDto findOrder=userOrderService.getOrderInfo(orderNo);
		findOrder.setOrderState(orderState);
		userOrderService.orderEdit(findOrder);
		System.out.println("orderEdit");
		System.out.println(orderNo+orderState);
		
		
		
		return "redirect:order-list";

	}

}
