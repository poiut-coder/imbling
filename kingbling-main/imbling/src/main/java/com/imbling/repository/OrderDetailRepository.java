package com.imbling.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.OrderDetailEntity;

public interface OrderDetailRepository extends JpaRepository<OrderDetailEntity, Integer>  {

	@Query(value="select * from imb_orderDetail where orderNo=:orderNo", nativeQuery = true)
	List<OrderDetailEntity> findByOrderNo(@Param("orderNo") int orderNo);

	@Query(value = "SELECT * FROM imb_orderDetail WHERE orderNo=:orderNo AND propertyNo=:propertyNo", nativeQuery = true)
    OrderDetailEntity findByIds(@Param("orderNo") int orderNo, @Param("propertyNo") int propertyNo);

}
