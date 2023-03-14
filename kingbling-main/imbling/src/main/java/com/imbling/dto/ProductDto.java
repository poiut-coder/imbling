package com.imbling.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductDto {

	private int productNo;
	private String productName;
	private String productContent;
	private String productImage;
	private int productPrice;
	private Date productRegdate;
	private int productCount;
	private boolean productdeleted;
	
	
	private CategoryDto category;
	private List<PropertyDto> properties;

}
