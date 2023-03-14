<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>

<jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />

<title>상품 목록</title>

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!--  product sidebar  -->
		<jsp:include page="/WEB-INF/views/modules/admin/admin-sidebar.jsp" />
		<!--  end product sidebar  -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<jsp:include page="/WEB-INF/views/modules/admin/admin-topbar.jsp" />



				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->


					<h1 class="h3 mb-2 text-gray-800">상품 목록</h1>
					<p class="mb-4">전체 상품 목록을 조회할 수 있는 페이지 입니다.</p>
					<!-- 상품 분류 -->
<!-- 					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">상품 분류</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" style="magin: 20px;">
									<thead>
										<tr>
											<th width="10%">상품분류</th>
											<td>
												<div>
													<select id="selectedValue" class="custom-select" size="3">
														<option class="option" value="0">전체보기</option>
														<option class="option" value="1643">발찌</option>
														<option class="option" value="1641">귀걸이</option>
														<option class="option" value="1642">목걸이</option>
														<option class="option" value="1643">반지</option>
														<option class="option" value="1644">팔찌</option>
													</select>
												</div> 	</td>
										</tr>
										<tr>
											<th>상품재고</th>
											<td></td>
										</tr>
										<tr>
											<th>등록일자</th>
											<td></td>
										</tr>
										<tr></tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
 -->					<br>
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">상품 목록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>check</th>
											<th>상품코드</th>
											<th>상품이미지</th>
											<th>상품명</th>
											<th>상품가격</th>
											<th>재고</th>
											<th>구분</th>
											<th>색상</th>
											<th>사이즈</th>
											<th>등록일자</th>
											<th>기능(수정, 삭제, 품절)</th>
										</tr>
									</thead>
									<tbody id="product-list">

										<c:forEach var="product" items="${products}">
											<c:forEach var="property" items="${product.properties}">
												<tr data-productno="${product.productNo}" style="opercity:0.5%;">
													<!-- 체크박스 -->
													<td></td>
													<!-- 상품코드 -->
													<td class="product__item"><h6>${product.productNo}</h6></td>
													<!-- 상품이미지 -->
													<td
														style="background-size: cover; word-break: break-all; table-layout: fixed;"
														width=50px height=50px><img
														src="${product.productImage}"
														alt="${product.productImage}"
														style="width: 150px; height: 150px"></td>
													<!-- 상품명 -->
													<td class="product__item__text" data-product-no="${product.productNo}" data-category-no="${product.category.categoryNo}" style="padding: 20px">
														<h6>${product.productName}</h6>
													</td>
													<!-- 상품가격 -->
													<td><fmt:formatNumber value="${product.productPrice}"
															pattern="₩#,###" /></td>
													<!-- 재고 -->
													<c:choose>
													<c:when test="${property.productEA < 6}">
													<td><h6 style= color:red;>${property.productEA}</h6></td>
													</c:when>
													<c:otherwise> <td><h6>${property.productEA}</h6></td></c:otherwise>
													</c:choose>
													<!-- 구분 -->
													<td><h6>${product.category.categoryName}</h6></td>
													<!-- 색상 -->
													<td><h6>${property.productColor}</h6></td>
													<!-- 사이즈 -->
													<td><h6>${property.productSize}</h6></td>
													<!-- 등록일자 -->
													<td><fmt:formatDate
															value="${ product.productRegdate }" type="both"
															dateStyle="full" timeStyle="short" /></td>
													<!-- 기능 -->
													<td><button>수정</button>
														<button class="delete_product_button"
															data-productno="${product.productNo}">삭제</button></td>
												</tr>

											</c:forEach>
										</c:forEach>

									</tbody>
								</table>
							</div>
					</div>
				</div>
				<!-- /.container-fluid -->

				<section class="shop spad">
					<div class="row ">
						<div class="col-lg-12">



							<!-- ****************************** product-option ************************** -->
							<div class="col-lg-9">
								<!-- product category -->
								<div class="shop__product__option">
									<div class="row">
										<div class="col-lg-6 col-md-6 col-sm-6">
											<div class="shop__product__option__left">
												<p>Showing 1–12 of 126 results</p>
											</div>
										</div>
										<div class="col-lg-6 col-md-6 col-sm-6">
											<div class="shop__product__option__right"></div>
										</div>
									</div>
								</div>
								<!-- 								 end of product category -->

								<!-- 								product list by category -->
								<div id="product-list" class="row"></div>
								<!--  								 end of product list by category -->

								<!-- 								paging -->
								<!-- end of paging -->
							</div>
						</div>
					</div>
				</section>
				<!-- ****************************** end product list ************************** -->
			</div>
			<!-- End of Main Content -->
			

		</div>
		<!-- End of Main Content -->
		<!-- Footer -->
		<footer class="sticky-footer bg-white">
			<div class="container my-auto">
				<div class="copyright text-center my-auto">
					<span>Copyright &copy; Your Website 2020</span>
				</div>
			</div>
		</footer>
		<!-- End of Footer -->
		
	</div>
	<!-- End of Page Wrapper -->
		</div>
	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
	<script type="text/javascript">
		$(function() {

			/* 		 $('#product-list').load("product-list?categoryNo="+ ${categories[0].categoryNo}); */

			// 상품삭제 
			$('.delete_product_button').on('click', function(event) {
				const productNo = $(this).data("productno");

				const ok = confirm(productNo + " 번 상품을 삭제할까요?");
				if (!ok)
					return;

				// location.href = '${product.productNo}/delete.action?';
				$.ajax({
					"url" : "/admin/delete-product",
					"method" : "get",
					"data" : "productNo=" + productNo,
					"success" : function(result, status, xhr) {
						console.log(result);
						$('tr[data-productno=' + productNo + ']').remove(); 
					},
					"error" : function(xhr, status, err) {
						alert('error');
					}
				});
			});
			
			// 상품명 또는 상품이미지 클릭시 상품상세페이지로 이동
			$('#product-list').on('click', 'td.product__item__text', function(event) {
				var productNo = $(this).data('product-no');
				var categoryNo = $(this).data('category-no');

				location.href = "/admin/product/detail?productNo=" + productNo + "&categoryNo=" + categoryNo;
			});

			/* 		 // 상품명 또는 상품이미지 클릭시 상품상세페이지로 이동
			 $('#product-list').on('click', 'a.product-name', function(event) {
			 var productNo = $(this).data('product-no');
			 var categoryNo = $(this).data('category-no');

			 location.href= "/product/detail?productNo=" + productNo + "&categoryNo=" + categoryNo;
			 });  */
			$('.custom-select .option').on("click", function(event) {
				var selectedValue = $(this).data("value");
				alert(selectedValue)

				 location.href = "/admin/searchedlist?selectedValue="
						+ selectedValue; 
			});

		});
	</script>
	<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp" />
</body>
</html>