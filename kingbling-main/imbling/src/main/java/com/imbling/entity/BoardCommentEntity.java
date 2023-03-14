package com.imbling.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "imb_comment")
public class BoardCommentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(nullable = false)
    private int commentNo;

    @Column
    private String writer;

    @Column
    private String commentContent;

    @Builder.Default
    @Column
    private Date commentRegDate = new Date();

    @Column
    private Integer commentGroup;

    @Column
    private Integer depth;

    @Column
    private Integer step;


    @ManyToOne
    @JoinColumn(name = "boardNo")
    private BoardEntity board;

    @ManyToOne
    @JoinColumn(name = "userId")
    private AccountDtoEntity account;

}
