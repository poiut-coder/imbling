package com.imbling.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AdminProductDto {

	private int adminProductNo;
	private String adminProductName;
	private String adminProductContent;
	private String adminProductImage;
	private int adminProductPrice;
	private Date adminProductRegdate;
	private int adminProductCount;
	private boolean adminproductdeleted;

	private CategoryDto category;
	private List<PropertyDto> properties;
}
