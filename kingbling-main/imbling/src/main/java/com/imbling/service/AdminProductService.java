package com.imbling.service;

import java.util.Collection;
import java.util.List;

import com.imbling.dto.CategoryDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.dto.AdminProductDto;
import com.imbling.entity.CategoryEntity;
import com.imbling.entity.ProductEntity;

public interface AdminProductService {

	public default AdminProductDto AdminProductEntityToDto(ProductEntity AdminProductEntity) {
		AdminProductDto AdminProductDto = new AdminProductDto();
		AdminProductDto.setAdminProductNo(AdminProductEntity.getProductNo());
		AdminProductDto.setAdminProductName(AdminProductEntity.getProductName());
		AdminProductDto.setAdminProductContent(AdminProductEntity.getProductContent());
		AdminProductDto.setAdminProductImage(AdminProductEntity.getProductImage());
		AdminProductDto.setAdminProductPrice(AdminProductEntity.getProductPrice());
		AdminProductDto.setAdminProductRegdate(AdminProductEntity.getProductRegdate());
		AdminProductDto.setAdminProductCount(AdminProductEntity.getProductCount());
		
		return AdminProductDto;
	}
	
	public default ProductEntity AdminProductDtoToEntity(AdminProductDto AdminProductDto) {
		ProductEntity AdminProductEntity = ProductEntity.builder()
												   .productNo(AdminProductDto.getAdminProductNo())
												   .productName(AdminProductDto.getAdminProductName())
												   .productContent(AdminProductDto.getAdminProductContent())
												   .productImage(AdminProductDto.getAdminProductImage())
												   .productPrice(AdminProductDto.getAdminProductPrice())
												   .productRegdate(AdminProductDto.getAdminProductRegdate())
												   .productCount(AdminProductDto.getAdminProductCount())
												   .build();
		
		return AdminProductEntity;
	}
	
	public default ProductDto productEntityToDto(ProductEntity productEntity) {
		ProductDto productDto = new ProductDto();
		productDto.setProductNo(productEntity.getProductNo());
		productDto.setProductName(productEntity.getProductName());
		productDto.setProductContent(productEntity.getProductContent());
		productDto.setProductImage(productEntity.getProductImage());
		productDto.setProductPrice(productEntity.getProductPrice());
		productDto.setProductRegdate(productEntity.getProductRegdate());
		productDto.setProductCount(productEntity.getProductCount());
		
		CategoryDto category = new CategoryDto();
		category.setCategoryName(productEntity.getCategory().getCategoryName());
		productDto.setCategory(category);;
		
		return productDto;
	}
	
	public default ProductEntity productDtoToEntity(ProductDto productDto) {
		ProductEntity productEntity = ProductEntity.builder()
												   .productNo(productDto.getProductNo())
												   .productName(productDto.getProductName())
												   .productContent(productDto.getProductContent())
												   .productImage(productDto.getProductImage())
												   .productPrice(productDto.getProductPrice())
												   .productRegdate(productDto.getProductRegdate())
												   .productCount(productDto.getProductCount())
												   .build();
		
		return productEntity;
	}
	
	public default CategoryDto categoryEntityToDto(CategoryEntity categoryEntity) {
		CategoryDto categoryDto = new CategoryDto();
		categoryDto.setCategoryNo(categoryEntity.getCategoryNo());
		categoryDto.setCategoryName(categoryEntity.getCategoryName());
		
		return categoryDto;
	}
	
	public default CategoryEntity categoryDtoToEntity(CategoryDto categoryDto) {
		CategoryEntity categoryEntity = CategoryEntity.builder()
													  .categoryNo(categoryDto.getCategoryNo())
													  .categoryName(categoryDto.getCategoryName())
													  .build();
		return categoryEntity;
	}
	
	// 네이버 쇼핑 API 데이터 저장 ////////////////////////////////
	void saveAdminProductInfo(AdminProductDto AdminProduct);

	void saveCategoryInfo(CategoryDto category);

	List<CategoryDto> findAllCategories();

	// 상품리스트 /////////////////////////////////////////////
	
	// 카테고리별 상품리스트 조회 
	CategoryDto findAdminProductListByCategory(int categoryNo);
	Collection<ProductDto> findAdminProductListByCategory2(int categoryNo);
	
	// 상품상세페이지 조회 
	public ProductDto showAdminProductDetail(int productNo);

	void writeAdminProduct(AdminProductDto adminProductWrite);

	// 상품삭제
	void deleteAdminProduct(int productNo);

	void addNewProduct(AdminProductDto product, List<PropertyDto> property, int categoryNo);

	Collection<ProductDto> findAdminProductListByCategoryName(int selectedValue);

	void productEdit(ProductDto findProduct);


}
