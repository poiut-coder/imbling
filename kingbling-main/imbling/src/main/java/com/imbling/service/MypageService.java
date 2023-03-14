package com.imbling.service;

import java.util.List;

import com.imbling.dto.AccountDocImgDto;
import com.imbling.dto.AccountDto;
import com.imbling.dto.BoardDto;
import com.imbling.dto.BoardFaqDto;
import com.imbling.dto.CartDto;
import com.imbling.dto.HeartDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.dto.ReviewDto;
import com.imbling.entity.AccountDocImgDtoEntity;
import com.imbling.entity.AccountDtoEntity;
import com.imbling.entity.BoardEntity;
import com.imbling.entity.BoardFaqEntity;
import com.imbling.entity.CartEntity;
import com.imbling.entity.ProductEntity;
import com.imbling.entity.PropertyEntity;
import com.imbling.entity.ReviewEntity;

public interface MypageService {

	public default BoardDto boardEntityToDto(BoardEntity boardEntity) {
		BoardDto boardDto = new BoardDto();
		boardDto.setBoardNo(boardEntity.getBoardNo());
		boardDto.setBoardCategory(boardEntity.getBoardCategory());
		boardDto.setBoardTitle(boardEntity.getBoardTitle());
		boardDto.setBoardContent(boardEntity.getBoardContent());
		boardDto.setBoardRegDate1(boardEntity.getBoardRegDate1());
		boardDto.setBoardCount(boardEntity.getBoardCount());
		boardDto.setUserId(boardEntity.getUserId());
		boardDto.setBoardDeleted(boardEntity.isBoardDeleted());

		return boardDto;
	}

	public default BoardEntity boardDtoToEntity(BoardDto boardDto) {
		BoardEntity boardEntity = BoardEntity.builder()
				.boardNo(boardDto.getBoardNo())
				.boardCategory(boardDto.getBoardCategory())
				.boardTitle(boardDto.getBoardTitle())
				.boardContent(boardDto.getBoardContent())
				.boardRegDate1(boardDto.getBoardRegDate1())
				.boardCount(boardDto.getBoardCount())
				.userId(boardDto.getUserId())
				.boardDeleted(boardDto.isBoardDeleted())
				.build();
		return boardEntity;
	}

	public default ReviewDto reviewEntityToDto(ReviewEntity ReviewEntity) {
		ReviewDto reviewDto = new ReviewDto();
		reviewDto.setReviewNo(ReviewEntity.getReviewNo());
//		reviewDto.setOrderNo(ReviewEntity.getOrderNo());
//		reviewDto.setProductNo(ReviewEntity.getProductNo());
		reviewDto.setUserId(ReviewEntity.getUserId());
		reviewDto.setReviewTitle(ReviewEntity.getReviewTitle());
		reviewDto.setReviewContent(ReviewEntity.getReviewContent());
		reviewDto.setReviewRegDate(ReviewEntity.getReviewRegDate());
		reviewDto.setReviewStar(ReviewEntity.getReviewStar());
		reviewDto.setReviewCount(ReviewEntity.getReviewCount());
		reviewDto.setReviewDeleted(ReviewEntity.isReviewDeleted());

		return reviewDto;
	}

	public default ReviewEntity reviewDtoToEntity(ReviewDto reviewDto) {
		ReviewEntity reviewEntity = ReviewEntity.builder()
				.reviewNo(reviewDto.getReviewNo())
				//.orderNo(reviewDto.getOrderNo())
				//.productNo(reviewDto.getProductNo())
				.userId(reviewDto.getUserId())
				.reviewTitle(reviewDto.getReviewTitle())
				.reviewContent(reviewDto.getReviewContent())
				.reviewRegDate(reviewDto.getReviewRegDate())
				.reviewStar(reviewDto.getReviewStar())
				.reviewCount(reviewDto.getReviewCount())
				.reviewDeleted(reviewDto.isReviewDeleted())
				.build();
		return reviewEntity;
	}
	
    public default BoardFaqDto boardFaqEntityToDto(BoardFaqEntity faqEntity){
        BoardFaqDto faqDto = new BoardFaqDto();
        faqDto.setFaqNo(faqEntity.getFaqNo());
        faqDto.setFaqCategory(faqEntity.getFaqCategory());
        faqDto.setFaqContent(faqEntity.getFaqContent());
        faqDto.setFaqTitle(faqEntity.getFaqTitle());
        faqDto.setUserId(faqEntity.getUserId());
        faqDto.setFaqRegDate(faqEntity.getFaqRegDate());
        faqDto.setFaqDeleted(faqEntity.isFaqDeleted());

        return faqDto;
    }

    public default BoardFaqEntity boardFaqDtoToEntity(BoardFaqDto faqDto){
        BoardFaqEntity faqEntity = BoardFaqEntity.builder()
                .faqNo(faqDto.getFaqNo())
                .faqCategory(faqDto.getFaqCategory())
                .faqContent(faqDto.getFaqContent())
                .faqTitle(faqDto.getFaqTitle())
                .userId(faqDto.getUserId())
                .faqRegDate(faqDto.getFaqRegDate())
                .faqDeleted(faqDto.isFaqDeleted())
                .build();

        return faqEntity;
    }

