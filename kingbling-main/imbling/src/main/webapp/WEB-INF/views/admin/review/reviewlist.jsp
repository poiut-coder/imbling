<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>

<jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />

<title>User List</title>

</head>
<style>
.btn-icon-split {
	width: 100px
}
</style>
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
					<h1 class="h3 mb-2 text-gray-800">리뷰 관리</h1>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">리뷰 목록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>리뷰 번호</th>
											<th>상품명</th>
											<th>제목</th>
											<th>별점</th>
											<th>작성자</th>
											<th>조회수</th>
											<th>작성일자</th>
											<th>삭제 여부</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="review" items="${reviews}">
											<tr>
												<td>
													${ review.reviewNo }
												</td> 
												<td>
													${review.productDto.productName}
												</td>
												<td><a href="reviewDetail?reviewNo=${review.reviewNo}">${review.reviewTitle}</a></td>


												<c:choose>
													<c:when test="${review.reviewStar == 5}">
														<td>⭐️⭐️⭐️⭐️⭐️</td>
													</c:when>
													<c:when test="${review.reviewStar == 4}">
														<td>⭐️⭐️⭐️⭐️️</td>
													</c:when>
													<c:when test="${review.reviewStar == 3}">
														<td>⭐️⭐️⭐️️</td>
													</c:when>
													<c:when test="${review.reviewStar == 2}">
														<td>⭐️⭐️</td>
													</c:when>
													<c:otherwise>
														<td>⭐️</td>
													</c:otherwise>
												</c:choose>
												<td>${review.userId}</td>
												<td>${review.reviewCount}</td>
												<td><fmt:formatDate value="${review.reviewRegDate}"
														type="both" dateStyle="full" timeStyle="short" /></td>

												<td><c:choose>
														<c:when test="${  review.reviewDeleted eq 'true'  }">
															<a href="#" class="btn btn-danger btn-icon-split deleteReview"
																style="width: 130px" data-review-no=${ review.reviewNo } > <span
																class="icon text-white-50"> <i
																	class="fas fa-trash"></i>
															</span> <span class="text">삭제 </span>
															</a>
														</c:when>

														<c:otherwise>
															<a href="#" class="btn btn-success btn-icon-split deleteReview"
																style="width: 130px" data-review-no=${ review.reviewNo }> <span
																class="icon text-white-50"> <i
																	class="fas fa-check"></i>
															</span> <span class="text">개시 중 </span>
															</a>
														</c:otherwise>
													</c:choose></td>
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
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						계정 수정 <a id="userDocValid" class="modalUserDocValid">데이터 식별 전
						</a>
					</h5>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="/member/edit" method="post">
					<div class="modal-body">

						<div class="form-group">
							사용자 아이디 <input name="userId" id="userId" type="text">
						</div>
						<div class="form-group">
							사용자 명 <input name="userName" id="userName" type="text">
						</div>
						<div class="form-group">
							휴대폰 번호 <input name="userPhone" id="userPhone" type="text">
						</div>
						<div class="form-group">
							이메일 <input name="userEmail" id="userEmail" type="text">
						</div>
						<div class="form-group">
							사용자 유형 <select name="userType">
								<option value="basic">일반 사용자</option>
								<option value="deniedDoc">문서 미 승인</option>
								<option value="needCheck">문서 승인 대기</option>

								<option value="admin">관리자</option>
							</select>
						</div>
						<div class="form-group">
							사용자 주소 <input name="userAddress" id="userAddress" type="text">
						</div>

						<div class="form-group">
							사용자 활동 상태 <a id="userActiveState" class="modalUserActiveState">데이터
								식별 전 </a>


						</div>
						<div class="form-group">
							사업자 등록증 등록번호 <input name="userCorpNo" id="userCorpNo" type="text">
						</div>
						<div class="form-group">
							사업자 등록증 <img id="attach" style="width: 100%;">
						</div>
						<!-- <div class="form-group">
							사업자 등록증 식별 여부 
						</div> -->
						<input type="hidden" name="userActiveState"
							id="hiddenUserActiveState"> <input type="hidden"
							name="userDocValid" id="hiddenUserDocValid">

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
			 $('#dataTable').on('click','.deleteReview', function(event){
				var reviewNo=$(this).data('review-no');
				var reviewState=$(this).attr("class");
				
				//console.log("message: ")
				event.preventDefault();
				if(reviewState.includes('btn-danger')){
					const yn = confirm("리뷰를 다시 개시하겠습니까?");
					if (!yn)
						return;
				}else{
					const yn = confirm("리뷰를 삭제하겠습니까?");
					if (!yn)
						return;
				}
				
				location.href="/board/adminDeleteReview?reviewNo="+reviewNo;


			});

		})
	</script>
</body>

</html>