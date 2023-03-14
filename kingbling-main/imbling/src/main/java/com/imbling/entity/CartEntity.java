package com.imbling.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
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
@Table(name = "imb_cart")
public class CartEntity {
	
	@EmbeddedId
	@Builder.Default
	private CartId cartId = new CartId();
	
	@Column(nullable = false)
	private int cartEA;
	
	@Column(nullable = false)
	private int cartTotalPrice;
	
	@Column(nullable = false)
	@Builder.Default
	private Date cartRegDate = new Date();
	
	@Column(nullable = false)
	@Builder.Default
	private boolean cartChk = false;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@MapsId("userId")
	@JoinColumn(name = "userId")
	private AccountDtoEntity user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@MapsId("propertyNo")
	@JoinColumn(name = "propertyNo")
	private PropertyEntity property;

}
