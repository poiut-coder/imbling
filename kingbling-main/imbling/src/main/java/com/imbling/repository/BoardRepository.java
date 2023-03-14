package com.imbling.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.BoardEntity;
import com.imbling.entity.BoardFaqEntity;


public interface BoardRepository extends JpaRepository<BoardEntity, Integer> {

    @Query(value = "SELECT * FROM imb_board WHERE boardCategory=1 AND boardDeleted = 0 ORDER BY boardRegDate1 DESC", nativeQuery = true)
    List<BoardEntity> findEventByBoardCategoryDesc();

    @Query(value = "SELECT * FROM imb_board WHERE boardCategory=2 AND boardDeleted = 0 ORDER BY boardRegDate1 DESC", nativeQuery = true)
    List<BoardEntity> findNoticeByBoardCategoryDesc();

    BoardEntity findByBoardNo(int boardNo);

    BoardEntity findByBoardNoAndBoardCategory(int boardNo, int boardCategory);

    @Transactional
    @Modifying
    @Query(value = "UPDATE imb_board b set b. boardCount = b.boardCount + 1 WHERE b.boardNo = :boardNo", nativeQuery = true)
    void increaseBoardCount(@Param("boardNo") int boardNo);

    @Query(value = "SELECT * FROM imb_board WHERE boardCategory=3 AND boardDeleted = 0 ORDER BY boardRegDate DESC", nativeQuery = true)
    List<BoardEntity> findModalByBoardCategoryDesc();

    @Query(value = "SELECT * fROM imb_board WHERE productNo= :productNo AND boardDeleted = 0",nativeQuery = true)
    List<BoardEntity> findBoardByProductNo(@Param("productNo") int productNo);

    @Query(value ="SELECT * FROM imb_board where boardNo=:boardNo AND productNo=:productNo", nativeQuery = true)
    BoardEntity findByBoardNoAndProductNo(@Param("boardNo") int boardNo, @Param("productNo") int productNo);

    //List<BoardEntity> findBoardByProductNo(int productNo);
    
    
    
    
    ////// 마이페이지에 글 불러오기용
	@Query(value = "SELECT * FROM imb_board WHERE (userId= :userId AND boardCategory=3 AND boardDeleted=0 and ROWNUM<6 ) ", nativeQuery = true)
	List<BoardEntity> findSomeByUserId(@Param("userId") String userId);

	@Query(value = "SELECT * FROM imb_board WHERE (userId= :userId AND boardCategory=3 AND boardDeleted=0) ", nativeQuery = true)
	List<BoardEntity> findAllByUserId(@Param("userId") String userId);
	
	@Query(value = "select count(*) from imb_comment where boardNo=:boardNo ", nativeQuery = true)
	int findInqueryComment(@Param("boardNo") int boardNo);
}
