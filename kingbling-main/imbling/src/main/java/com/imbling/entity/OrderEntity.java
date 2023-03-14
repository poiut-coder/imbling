package com.imbling.entity;

import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "imb_order")
public class OrderEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(nullable = false)
	private int orderNo;
	
	@Column(nullable = false) 
	@Builder.Default
	private String orderState ="주문완료";
	
	@Column(nullable = false) 
	@Builder.Default
	private Date orderDate = new Date();
	
	@Column(nullable = true)
	private String orderDeliveryRequire;
	
	@Column(nullable = false)
	private String orderPay;
	
	@Column(nullable = false)
	private String userId;
	
	@Column(nullable = false)
	private String orderAddr;
	
	private String orderAddr2;
	
	@OneToMany(mappedBy = "order", fetch = FetchType.LAZY)
	private Collection<OrderDetailEntity> orderDetails;

	@OneToMany(mappedBy = "order", fetch = FetchType.LAZY)
	private Collection<ReviewEntity> reviews;

}
