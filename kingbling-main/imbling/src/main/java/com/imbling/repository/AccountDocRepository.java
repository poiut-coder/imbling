package com.imbling.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.imbling.entity.AccountDocImgDtoEntity;

public interface AccountDocRepository extends JpaRepository<AccountDocImgDtoEntity, String> {

	
	@Query(value = "select * from imb_doc where userId = :userId ", nativeQuery = true)
	AccountDocImgDtoEntity findByUserId(@Param("userId")String userId);

}
