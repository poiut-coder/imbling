package com.imbling.service;

import java.util.List;

import com.imbling.dto.OrderDto;

public interface HomeService {
	
	List<OrderDto> findSalesData();

	int findAllUserAmount();

	int findProductAmount();

	int findUnPreparedOrder();

	int findNeedReply();

	List<Integer> findValidUserData();

	List<Integer> findPurchaseData();

	List<Integer> findOrderData();

}
