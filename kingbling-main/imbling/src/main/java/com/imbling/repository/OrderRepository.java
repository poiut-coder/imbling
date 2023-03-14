package com.imbling.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.OrderEntity;
import com.imbling.entity.SalesChartData;

public interface OrderRepository extends JpaRepository<OrderEntity, Integer	>{

	@Query(value="select hibernate_sequence.currval from dual", nativeQuery = true)
	int findRecentOrderNo();

	List<OrderEntity> findAllByUserId(String userId);

	@Query(value="select to_char(l.orderDate,'yyyy-mm-dd') orderDate, sum(d.orderDetailTotalPrice) orderPrice from imb_order l Inner Join imb_orderDetail d on l.orderNo = d.orderNo group by to_char(l.orderDate,'yyyy-mm-dd') order By orderDate", nativeQuery = true)
	List<SalesChartData> findSalesData();

	@Query(value="select * from imb_order where (orderState=:selectedValue and userId=:userId)", nativeQuery = true)
	List<OrderEntity> findAllByUserIdAndCondition(@Param("userId") String userId,@Param("selectedValue") String selectedValue);

	OrderEntity findByOrderNo(int orderId);



//	// 리뷰 다 작성된 주문은 구매확정으로 상태 바꾸기
//	@Query(value="update imb_order set orderState = '구매확정' "
//			+ "where orderNo=(select :orderNo from dual "
//			+ "where ((select count(*) from imb_orderDetail where orderNo=:orderNo)=(select count(*) from imb_review where orderNo=:orderNo)))",nativeQuery = true)
//	void updateOrderState(@Param("orderNo") int orderNo);
	@Query(value="select count(:orderNo) from dual where ((select count(*) from imb_orderDetail where orderNo=:orderNo)=(select count(*) from imb_review where orderNo=:orderNo and reviewDeleted=0))", nativeQuery = true)
	int findOrderState(@Param("orderNo") int orderNo);

}
