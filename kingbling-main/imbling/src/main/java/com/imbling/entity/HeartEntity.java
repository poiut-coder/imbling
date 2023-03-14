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
@Table(name = "imb_heart")
public class HeartEntity {
	
	@EmbeddedId
	@Builder.Default
	private HeartId heartId = new HeartId();
	
	@Column(nullable = false)
	@Builder.Default
	private Date heartRegdate = new Date();
	
	@Column(nullable = false)
	private int categoryNo;
	
	@ManyToOne
	@MapsId("userId")
	@JoinColumn(name = "userId")
	private AccountDtoEntity user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@MapsId("productNo")
	@JoinColumn(name = "productNo")
	private ProductEntity products;

}
