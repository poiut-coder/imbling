package com.imbling.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.imbling.common.Util;
import com.imbling.dto.AdminProductDto;
import com.imbling.dto.CategoryDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.service.AdminProductService;
import com.imbling.service.ProductService;

@Controller @RequestMapping(path="/admin")
public class AdminProductController {

	@Autowired
	@Qualifier("adminProductService")
	private AdminProductService adminProductService;
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	

	// 상품리스트
	@GetMapping(path= {"list"})
	public String showAdminProductList(AdminProductDto adminProductDto , Model model) {
			
			int productNo = adminProductDto.getAdminProductNo();
			
			Collection<ProductDto> products = adminProductService.findAdminProductListByCategory2(productNo);
			model.addAttribute("products", products);

			model.addAttribute("productNo", productNo);
			System.out.println(products);
		return "admin/product/list";
	}

	// 상품삭제
	@GetMapping(path = { "/{productNo}/delete" })
	public String deleteAdminProduct1å(@PathVariable("productNo")int productNo) {
		adminProductService.deleteAdminProduct(productNo);

		return "redirect:list";
	}
	
	// 상품삭제
	@GetMapping(path = { "/delete-product" })
	@ResponseBody
	public String deleteAdminProduct(int productNo) {
		adminProductService.deleteAdminProduct(productNo);

		return "success";
	}
	
	//상품 등록 페이지 보여주기
	@GetMapping(path = {"/detail"})
	public String showAddProduct(@RequestParam(defaultValue = "1") int categoryNo, Model model){

		model.addAttribute("categoryNo", categoryNo);
		return "admin/product/addProduct";
	}
	
	//상품 상세 작성 페이지 보여주기
	@GetMapping(path = {"/product/detail"})
	public String showAdminProductDetail(int categoryNo, int productNo, Model model) {
		
		ProductDto product = productService.showProductDetail(productNo);
		model.addAttribute("product", product);
		model.addAttribute("categoryNo", categoryNo);
		return "admin/product/detail";
	}
	//상품 상세 작성 페이지 보여주기(Modal...)
	@PostMapping(path = {"/product/detail"})
	@ResponseBody
	public String showAdminProductDetail2(int productNo) {
		return "redirect:detail";		
	}

	// 상품 수정(Modal)
	@PostMapping(path= {"productEdit"})
	public String productEdit(ProductDto product ) {
		System.out.println("productEdit" +product);
		ProductDto productbefore=new ProductDto();
		productbefore=productService.findByProductNo(product.getProductNo());
		productbefore.setProductNo(product.getProductNo());	// 상품번호 
		productbefore.setProductName(product.getProductName()); // 상품명
		productbefore.setProperties(product.getProperties());// 상품 사이즈, 상품 색상
		productbefore.setCategory(product.getCategory());
		for(int i=0;i<product.getProperties().size();i++) {
			if(product.getProperties().get(0).getPropertyNo()==productbefore.getProperties().get(i).getPropertyNo()) {
				productbefore.getProperties().set(0, product.getProperties().get(0));
			}
		}
		productbefore.setProperties(product.getProperties());
		productbefore.setProductPrice(product.getProductPrice());// 상품가격
		System.out.println("productbefore" +productbefore);

		productService.modeifyProduct(productbefore);
		
		return "redirect:product/detail?categoryNo="+product.getCategory().getCategoryNo()+"&productNo="+product.getProductNo();

	}

	@RequestMapping(path = { "/productRegister" })
	public String addNewProduct(AdminProductDto product, int categoryNo, String[] colors, String[] sizes,
			MultipartHttpServletRequest req,RedirectAttributes rttr) {
		System.out.println(colors);
		System.out.println(sizes);
		List<PropertyDto> property = new ArrayList<>();
		for(int i=0;i<colors.length;i++) {
			PropertyDto p = new PropertyDto();
			p.setProductColor(colors[i]);
			p.setProductSize(sizes[i]);
			property.add(p);
		}
		
		MultipartFile productImage = req.getFile("productAttach");

		if (productImage != null) {
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/product-attachments");
			String fileName = productImage.getOriginalFilename();
			if (fileName != null && fileName.length() > 0) {
				String uniqueFileName = Util.makeUniqueFileName(fileName);
				try {
					productImage.transferTo(new File(path, uniqueFileName));
					product.setAdminProductImage("/product-attachments/"+uniqueFileName);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		adminProductService.addNewProduct(product,property,categoryNo);
		return "redirect:/admin/detail?categoryNo="+categoryNo;
	}


}
