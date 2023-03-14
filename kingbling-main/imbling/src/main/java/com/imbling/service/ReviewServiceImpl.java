package com.imbling.service;

import com.imbling.dto.*;
import com.imbling.entity.*;

import com.imbling.repository.OrderDetailRepository;
import com.imbling.repository.OrderRepository;
import com.imbling.repository.PropertyRepository;
import com.imbling.repository.ReviewRepository;

import lombok.Builder;

import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private PropertyRepository propertyRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private OrderRepository orderRepository;


    @Override
    public void writeReview(ReviewDto review) {
        ReviewEntity reviewEntity = ReviewEntity.builder()
                .reviewTitle(review.getReviewTitle())
                .reviewStar(review.getReviewStar())
                .reviewContent(review.getReviewContent())
                .userId(review.getUserId())
                .build();

        PropertyEntity propertyEntity = propertyRepository.findById(review.getPropertyNo()).orElse((null));
        OrderEntity orderEntity = orderRepository.findById(review.getOrderNo()).orElse(null);

        //reviewEntity에 property타고 product 넣기.. 디비는 수정 해야함
        reviewEntity.setProduct(propertyEntity.getProduct());
        reviewEntity.setOrder(orderEntity);
        reviewEntity.setProperty(propertyEntity);

        reviewRepository.save(reviewEntity);

        OrderDetailEntity orderDetailEntity = orderDetailRepository.findByIds(review.getOrderNo(), review.getPropertyNo());
        orderDetailEntity.setReviewState(true);
        orderDetailRepository.save(orderDetailEntity);

        // 리뷰 다 작성된 주문은 구매확정으로 상태 바꾸기
//        orderRepository.updateOrderState(review.getOrderNo());
        int orderDone = orderRepository.findOrderState(review.getOrderNo());
        if (orderDone == 1) {
            orderEntity.setOrderState("구매확정");
            orderRepository.save(orderEntity);
        }
    }

    @Override
    public List<ReviewDto> findAllReview(ReviewDto review) {
        List<ReviewEntity> reviewList = reviewRepository.findAll();
        ArrayList<ReviewDto> reviews = new ArrayList<>();

        for (ReviewEntity reviewEntity : reviewList) {

            ReviewDto reviewDto = reviewEntityToDto(reviewEntity);
            reviewDto.setOrderDto(orderEntityToDto(reviewEntity.getOrder()));
            reviewDto.setPropertyDto(propertyEntityToDto(reviewEntity.getProperty()));
            reviewDto.setProductDto(productEntityToDto(reviewEntity.getProperty().getProduct()));
            reviews.add(reviewDto);
        }

        return reviews;
    }

    @Override
    public ReviewDto findReviewByReviewNo(int reviewNo) {

        ReviewEntity reviewEntity = reviewRepository.findByReviewNo(reviewNo);
        ReviewDto reviewDto = reviewEntityToDto(reviewEntity);
        reviewDto.setOrderDto(orderEntityToDto(reviewEntity.getOrder()));
        reviewDto.setPropertyDto(propertyEntityToDto(reviewEntity.getProperty()));
        reviewDto.setProductDto(productEntityToDto(reviewEntity.getProperty().getProduct()));

        return reviewDto;
    }

    //=============================================================================

    @Override
    public void increaseReviewCount(int reviewNo) {
        reviewRepository.increaseReviewCount(reviewNo);
    }

    @Override
    public List<ReviewDto> findReviewsByProductNo(int productNo) {
        List<ReviewEntity> reviewList = reviewRepository.findReviewByProductNo(productNo);
        ArrayList<ReviewDto> reviews = new ArrayList<>();
        for (ReviewEntity reviewEntity : reviewList) {

            ReviewDto reviewDto = reviewEntityToDto(reviewEntity);
            reviewDto.setOrderDto(orderEntityToDto(reviewEntity.getOrder()));
            reviewDto.setPropertyDto(propertyEntityToDto(reviewEntity.getProperty()));
            reviewDto.setProductDto(productEntityToDto(reviewEntity.getProperty().getProduct()));
            reviews.add(reviewDto);
        }
        return reviews;
    }

    @Override
    public void modifiedReview(ReviewDto review) {
        ReviewEntity reviewEntity = reviewRepository.findByReviewNo(review.getReviewNo());
        reviewEntity.setReviewTitle(review.getReviewTitle());
        reviewEntity.setReviewContent(review.getReviewContent());
        reviewEntity.setReviewStar(review.getReviewStar());
        reviewEntity.setUserId(reviewEntity.getUserId());
        reviewEntity.setReviewDeleted(reviewEntity.isReviewDeleted());
        reviewRepository.save(reviewEntity);

        PropertyEntity propertyEntity = propertyRepository.findById(review.getPropertyNo()).orElse((null));
        OrderEntity orderEntity = orderRepository.findById(review.getOrderNo()).orElse(null);

        reviewEntity.setProduct(propertyEntity.getProduct());
        reviewEntity.setOrder(orderEntity);
        reviewEntity.setProperty(propertyEntity);

    }

    @Override
    public void deleteReview(ReviewDto review) {
        ReviewEntity reviewEntity = reviewRepository.findByReviewNo(review.getReviewNo());
        reviewEntity.setReviewTitle(review.getReviewTitle());
        reviewEntity.setReviewContent(review.getReviewContent());
        reviewEntity.setReviewStar(review.getReviewStar());
        reviewEntity.setUserId(reviewEntity.getUserId());
        reviewEntity.setReviewDeleted(true);

        reviewRepository.save(reviewEntity);

        PropertyEntity propertyEntity = propertyRepository.findById(review.getPropertyNo()).orElse((null));
        OrderEntity orderEntity = orderRepository.findById(review.getOrderNo()).orElse(null);
        OrderDetailEntity orderDetailEntity = orderDetailRepository.findByIds(review.getOrderNo(),review.getPropertyNo());
// 여기 값이 들어가지 않으니 수정해야함
        orderDetailEntity.setReviewState(false);
        orderDetailRepository.save(orderDetailEntity);

        reviewEntity.setProduct(propertyEntity.getProduct());
        reviewEntity.setOrder(orderEntity);
        reviewEntity.setProperty(propertyEntity);


        int orderDone = orderRepository.findOrderState(review.getOrderNo());
        if (orderDone != 1) {
            orderEntity.setOrderState("배송완료");
            orderRepository.save(orderEntity);

        }
    }

    @Override
    public int findOneReview(int orderNo, int propertyNo) {
        int reviewNo = reviewRepository.findOneReview(orderNo,propertyNo);
        return reviewNo;
    }

	@Override
	public List<ReviewDto> findAllReviewWithoutDelete() {
		List<ReviewEntity> reviewList = reviewRepository.findAllReviewWithoutDelete();
        ArrayList<ReviewDto> reviews = new ArrayList<>();

        for (ReviewEntity reviewEntity : reviewList) {

            ReviewDto reviewDto = reviewEntityToDto(reviewEntity);
            reviewDto.setOrderDto(orderEntityToDto(reviewEntity.getOrder()));
            try {
            	reviewDto.setPropertyDto(propertyEntityToDto(reviewEntity.getProperty()));
                reviewDto.setProductDto(productEntityToDto(reviewEntity.getProperty().getProduct()));	
            }catch (Exception e ) {
        	    e.printStackTrace();    //예외정보 출력 

            }
            
            reviews.add(reviewDto);
        }

        return reviews;

	}

	@Override
	public void deleteReviewAdmin(ReviewDto review) {
		ReviewEntity reviewEntity = reviewRepository.findByReviewNo(review.getReviewNo());
        reviewEntity.setReviewTitle(review.getReviewTitle());
        reviewEntity.setReviewContent(review.getReviewContent());
        reviewEntity.setReviewStar(review.getReviewStar());
        reviewEntity.setUserId(reviewEntity.getUserId());
        reviewEntity.setReviewDeleted(review.isReviewDeleted());

        reviewRepository.save(reviewEntity);

        PropertyEntity propertyEntity = propertyRepository.findById(review.getPropertyNo()).orElse((null));
        OrderEntity orderEntity = orderRepository.findById(review.getOrderNo()).orElse(null);

        OrderDetailEntity orderDetailEntity = orderDetailRepository.findByIds(review.getOrderNo(),review.getPropertyNo());
// 여기 값이 들어가지 않으니 수정해야함
        orderDetailEntity.setReviewState(!review.isReviewDeleted());
        orderDetailRepository.save(orderDetailEntity);

        reviewEntity.setProduct(propertyEntity.getProduct());
        reviewEntity.setOrder(orderEntity);
        reviewEntity.setProperty(propertyEntity);


        int orderDone = orderRepository.findOrderState(review.getOrderNo());
        if (orderDone == 1) {
            orderEntity.setOrderState("배송완료");
            orderRepository.save(orderEntity);

        }
		
		
	}

}


//    @Override
//    public void modifiedOrderState(ReviewDto review) {
//
//        OrderDetailEntity orderDetailEntity = orderDetailRepository.findByIds(review.getOrderNo(), review.getPropertyNo());
//        orderDetailEntity.setReviewState(false);
//        orderDetailRepository.save(orderDetailEntity);
//
//
//        OrderEntity orderEntity = orderRepository.findById(review.getOrderNo()).orElse(null);
//        int orderDone = orderRepository.findOrderState(review.getOrderNo());
//        if(orderDone == 0) {
//            orderEntity.setOrderState("배송왼료");
//            orderRepository.save(orderEntity);
//        }
//
//    }

