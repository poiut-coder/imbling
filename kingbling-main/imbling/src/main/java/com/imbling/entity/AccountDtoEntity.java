package com.imbling.entity;

import java.util.Collection;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.imbling.dto.AccountDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="imb_user")
public class AccountDtoEntity {
	
	public AccountDtoEntity(AccountDto member) {
		this.userName = member.getUserName();
		this.userPhone = member.getUserPhone();
		this.userEmail = member.getUserEmail();
		this.userType = member.getUserType();
		this.userAddress = member.getUserAddress();
		this.userId = member.getUserId();
		this.userPassword = member.getUserPassword();
		this.userActiveState = member.isUserActiveState();
		this.userDocValid = member.isUserDocValid();

	}
	
	public AccountDto exportAccountDto() {
		AccountDto member = new AccountDto();
		member.setUserName(userName);
		member.setUserPhone(userPhone);
		member.setUserEmail(userEmail);
		member.setUserType(userType);
		member.setUserAddress(userAddress);
		member.setUserId(userId);
		member.setUserPassword(userPassword);
		member.setUserActiveState(userActiveState);
		member.setUserDocValid(userDocValid);

		return member;
	}
	
	
	
	
	
	@Column(nullable = false)
	private String userName;
	
	@Column(nullable = false)
	private String userPhone;
	
	@Column(nullable = false)
	private String userEmail;
	
	@Builder.Default
	@Column(nullable = false)
	private String userType="basic"; //유저 구분 

	
	@Column(nullable = false)
	private String userAddress;
	
	@Id
	@Column(nullable = false)
	private String userId;
	
	@Column(nullable = false)
	private String userPassword;
	
	@Column(nullable = false)
	private boolean userActiveState;
	
	@Column
	private String userCorpNo;
	
	@Builder.Default
	@Column(nullable = false)
	private boolean userDocValid = true;


	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "userId")
	private Collection<AccountDocImgDtoEntity> attachments;

	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<CartEntity> carts;

}
