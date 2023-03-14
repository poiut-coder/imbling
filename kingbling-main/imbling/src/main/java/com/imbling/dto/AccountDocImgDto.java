package com.imbling.dto;
import lombok.Data;

@Data
public class AccountDocImgDto {
	//문서 정보 
	private int docNo;	//문서 번호(식별자) 
	private int userId;	//유저 번호(식별자) 
	private String docName;//문서 저장 이름 
}
