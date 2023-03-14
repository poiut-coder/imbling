package com.imbling.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.imbling.entity.ProductEntity;


public interface AdminProductRepository extends JpaRepository<ProductEntity,  Integer> {

//  @Transactional
//  @Modifying
//  @Query(value = "UPDATE imb_property d set d. boardCount = d.boardCount + 1 WHERE b.boardNo = :boardNo", nativeQuery = true)
//  void increaseBoardCount(int boardNo);
	
	
//	// 상품 삭제
//	@Transactional
//	@Modifying
//	@Query(value="delete from imb_product where (productNo=:productNo and categoryNo=:categoryNo and propertyNo=:propertyNo)", nativeQuery = true)
//	static
//	void deleteByProductNo(@Param("productNo") int productNo, @Param("categoryNo") int categoryNo, @Param("propertyNo") int propertyNo) {
//		// TODO Auto-generated method stub
	
	@Query(value = "SELECT new map (ce.categoryNo as categoryNo, ce.categoryName as categoryName, pe.productNo as productNo, pe.productName as productName, pe.productImage as productImage, pe.productPrice as productPrice, pe.productRegdate as productRegdate, pe.productCount as productCount, pe.deleted as deleted, pre.propertyNo as propertyNo, pre.productColor as productColor, pre.productSize as productSize, pre.productEA as productEA) FROM CategoryEntity ce LEFT OUTER JOIN ce.products pe LEFT OUTER JOIN pe.properties pre ORDER BY ce.categoryNo, pe.productNo, pre.propertyNo")
	List<Map<String, Object>> findAllProducts();

//	List<ProductEntity> findByCategoryNo(int selectedValue);
	
		
	
}