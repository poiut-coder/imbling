package com.imbling.repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.ProductEntity;

public interface ProductRepository extends JpaRepository<ProductEntity, Long> {

	// 상품리스트
	ProductEntity findByProductNo(int productNo);
	
	// 인기상품순 정렬
	List<ProductEntity> findByCategoryCategoryNoOrderByProductCountDesc(int categoryNo);

	// 신상품순 정렬
	List<ProductEntity> findByCategoryCategoryNoOrderByProductRegdateDesc(int categoryNo);

	// 낮은가격순 정렬
	List<ProductEntity> findByCategoryCategoryNoOrderByProductPrice(int categoryNo);

	// 높은가격순 정렬
	List<ProductEntity> findByCategoryCategoryNoOrderByProductPriceDesc(int categoryNo);
	
	// 인기상품순 정렬
	
	// 리뷰많은순 정렬
	@Query(value="select p.*, (select count(*) from imb_review where productNo = p.productNo and reviewDeleted=0) cnt "
			+ "from imb_product p "
			+ "where p.categoryNo = :categoryNo "
			+ "order by cnt desc ", nativeQuery = true)
	List<Map<String, Object>> findByCategroyCategoryNoOrderByReviewDesc(@Param(value = "categoryNo")int categoryNo);
	
	// 조회수 증가
	@Transactional
	@Modifying
	@Query(value = "update imb_product set PRODUCTCOUNT = PRODUCTCOUNT + 1 where PRODUCTNO = :productNo", nativeQuery = true)
	int updateProductCount(@Param("productNo") int productNo);
	
	// 검색
	List<ProductEntity> findByProductNameContaining(String keyword);

	// 장바구니
	// 장바구니에 넣을 상품 정보 조회
	@Query(value = "select * from imb_product where productNo=( select productNo from imb_property where propertyNo=:propertyNo ) ", nativeQuery = true)
	ProductEntity findByPropertyNo(@Param("propertyNo") int propertyNo);


}
