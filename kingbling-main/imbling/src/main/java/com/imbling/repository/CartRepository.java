package com.imbling.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.CartEntity;

public interface CartRepository extends JpaRepository<CartEntity, Integer> {

	@Query(value = "select * from imb_cart where userId = :userId order By cartRegDate", nativeQuery = true)
	List<CartEntity> findAllByUserId(@Param("userId") String userId);

	@Modifying @Transactional
	@Query(value = "delete from imb_cart where (userId=:userId and propertyNo=:propertyNo)", nativeQuery = true)
	void deleteById(@Param("userId") String userId,@Param("propertyNo") int propertyNo);

	@Query(value = "select * from imb_cart where (userId=:userId and propertyNo=:propertyNo)", nativeQuery = true)
	CartEntity findByKeys(@Param("userId") String userId,@Param("propertyNo") int propertyNo);

	@Modifying @Transactional
	@Query(value = "delete from imb_cart where userId=:userId", nativeQuery = true)
	void deleteAllByUserId(@Param("userId") String userId);

	@Query(value = "select * from imb_cart where (userId = :userId and cartChk=1) order By cartRegDate", nativeQuery = true)
	List<CartEntity> findCheckedByUserId(@Param("userId") String userId);

	@Modifying @Transactional
	@Query(value = "delete from imb_cart where (userId=:userId and cartChk=1)", nativeQuery = true)
	void deleteCheckedById(@Param("userId") String userId);

	@Query(value = "select count(*) from imb_cart where userId=:userId ", nativeQuery = true)
	int cartOrNot(@Param("userId")String userId);

	



}
