package com.imbling.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "imb_board")
public class BoardEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(nullable = false)
	private int boardNo;
	
	@Column(length = 100)
	private int boardCategory;

	@Column(length = 100)
	private String boardTitle;

	@Column(length = 1000, nullable = false)
	private String boardContent;

	@Builder.Default
	@Column(nullable = false)
	private Date boardRegDate1 = new Date();

	@Column
	private Date boardRegDate2;

	@Builder.Default
	@Column(nullable = false)
	private int boardCount = 0;

	@Column
	private String userId;

	@Builder.Default
	@Column(nullable = false)
	private boolean boardDeleted = false;

	//첨부파일 추가
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "boardNo")
	private Collection<BoardAttachEntity> boardAttachments;

	//댓글 추가
	@OneToMany(mappedBy = "board", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Collection<BoardCommentEntity> boardComments;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "productNo")
	private ProductEntity product;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "propertyNo")
	private PropertyEntity property;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "categoryNo")
	private CategoryEntity category;
}