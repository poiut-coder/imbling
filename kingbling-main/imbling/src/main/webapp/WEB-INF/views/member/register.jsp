<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%--    <!-- meta -->--%>
<%--    <jsp:include page="/WEB-INF/views/modules/common-meta.jsp" />--%>
<!-- Css Styles ,font -->
<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />


<title>회원가입</title>

<!-- Custom fonts for this template-->

<%--  /resources/dist/  --%>
<link href="/resources/plugins/admin/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/dist/admin/css/sb-admin-2.min.css"
	rel="stylesheet">

</head>
<%--<body>--%>
<body>

	<div class="container">
		<jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp" />
		<jsp:include page="/WEB-INF/views/modules/header.jsp" />
		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="row">

					<div class="col-lg-7">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">회원가입 화면입니다!</h1>
							</div>
							<form class="user" action="/member/register" method="post"
								enctype="multipart/form-data">
								<div class="row">
									<div class="form-group  col-lg-6">
										<input type="text" class="form-control form-control-user"
											id="userId" placeholder="아이디 " name="userId">
									</div>

									<div class="form-group   col-lg-6">
										<input type="password" class="form-control form-control-user"
											id="exampleInputPassword" placeholder="비밀번호 "
											name="userPassword">
									</div>

								</div>


								<div class="form-group col-lg-6 ">
									<div id="IdExistence">아이디 중복을 확인해주세요</div>
									<input id="btn-checkId" type="button" value="id 중복 확인 "
										style="height: 40px" />
								</div>

								<div class="form-group col-lg-12">
									<div class=" col-lg-12 ">사업자 등록증 이미지 파일을 등록 후 등록 버튼을
										눌러주세요</div>
									<div class="row">
										<div class=" col-lg-6 ">
											<input type="file" id="inputed_doc" name="attach"
												onchange="readURL(this);">
										</div>
										<div class=" col-lg-5  ">
											<input id="btn-checkDoc" type="button" value="등록"
												style="height: 40px" />
										</div>
									</div>


								</div>

								<div class="form-group col-lg-12">
									<div class="row">
										<input type="text" class="form-control form-control-user"
											id="userCorpNo" placeholder="사업자 등록번호 " name="userCorpNo">
									</div>
									<input id="btn-checkInfoByDocNo" type="button" value="정보 조회  "
										style="height: 40px" />
								</div>

								<div class="form-group  col-lg-12">
									<div class="row">
										<input type="text" class="form-control form-control-user"
											id="userName" placeholder="이름 " name="userName">
									</div>

								</div>


								<div class="form-group">
									<input type="text" placeholder="주소 찾기 버튼을 눌러주세요"
										id="roadFullAddr" class="form-control form-control-user"
										style="color: black" name="userAddress" readonly>
									<%-- value="${regiInfo.userAddress}" --%>

									<button type="button" class="btn btn-secondary" id="goPopup">
										주소 찾기</button>


								</div>


								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										id="userPhone" placeholder="전화번호 " name="userPhone">
								</div>
								<div class="form-group">
									<input type="email" class="form-control form-control-user"
										id="exampleInputEmail" placeholder="이메일 주소 " name="userEmail">
								</div>



								<div class="form-group ">
									<input type="submit" class="btn btn-primary btn-user btn-block"
										id="submit" value="회원가입하기!" disabled="disabled">
								</div>
								<input type="hidden" name="userType" value="needCheck"
									id="userType"> <input type="hidden" name="userDocValid"
									value="false" id="userDocValid">

							</form>
							<hr>

							<div class="text-center">
								<a class="small" href="/member/login">로그인하러 가기!</a>
							</div>
						</div>
					</div>
					<div class="col-lg-5 d-none d-lg-block ">
						<img id="preview">
					</div>
				</div>
			</div>
		</div>


	</div>


	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title fs-5" id="exampleModalLabel">알림</h5>
				</div>
				<div class="modal-body">...</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#exampleModal" style="display: none"></button>
	<!-- 모달 끝 -->
	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />


	<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp" />
	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
	<script type="text/javascript">
		$(function() {
			<c:if test ="${not empty errM}">
			alert("${errM}")

			</c:if>

			
			<c:if test ="${not empty regiInfo}">

				<c:if test ="${not empty regiInfo.userId}">
					$("#userId").val("${regiInfo.userId}")
	
				</c:if>

				<c:if test ="${not empty regiInfo.userCorpNo}">
				$("#userCorpNo").val("${regiInfo.userCorpNo}")
				</c:if>
			
				<c:if test ="${not empty regiInfo.userName}">
				$("#userName").val("${regiInfo.userName}")
				</c:if>
				
				<c:if test ="${not empty regiInfo.userAddress}">
				$("#roadFullAddr").val("${regiInfo.userAddress}")
				</c:if>
				
				<c:if test ="${not empty regiInfo.userPhone}">
				$("#userPhone").val("${regiInfo.userPhone}")
				</c:if>
	
				<c:if test ="${not empty regiInfo.userEmail}">
				$("#exampleInputEmail").val("${regiInfo.userEmail}")
				</c:if>


			</c:if>

			console.log("${errM}")
			$('#btn-checkId').on('click', function(event) {

				if ($("#userId").val() == "") {
					alert("아이디를 입력해주세요 ")
					return

					

				}

				$.ajax({
					"url" : '/member/checkId',//해당 컨트롤러에서 리턴값으로success를 받
					"method" : "get",
					"data" : 'userId=' + $("#userId").val(),//지정된 변
					"success" : function(data, status, xhr) {
						if (data == "success") {
							$("#IdExistence").html("사용 가능합니다 ")
							$("#submit").removeAttr("disabled");

						} else if (data == "noId") {
							$("#IdExistence").html("사용 불가능합니다 ")
							$("#submit").attr("disabled", "disabled");

						}
					},
					"error" : function(xhr, status, err) {
						alert('삭제실패 1')
					}
				})

			});

			$('#btn-checkDoc').on(
					'click',
					function(event) {
						const imageInput = $("#inputed_doc")[0];

						if (imageInput.files.length === 0) {
							alert("파일은 선택해주세요");
							return;
						}

						const formData = new FormData();
						formData.append("attach", imageInput.files[0]);// hashmap 형식 

						var extensionLocation = $("#inputed_doc").val()
								.lastIndexOf(".")

						var extension = $("#inputed_doc").val().substr(
								extensionLocation + 1);

						if (extension == "jpeg" || extension == "jfif"
								|| extension == "gif" || extension == "jpg"
								|| extension == "png" || extension == "ppm") {

							$.ajax({
								type : "POST",
								url : "/member/identifyCorpNo",
								processData : false,
								contentType : false,
								data : formData,
								success : function(rtn) {

									console.log("message: ", rtn)
									//$("#resultUploadPath").text(message.uploadFilePath)
									if (rtn != "fail 1") {

										if (rtn === "cropNo") {
											$("#userCorpNo").attr(
													"placeholder",
													"인식 실패. 직접 입력해 주세요. ")
											$("#userType").val("needCheck")

										} else {
											$("#userCorpNo").val(rtn)
											$("#userDocValid").val("true")
											$("#userType").val("basic")

										}
									}

								},
								err : function(err) {
									console.log("err:", err)
								}
							})
							alert("사용 가능한 파일입니다 ")

						} else {
							alert("사용 불가능한 파일입니다 ")
							$("#inputed_doc").val("")

						}

					});

			$('#btn-checkInfoByDocNo').on('click', function(event) {

				$.ajax({
					type : "POST",
					url : "/member/searchByCorpNo",
					"method" : "get",
					"data" : 'docNo=' + $("#userCorpNo").val(),
					"success" : function(data, status, xhr) {
						console.log("message: ", data)
						$("#userName").val(data)
					},
					"error" : function(xhr, status, err) {
						alert('삭제실패 1')
					}
				})

			});

			$("#goPopup").on(
					'click',
					function(event) {
						new daum.Postcode({
							oncomplete : function(data) {
								// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

								// 각 주소의 노출 규칙에 따라 주소를 조합한다.
								// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
								var addr = ''; // 주소 변수
								var extraAddr = ''; // 참고항목 변수

								//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
								if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
									addr = data.roadAddress;
								} else { // 사용자가 지번 주소를 선택했을 경우(J)
									addr = data.jibunAddress;
								}

								// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
								if (data.userSelectedType === 'R') {
									// 법정동명이 있을 경우 추가한다. (법정리는 제외)
									// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
									if (data.bname !== ''
											&& /[동|로|가]$/g.test(data.bname)) {
										extraAddr += data.bname;
									}
									// 건물명이 있고, 공동주택일 경우 추가한다.
									if (data.buildingName !== ''
											&& data.apartment === 'Y') {
										extraAddr += (extraAddr !== '' ? ', '
												+ data.buildingName
												: data.buildingName);
									}
									// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
									if (extraAddr !== '') {
										extraAddr = ' (' + extraAddr + ')';
									}
									// 조합된 참고항목을 해당 필드에 넣는다.
									$('#roadFullAddr').val(extraAddr);

								} else {
									$('#roadFullAddr').val('');
								}

								// 주소 정보를 해당 필드에 넣는다.
								$('#roadFullAddr').val(addr);
							}
						}).open();
					});

		});
		function readURL(input) {

			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('preview').src = e.target.result;
				};
				reader.readAsDataURL(input.files[0]);
			} else {
				document.getElementById('preview').src = "";
			}
		}
	</script>


</body>
</html>