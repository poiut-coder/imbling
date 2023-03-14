package com.imbling.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.imbling.dto.OrderDto;
import com.imbling.entity.SalesChartData;
import com.imbling.repository.AdminHomeRepository;
import com.imbling.repository.OrderRepository;

@Service("homeService")
public class HomeServiceImpl implements HomeService {
	
	@Autowired
	private OrderRepository orderRepository;
		
	@Autowired
	private AdminHomeRepository mypageRepository;
	
	@Override
	public List<OrderDto> findSalesData() {
		List<SalesChartData> order = orderRepository.findSalesData();
		List<OrderDto> orders = new ArrayList<>();
		for( SalesChartData a : order ) {
			OrderDto od = new OrderDto();
			od.setOrderAddr(a.getOrderDate());
			od.setOrderNo(a.getOrderPrice());
			orders.add(od);
		}
		return orders;
	}

	@Override
	public int findAllUserAmount() {
		int joinedUser = mypageRepository.findUserAmount();
		return joinedUser;
	}

	@Override
	public int findProductAmount() {
		int productAmount = mypageRepository.findProductAmount();
		return productAmount;
	}

	@Override
	public int findUnPreparedOrder() {
		int unPreparedOrder = mypageRepository.findUnPreparedOrder();
		return unPreparedOrder;
	}

	@Override
	public int findNeedReply() {
		int needReply = mypageRepository.findNeedReply();
		return needReply;
	}

	@Override
	public List<Integer> findValidUserData() {
		SalesChartData order = mypageRepository.findValidUserData();
		List<Integer> od = new ArrayList<>();
		od.add(Integer.parseInt(order.getOrderDate()));
		od.add(order.getOrderPrice());
		return od;
	}

	@Override
	public List<Integer> findPurchaseData() {
		SalesChartData order = mypageRepository.findPurchaseData();
		List<Integer> od = new ArrayList<>();
		od.add(Integer.parseInt(order.getOrderDate()));
		od.add(order.getOrderPrice());
		od.add(Integer.parseInt(order.getOrderDate())-order.getOrderPrice());
		return od;
	}

	@Override
	public List<Integer> findOrderData() {
		SalesChartData order = mypageRepository.findOrderData();
		List<Integer> od = new ArrayList<>();
		od.add(order.getOrderPrice());
		od.add(Integer.parseInt(order.getOrderDate())-order.getOrderPrice());
		return od;
	}

}
