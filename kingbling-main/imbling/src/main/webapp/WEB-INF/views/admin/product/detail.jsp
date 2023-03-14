<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>

<jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />

<title>상품 상세</title>

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


					<h1 class="h3 mb-2 text-gray-800">상품</h1>
					<p class="mb-4">상품을 조회할 수 있는 페이지 입니다.</p>

					<div class="card shadow mb-4">

						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">${product.productName}
							</h6>
						</div>

						<div class="card-body">
							<div class="row">
								<div class="col-lg-3 col-md-3"></div>
								<div class="col-lg-6 col-md-9">
									<div class="tab-content">
										<div class="tab-pane active" id="tabs-1" role="tabpanel">
											<div class="product__details__pic__item">
												<img src="${product.productImage}"
													alt="${product.productImage}"
													style="width: 500px; height: 500px;">
											</div>
											<br> <br>

										</div>
									</div>
								</div>
							</div>
							<div class="row d-flex justify-content-center">
								<div id="productEdit">
									<a data-order-id=${  product.productNo  } id="productEdit_btn"
										class="btn btn-primary btn-icon-split editOrderInfo ">수정
									</a>
								</div>
								<div class="col-lg-8">

									<div class="form-group row">
										<div>
											<button class="btn btn-primary btn-user add-property"
												id="add-property0">상품카테고리</button>
										</div>
										<div>
											<h3 class="form-control form-control-user">${product.category.categoryName}</h3>
										</div>
									</div>
									<div class="form-group row">
										<div>
											<button class="btn btn-primary btn-user add-property"
												id="add-property0">상품명</button>
										</div>
										<div>
											<h3 class="form-control form-control-user">${product.productName}</h3>
										</div>
									</div>
									<div class="form-group row">
										<div>
											<button class="btn btn-primary btn-user add-property"
												id="add-property0">상품설명</button>
										</div>
										<div>
											<h3 class="form-control form-control-user">${product.productContent}</h3>
										</div>
									</div>
									<div class="form-group row">
										<div>
											<button class="btn btn-primary btn-user add-property"
												id="add-property0">상품사이즈</button>
										</div>
										<div>
											<h3 class="form-control form-control-user"> ${product.properties[0].productSize}</h3>
										</div>
									</div>
									<div class="form-group row">
										<div>
											<button class="btn btn-primary btn-user add-property"
												id="add-property0">상품색상</button>
										</div>
										<div>
											<h3 class="form-control form-control-user"> ${product.properties[0].productColor}</h3>
										</div>
									</div>
									<div class="form-group row">
										<div>
											<button class="btn btn-primary btn-user add-property"
												id="add-property0">상품가격</button>
										</div>
										<div>
											<h3 class="form-control form-control-user">${product.productPrice}</h3>
										</div>
									</div>
									<div class="form-group row">
										<div>
											<button class="btn btn-primary btn-user add-property"
												id="add-property0">상품재고</button>
										</div>
										<div>
											<h3 class="form-control form-control-user">${product.properties[0].productEA}</h3>
										</div>
									</div>
								</div>


							</div>
						</div>


					</div>
					<!-- /.container-fluid -->
					<!-- ****************************** 모달  ************************** -->

					<div class="modal fade" id="detailModal" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content" style="width: 800px">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">상품 수정</h5>

									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<form action="/admin/productEdit" method="post">
									<div class="modal-body">

										<div class="form-group">
											상품 번호 <input name="productNo" id="productNo" type="text" readonly>
										</div>
										<div class="form-group">
											상품명 <input name="productName" id="productName" type="text">
										</div>
										<div class="form-group">
											상품 사이즈 <input name="properties[0].productSize" id="productSize" type="text">
										</div>
										<div class="form-group">
											상품 색상 <input name="properties[0].productColor" id="productColor" type="text">
										</div>
										<div class="form-group">
											상품 카테고리 <input name="category.categoryName" id="categoryName" type="text">
										</div>
										<div class="form-group">
											상품 가격 <input name="productPrice"
												id="productPrice" type="text">
										</div>
										<div class="form-group">
											상품 재고 <input name="properteis[0].productEA"
												id="productEA" type="text">
										</div>
										<div class="form-group">
											상품 이미지
										</div>
										 <img name="productImage" id="productImage"  style="width:400px;height:300px">
										 <input name="category.categoryNo" id="categoryNo" type="hidden">
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">취소하기</button>
											<input id="submitBtn" type="submit" class="btn btn-primary"
												value=" 수정  ">

										</div>

									</div>
								</form>
							</div>
						</div>
					</div>
					<!-- ****************************** 모달  ************************** -->
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
									<div class="row">
										<div class="col-lg-12">
											<div class="product__pagination"></div>
										</div>
									</div>
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
	</div>
	<!-- End of Page Wrapper -->

	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>

	<script type="text/javascript">
		$(function() {
			
			 $('#productEdit_btn').on('click', function(event){

					var productNo = $(this).data('order-id');
					alert(productNo + "번 상품을 수정하시겠습니까?");
			 })
			
			$('#productEdit')
				.on( 'click', function(event) {
						var productNo = $(this).data('order-id');
						
						$('#detailModal').modal('show')
						$('#productNo').val(${product.productNo});
						 $('#productName').val("${product.productName}");
						$('#productSize').val("${product.properties[0].productSize}");
						$('#productColor').val("${product.properties[0].productColor}");
						$('#productEA').val("${product.properties[0].productEA}");
						
						$('#categoryNo').val("${categoryNo}");
						$('#categoryName').val("${product.category.categoryName}");
						$('#productPrice').val("${product.productPrice}");
						$('#productImage').attr("src","${product.productImage}");
						 
						
						
/* 						$.ajax({
							url : "/admin/detail",
							"method" : "post",
							"data" : 'productNo=' + productNo,
							"success" : function(data, status,
									xhr) {
								console.log(data);
	
								$('#productNo').val(data.productNo);
								$('#productName').val(data.productName);
								$('#productSize').val(data.orderPay);
								$('#orderDate').val(data.orderDate); */

								
			});
		});
	</script>
	<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp" />
</body>
</html>