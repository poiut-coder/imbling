package com.imbling.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.imbling.dto.CategoryDto;
import com.imbling.dto.ProductDto;
import com.imbling.dto.PropertyDto;
import com.imbling.service.ProductService;

@Controller
public class ApiController {
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@GetMapping(path = { "/setup-category" })
	@ResponseBody
	public String setupCategory() {
		
		String[] categorieNames = {"귀걸이", "목걸이", "반지", "팔찌", "발찌" };
		for (String categoryName : categorieNames) {
			CategoryDto category = new CategoryDto();
			category.setCategoryName(categoryName);
			productService.saveCategoryInfo(category);
		}
		
		return "success";
	}
	
	@GetMapping(path= {"/search-product-info"})
	@ResponseBody
	public String searchProductInfo() {

		//String[] categories = {"귀걸이", "목걸이", "반지", "팔찌", "발찌" };
		List<CategoryDto> categories = productService.findAllCategories();
		for (CategoryDto category : categories) {
			makeDataFromOpenApi(category);
		}
		
		return "success";
	}
	
	private void makeDataFromOpenApi(CategoryDto category) {
		String clientId = "gFP5AKvLYgBMYpgYeL_y"; //애플리케이션 클라이언트 아이디
        String clientSecret = "bydFd_tWVZ"; //애플리케이션 클라이언트 시크릿

        String text = null;
        try {
            text = URLEncoder.encode(category.getCategoryName(), "UTF-8");
        } catch (UnsupportedEncodingException e) {
        	e.printStackTrace();
        }
        
        String apiURL = "https://openapi.naver.com/v1/search/shop.xml?query="+ text; // XML 결과
        apiURL += "&display=60";

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        
        try {
        	HttpURLConnection con = connect(apiURL);
        	con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode(); // 요청 전송 + 응답 수신
            
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                InputStream is = con.getInputStream();
                
                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                DocumentBuilder parser = factory.newDocumentBuilder(); // xml parser
                Document doc = parser.parse(is); // xml string -> object tree
                            
                NodeList items = doc.getElementsByTagName("item"); // <item>...</item>을 모두 찾아서 반환
                
                for (int i = 0; i < items.getLength(); i++) {
                	Node item = items.item(i);
                	NodeList children = item.getChildNodes();
                	ProductDto product = new ProductDto();	// 상품 한 저장 변수
                	
                	for (int j = 0; j < children.getLength(); j++) {
                		Node child = children.item(j);
                		
                		if (child.getNodeName().equals("title")) {
                			product.setProductName(child.getTextContent().replaceAll("<b>", "").replaceAll("</b>", ""));
                		}
                		if (child.getNodeName().equals("image")) {
                			product.setProductImage(child.getTextContent());
                		}
                		if (child.getNodeName().equals("lprice")) {
                			product.setProductPrice(Integer.parseInt(child.getTextContent()));
                		}
                	}
                	product.setCategory(category);
                	
                	PropertyDto property = new PropertyDto();
                	property.setProductColor("단일색상");
                	property.setProductSize("FREE");
                	property.setProductEA(20);
                	ArrayList<PropertyDto> properties = new ArrayList<>();
                	properties.add(property);
                	product.setProperties(properties);
                	
                	productService.saveProductInfo(product);
                }
                
            } else { // 오류 발생
            	System.out.println("error");
            }
        } catch (Exception ex) {
        	ex.printStackTrace();
        }
	}
	
	private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
    
}
