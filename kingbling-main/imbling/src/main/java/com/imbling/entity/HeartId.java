package com.imbling.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;

@Embeddable
@Data
public class HeartId implements Serializable {
	
	@Column(name="userId")
	private String userId;
	
	@Column(name="productNo")
	private int productNo;
	
}
