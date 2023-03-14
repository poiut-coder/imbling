package com.imbling.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.imbling.dto.AccountDocImgDto;
import com.imbling.repository.AccountDocRepository;

// @Component
@Service("accountDocService")
public class AccountDocServiceImpl implements AccountDocService {

	@Autowired
	private AccountDocRepository accountDocRepository;

	@Override
	public AccountDocImgDto findByUserId(String userId) {
		if (accountDocRepository.findByUserId(userId) == null) {
			return null;
		} else {
			AccountDocImgDto findByUserId = AccountDocImgDtoEntitytoDto(accountDocRepository.findByUserId(userId));
			return findByUserId;
		}
	}

}
