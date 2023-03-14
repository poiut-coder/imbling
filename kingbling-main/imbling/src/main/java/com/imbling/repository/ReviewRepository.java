package com.imbling.repository;


import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.ReviewEntity;

public interface ReviewRepository extends JpaRepository<ReviewEntity, Integer> {

    @Query(value = "select * from imb_review WHERE reviewDeleted = 0 order By reviewNo desc", nativeQuery = true)
    List<ReviewEntity> findAll();

    ReviewEntity findByReviewNo(int reviewNo);

    @Transactional
    @Modifying
    @Query(value = "UPDATE imb_review r set r. reviewCount = r.reviewCount + 1 WHERE r.reviewNo = :reviewNo", nativeQuery = true)
    void increaseReviewCount(@Param("reviewNo") int reviewNo);
    
	@Query(value = "SELECT * FROM imb_review WHERE (userId= :userId AND reviewDeleted=0 and ROWNUM<6 ) ORDER BY reviewRegDate DESC", nativeQuery = true)
	List<ReviewEntity> findSomeById(@Param("userId") String userId);

	@Query(value = "SELECT * FROM imb_review WHERE userId= :userId ORDER BY reviewRegDate DESC", nativeQuery = true)
	List<ReviewEntity> findAllById(@Param("userId") String userId);

    @Query(value = "SELECT * FROM imb_review WHERE productNo= :productNo AND reviewDeleted = 0 ORDER BY reviewRegDate DESC", nativeQuery = true)
    List<ReviewEntity> findReviewByProductNo(@Param("productNo") int productNo);

    @Query(value = "SELECT reviewNo FROM imb_review WHERE orderNo= :orderNo AND propertyNo= :propertyNo and reviewDeleted=0", nativeQuery = true)
	int findOneReview(@Param("orderNo") int orderNo,@Param("propertyNo") int propertyNo);

    
    @Query(value = "select * from imb_review order By reviewRegDate desc", nativeQuery = true)
	List<ReviewEntity> findAllReviewWithoutDelete();
    //List<ReviewEntity> findAllByOrderByReviewRegDateDesc();

//	@Query(value = "SELECT * FROM imb_review WHERE productNo= :productNo ORDER BY reviewRegDate DESC", nativeQuery = true)
//    ReviewEntity findReviewByProductNo(int productNo);
}
