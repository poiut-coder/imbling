package com.imbling.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Collection;
import java.util.Date;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "imb_boardFaq")
public class BoardFaqEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(nullable = false)
    private int faqNo;

    @Column
    private int faqCategory;

    @Column
    private String faqTitle;

    @Column
    private String faqContent;

    @Column
    private String faqReply;

    @Column
    @Builder.Default
    private Date faqRegDate = new Date();

    @Column
    private String userId;

    @Column
    @Builder.Default
    private boolean faqDeleted = false;


    //댓글 추가
    @OneToMany(mappedBy = "board", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Collection<BoardCommentEntity> boardComments;


}
