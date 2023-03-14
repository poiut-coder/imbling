package com.imbling.dto;

import java.util.List;

import lombok.Data;

@Data
public class CategoryDto {

	private int categoryNo;
	private String categoryName;
	
	private List<ProductDto> products;
}
