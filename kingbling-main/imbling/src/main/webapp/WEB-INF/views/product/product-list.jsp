<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach var="product" items="${products}">
	<div class="col-lg-4 col-md-6 col-sm-6">
		<div class="product__item">
			<div class="product__item__pic set-bg product-image" data-product-no2="${product.productNo}" data-category-no2="${ categoryNo }"
			style="background-image:url('${product.productImage}')">
			<ul class="product__hover">
				<c:set var="isChecked" value="false" />
				<c:forEach var="productNo" items="${ hearts }">	
					<c:if test="${ productNo == product.productNo }">
					<c:set var="isChecked" value="true" />
					</c:if>
				</c:forEach>
				<c:choose>
					<c:when test="${isChecked}">
						<li><img src="/resources/dist/img/icon/full-heart.png" class="heart-btn" data-product-no3="${product.productNo}" data-category-no3="${ categoryNo }"></li>
					</c:when>
					<c:otherwise>
						<li><img src="/resources/dist/img/icon/empty-heart.png" class="heart-btn" data-product-no3="${product.productNo}" data-category-no3="${ categoryNo }"></li>
					</c:otherwise>
				</c:choose>
			</ul>
			</div>
			<input type="hidden" value="${product.productImage}" id="product-image"/>
			<div class="product__item__text">
				<h6>${product.productName}</h6>
				<input type="hidden" value="${product.productName}" id="product-name"/>
				<a class="add-cart product-name" data-product-no="${product.productNo}" data-category-no="${ categoryNo }">+ 상세페이지 보기</a>
				<h5>
					<fmt:formatNumber value="${product.productPrice}" pattern="₩#,###" />
					<input type="hidden" value="${product.productPrice}" id="product-price"/>
				</h5>
				<%-- <span class="add-cart" style="color:lightgray;">${product.productRegdate} <i class="fa-solid fa-person"></i> ${product.productCount}</span> --%><!-- 테스트 용도 추후 상의후 수정 예정 -->
			</div>
		</div>
	</div>
</c:forEach>