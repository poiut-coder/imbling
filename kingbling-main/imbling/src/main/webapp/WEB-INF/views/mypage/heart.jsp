<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>나의 관심상품</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp" />
	<jsp:include page="/WEB-INF/views/modules/header.jsp" />
	<h2 style="text-align:center">관심상품 목록</h2>
	<!-- ****************************** 다자인 허전하니까 뭐 넣을거긴 함 ************************** -->
	<!-- ****************************** end ************************** -->

	<!-- ****************************** product list ************************** -->
	<section class="shop spad">
		<div class="container">
			<div class="row">
				<!-- product list by category -->
					<div id="heart-list" class="row"></div>
					<!--  end of product list by category -->
				
				<div class="col-lg-3">
				</div>
			</div>
		</div>
	</section>
	<!-- ****************************** end product list ************************** -->

	<!-- alert -->
	<div class="position-fixed bottom-0 right-0 p-3" style="z-index: 5; right: 0; top: 0;">
		<div id="heart-delete-alert" class="toast hide" role="alert"
			aria-live="assertive" aria-atomic="true" data-delay="3000" style="width: 1000px;">
			<div class="toast-header">
				<img src="/resources/dist/img/icon/notification.png" class="rounded mr-2"
					alt="..."> <strong class="mr-auto">NOTIFY</strong>
				<button type="button" class="ml-2 mb-1 close" data-dismiss="toast"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="toast-body" id="max-body">해당 상품을 관심상품에서 삭제했습니다.</div>
		</div>
	</div>
	<!-- end of alert -->

	<!-- ****************************** footer ************************** -->
	<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
	<!-- ****************************** end footer ************************** -->

	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
	<script type="text/javascript">
		$(function() {
			
			$('#heart-list').load("heart-list");
			
			// 상품명 또는 상품이미지 클릭시 상품상세페이지로 이동
			$('#heart-list').on('click', 'a.product-name', function(event) {
				var productNo = $(this).data('product-no');
				var categoryNo = $(this).data('category-no');

				location.href= "/product/detail?productNo=" + productNo + "&categoryNo=" + categoryNo;
			});
			
			$('#heart-list').on('click', 'div.product-image', function(event) {
				var productNo2 = $(this).data('product-no2');
				var categoryNo2 = $(this).data('category-no2');

				location.href= "/product/detail?productNo=" + productNo2 + "&categoryNo=" + categoryNo2;
			});
			
			$('#heart-list').on('click', 'img.delete-heart', function(event) {
				event.preventDefault();
				event.stopPropagation();
				
				var productNo = $(this).data('product-no3');
				
				$.ajax({
					url : '/delete-heart',
					type : 'get',
					data : 'productNo=' + productNo,
					success : function(result) {
						$('#heart-delete-alert').toast('show');
						$('#heart-list').load("heart-list");
					},
					error : function(request, status, error) {
						alert("관심상품 삭제 실패");
					}
 				})
			});
			
		});
	</script>


</body>
</html>