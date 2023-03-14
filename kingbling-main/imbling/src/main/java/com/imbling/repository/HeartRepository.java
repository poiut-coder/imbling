package com.imbling.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.HeartEntity;

public interface HeartRepository extends JpaRepository<HeartEntity, Integer>{

	// 관심상품 리스트 조회 및 최신순으로 정렬
	@Query(value = "select * from imb_heart where userId = :userId order by heartRegDate desc", nativeQuery = true)
	List<HeartEntity> findAllByUserId(@Param("userId") String userId);
	
	// 관심상품 삭제
	@Transactional
	@Modifying
	@Query(value="delete from imb_heart where (userId=:userId and productNo=:productNo)", nativeQuery = true)
	void deleteById(@Param("userId") String userId, @Param("productNo") int productNo);
	
}
