package com.imbling.entity;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "imb_property")
public class PropertyEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(nullable = false)
	private int propertyNo; // 속성 식별자

	@Column(length = 200, nullable = false)
	private String productColor; // 상품 색상
	
	@Column(length = 200, nullable = false)
	private String productSize;	// 상품 사이즈 
	
	@Column(nullable = false)
	private int productEA;	// 상품 수량

	// 장바구니 외래키 ...
	// 주문 외래키 ...
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "productNo")
	private ProductEntity product;
	
	@OneToMany(mappedBy = "property", fetch = FetchType.LAZY)	
	private List<CartEntity> carts;
	
	@OneToMany(mappedBy = "property", fetch = FetchType.LAZY)	
	private Collection<OrderDetailEntity> orderDetails;

	@OneToMany(mappedBy = "property", fetch = FetchType.LAZY)
	private Collection<ReviewEntity> reviews;

	@OneToMany(mappedBy = "property", fetch = FetchType.LAZY)
	private Collection<ReviewEntity> boards;
}
