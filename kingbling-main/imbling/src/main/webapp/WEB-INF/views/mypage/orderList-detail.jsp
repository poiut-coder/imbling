<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<!-- Checkout Section Begin -->
<section class="checkout spad">
    <div class="container">
        <div class="checkout__form">
            <form action="/userOrder/updateOrderInfo" method="post">
                <div class="row">
                    <div class="col-lg-8 col-md-6">

                        <h6 class="checkout__title">주문 상세 정보</h6>
                        <input type="hidden" name="orderNo" value="${order.orderNo}">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>이름<span>  </span></p>
                                    <input type="text" value="${order.userId}" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>주문일자<span>  </span></p>
                                    <input type="text" value="${order.orderDate}" readonly>
                                </div>
                                <div class="checkout__input">
                                    <p>결제정보<span>  </span></p>
                                    <input type="text" value="${order.orderPay}" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="checkout__input" id="callBackDiv">
                            <p>배송주소<span></span>&nbsp&nbsp&nbsp
                            <button type="button" class="btn btn-secondary" id="goPopup"> 주소 찾기</button></p>
                            <input type="text" placeholder="주소 찾기 버튼을 눌러주세요" id="roadFullAddr" class="checkout__input__add"
                            style="color:black" name="orderAddr" value="${order.orderAddr}" readonly >
                            <input type="text" placeholder="상세주소를 입력해 주세요" id="detailAddr" class="checkout__input__add"
                            style="color:black" name="orderAddr2" value="${order.orderAddr2}">
                        </div>
                        <div class="checkout__input">
                            <p>배송요청사항<span></span></p>
                            <input type="text" style="color:black" value="${order.orderDeliveryRequire}" name="orderDeliveryRequire"
                                   placeholder="배송 기사님께 전달할 메세지를 입력해주세요.">
                        </div>

                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="checkout__order">
                            <h4 class="order__title">주문상품</h4>
                            <div class="checkout__order__products">상품 <span>총 금액</span></div>
                            <ul class="checkout__total__products">
                            	<c:forEach items="${order.orders}" var="orders">
                            	<c:set var="i" value="${i+1}" />
                            	<li>💎 ${i}. ${orders.productName} <span>${orders.orderDetailEA}개 <fmt:formatNumber value="${orders.orderDetailTotalPrice}" pattern="#,###원" /></span></li>
                                <c:choose>
                                    <c:when test="${orders.reviewState == false&&order.orderState=='배송완료'}">
                                        <li><a class="btn btn-outline-primary" href="/board/writeReview?orderNo=${order.orderNo}&propertyNo=${orders.propertyNo}">리뷰쓰기</a></li>
                                    </c:when>
                                   	<c:when test="${orders.reviewState==true}">
                                   		    <li><a href="/mypage/myboard" class="btn btn-outline-dark">내가 쓴 게시글 목록 보기</a></li>
                                            <li><button type="button" class="btn btn-outline-dark" id="goToReviewDtail${i}" data-orderno="${order.orderNo}" data-propertyno="${orders.propertyNo}">내가 쓴 리뷰 보러가기</button></li>
                                   	</c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
                                </c:forEach>
                            </ul>
                            <ul class="checkout__total__all">
                                <li>총 주문금액 <span><fmt:formatNumber value="${orderTotalPrice}" pattern="#,###원" /></span></li>
                            </ul>
                            <c:choose>
                            <c:when test="${order.orderState=='주문취소'}">
                            <a> 취소된 주문입니다. </a>
                            </c:when>
                            <c:otherwise>
                            	<c:choose>
                            	<c:when test="${order.orderState=='주문완료'}">
	                            <button type="submit" class="site-btn">주문 정보 수정</button>
	                            <button type="button" class="cancel-btn" id="cancel-btn">주문 취소</button>
	                            </c:when>
	                            <c:when test="${order.orderState=='구매확정'}">
	                            <a> 구매가 확정된 주문입니다. </a>
	                            </c:when>
	                            <c:otherwise>
	                            <a> 주문 정보 수정/취소 가능 상태가 아닙니다. </a>
<%--                                <a class="btn btn-outline-primary" href="/board/writeReview?orderNo=${order.orderNo}">리뷰쓰기</a>--%>
	                            </c:otherwise>
                            	</c:choose>
                            </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- Checkout Section End -->


<!-- ****************************** footer ************************** -->
<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
<!-- ****************************** end footer ************************** -->

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<script type="text/javascript">
$(function(){
	$("#goPopup").on('click',function(event){
		new daum.Postcode({
            oncomplete: function(data) {
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
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
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
	
	$('.site-btn').on('click',function(event){
		const ok = confirm("주문 정보를 수정합니다.");
		if (!ok){
		return false;
		}
		return true;
	});
	
	$('#cancel-btn').on('click',function(event){
		const ok = confirm("주문을 취소하시겠습니까?");
		if (!ok){
		return false;
		}
		location.href="/userOrder/cancelOrder?orderNo="+${order.orderNo};
	});
	
	$('li').on('click',"button[id *= 'goToReviewDtail']",function(event){//내가 쓴 리뷰 보러가기 누르면 리뷰글 번호 조회해서 리뷰상세보기로 이동
		var orderNo = $(this).data('orderno');
		var propertyNo = $(this).data('propertyno');
		$.ajax({
			url:"/board/findReviewNo",
			type:"post",
			data:{"orderNo":orderNo,"propertyNo":propertyNo},
			dataType:"text",
			success(data){
				location.href="/board/reviewDetail?reviewNo="+Number(data);
			},
			error(err){
				console.log(err)
			}
		});
	});
	

});


</script>

</body>
</html>