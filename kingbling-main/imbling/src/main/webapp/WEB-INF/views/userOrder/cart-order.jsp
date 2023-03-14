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
            <form action="/userOrder/completeCartOrder" method="post">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                    
	                    <div class="shopping__cart__table">
	                    <div style="background:#EAEAEA;border-radius:15px" id="toggle">
	                    <h5 style="padding:10px 10px 8px 15px;font-weight:700">주문 제품 보기<i class="fa fa-arrow-down" id="toggleIcon" style="float:right"></i></h5>
	                    </div>
	                    
						<div style="padding:10px 10px 15px 15px; display:none" id="productList">
							<table>
	                        <thead>
	                        <tr>
	                            <th>제품</th>
	                            <th>주문 수량</th>
	                            <th>주문 금액</th>
	                            <th></th>
	                        </tr>
	                        </thead>
	                        <tbody>
	                        <c:forEach items="${carts}" var="cart">
	                        							<tr>
	                            <td class="product__cart__item">
	                                <div class="product__cart__item__pic">
	                                    <img style="height:130px;width:130px" src="${cart.product.productImage}" alt="">
	                                </div>
	                                <div class="product__cart__item__text">
	                                    <h6>${cart.product.productName}</h6>
	                                    <h5><fmt:formatNumber value="${cart.product.productPrice}" pattern="₩#,###" /></h5>
	                                </div>
	                            </td>
	                            <td class="cart__price">${cart.cartEA}</td>
	                            <td class="cart__price"><fmt:formatNumber value="${cart.cartTotalPrice}" pattern="₩#,###" /></td>
	                        </tr>
	                        </c:forEach>

	                        </tbody>
	                    </table>
						</div>
	                </div>

                        <h6 class="checkout__title">주문 상세 정보</h6>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>이름<span></span></p>
                                    <input type="text" value="${loginuser.userId}" style="color:black" name="userId" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>결제정보<span>*</span></p>
                                    <input type="text" name="orderPay" value="무통장입금">
                                </div>
                            </div>
                        </div>
                        <div class="checkout__input" id="callBackDiv">
                            <p>배송주소<span>*</span>&nbsp&nbsp&nbsp
                            <button type="button" class="btn btn-secondary" id="goPopup"> 주소 찾기</button></p>
                            <input type="text" placeholder="주소 찾기 버튼을 눌러주세요" id="roadFullAddr" class="checkout__input__add"
                            style="color:black" name="orderAddr" readonly >
                            <input type="text" name="orderAddr2" placeholder="상세주소를 입력해 주세요" id="detailAddr" class="checkout__input__add"
                            style="color:black" >
                        </div>
                        <div class="checkout__input">
                            <p>배송요청사항<span></span></p>
                            <input type="text" name="orderDeliveryRequire" 
                                   placeholder="배송 기사님께 전달할 메세지를 입력해주세요.">
                        </div>

                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="checkout__order">
                            <h4 class="order__title">주문상품</h4>
                            <div class="checkout__order__products">상품 <span>총 금액</span></div>
                            <ul class="checkout__total__products">
                            <c:forEach items="${carts}" var="cart">
                            	<c:set var="i" value="${ i+1 }" />
                            	<li>0${i}. ${cart.product.productName} <span>${cart.cartEA}개 <fmt:formatNumber value="${cart.cartTotalPrice}" pattern="#,###원" /></span></li>
                            </c:forEach>

                            </ul>
                            <ul class="checkout__total__all">
                                <li>총 주문금액 <span><fmt:formatNumber value="${cartTotalPrice}" pattern="₩#,###" /></span></li>
                            </ul>
                            <button type="submit" class="site-btn">주문 하기</button>
                            <button type="button" class="cancel-btn">주문 취소</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- Checkout Section End -->
<!-- 모달 시작 -->	
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fs-5" id="exampleModalLabel">알림</h5>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" style="display:none"> 
</button>
<!-- 모달 끝 -->

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
	
	$('.modal-footer').on('click','button',function(event){
		$("#myModal").modal('hide');
	});
	
	$(".cancel-btn").on('click',function(event){
		location.href="/mypage/cart";
	});
	
	$(".site-btn").on('click',function(event){
		if($('#roadFullAddr').val()==null||$('#roadFullAddr').val()==""){
			$("#myModal").modal();
			$('.modal-body').html("<p>주소를 입력해주세요.</p>");
			return false;
		}
		return true;
	});
	
	
	$("#toggle").on('click',function(event){
		
		if($("#toggleIcon").hasClass("fa fa-arrow-down")){
			$("#toggleIcon").removeClass();
			$("#toggleIcon").addClass("fa fa-arrow-up");
			$('#productList').show();
		}else{
			$("#toggleIcon").removeClass();
			$("#toggleIcon").addClass("fa fa-arrow-down");
			$('#productList').hide();
		}
		
	});

});


</script>

</body>
</html>