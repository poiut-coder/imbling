package com.imbling.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.BoardCommentEntity;

public interface CommentRepository extends JpaRepository<BoardCommentEntity, Integer> {

    @Query(value = "SELECT * FROM imb_comment WHERE boardNo=:boardNo", nativeQuery = true)
    List<BoardCommentEntity> findBoardCommentDesc(@Param("boardNo") int boardNo);
}