	public default AccountDto accountEntityAccountDto(AccountDtoEntity accountEntity) {
		AccountDto accountDto = new AccountDto();
		accountDto.setUserName(accountEntity.getUserName());
		accountDto.setUserType(accountEntity.getUserType());

		accountDto.setUserPhone(accountEntity.getUserPhone());
		accountDto.setUserEmail(accountEntity.getUserEmail());
		accountDto.setUserAddress(accountEntity.getUserAddress());
		accountDto.setUserId(accountEntity.getUserId());
		accountDto.setUserPassword(accountEntity.getUserPassword());
		accountDto.setUserActiveState(accountEntity.isUserActiveState());

		accountDto.setUserCorpNo(accountEntity.getUserCorpNo());

		return accountDto;
	}

	public default AccountDtoEntity accountDtoToEntity(AccountDto accountDto) {
		AccountDtoEntity accountEntity = AccountDtoEntity.builder()
				.userName(accountDto.getUserName())
				.userPhone(accountDto.getUserPhone())
				.userType(accountDto.getUserType())
				.userEmail(accountDto.getUserEmail())
				.userAddress(accountDto.getUserAddress())
				.userId(accountDto.getUserId())
				.userPassword(accountDto.getUserPassword())
				.userActiveState(accountDto.isUserActiveState())
				.userCorpNo(accountDto.getUserCorpNo())
				.build();
		return accountEntity;
	}

	public default ProductDto productEntityToDto(ProductEntity productEntity) {
		ProductDto productDto = new ProductDto();
		productDto.setProductNo(productEntity.getProductNo());
		productDto.setProductName(productEntity.getProductName());
		productDto.setProductContent(productEntity.getProductContent());
		productDto.setProductImage(productEntity.getProductImage());
		productDto.setProductPrice(productEntity.getProductPrice());
		productDto.setProductRegdate(productEntity.getProductRegdate());
		productDto.setProductCount(productEntity.getProductCount());

		return productDto;
	}

	public default ProductEntity productDtoToEntity(ProductDto productDto) {
		ProductEntity productEntity = ProductEntity.builder()
				.productNo(productDto.getProductNo())
				.productName(productDto.getProductName())
				.productContent(productDto.getProductContent())
				.productImage(productDto.getProductImage())
				.productPrice(productDto.getProductPrice())
				.productRegdate(productDto.getProductRegdate())
				.productCount(productDto.getProductCount())
				.build();

		return productEntity;
	}

	public default PropertyDto propertyEntityToDto(PropertyEntity propertyEntity) {
		PropertyDto propertyDto = new PropertyDto();
		propertyDto.setProductColor(propertyEntity.getProductColor());
		propertyDto.setProductEA(propertyEntity.getProductEA());
		propertyDto.setProductSize(propertyEntity.getProductSize());
		propertyDto.setPropertyNo(propertyEntity.getPropertyNo());

		return propertyDto;
	}

	public default PropertyEntity propertyDtoToEntity(PropertyDto propertyDto) {
		PropertyEntity propertyEntity = PropertyEntity.builder()
				.propertyNo(propertyDto.getPropertyNo())
				.productColor(propertyDto.getProductColor())
				.productEA(propertyDto.getProductEA())
				.productSize(propertyDto.getProductSize())
				.build();

		return propertyEntity;
	}

	public default CartDto cartEntityToDto(CartEntity cartEntity) {
		CartDto cartDto = new CartDto();
		cartDto.setCartEA(cartEntity.getCartEA());
		cartDto.setCartTotalPrice(cartEntity.getCartTotalPrice());
		cartDto.setPropertyNo(cartEntity.getProperty().getPropertyNo());
		cartDto.setUserId(cartEntity.getUser().getUserId());
		cartDto.setCartChk(cartEntity.isCartChk());

		return cartDto;
	}

	public default CartEntity cartDtoToEntity(CartDto cartDto) {


		AccountDtoEntity userEntity = AccountDtoEntity.builder().userId(cartDto.getUserId()).build();
		PropertyEntity propertyEntity = PropertyEntity.builder().propertyNo(cartDto.getPropertyNo()).build();

		CartEntity cartEntity = CartEntity.builder().cartEA(cartDto.getCartEA()).cartTotalPrice(cartDto.getCartTotalPrice())
				.cartChk(cartDto.isCartChk()).user(userEntity).property(propertyEntity).build();
		return cartEntity;
	}
	
	public default AccountDocImgDto AccountDocImgDtoEntitytoDto(AccountDocImgDtoEntity accountDocImgDtoEntity) {
		AccountDocImgDto accountDocImgDto = new AccountDocImgDto();
		accountDocImgDto.setDocName(accountDocImgDtoEntity.getDocName());
		accountDocImgDto.setDocNo(accountDocImgDtoEntity.getDocNo());

		return accountDocImgDto;		
	}
	
	public default AccountDocImgDtoEntity accountDocImgDtoToEntity(AccountDocImgDto accountDocImgDto) {
		AccountDocImgDtoEntity accountEntity = AccountDocImgDtoEntity.builder()
				.docName(accountDocImgDto.getDocName())
				.docNo(accountDocImgDto.getDocNo())
				.build();
		return accountEntity;
	}
	

	List<BoardDto> findMyInquery(String userId);

	List<BoardDto> findMyAllInquery(String userId);

	List<ReviewDto> findMyreview(String userId);

	List<ReviewDto> findMyAllReview(String userId);

	void modifyAccount(AccountDto account);

	List<CartDto> getCartInfo(String userId);

	void setCartInfoToUnChk(String userId);

	// 관심상품
	List<HeartDto> getHeartInfo(String userId);

	void addProductToHeart(HeartDto heart);

	void deleteFromHeart(String userId, int productNo);


}