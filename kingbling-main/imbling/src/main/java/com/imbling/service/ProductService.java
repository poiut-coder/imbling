package com.imbling.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.imbling.dto.CategoryDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.entity.CategoryEntity;
import com.imbling.entity.ProductEntity;

public interface ProductService {

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
	void saveProductInfo(ProductDto product);

	void saveCategoryInfo(CategoryDto category);

	List<CategoryDto> findAllCategories();

	// 상품리스트 /////////////////////////////////////////////
	
	// 카테고리별 상품리스트 조회 
	CategoryDto findProductListByCategory(int categoryNo);
	List<ProductDto> findProductListByCategory2(String sort, boolean asc, int categoryNo);
//	Page<ProductDto> findProductListByCategory2(String sort, boolean asc, int categoryNo, Pageable pageable);
	
	// 상품상세페이지 조회 
	public ProductDto showProductDetail(int productNo);

	// 상품번호 받아서 상품게시글 조회수 증가 
	void increaseProductReadCount(int productNo);
	
	// 검색 
	public List<ProductDto> searchProduct(String keyword);

	int getProductEAByPropertyNo(int propertyNo);

	ProductDto findByProductNo(int productNo);

	void modeifyProduct(ProductDto productbefore);

}
