<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<%--    <jsp:include page="/WEB-INF/views/modules/common-meta.jsp" />--%>
<!-- Css Styles ,font -->
<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />

<title>로그인</title>
</head>


<body>

	<div class="container">
		<jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp" />
		<jsp:include page="/WEB-INF/views/modules/header.jsp" />
		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block"
								style="background-color: #0c5460;"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">로그인 화면입니다!</h1>
									</div>
									<form class="user" action="/member/login" method="post">
										<div class="form-group">
											<input type="text" class="form-control form-control-user"
												id="exampleInputEmail" name="userId" placeholder=" ID 입력 ">
										</div>
										<div class="form-group">
											<input type="password" class="form-control form-control-user"
												id="exampleInputPassword" placeholder="비밀번호 입력 "
												name="userPassword">
										</div>
										

										<div class="form-group ">
											<input type="submit"
												class="btn btn-primary btn-user btn-block" value="로그인 ">
										</div>


									</form>
									<hr>
									
									<div class="text-center">
										<a class="small" href="register">회원가입 하기!</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>
	
	<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp" />
	
	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
	
	<script type="text/javascript">
	$(function() {
		<c:if test ="${not empty errM}">
		alert("${errM}")
		console.log("${errM}")
		</c:if>
	})
	</script>
</body>
</html>