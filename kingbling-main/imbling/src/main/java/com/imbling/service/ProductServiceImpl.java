package com.imbling.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.imbling.dto.CategoryDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.entity.CategoryEntity;
import com.imbling.entity.ProductEntity;
import com.imbling.entity.PropertyEntity;
import com.imbling.repository.CategoryRepository;
import com.imbling.repository.ProductRepository;
import com.imbling.repository.PropertyRepository;

@Service("productService")
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductRepository productRepository;
	
	@Autowired 
	private CategoryRepository categoryRepository;

	@Autowired
	private PropertyRepository propertyRepository;
	
	// 네이버 쇼핑 API 데이터 저장
	@Override
	public void saveProductInfo(ProductDto product) {
		
		CategoryEntity category = categoryRepository.findByCategoryName(product.getCategory().getCategoryName());
		ProductEntity productEntity = ProductEntity.builder()
												   .productName(product.getProductName())
												   .productImage(product.getProductImage())
												   .productPrice(product.getProductPrice())
												   .category(category)
												   .build();
		
		ArrayList<PropertyEntity> properties = new ArrayList<>();
		for (PropertyDto property : product.getProperties()) {
			properties.add(PropertyEntity.builder()
										 .productColor(property.getProductColor())
										 .productSize(property.getProductSize())
										 .productEA(property.getProductEA())
										 .product(productEntity)
										 .build());
		}
		productEntity.setProperties(properties);
		
		productRepository.save(productEntity);
	}
	
	@Override
	public void saveCategoryInfo(CategoryDto category) {
		CategoryEntity categoryEntity = CategoryEntity.builder()
													  .categoryName(category.getCategoryName())
													  .build();
		
		categoryRepository.save(categoryEntity);
	}
	
	@Override
	public List<CategoryDto> findAllCategories() {
		List<CategoryEntity> categories = categoryRepository.findAllByOrderByCategoryNo();
		ArrayList<CategoryDto> categoryDtos = new ArrayList<>();
		for (CategoryEntity category : categories) {
			CategoryDto categoryDto = new CategoryDto();
			categoryDto.setCategoryNo(category.getCategoryNo());
			categoryDto.setCategoryName(category.getCategoryName());
			categoryDtos.add(categoryDto);
		}
		
		return categoryDtos;
	}

	// 상품리스트 ////////////////////////////////////////////////////////////
	
	@Override
	public CategoryDto findProductListByCategory(int categoryNo) {
		
		CategoryEntity categoryEntity = categoryRepository.findByCategoryNo(categoryNo);
		CategoryDto category = categoryEntityToDto(categoryEntity);
		
		ArrayList<ProductDto> products = new ArrayList<>();
		for (ProductEntity productEntity : categoryEntity.getProducts()) {
			ProductDto productDto = new ProductDto();
			productDto.setProductNo(productEntity.getProductNo());
			productDto.setProductName(productEntity.getProductName());
			productDto.setProductImage(productEntity.getProductImage());
			productDto.setProductPrice(productEntity.getProductPrice());
			productDto.setProductRegdate(productEntity.getProductRegdate());
			
			products.add(productDto);
		}
		category.setProducts(products);
		
		return category;
	}
	
	// 페이징 
	@Transactional
	public Page<ProductEntity> pageList(Pageable pageable) {
		return productRepository.findAll(pageable);
	}
	
	// 카테고리별 상품리스트 조회 
	@Override
	public List<ProductDto> findProductListByCategory2(String sort, boolean asc, int categoryNo) {
//	public Page<ProductDto> findProductListByCategory2(String sort, boolean asc, int categoryNo, Pageable pageable) {
		
//		Page<ProductEntity> entities = null;
//		if (sort.equals("productRegdate") && asc == false) {
//			entities = productRepository.findByCategoryCategoryNoOrderByProductRegdateDesc(categoryNo, pageable);
//		} else if (sort.equals("productPriceDesc") && asc == false) {
//			entities = productRepository.findByCategoryCategoryNoOrderByProductPriceDesc(categoryNo, pageable);
//		} else if (sort.equals("productPriceAsc") && asc == true ) {
//			entities = productRepository.findByCategoryCategoryNoOrderByProductPrice(categoryNo, pageable);
//		} else {
//			entities = productRepository.findByCategoryCategoryNoOrderByProductCountDesc(categoryNo, pageable);
//		}
		
		ArrayList<ProductDto> products = new ArrayList<>();
		if (sort.equals("reviewCountDesc") ) {
			List<Map<String, Object>> entities2 = productRepository.findByCategroyCategoryNoOrderByReviewDesc(categoryNo);
			for (Map<String, Object> productEntity : entities2) {
				ProductDto productDto = new ProductDto();
				productDto.setProductNo(((BigDecimal)productEntity.get("productNo")).intValue());
				productDto.setProductName((String)productEntity.get("productName"));
				productDto.setProductImage((String)productEntity.get("productImage"));
				productDto.setProductPrice(((BigDecimal)productEntity.get("productPrice")).intValue());
				productDto.setProductRegdate((Date)productEntity.get("productRegdate"));
				
				products.add(productDto);
			}
		} else {
			List<ProductEntity> entities = new ArrayList<>();
			if (sort.equals("productRegdate") && asc == false) {
				entities = productRepository.findByCategoryCategoryNoOrderByProductRegdateDesc(categoryNo);
			} else if (sort.equals("productPriceDesc") && asc == false) {
				entities = productRepository.findByCategoryCategoryNoOrderByProductPriceDesc(categoryNo);
			} else if (sort.equals("productPriceAsc") && asc == true ) {
				entities = productRepository.findByCategoryCategoryNoOrderByProductPrice(categoryNo);
			} else if (sort.equals("productCountDesc")){
				entities = productRepository.findByCategoryCategoryNoOrderByProductCountDesc(categoryNo);
			} 
			for (ProductEntity productEntity : entities) {
				ProductDto productDto = new ProductDto();
				productDto.setProductNo(productEntity.getProductNo());
				productDto.setProductName(productEntity.getProductName());
				productDto.setProductImage(productEntity.getProductImage());
				productDto.setProductPrice(productEntity.getProductPrice());
				productDto.setProductRegdate(productEntity.getProductRegdate());
				
				products.add(productDto);
			}
		}
		
		
		
		
		return products;
//		return (Page<ProductDto>) products;
	}

	
	// 상품상세페이지 조회 
	public ProductDto showProductDetail(int productNo) {
		
		ProductEntity productEntity = productRepository.findByProductNo(productNo);
		ProductDto product = productEntityToDto(productEntity);
		
		ArrayList<PropertyDto> properties = new ArrayList<>();
		for (PropertyEntity propertyEntity : productEntity.getProperties()) {
			PropertyDto propertyDto = new PropertyDto();
			propertyDto.setPropertyNo(propertyEntity.getPropertyNo());
			propertyDto.setProductColor(propertyEntity.getProductColor());
			propertyDto.setProductSize(propertyEntity.getProductSize());
			propertyDto.setProductEA(propertyEntity.getProductEA());
			
			properties.add(propertyDto);
		}
		product.setProperties(properties);
		
		return product;
	}
	
	// 상품번호 받아서 상품게시글 조회수 증가
	@Override
	public void increaseProductReadCount(int productNo) {
		productRepository.updateProductCount(productNo);
	}
	
	// 검색 
	@Transactional
	public List<ProductDto> searchProduct(String keyword) {
		List<ProductEntity> products = productRepository.findByProductNameContaining(keyword);
		ArrayList<ProductDto> productDtos = new ArrayList<>();
		
		for (ProductEntity product : products) {
			ProductDto productDto = new ProductDto();
			productDto.setProductNo(product.getProductNo());
			productDto.setProductName(product.getProductName());
			productDto.setProductImage(product.getProductImage());
			productDto.setProductPrice(product.getProductPrice());
			CategoryEntity categoryEntity = product.getCategory();
			CategoryDto dto = null;
			dto = categoryEntityToDto(categoryEntity);
			productDto.setCategory(dto);
			productDtos.add(productDto);
		}
		
		return productDtos;
	}

	@Override
	public int getProductEAByPropertyNo(int propertyNo) {
		int propertyEA = propertyRepository.findProductEAByPropertyNo(propertyNo);
		return propertyEA;
	}

	@Override
	public ProductDto findByProductNo(int productNo) {
		ProductDto findByProductNo=productEntityToDto( productRepository.findByProductNo(productNo));
		return findByProductNo;
	}

	@Override
	public void modeifyProduct(ProductDto productbefore) {
		
		System.out.println("==modeifyProduct=========================");

		System.out.println(productbefore);
		CategoryEntity categoryEntity =  CategoryEntity.builder().categoryNo(productbefore.getCategory().getCategoryNo()).build(); 
			ProductEntity productEntity = ProductEntity.builder()
					.productNo(productbefore.getProductNo())   
					.productName(productbefore.getProductName())
					   .productImage(productbefore.getProductImage())
					   .productPrice(productbefore.getProductPrice())
					   .category(categoryEntity)
					   .build();
	
	ArrayList<PropertyEntity> properties = new ArrayList<>();
	for (PropertyDto property : productbefore.getProperties()) {
	properties.add(PropertyEntity.builder()
			 .productColor(property.getProductColor())
			 .productSize(property.getProductSize())
			 .productEA(property.getProductEA())
			 .product(productEntity)
			 .build());
	}

	productEntity.setProperties(properties);
	//System.out.println(productEntity);

	productRepository.save(productEntity);
	}


}
