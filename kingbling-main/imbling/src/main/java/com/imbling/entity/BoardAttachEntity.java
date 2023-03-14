package com.imbling.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.repository.Query;

import javax.persistence.*;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "imb_boardAttach")

public class BoardAttachEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int attachNo;

    @Column
    private String attachName;

    @Column
    private String savedAttachName;


//    @Column
//    private int boardNo;
}
