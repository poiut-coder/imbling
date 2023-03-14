package com.imbling.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;

@Embeddable @Data
public class CartId implements Serializable {
	
	@Column(name="userId")
	private String userId;
	
	@Column(name="propertyNo")
	private int propertyNo;
	
}
