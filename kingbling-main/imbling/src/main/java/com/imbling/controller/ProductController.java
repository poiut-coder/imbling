package com.imbling.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.imbling.dto.AccountDto;
import com.imbling.dto.BoardDto;
import com.imbling.dto.CategoryDto;
import com.imbling.dto.HeartDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.dto.ReviewDto;
import com.imbling.service.BoardService;
import com.imbling.service.MypageService;
import com.imbling.service.ProductService;
import com.imbling.service.ReviewService;
import com.imbling.service.UserOrderService;

@Controller
@RequestMapping (path = { "/product" })
public class ProductController {

	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@Autowired
	@Qualifier("mypageService")
	private MypageService mypageService;

	@Autowired
	@Qualifier("reviewService")
	private ReviewService reviewService;

	@Autowired
	@Qualifier("boardService")
	private BoardService boardService;
	
	@Autowired
	@Qualifier("userOrderService")
	private UserOrderService userOrderService;
	
	// 상품리스트
	@GetMapping(path = { "/list" })
	public String productList(ProductDto productDto, @RequestParam(defaultValue = "-1") int categoryNo, Model model) {
		
		List<CategoryDto> categories = productService.findAllCategories();;
		model.addAttribute("categories", categories);
		model.addAttribute("categoryNo", categoryNo);
		
		return "product/list";
	}
	
	// 카테고리별 상품리스트 조회 
	@GetMapping(path= {"/product-list"})
	public String showProductListByCategory(CategoryDto categoryDto,
											@RequestParam(defaultValue = "productCountDesc") String sort,
											Model model, HttpSession session) {
		
		boolean asc = true;
		if (sort.equals("productRegdate")) {
			asc = false;
		} else if (sort.equals("productPriceDesc")) {
			asc = false;
			sort = "productPriceDesc";
		}
		
		List<ProductDto> products = productService.findProductListByCategory2(sort, asc, categoryDto.getCategoryNo());	
		model.addAttribute("products", products);
		model.addAttribute("categoryNo", categoryDto.getCategoryNo());
		
		// 관심상품 내에 있는 상품번호 목록
		AccountDto loginuser = (AccountDto) session.getAttribute("loginuser");
		List<HeartDto> hearts = mypageService.getHeartInfo(loginuser.getUserId());
		List<Integer> heart = new ArrayList<>();
		for (HeartDto h : hearts) {
			heart.add(h.getProductNo());
		}
		model.addAttribute("hearts", heart);
		
		return "product/product-list";
	}
	
	// 상품상세페이지 
	@GetMapping(path = { "/detail" })
	public String showDetail(int categoryNo, int productNo, ReviewDto review, Model model, HttpSession session) {
		
		// 상품게시글 조회수 증가
		ArrayList<Integer> productList = (ArrayList<Integer>) session.getAttribute("product-list");
		if (productList == null) {	// 세션에 목록이 없으면 
			productList = new ArrayList<>();	// 목록 새로 만들기 
			session.setAttribute("product-list", productList);	// 세션에 목록 등록 
		}
		if (!productList.contains(productNo)) {	// 현재 상품번호가 읽은 상품목록에 포함되지 않은 경우 
			productService.increaseProductReadCount(productNo);	// 상품게시글 조회수 증가 
			productList.add(productNo);	// 읽은 상품 목록에 현재 상품번호 추가 
		}
		
		ProductDto product = productService.showProductDetail(productNo);
		model.addAttribute("product", product);
		model.addAttribute("categoryNo", categoryNo);

		//리뷰 리스트 추가
		List<ReviewDto> reviews = reviewService.findReviewsByProductNo(productNo);
		model.addAttribute("reviews", reviews);
		model.addAttribute("productNo", productNo);


		List<BoardDto> boards = boardService.findModalBoardByProductNo(productNo);
		model.addAttribute("boards", boards);

		
		// 관심상품 내에 있는 상품번호 목록
		AccountDto loginuser = (AccountDto) session.getAttribute("loginuser");
		List<HeartDto> hearts = mypageService.getHeartInfo(loginuser.getUserId());
		List<Integer> heart = new ArrayList<>();
		for (HeartDto h : hearts) {
			heart.add(h.getProductNo());
		}
		model.addAttribute("hearts", heart);
		
		return "product/detail";
	}

	//======================상품목록에서 1:1문의==========================

	@PostMapping(path={"/detail"})
	public String writeProductModal(BoardDto board, CategoryDto category, ProductDto product, int  productNo, Model model){

		boardService.writeProductBoard(board, product,category);
		model.addAttribute("categoryNo", category.getCategoryNo());

//		return "product/detail?productNo="+board.getProductDto().getProductNo() + "categoryNo="+category.getCategoryNo();
		return "redirect:/product/detail?productNo="+ product.getProductNo() + "&categoryNo="+category.getCategoryNo();

	}
	
	// 검색
	@GetMapping("/search")
	public String showSearchList(String keyword, CategoryDto categoryDto, HttpSession session, Model model) {
		List<ProductDto> productList = productService.searchProduct(keyword);
		model.addAttribute("products", productList);
		model.addAttribute("categoryNo", categoryDto.getCategoryNo());
		
		AccountDto loginuser = (AccountDto) session.getAttribute("loginuser");
		List<HeartDto> hearts = mypageService.getHeartInfo(loginuser.getUserId());
		List<Integer> heart = new ArrayList<>();
		for (HeartDto h : hearts) {
			heart.add(h.getProductNo());
		}
		model.addAttribute("hearts", heart);
		
		return "product/product-list";
	}
	
	@PostMapping("/getPropertyInfo")
	@ResponseBody
	public int getPropertyInfo(int propertyNo) {
		int propertyEA = productService.getProductEAByPropertyNo(propertyNo);
		return propertyEA;
	}
	
}

