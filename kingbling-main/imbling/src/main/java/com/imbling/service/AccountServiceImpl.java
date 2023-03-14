package com.imbling.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.imbling.common.Util;
import com.imbling.dto.AccountDocImgDto;
import com.imbling.dto.AccountDto;
import com.imbling.entity.AccountDocImgDtoEntity;
import com.imbling.entity.AccountDtoEntity;
import com.imbling.repository.AccountRepository;

// @Component
@Service("accountService")
public class AccountServiceImpl implements AccountService {

	@Autowired
	private AccountRepository accountRepository;
	
	
	@Override
	public void registerMember(AccountDto member) {

		String passwd = Util.getHashedString(member.getUserPassword(), "SHA-256");
		member.setUserPassword(passwd); // 암호화된 패스워드를 멤버에 저장
		
		AccountDtoEntity accountEntity;
		accountEntity= accountDtoToEntity(member);
		
		HashSet<AccountDocImgDtoEntity> attachments = new HashSet<>();
		
 		for (AccountDocImgDto boardAttachDto : member.getAttachments()) {
 			attachments.add(accountDocImgDtoToEntity(boardAttachDto));
 		}
 		accountEntity.setAttachments(attachments);
 		
		
		accountRepository.save(accountEntity); // 데이터베이스에 데이터 저장	
		
		
		
	}


	@Override
	public AccountDto  findByUserIdAndUserPassword(String userId, String userPassword) {
		userPassword = Util.getHashedString(userPassword, "SHA-256");


		AccountDtoEntity loginuser=accountRepository.findByUserIdAndUserPassword(userId,userPassword);
		if (loginuser!=null) {
			AccountDto loginuserDto =accountEntityAccountDto(loginuser);
			return loginuserDto;

		}else {
			return null;

		}
	}


	@Override
	public AccountDto findByUserId(String userId) {
		AccountDtoEntity checkerId= accountRepository.findByUserId(userId);
		if(checkerId==null) {
			return null;
		}else {
			AccountDto returnId=accountEntityAccountDto(checkerId);
			return returnId;	
		}
		
	}


	@Override
	public void deleteMember(AccountDto member) {
		
		AccountDtoEntity accountEntity;
		accountEntity= accountDtoToEntity(member);
		
//		HashSet<AccountDocImgDtoEntity> attachments = new HashSet<>();
//		
// 		for (AccountDocImgDto boardAttachDto : member.getAttachments()) {
// 			attachments.add(accountDocImgDtoToEntity(boardAttachDto));
// 		}
// 		accountEntity.setAttachments(attachments);
 		
		
		accountRepository.save(accountEntity); // 데이터베이스에 데이터 저장	
		
		
	}


	@Override
	public List<AccountDto> findAll() {
		List<AccountDto> returnDto =  new ArrayList<>();;
		// TODO Auto-generated method stub
		List<AccountDtoEntity> findAll= accountRepository.findAll();
		for (AccountDtoEntity findEntity :  findAll) {
			returnDto.add(accountEntityAccountDto(findEntity));
 		}
		return returnDto;
	}


	@Override
	public void modifyAccount(AccountDto account) {
		AccountDtoEntity modifyAccount=accountRepository.findByUserId(account.getUserId());
		modifyAccount.setUserEmail(account.getUserEmail());
		modifyAccount.setUserAddress(account.getUserAddress());
		modifyAccount.setUserName(account.getUserName());
		modifyAccount.setUserPhone(account.getUserPhone());
		modifyAccount.setUserType(account.getUserType());
		modifyAccount.setUserActiveState(account.isUserActiveState());
		modifyAccount.setUserCorpNo(account.getUserCorpNo());
		modifyAccount.setUserDocValid(account.isUserDocValid());
		
		accountRepository.save(modifyAccount);		
	}



	


}
