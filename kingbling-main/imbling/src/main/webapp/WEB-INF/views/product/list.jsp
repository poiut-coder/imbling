<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<jsp:include page="/WEB-INF/views/modules/common-meta.jsp" />
<!-- Css Styles ,font -->
<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<meta charset="UTF-8">
<title>상품리스트</title>
</head>
<style>
	input::-webkit-search-cancel-button {
		display: none;
	}
</style>
<body>
	<jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp" />
	<jsp:include page="/WEB-INF/views/modules/header.jsp" />
	<!-- ****************************** 다자인 허전하니까 뭐 넣을거긴 함 ************************** -->
	<!-- ****************************** end ************************** -->

	<!-- ****************************** product list ************************** -->
	<section class="shop spad">
	<input type="hidden" value="${loginuser.userId}" id="user-id" />
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<!-- ****************************** product sidebar ************************** -->
					<div class="shop__sidebar">
						<!-- search -->
						<div class="shop__sidebar__search">
							<form name="search-form" id="search-form">
								<input id="search-content" type="search" name="keyword" placeholder="Search...">
								<button type="button" id="search-btn">
									<span class="icon_search"></span>
								</button>
							</form>
						</div>
						<!-- end of search -->
						<div class="shop__sidebar__accordion">
							<div class="accordion" id="accordionExample">
								<div class="card">
									<div class="card-heading">
										<a data-toggle="collapse" data-target="#collapseOne">Categories</a>
									</div>
									<div id="collapseOne" class="collapse show"
										data-parent="#accordionExample">
										<div class="card-body">
											<div class="shop__sidebar__categories">
												<ul class="nice-scroll">
													<c:forEach var="category" items="${categories}">
														<li><a class="product-category"
																href="#"
															data-category-no="${category.categoryNo}">
																${category.categoryName}</a></li>
													</c:forEach>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- ****************************** end product sidebar ************************** -->

				<!-- ****************************** product-option ************************** -->
				<div class="col-lg-9">
					<!-- product category -->
					<div class="shop__product__option">
						<div class="row">
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="shop__product__option__left">
									<h4>상품목록</h4>
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="shop__product__option__right">
									<select id="sort-select">
										<option value="productCount">인기상품순</option>
										<%-- <option value="">판매량순</option> --%>
										<option value="reviewCountDesc">리뷰많은순</option>
										<option value="productRegdate">신상품순</option>
										<option value="productPriceAsc">낮은가격순</option>
										<option value="productPriceDesc">높은가격순</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<!--  end of product category -->

					<!-- product list by category -->
					<div id="product-list" class="row"></div>
					<!--  end of product list by category -->

					<!-- paging -->
					<div class="row">
						<%-- <div class="col-lg-12">
							<div class="product__pagination">
								<c:forEach var="product" items="page:${#numbers.sequence(startPage, endPage}">
									<c:if test="${page not eq nowPage }">
										<a href="/product/list?page=${page eq (page -1)}"></a>
									</c:if>
									<c:if test="${page eq nowPage}">
									</c:if>
								</c:forEach>
								<a class="active" href="#">1</a> <a href="#">2</a> <a href="#">3</a>
								<span>...</span> <a href="#">21</a>
							</div>
						</div>
					</div> --%>
					<!-- end of paging -->
				</div>
			</div>
		</div>
	</section>
	
	<!-- modal -->
	<div class="modal fade" id="heart-delete-modal" tabindex="-1" role="dialog"aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel" style="font-weight:bold;">해당 상품을 관심상품 목록에서 삭제하시겠습니까?</h5>
					<%-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button> --%>
				</div>
				<div class="modal-body">이미 관심상품 목록에 등록된 상품입니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">계속 쇼핑하기</button>
					<button id="delete-heart-detail" type="button" class="btn btn-primary">관심상품 해제</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="position-fixed bottom-0 right-0 p-3" style="z-index: 5; right: 0; top:0;">
		<div id="warning-alert" class="toast hide" role="alert"
			aria-live="assertive" aria-atomic="true" data-delay="3000" style="width:1000px;">
			<div class="toast-header">
				<img src="/resources/dist/img/icon/warning.png" class="rounded mr-2"
					alt="..."> <strong class="mr-auto">WARNING</strong>
				<button type="button" class="ml-2 mb-1 close" data-dismiss="toast"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="toast-body" id="warning-body"></div>
		</div>
	</div>
	
	<div class="position-fixed bottom-0 right-0 p-3" style="z-index: 5; right: 0; top: 0;">
		<div id="heart-alert" class="toast hide" role="alert"
			aria-live="assertive" aria-atomic="true" data-delay="3000" style="width: 1000px;">
			<div class="toast-header">
				<img src="/resources/dist/img/icon/notification.png" class="rounded mr-2"
					alt="..."> <strong class="mr-auto">NOTIFY</strong>
				<button type="button" class="ml-2 mb-1 close" data-dismiss="toast"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="toast-body" id="heart-body"></div>
		</div>
	</div>
	<!-- end of modal -->
	
	<!-- ****************************** end product list ************************** -->

	<!-- ****************************** footer ************************** -->
	<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
	<!-- ****************************** end footer ************************** -->

	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
	<script type="text/javascript">
		$(function() {
			
			let currentCategoryNo = ${ categoryNo == -1 ? categories[0].categoryNo : categoryNo };
			
			$('#product-list').load("product-list?categoryNo="+ ${ categoryNo == -1 ? categories[0].categoryNo : categoryNo });
			
			// 카테고리 클릭시 그 카테고리에 해당하는 상품리스트 조회 
			$('.product-category').on('click', function(event) {
				event.preventDefault();
				event.stopPropagation();
				
				var categoryNo = $(this).data('category-no');
				currentCategoryNo = categoryNo;
				
				$('#sort-select option[value]').attr('selected', false);
				$('#sort-select option[value=productCount]').attr('selected', true);
				
				$.ajax({
					"url" : "product-list",
					"method" : "get",
					"data" : "categoryNo=" + categoryNo,
					"success" : function(data, status, xhr) {
						$('#product-list').load("product-list?categoryNo="+ categoryNo);
					},
					"error" : function(data, status, err) {
						alert('error');
					}
				})
			});

			$('#product-list').on('click', 'img.heart-btn', function(event) {
				
				event.preventDefault();
				event.stopPropagation();
				
				var productNo = $(this).data('product-no3');
				var categoryNo = $(this).data('category-no3');
				var productName = $('#product-name').val();
				var productPrice = $('#product-price').val();
				var productImage = $('#product-image').val();
				
				// $('.heart-btn[data-product-no3=' + productNo + ']').attr( "src", "/resources/dist/img/icon/full-heart.png");
				
				$.ajax({
					url : '/add-to-heart',
				    type : 'post',
				    dataType : 'text',       // 반환 데이터 타입 (html, xml, json, text 등등)
				    data : {"productNo":productNo,"categoryNo":categoryNo,"productName":productName,"productImage":productImage,"productPrice":productPrice},
				    success : function(result) { // 결과 성공 콜백함수
				    	$('.heart-btn[data-product-no3=' + productNo + ']').attr( "src", "/resources/dist/img/icon/full-heart.png");
				    	$('#heart-alert').toast('show');
				    	$('#heart-body').html("해당 상품을 관심상품 목록에 등록했습니다.");
				    },
				    error : function(request, status, error) { // 결과 에러 콜백함수
				    	var loginuser = $('#user-id').val();
				    	
				    	if (loginuser == null) {
				    		$("#warning-alert").toast('show');
							$('#warning-body').html("로그인이 필요한 서비스입니다.");
				    	} else {
				    		$('#heart-delete-modal').modal();
				    		$('#delete-heart-detail').on('click', function(event) {
				    			$('#heart-delete-modal').modal('hide');
				    			
				    			$.ajax({
									url : '/delete-heart',
									type : 'get',
									data : 'productNo=' + productNo,
									success : function(result) {
										$('#heart-alert').toast('show');
										$('#heart-body').html("해당 상품을 관심상품 목록에서 삭제했습니다.");
										$('.heart-btn[data-product-no3=' + productNo + ']').attr( "src", "/resources/dist/img/icon/empty-heart.png");
									},
									error : function(request, status, error) {
										$("#warning-alert").toast('show');
										$('#warning-body').html("관심상품 삭제 실패");
									}
				 				})
				    		});
				    	} 
				    }
				})
			});
			
			// 상품명 또는 상품이미지 클릭시 상품상세페이지로 이동
			$('#product-list').on('click', 'a.product-name', function(event) {
				var productNo = $(this).data('product-no');
				var categoryNo = $(this).data('category-no');

				location.href = "/product/detail?productNo=" + productNo + "&categoryNo=" + categoryNo;
			});
			
			$('#product-list').on('click', 'div.product-image', function(event) {
				var productNo2 = $(this).data('product-no2');
				var categoryNo2 = $(this).data('category-no2');

				location.href = "/product/detail?productNo=" + productNo2 + "&categoryNo=" + categoryNo2;
			});
			
			// 정렬 옵션 클릭시 해당하는 기준으로 상품리스트 정렬 
			$("#sort-select").on('change', function(event) {
				option = $(this).find("option:selected");
				const sort = option.attr('value');
				
				//const categoryNo = ${ categoryNo == -1 ? categories[0].categoryNo : categoryNo };

				$('#product-list').load("product-list?categoryNo="+ currentCategoryNo + "&sort=" + sort);
				
			});
			
			// 검색
			// 검색 함수 
			function searchProductName() {
				
				const searchValue = $('input[name=keyword]').val();
				if (searchValue.length == 0) {
					$('#warning-alert').toast('show');
					$('#warning-body').html("검색어를 입력하세요.");
					return;
				}
				
				// const formData = $('form[name=search-form]').serialize();
				const searchContent = $('#search-content').val();
				// const cn = ${ categoryNo == -1 ? categories[0].categoryNo : categoryNo };
				$('#product-list').load("/product/search?keyword=" + searchContent + "&categoryNo=" + currentCategoryNo);
				
				/* $.ajax({
					"url" : "/product/search",
					"method" : "get",
					"data" : formData,
					"success" : function(result) {
						if(result.length >= 1) {
							$('#product-list').empty(); // 테이블 초기화
							result.forEach(function(item) {
								var str = "<div class='col-lg-4 col-md-6 col-sm-6'>";
								str += "<div class='product__item'>";
								str += "<div class='product__item__pic set-bg product-image' data-product-no2='" + item.productNo + "' data-category-no2='" + item.category.categoryNo + "' style='background-image:url(" + item.productImage + ")'>";
								str += "<ul class='product__hover'>";
								str += "<li><img src='/resources/dist/img/icon/empty-heart.png' class='heart-btn' data-product-no3='" + item.productNo + "' data-category-no3='" + item.categoryNo + "'></li>"
								str += "</ul>";
								str += "</div>";
								str += "<input type='hidden' value='" + item.productImage + "' id='product-image'/>";
								str += "<div class='product__item__text'>"
								str += "<h6>" + item.productName + "</h6>";
								str += "<input type='hidden' value='" + item.productName + "' id='product-name'/>";
								str += "<a class='add-cart product-name' data-product-no='" + item.productNo + "' data-category-no='" + item.categoryNo + "'>+ 상세페이지 보기</a>"
								str += "<h5 class='product-price'>₩" + item.productPrice.toLocaleString("ko-KR") + "</h5>";
								str += "<input type='hidden' value='" + item.productPrice + "' id='product-price'/>";
								str += "</div>";
								str += "</div>"; 
								str += "</div>";
								str += "</div>"; 
							
								$('#product-list').append(str);
							});
						} else {
							alert("일치하는 상품이 없습니다.");
						}
					},
					"error" : function(err) {
						alert("검색에 실패했습니다.");
					}
				}) */
			
			}
			
			// enter시 검색
			$('#search-content').on('keypress', function(event) {
				if (event.keyCode == '13') {
					if(window.event) {
						event.preventDefault();
						searchProductName();
					} else {
						alert("검색에 실패했습니다. 2");
					}
				}
			});
			
			// 서치아이콘 클릭시 검색
			$('#search-form').on('click', '#search-btn', function(event) {
				event.preventDefault();
				searchProductName();
			});
			
		});
	</script>


</body>
</html>