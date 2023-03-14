package com.imbling.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import com.imbling.dto.*;
import com.imbling.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.imbling.common.Util;

@Controller
public class MyPageController {

	@Autowired
	@Qualifier("mypageService")
	private MypageService mypageService;

	@Autowired
	@Qualifier("accountService")
	private AccountService accountService;

	@Autowired
	@Qualifier("accountDocService")
	private AccountDocService accountDocService;

	@Autowired
	@Qualifier("userOrderService")
	private UserOrderService userOrderService;

	@Autowired
	@Qualifier("reviewService")
	private ReviewService reviewService;

	@GetMapping(path = { "/mypage/myInfo", })
	public String showMyInfo(HttpSession session, String errM, Model model) {
		if (errM != null) {

			if (errM.contains("1")) {
				System.out.println("=showMyInfo============");

				model.addAttribute("errM", "서류의 식별이 필요한 유저입니다. 새로운 사진을 업로드 하거나 관리자의 승인을 기달려 주세요.");

			}else if (errM.contains("3")) {
				System.out.println("=showMyInfo============");

				model.addAttribute("errM", "빈칸이 있으면 안 됩니다.");

			}


		}
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");

		System.out.print(loginUser);

		if (loginUser == null) {
			return "/member/login";

		}
		ArrayList<AccountDocImgDto> attachments = new ArrayList<>();
		attachments.add(accountDocService.findByUserId(loginUser.getUserId()));

		model.addAttribute("attachments", attachments);
		return "mypage/myInfo";
	}

	@PostMapping(path = { "/mypage/edit", })
	public String editMyInfo(HttpSession session, AccountDto account,MultipartHttpServletRequest req) {
		MultipartFile attach = req.getFile("attach");

		
		
		
		if (attach != null) { // 내용이 있는 경우
			// 2. 데이터 처리
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/ocr/venv/account-attachments");
			String fileName = attach.getOriginalFilename(); // 파일 이름 가져오기
			if (fileName != null && fileName.length() > 0) {
				String uniqueFileName = Util.makeUniqueFileName(fileName);

				try {
					attach.transferTo(new File(path, uniqueFileName));// 파일 저장

					// 첨부파일 정보를 객체에 저장
					ArrayList<AccountDocImgDto> attachments = new ArrayList<>(); // 첨부파일 정보를 저장하는 DTO 객체

					AccountDocImgDto attachment = new AccountDocImgDto();
					attachment.setDocName(uniqueFileName);

					attachments.add(attachment);

					account.setAttachments(attachments);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		account.setUserType("needCheck");
		mypageService.modifyAccount(account);

		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		
		loginUser.setUserName(account.getUserName());
		loginUser.setUserAddress(account.getUserAddress());
		loginUser.setUserEmail(account.getUserEmail());
		loginUser.setUserPhone(account.getUserPhone());
		loginUser.setUserDocValid(account.isUserDocValid());
		loginUser.setUserType(account.getUserType());
		session.setAttribute("loginuser", loginUser);

		return "redirect:myInfo";
	}

	///////////////////////// 장바구니////////////////////////////////////////
	@GetMapping(path = { "/mypage/cart", })
	public String showCart(HttpSession session) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		mypageService.setCartInfoToUnChk(loginUser.getUserId());
		return "mypage/cart";
	}

	@GetMapping(path = { "/mypage/cartlist", })
	public String showCartlist(HttpSession session, Model model) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		List<CartDto> carts = mypageService.getCartInfo(loginUser.getUserId());
		int cartTotalPrice = 0;
		for (int i = 0; i < carts.size(); i++) {
			cartTotalPrice = cartTotalPrice + carts.get(i).getCartTotalPrice();
		}
		model.addAttribute("carts", carts);
		model.addAttribute("cartTotalPrice", cartTotalPrice);

		return "mypage/cartlist";
	}

	////////////////////////// 내 주문 내역//////////////////////////////////

	@GetMapping(path = { "/mypage/orderList", })
	public String showOrder(HttpSession session,@RequestParam(defaultValue="전체보기")String selectedValue,Model model) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
//		mypageService.setCartInfoToUnChk(loginUser.getUserId());
		List<OrderDto> orders = userOrderService.getUserOrderList(loginUser.getUserId(),selectedValue);
		model.addAttribute("selectedValue", selectedValue);
		model.addAttribute("orders", orders);
		return "mypage/orderList";
	}

