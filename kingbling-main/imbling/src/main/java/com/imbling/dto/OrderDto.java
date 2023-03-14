package com.imbling.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderDto {
	
	private int orderNo;
	private String orderState;
	private Date orderDate;
	private String orderDeliveryRequire;
	private String orderPay;
	private String userId;
	private String orderAddr;
	private String orderAddr2;

	private int reviewNo;

	private List<OrderDetailDto> orders;

}
