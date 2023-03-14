package com.imbling.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.imbling.dto.AdminProductDto;
import com.imbling.dto.CategoryDto;
import com.imbling.dto.OrderDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.entity.CategoryEntity;
import com.imbling.entity.OrderEntity;
import com.imbling.entity.ProductEntity;
import com.imbling.entity.PropertyEntity;
import com.imbling.repository.AdminProductRepository;
import com.imbling.repository.CategoryRepository;
import com.imbling.repository.OrderRepository;
import com.imbling.repository.ProductRepository;
import com.imbling.repository.PropertyRepository;

@Service("adminProductService")
public class AdminProductServiceImpl implements AdminProductService {

	@Autowired
	private ProductRepository productRepository;
	@Autowired
	private AdminProductRepository adminProductRepository;

	@Autowired
	private CategoryRepository categoryRepository;

	@Autowired
	private PropertyRepository propertyRepository;
	
	@Autowired
	private OrderRepository orderRepository;

//	findAll() 메소드
//	Member 테이블에서 레코드 전체 목록을 조회
//	List<Member> 객체가 리턴
//	 
//
//	findById(id)
//	Member 테이블에서 기본키 필드 값이 id인 레코드를 조회
//	Optional<Member> 타입의 객체가 리턴
//	이 객체의 get 메서드를 호출하면 Member 객체가 리턴 예) Member m = memberRepository.findById(id).get();
//
//
//	save(member)
//	Member 객체를 Member 테이블에 저장
//	객체의 id(기본키) 속성값이 0이면 INSERT / 0이 아니면 UPDATE
//
//
//	saveAll(memberList)
//	Member 객체 목록을 Member 테이블에 저장
//
//	 
//	delete(member)
//	Member 객체의 id(기본키) 속성값과 일치하는 레코드를 삭제
//	 
//
//	deleteAll(memberList)
//	Member 객체 목록을 테이블에서 삭제
//	 
//
//	count()
//	Member 테이블의 전체 레코드 수를 리턴
//
//
//	exists(id)
//	Member 테이블에서 id에 해당하는 레코드가 있는지 true/false를 리턴
//
//
//	flush()
//	지금까지 Member 테이블에 대한 데이터 변경 작업들이 디스크에 모두 기록
	
