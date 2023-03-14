<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>

<jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />

<title>Order List</title>

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<jsp:include page="/WEB-INF/views/modules/admin/admin-sidebar.jsp" />

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">

				<jsp:include page="/WEB-INF/views/modules/admin/admin-topbar.jsp" />

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">주문 내역을 확인하세요.</h1>
					<p class="mb-4">전체 주문 내역을 조회할 수 있는 페이지 입니다.</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">주문 내역 목록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>주문 번호</th>
											<th>주문 상태</th>
											<th>주문 날짜</th>
											<th>주문 요청 사항</th>
											<th>주문 결제 방법</th>
											<th>주문 사용자</th>
											<th>주문 주소</th>
											<th>주문 정보 수정</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach var="order" items="${ orders }">

											<tr>
												<td>${ order.orderNo }</td>
												<td>${ order.orderState }</td>
												<td>
												<fmt:formatDate value="${ order.orderDate }" type="both" dateStyle="full" timeStyle="short" />
												</td>
												<td>${ order.orderDeliveryRequire }</td>
												<td>${ order.orderPay }</td>
												<td>${ order.userId }</td>
												<td>${ order.orderAddr }${ order.orderAddr2 }</td>
												<td><a style="width: 100%"
													data-order-id=${  order.orderNo  }
													class="btn btn-primary btn-icon-split editOrderInfo ">수정
												</a></td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
						</div>
					</div>


				</div>
				<!-- /.container-fluid -->

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
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- ****************************** 모달  ************************** -->

	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content" style="width: 800px">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">주문 수정</h5>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="/admin/orderEdit" method="post">
					<div class="modal-body">

						<div class="form-group">
							주문 번호 <input name="orderNo" id="orderNo" type="text" readonly>
						</div>
						<div class="form-group">
							주문 사용자 <input name="userId" id="userId" type="text">
						</div>
						<div class="form-group">
							주문 방법 <input name="orderPay" id="orderPay" type="text">
						</div>
						<div class="form-group">
							주문 날짜 <input name="orderDate" id="orderDate" type="text">
						</div>
						<div class="form-group">
							주문 요청 사항 <input name="orderDeliveryRequire" id="orderDeliveryRequire" type="text">
						</div>
						<div class="form-group">
							주문 주소 <input name="orderAddr" id="orderAddr" type="text">
						</div>
						<div class="form-group">
							주문 상태 
							<select name="orderState" id="orderState">
								<option value="주문완료">주문완료</option>
								<option value="배송중">배송중</option>
								<option value="배송완료">배송완료</option>
								<option value="구매확정">구매확정</option>
							</select>
						</div>
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">주문 상품 목록</h6>
							</div>
							<div class="card-body">

								<div class="table-responsive">
									<table class="table table-bordered dataTableModal"
										id="dataTableModal" width="100%" cellspacing="0">
										<thead>
											<tr>
												<th>제품 이름</th>
												<th>주문 색상</th>
												<th>주문 사이즈</th>
												<th>주문 수량</th>
												<th>주문 총 액</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>s</td>
												<td>s</td>
												<td>s</td>
												<td>s</td>
												<td>s</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
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

	<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp" />

	<script type="text/javascript">
		$(function() {
			$('#dataTable')
					.on( 'click', '.editOrderInfo', function(event) {
								var orderNo = $(this).data('order-id');
								$('#detailModal').modal('show')
								
								$.ajax({
									//type : "POST",
									url : "/admin/orderDetail",
									"method" : "post",
									"data" : 'orderNo=' + orderNo,
									"success" : function(data, status,
											xhr) {
										console.log(data);

										const tableData = [];
										for (var i = 0; i < data.orders.length; i++) {
											const orderDetail = data.orders[i];
											tableData.push([
												orderDetail.productName,
												orderDetail.propertyDto.productColor,
												orderDetail.propertyDto.productSize,
												orderDetail.orderDetailEA,
												orderDetail.orderDetailTotalPrice ]);
										}

										$('#orderNo').val(data.orderNo);
										$('#userId').val(data.userId);
										$('#orderPay').val(data.orderPay);
										$('#orderDate').val(data.orderDate);
										var ard=" ";
										var delReq="없음 ";
										if( data.orderAddr2!=null){
											ard=data.orderAddr2
										}
										if( data.orderDeliveryRequire!=null){
											delReq=data.orderAddr2
										}	
										$('#orderDeliveryRequire').val(delReq);

										$('#orderAddr').val(data.orderAddr+" "+ard);
										
										
										
										$('.dataTableModal').DataTable(
												{
													paging : false,
													searching : false,
													destroy : true,

													data : tableData

												})

									},
									"error" : function(xhr, status, err) {

									}
								});
							});
		})
	</script>
</body>

</html>