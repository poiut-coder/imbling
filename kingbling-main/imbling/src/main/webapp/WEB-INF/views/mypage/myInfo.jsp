<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<jsp:include page="/WEB-INF/views/modules/common-meta.jsp" />
<!-- Css Styles ,font -->
<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<meta charset="UTF-8">
<title>임블리 사이트</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp" />
	<jsp:include page="/WEB-INF/views/modules/header.jsp" />

	<!-- ****************************** carousel ************************** -->


	<section class="checkout spad">
		<div class="container">
			<div class="checkout__form">
				<form action="/mypage/edit" method="post"
					enctype="multipart/form-data">
					<div class="row">
						<div class="col-lg-12 col-md-6">

							<h6 class="checkout__title">
								회원정보 조회 및 수정 <input type="submit"> <input
									style="float: right;" type="button" id="deleteId"
									value="계정 삭제 ">


							</h6>


							<div class="checkout__input">
								<p>
									아이디 <span>*</span>
								</p>
								${loginuser.userId}
							</div>
							<div class="checkout__input">
								<p>
									사용자 타입  <span>*</span>
								</p>
								${loginuser.userType}
							</div>
							<div class="checkout__input">
								<p>
									제출 서류 <span>*</span>
								</p>
								<input type="file" id="inputed_doc" name="attach"
									onchange="readURL(this);"> 
								<input id="btn-checkDoc"
									type="button" value="등록" style="height: 40px" /> 
								<img
									src="/ocr/venv/account-attachments/${attachments[0].docName }"
									id="preview" style="width: 600px">
							</div>
							<div class="checkout__input">
							<p>
									사업자 등록번호 <span>*</span>
								</p>
									<input type="text" class="form-control form-control-user"  value="${loginuser.userCorpNo}"
										id="userCorpNo" placeholder="사업자 등록번호 " name="userCorpNo">
								<input id="btn-checkInfoByDocNo" type="button" value="정보 조회  "
									style="height: 40px" />
							</div>
							<div class="checkout__input">
								<p>
									이름 <span>*</span>
								</p>
								<input type="text" value="${loginuser.userName}" name="userName" class="form-control form-control-user"
									id="userName">
							</div>
							
							
							<div class="checkout__input">
								<p>
									주소 <span>*</span>
								</p>
								<input type="text" value="${loginuser.userAddress}"
									name="userAddress">
							</div>
							<div class="checkout__input">
								<p>
									이메일 <span>*</span>
								</p>
								<input type="text" value="${loginuser.userEmail}"
									name="userEmail">
							</div>

							<div class="checkout__input">
								<p>
									전화번호 <span>*</span>
								</p>
								<input type="text" value="${loginuser.userPhone}"
									name="userPhone">
							</div>

						</div>
						<input type="hidden" id="userId" value="${loginuser.userId}"
							name="userId"> 
							<input type="hidden" id="userType" value="${loginuser.userType}"
							name="userType"> 
							<input type="hidden" id="userDocValid"
							value="false" name="userDocValid">
							

					</div>
				</form>

			</div>

			<!-- ****************************** 모달  ************************** -->

			<div class="modal fade" id="deleteIdModal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">계정 삭제 userId
								: ${loginuser.userId}</h5>

							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">

							<div class="form-group">
								<label for="recipient-name" class="col-form-label">1.
									회원탈퇴 전, 유의사항을 확인해 주시기 바랍니다.</label>
								<p>
									- 회원탈퇴 시 회원전용 웹 서비스 이용이 불가합니다.<br> - 거래정보가 있는 경우, 전자상거래
									등에서의 소비자 보호에 관한 법률에 따라 계약 또는 청약철회에 관한 기록, 대금결제 및 재화 등의 공급에 관한
									기록은 5년동안 보존됩니다.<br> - 유효기간이 경과되지 않은 미사용 쿠폰관련 정보는 유효기간
									만료일까지 보관되며, 탈퇴 후에도 유효기간 내 사용하실 수 있습니다.<br> - 유효기간 내 사용하지
									못한 미사용 쿠폰은 구매금액의 70%를 임블캐시로 적립해 드리나, 탈퇴시 적립 받을 수 없습니다.<br>
									- 회원탈퇴 후 쿠팡 서비스에 입력하신 상품문의 및 후기, 댓글은 삭제되지 않으며, 회원정보 삭제로 인해 작성자
									본인을 확인할 수 없어 편집 및 삭제처리가 원천적으로 불가능 합니다.<br> - 상품문의 및 후기, 댓글
									삭제를 원하시는 경우에는 먼저 해당 게시물을 삭제하신 후 탈퇴를 신청하시기 바랍니다.<br> - 이미
									결제가 완료된 건은 탈퇴로 취소되지 않습니다.<br>


								</p>
								<input type="checkbox" id="agreeDelete" value="agreeDelete ">동의합니다
							</div>
							<div class="form-group">
								<label for="message-text" class="col-form-label">탈퇴를 위한
									계정의 비밀번호를 작성해 주세요 :</label> <input type="hidden" name="userId"
									value=${loginuser.userId } id="userId"> <input
									type="password" name="userPassword" id="userPassword">

							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">취소하기</button>
								<input id="submitBtn" type="button" class="btn btn-primary"
									value="계정 삭제 " disabled>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- ****************************** 모달  ************************** -->

	</section>


	<!-- ****************************** footer ************************** -->
	<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
	<!-- ****************************** end footer ************************** -->





	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
	<!-- <script src="https://code.jquery.com/jquery-3.6.1.js"></script> 인쿨루드에 있음  -->
	<script type="text/javascript">
		$(function() {
			<c:if test ="${not empty errM}">
			alert("${errM}")
			//console.log("${errM}")
			</c:if>

			$('#deleteId').on('click', function(event) {
				//console.log("message: ")

				event.preventDefault();
				const yn = confirm("계정을 삭제하겠습니까?");
				if (!yn)
					return;

				$('#deleteIdModal').modal('show')

			});

			$('#agreeDelete').on('click', function(event) {
				var checked = $("#agreeDelete").is(':checked');

				$("#submitBtn").attr("disabled", !checked);

			});
			$('#submitBtn').on(
					'click',
					function(event) {

						$.ajax({
							url : "/mypage/deleteIdModal",
							"method" : "post",
							"data" : 'userId=' + $("#userId").val()
									+ '&userPassword='
									+ $("#userPassword").val(),
							"success" : function(data, status, xhr) {
								//						console.log("message: ", data)
								if (data == "success") {
									alert('계정이 삭제되었습니다.')
									location.href = '/home';

								} else if (data = "wrongIdOrPw") {
									alert('비밀번호가 틀렸습니다.')

								}
							},
							"error" : function(xhr, status, err) {
							}
						})

					});
			
			
			$('#btn-checkDoc').on( 'click', function(event) {
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

		});
		function readURL(input) {
			$("#userType").val("needCheck");

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