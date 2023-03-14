package com.imbling.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.imbling.entity.BoardEntity;
import com.imbling.entity.SalesChartData;

public interface AdminHomeRepository extends JpaRepository<BoardEntity, String> {

	@Query(value = "select COUNT(*) from imb_user where usertype!='admin' ", nativeQuery = true)
	int findUserAmount();

	@Query(value = "select COUNT(*) from imb_product ", nativeQuery = true)
	int findProductAmount();

	@Query(value = "select COUNT(*) from imb_order where orderState='주문완료' ", nativeQuery = true)
	int findUnPreparedOrder();

	@Query(value = "select (select count(boardNo) from imb_board where boardcategory=3)-(select count(b.boardNo) from imb_board b inner join imb_comment c on b.boardNo = c.boardNo where b.boardcategory=3) a from imb_board  where rownum=1", nativeQuery = true)
	int findNeedReply();

	@Query(value = "select (select COUNT(*) from imb_user where userType = 'basic') orderDate, (select COUNT(*) from imb_user where userType = 'deniedDoc' or userType = 'needCheck' ) OrderPrice from imb_user where rownum=1", nativeQuery = true)
	SalesChartData findValidUserData();

	@Query(value = "select (select count(*) from imb_user where userType = 'basic') orderDate, (select COUNT(DISTINCT userid) from imb_order) OrderPrice from dual", nativeQuery = true)
	SalesChartData findPurchaseData();

	@Query(value = "select (select count(*) from imb_product) orderDate, (select count(DISTINCT productNo) from imb_property where propertyNo in (select DISTINCT propertyNo from imb_orderDetail)) OrderPrice from dual", nativeQuery = true)
	SalesChartData findOrderData();
	
}


