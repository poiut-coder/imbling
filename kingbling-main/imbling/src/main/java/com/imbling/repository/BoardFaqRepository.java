package com.imbling.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.BoardEntity;
import com.imbling.entity.BoardFaqEntity;


public interface BoardFaqRepository extends JpaRepository<BoardFaqEntity, Integer> {


//    @Query(value = "SELECT * FROM imb_board WHERE boardCategory=1 ORDER BY boardRegDate DESC", nativeQuery = true)
//    List<BoardEntity> findEventByBoardCategoryDesc();
//
//    @Query(value = "SELECT * FROM imb_board WHERE boardCategory=2 ORDER BY boardRegDate DESC", nativeQuery = true)
//    List<BoardEntity> findNoticeByBoardCategoryDesc();
//
//    BoardEntity findByBoardNo(int boardNo);
//
//    BoardEntity findByBoardNoAndBoardCategory(int boardNo, int boardCategory);
//
//    @Transactional
//    @Modifying
//    @Query(value = "UPDATE imb_board b set b. boardCount = b.boardCount + 1 WHERE b.boardNo = :boardNo", nativeQuery = true)
//    void increaseBoardCount(int boardNo);
//
//    @Query(value = "SELECT * FROM imb_board WHERE boardCategory=3 ORDER BY boardRegDate DESC", nativeQuery = true)
//    List<BoardEntity> findModalByBoardCategoryDesc();

    @Query(value = "select * from imb_boardfaq where faqCategory=1 AND faqDeleted = 0 order by faqRegdate desc", nativeQuery = true)
    List<BoardFaqEntity> findFaqByBoardFaqCategoryDesc();

    @Query(value = "select * from imb_boardfaq where faqCategory=2 AND faqDeleted = 0 order by faqRegdate desc", nativeQuery = true)
    List<BoardFaqEntity> findFaq2ByBoardFaqCategoryDesc();

    @Query(value = "select * from imb_boardfaq where faqCategory=3 AND faqDeleted = 0 order by faqRegdate desc", nativeQuery = true)
    List<BoardFaqEntity> findFaq3ByBoardFaqCategoryDesc();

    BoardFaqEntity findByFaqNoAndFaqCategory(int faqNo, int faqCategory);

    BoardFaqEntity findByFaqNo(int faqNo);




}
