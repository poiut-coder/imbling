package com.imbling.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name="imb_doc")
public class AccountDocImgDtoEntity {
	

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int docNo;
	
//	@Column(nullable = false)
//	private int userNo;
	
	@Column(nullable = false)
	private String docName;
	
	
}
