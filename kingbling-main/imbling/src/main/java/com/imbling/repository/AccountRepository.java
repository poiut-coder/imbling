package com.imbling.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.imbling.entity.AccountDtoEntity;

public interface AccountRepository extends JpaRepository<AccountDtoEntity, String> {

//	@Query(value = "SELECT user FROM imb_user user  WHERE user.userId = :userId and user.userPassword= :userPassword")
	AccountDtoEntity findByUserIdAndUserPassword(String userId, String userPassword);

	AccountDtoEntity findByUserId(String userId);

}
