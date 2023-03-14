package com.imbling.entity;

import java.util.Collection;
import java.util.Date;
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

import com.imbling.dto.BoardDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "imb_product")
public class ProductEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(nullable = false)
	private int productNo; // 상품 식별자

	@Column(length = 300, nullable = false)
	private String productName; // 상품명 

	@Column(length = 5000)
	private String productContent; // 상품 설명

	@Column(length = 500, nullable = false)
	private String productImage; // 상품 이미지

	@Column(nullable = false)
	private int productPrice; // 상품 가격

	@Builder.Default
	@Column(nullable = false)
	private Date productRegdate = new Date(); // 상품 등록일자

	@Builder.Default
	@Column(nullable = false)
	private int productCount = 0; // 상품 조회수
	
	@Builder.Default
	@Column(nullable=true)
	private Boolean deleted = false;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "categoryNo")
	private CategoryEntity category;
	
	@OneToMany(mappedBy="product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<PropertyEntity> properties;

	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<ReviewEntity> reviews;

	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<BoardEntity> boards;
	
	@OneToMany(mappedBy = "products", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<HeartEntity> hearts;


	
}
