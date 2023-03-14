package com.imbling.dto;

import lombok.Data;
import org.hibernate.criterion.Order;

import java.util.Date;
import java.util.List;

@Data
public class ReviewDto {
    private int reviewNo;
    private int orderNo;
    private int propertyNo;
    private int productNo;
    private String userId;
    private String reviewTitle;
    private String reviewContent;
    private Date reviewRegDate;
    private int reviewStar;
    private int reviewCount;
    private boolean reviewDeleted;

    // 조회 위한 dto
    private OrderDto orderDto;
    private PropertyDto propertyDto;
    private ProductDto productDto;
//    private int productNo;
//    private List<ProductDto> products;
//    private List<PropertyDto> properties;

}
