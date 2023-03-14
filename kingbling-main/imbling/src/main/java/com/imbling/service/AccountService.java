package com.imbling.service;

import java.util.List;

import com.imbling.dto.AccountDocImgDto;
import com.imbling.dto.AccountDto;
import com.imbling.entity.AccountDocImgDtoEntity;
import com.imbling.entity.AccountDtoEntity;

public interface AccountService {

	public default AccountDto accountEntityAccountDto(AccountDtoEntity accountEntity) {
		AccountDto accountDto = new AccountDto();


		accountDto.setUserType(accountEntity.getUserType());

		accountDto.setUserPhone(accountEntity.getUserPhone());
		accountDto.setUserName(accountEntity.getUserName());

		accountDto.setUserEmail(accountEntity.getUserEmail());
		accountDto.setUserAddress(accountEntity.getUserAddress());
		accountDto.setUserId(accountEntity.getUserId());
		accountDto.setUserPassword(accountEntity.getUserPassword());
		accountDto.setUserActiveState(accountEntity.isUserActiveState());
		accountDto.setUserDocValid(accountEntity.isUserDocValid());

		accountDto.setUserCorpNo(accountEntity.getUserCorpNo());

		return accountDto;		
	}
	
	public default AccountDtoEntity accountDtoToEntity(AccountDto accountDto) {
		AccountDtoEntity accountEntity = AccountDtoEntity.builder()
				.userName(accountDto.getUserName())
				.userPhone(accountDto.getUserPhone())
				.userType(accountDto.getUserType())
				.userEmail(accountDto.getUserEmail())
				.userAddress(accountDto.getUserAddress())
				.userId(accountDto.getUserId())
				.userPassword(accountDto.getUserPassword())
				.userActiveState(accountDto.isUserActiveState())
				.userCorpNo(accountDto.getUserCorpNo())
				.userDocValid(accountDto.isUserDocValid())

				.build();
		return accountEntity;
	}
	
	public default AccountDocImgDto AccountDocImgDtoEntitytoDto(AccountDocImgDtoEntity accountDocImgDtoEntity) {
		AccountDocImgDto accountDocImgDto = new AccountDocImgDto();
		accountDocImgDto.setDocName(accountDocImgDtoEntity.getDocName());
		accountDocImgDto.setDocNo(accountDocImgDtoEntity.getDocNo());

		return accountDocImgDto;		
	}
	
	public default AccountDocImgDtoEntity accountDocImgDtoToEntity(AccountDocImgDto accountDocImgDto) {
		AccountDocImgDtoEntity accountEntity = AccountDocImgDtoEntity.builder()
				.docName(accountDocImgDto.getDocName())
				.docNo(accountDocImgDto.getDocNo())
				.build();
		return accountEntity;
	}
	
	void registerMember(AccountDto accountDto);

	
	

	AccountDto findByUserIdAndUserPassword(String userId, String userPassword);

	AccountDto findByUserId(String userId);

	void deleteMember(AccountDto loginUser);

	List<AccountDto> findAll();

	void modifyAccount(AccountDto account);

}