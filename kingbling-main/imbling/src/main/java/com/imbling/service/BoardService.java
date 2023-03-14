package com.imbling.service;

import com.imbling.dto.*;
import com.imbling.entity.*;
import jdk.jfr.Category;

import java.util.List;

public interface BoardService {

    public default BoardDto boardEntityToDto(BoardEntity boardEntity){
        BoardDto boardDto = new BoardDto();
        boardDto.setBoardNo(boardEntity.getBoardNo());
        boardDto.setBoardCategory(boardEntity.getBoardCategory());
        boardDto.setBoardTitle(boardEntity.getBoardTitle());
        boardDto.setBoardContent(boardEntity.getBoardContent());
        boardDto.setBoardRegDate1(boardEntity.getBoardRegDate1());
        boardDto.setBoardRegDate2(boardEntity.getBoardRegDate2());
        boardDto.setBoardCount(boardEntity.getBoardCount());
        boardDto.setUserId(boardEntity.getUserId());
        boardDto.setBoardDeleted(boardEntity.isBoardDeleted());

        return boardDto;
    }

    public default BoardEntity boardDtoToEntity(BoardDto boardDto){
        BoardEntity boardEntity = BoardEntity.builder()
                            .boardNo(boardDto.getBoardNo())
                            .boardCategory(boardDto.getBoardCategory())
                            .boardTitle(boardDto.getBoardTitle())
                            .boardContent(boardDto.getBoardContent())
                            .boardRegDate1(boardDto.getBoardRegDate1())
                            .boardRegDate2(boardDto.getBoardRegDate2())
                            .boardCount(boardDto.getBoardCount())
                            .userId(boardDto.getUserId())
                            .boardDeleted(boardDto.isBoardDeleted())
                            .build();
        return boardEntity;
    }
//=========================== boardAttach ===========================
    public default BoardAttachDto boardAttachEntityToDto(BoardAttachEntity boardAttachEntity){
        BoardAttachDto boardAttachDto = new BoardAttachDto();
        boardAttachDto.setAttachName(boardAttachEntity.getAttachName());
        boardAttachDto.setSavedAttachName(boardAttachEntity.getSavedAttachName());
        //boardAttachDto.setBoardNo(boardEntityToDto());
        boardAttachDto.setAttachNo(boardAttachEntity.getAttachNo());

        return boardAttachDto;
    }



    public default BoardAttachEntity boardAttachDtoToEntity(BoardAttachDto boardAttachDto){
        BoardAttachEntity boardAttachEntity = BoardAttachEntity.builder()
                            .attachNo(boardAttachDto.getAttachNo())
                            .attachName(boardAttachDto.getAttachName())
                            .savedAttachName(boardAttachDto.getSavedAttachName())
                            .build();
        return boardAttachEntity;
    }

//=========================== boardComment ===========================
    public default BoardCommentDto boardCommentEntityToDto(BoardCommentEntity commentEntity){
        BoardCommentDto commentDto = new BoardCommentDto();
        commentDto.setCommentNo(commentEntity.getCommentNo());
        commentDto.setWriter(commentEntity.getWriter());
        commentDto.setCommentContent(commentEntity.getCommentContent());
        commentDto.setCommentRegDate(commentEntity.getCommentRegDate());
        commentDto.setCommentGroup(commentEntity.getCommentGroup());
        commentDto.setDepth(commentEntity.getDepth());
        commentDto.setStep(commentEntity.getStep());

        return commentDto;
    }

    public default BoardCommentEntity boardCommentDtoToEntity(BoardCommentDto commentDto){
        BoardCommentEntity commentEntity = BoardCommentEntity.builder()
                .commentNo(commentDto.getCommentNo())
                .writer(commentDto.getWriter())
                // .commentRegDate(commentDto.getCommentRegDate())
                .commentGroup(commentDto.getCommentGroup())
                .depth(commentDto.getDepth())
                .step(commentDto.getStep())
                .build();

//        if (commentDto.getCommentRegDate() != null) {
//            commentEntity.setCommentRegDate(commentDto.getCommentRegDate());
//        }

        return commentEntity;
    }

    //=========================== boardFaq ===========================
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


    List<BoardDto> findEventBoard();

    List<BoardDto> findNoticeBoard();

    void writeBoardNotice(BoardDto board);

    //Detail 수정
    //BoardDto findBoardByBoardNoAndBoardCategory(int boardNo, int boardCategory);
    BoardDto findBoardByBoardNo(int boardNo, int boardCategory);

    BoardDto findBoardByBoardNoAndProductNo(int boardNo, int productNo, String productName);

    BoardDto findBoardByBoardNo(int boardNo);

    void modifiedNoticeBoard(BoardDto board);

//    void deleteBoard(int boardNo);
    void deleteBoard(BoardDto board);

    void increaseBoardCount(int boardNo);

    void writeBoardModal(BoardDto board2);

    List<BoardDto> findModalBoard();

    //댓글
    List<BoardCommentDto> findComments(int boardNo);

    void writeComment(BoardCommentDto comment, AccountDto account);

    //faq게시판
    List<BoardFaqDto> findFaq();

    void writeFaq(BoardFaqDto faq);

    BoardFaqDto findFaqByFaqNo(int faqNo, int faqCategory);

    void modifiedFaq(BoardFaqDto faq);

    //void deleteFaq(int faqNo);

    List<BoardFaqDto> findFaq2();

    List<BoardFaqDto> findFaq3();

    List<BoardDto> findModalBoardByProductNo(int productNo);

    void deleteFaq(BoardFaqDto faq);

    void writeProductBoard(BoardDto board, ProductDto product, CategoryDto category);


    //void updateGroupNo(int commentNo, int commentGroup);
}
