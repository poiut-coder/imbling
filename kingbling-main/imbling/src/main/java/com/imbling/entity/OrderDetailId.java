package com.imbling.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;

@Embeddable @Data
public class OrderDetailId implements Serializable{
	
	@Column(name="orderNo")
	private int orderNo;
	
	@Column(name="propertyNo")
	private int propertyNo;

}
