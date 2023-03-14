package com.imbling.dto;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class BoardDto {
	
	private int boardNo;
	private int boardCategory;
	private String boardTitle;
	private String boardContent;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date boardRegDate1; //default, 이벤트 페이지를 위해 넣어둠
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date boardRegDate2; // 이벤트 페이지 마감기간
	private int boardCount;
	private String userId;
	private boolean boardDeleted;

	private List<BoardAttachDto> boardAttachments;
	private List<BoardCommentDto> boardComments;

	//조회 위한 dto
	private int propertyNo;
	private int productNo;
	private int categoryNo;
	private PropertyDto propertyDto;
	private ProductDto productDto;


}
