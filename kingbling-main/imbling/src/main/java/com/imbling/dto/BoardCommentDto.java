package com.imbling.dto;

import lombok.Data;

import java.util.Date;

@Data
public class BoardCommentDto {

    private int commentNo;
    private String commentContent;
    private String writer;
    private Date commentRegDate;
    private Integer commentGroup;
    private Integer depth;
    private Integer step;
    private int boardNo;




}