	@Override
	public void saveCategoryInfo(CategoryDto category) {
		CategoryEntity categoryEntity = CategoryEntity
				.builder()
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
	public CategoryDto findAdminProductListByCategory(int categoryNo) {

		CategoryEntity categoryEntity = categoryRepository.findByCategoryNo(categoryNo);
		CategoryDto category = categoryEntityToDto(categoryEntity);

		ArrayList<AdminProductDto> products = new ArrayList<>();
		for (ProductEntity productEntity : categoryEntity.getProducts()) {
			AdminProductDto productDto = new AdminProductDto();
			productDto.setAdminProductNo(productEntity.getProductNo());
			productDto.setAdminProductName(productEntity.getProductName());
			productDto.setAdminProductImage(productEntity.getProductImage());
			productDto.setAdminProductPrice(productEntity.getProductPrice());
			productDto.setAdminProductRegdate(productEntity.getProductRegdate());

			products.add(productDto);
		}

		return category;
	}

	// 상품리스트 조회
	@Override
	public Collection<ProductDto> findAdminProductListByCategory2(int categoryNo) {

		List<Map<String, Object>> rows = adminProductRepository.findAllProducts();
		
		HashMap<Integer, CategoryDto> categories = new HashMap<>();
		HashMap<Integer, ProductDto> products = new HashMap<>();
		HashMap<Integer, PropertyDto> properties = new HashMap<>();
		
		for (Map<String, Object> row : rows) {
		
			int categoryNo2 = (int)row.get("categoryNo");
			CategoryDto categoryDto = categories.get(categoryNo);
			if (categoryDto == null) {
				categoryDto = new CategoryDto();
				categoryDto.setCategoryNo(categoryNo2);
				categoryDto.setCategoryName((String)row.get("categoryName"));
				categories.put(categoryNo2, categoryDto);
			}
			try {
				int productNo = (int)row.get("productNo");
				ProductDto productDto = products.get(productNo);
				if (productDto == null) {
					productDto = new ProductDto();
					productDto.setProductNo(productNo);
					productDto.setProductName((String)row.get("productName"));
					productDto.setProductImage((String)row.get("productImage"));
					productDto.setProductPrice((int)row.get("productPrice"));
					productDto.setProductRegdate((Date)row.get("productRegdate"));
//					productDto.setProductdeleted((boolean)row.get("productDeleted"));
					productDto.setCategory(categoryDto);
					products.put(productNo, productDto);
				}
				
				int propertyNo = (int)row.get("propertyNo");
				PropertyDto propertyDto = properties.get(propertyNo);
				if (propertyDto == null) {
					propertyDto = new PropertyDto();
					propertyDto.setPropertyNo(propertyNo);
					propertyDto.setProductColor((String)row.get("productColor"));
					propertyDto.setProductEA((int)row.get("productEA"));
					propertyDto.setProductSize((String)row.get("productSize"));
					properties.put(propertyNo, propertyDto);
					List<PropertyDto> properties2 = productDto.getProperties();
					if (properties2 == null) {
						properties2 = new ArrayList<PropertyDto>();
					}
					properties2.add(propertyDto);
					productDto.setProperties(properties2);
				} 
			}catch(Exception e ) {
        	    e.printStackTrace();    //예외정보 출력 

			}
			
		}

		return products.values();
	}

	// 상품추가
	@Override
	public void writeAdminProduct(AdminProductDto adminProductWrite) {
		ProductEntity productEntity =new ProductEntity();
			productEntity.setProductName(adminProductWrite.getAdminProductName());
			productEntity.setProductImage(productEntity.getProductImage());
			productEntity.setProductContent(productEntity.getProductContent());
			productEntity.setProductPrice(productEntity.getProductPrice());
			productEntity.setCategory(productEntity.getCategory());
			productEntity.setProperties(productEntity.getProperties());
			productRepository.save(productEntity);
	}
	
	// 상품삭제
	@Override
	public void deleteAdminProduct(int productNo) {
		ProductEntity productEntity = adminProductRepository.findById(productNo).orElse(null);
		if (productEntity != null) {
			productEntity.setDeleted(true);
			adminProductRepository.save(productEntity);
		}
	}

	private void build() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveAdminProductInfo(AdminProductDto AdminProduct) {
		// TODO Auto-generated method stub

	}




	@Override
	public void addNewProduct(AdminProductDto product, List<PropertyDto> property, int categoryNo) {
		ProductEntity productEntity = AdminProductDtoToEntity(product);
		productEntity.setProductRegdate(new Date());
		productEntity.setProductCount(0);
		CategoryEntity category = CategoryEntity.builder().categoryNo(categoryNo).build();
		productEntity.setCategory(category);
		productRepository.save(productEntity);
		productEntity.setProductNo(orderRepository.findRecentOrderNo());
		for(PropertyDto pro: property) {
			PropertyEntity propertyEntity = PropertyEntity.builder().productColor(pro.getProductColor()).product(productEntity)
					.productEA(0).productSize(pro.getProductSize()).build();
			propertyRepository.save(propertyEntity);//상품 저장할때 속성이 같이 저장되긴 하는데 상품번호는 빼고 저장되어서 수동으로 따로 넣음ㅠ
		}
	}

	// 상품상세페이지 조회 
	public ProductDto showAdminProductDetail(int productNo) {
		
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

	@Override
	public Collection<ProductDto> findAdminProductListByCategoryName(int selectedValue) {
		// TODO Auto-generated method stub
		 Collection<ProductDto> findProduct;
//				 adminProductRepository.findAllByCategoryNo(selectedValue);
		return null;
	}

	@Override
	public void productEdit(ProductDto findProduct) {
		ProductEntity productentity =productDtoToEntity(findProduct); 
		productRepository.save(productentity);

		// TODO Auto-generated method stub
		
	}

	

}