	@GetMapping(path = { "/mypage/orderList-detail" })
	public String showOrderListDetail(int orderNo, @RequestParam(defaultValue = "-1")int reviewNo, Model model) {
		OrderDto order = userOrderService.getOrderInfo(orderNo);

		int orderTotalPrice = 0;
		for (int i = 0; i < order.getOrders().size(); i++) {
			orderTotalPrice = orderTotalPrice + order.getOrders().get(i).getOrderDetailTotalPrice();
		}

		model.addAttribute("order", order);
		model.addAttribute("orderTotalPrice", orderTotalPrice);

			return "mypage/orderList-detail";

	}

	////////////////////////// 내가 쓴 게시글////////////////////////////////////////////
	@GetMapping(path = { "/mypage/myboard", })
	public String showByboard(HttpSession session, Model model) {
		AccountDto loginUser = (AccountDto) session.getAttribute("loginuser");
		List<BoardDto> boards = mypageService.findMyInquery(loginUser.getUserId());
		List<ReviewDto> reviews = mypageService.findMyreview(loginUser.getUserId());
		model.addAttribute("boards", boards);
		model.addAttribute("reviews", reviews);
		return "mypage/myboard";
	}

	@GetMapping(path = { "/mypage/myboardInquery" })
	public String showByboardInquery(String userId, Model model) {
		List<BoardDto> boards = mypageService.findMyAllInquery(userId);
		model.addAttribute("boards", boards);
		model.addAttribute("sort", "inquery");

		return "mypage/myboard-see-more";
	}

	@GetMapping(path = { "/mypage/myboardReview" })
	public String showByboardReview(String userId, Model model) {
		List<ReviewDto> reviews = mypageService.findMyAllReview(userId);
		model.addAttribute("reviews", reviews);
		model.addAttribute("sort", "review");

		return "mypage/myboard-see-more";
	}

	///////////////////////////////////////////////////////////////////
	@PostMapping(path = { "/mypage/deleteIdModal" })
	@ResponseBody

	public String deleteIdModal(String userId, String userPassword, HttpSession session) {

		AccountDto loginUser = accountService.findByUserIdAndUserPassword(userId, userPassword);

		if (loginUser != null) {

			// ArrayList<AccountDocImgDto> attachments = new ArrayList<>(); // 첨부파일 정보를 저장하는
			// DTO 객체
//			AccountDocImgDto attachment = new AccountDocImgDto();
//			attachment.setDocName("deleteUser");
//			attachments.add(attachment);
			loginUser.setUserActiveState(true);
//			loginUser.setAttachments(attachments);
			System.out.println(loginUser);

			session.setAttribute("loginuser", null);

		} else {
			return "wrongIdOrPw"; // return "redirect:/home.action";

		}

		accountService.deleteMember(loginUser);
		session.setAttribute("loginuser", null);

		return "success";
	}

	// 관심상품 /////////////////////////////////////////////////////////////
	// 관심상품 리스트 조회
	@GetMapping(path = { "/mypage/heart" })
	public String showHeartList() {

		return "/mypage/heart";
	}

	@GetMapping(path = { "/mypage/heart-list" })
	public String showHeartList(HttpSession session, Model model, CategoryDto category) {
		AccountDto loginuser = (AccountDto) session.getAttribute("loginuser");
		List<HeartDto> hearts = mypageService.getHeartInfo(loginuser.getUserId());

		model.addAttribute("hearts", hearts);

		return "/mypage/heart-list";
	}

	// 관심상품 추가
	@PostMapping(path = { "/add-to-heart" })
	@ResponseBody
	public String addToHeart(HttpSession session, int productNo, CategoryDto categoryDto) {
		AccountDto loginuser = (AccountDto) session.getAttribute("loginuser");

		HeartDto heart = new HeartDto();
		heart.setUserId(loginuser.getUserId());
		heart.setProductNo(productNo);
		heart.setCategoryNo(categoryDto.getCategoryNo());

		mypageService.addProductToHeart(heart);

		return "success";
	}

	// 관심상품 삭제
	@GetMapping(path = { "/delete-heart" })
	@ResponseBody
	public String deleteFromHeart(int productNo, HttpSession session) {
		AccountDto loginuser = (AccountDto) session.getAttribute("loginuser");
		mypageService.deleteFromHeart(loginuser.getUserId(), productNo);

		return "success";
	}
}
