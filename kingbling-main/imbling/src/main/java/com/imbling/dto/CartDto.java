package com.imbling.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class CartDto {
	
	private String userId;
	private int propertyNo;
	private int cartEA;
	private int cartTotalPrice;
	private Date cartRegDate;
	private boolean cartChk;
	
	private ProductDto product;
	private PropertyDto property;
	
}
