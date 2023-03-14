<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <!-- meta -->
    <jsp:include page="/WEB-INF/views/modules/common-meta.jsp" />
    <!-- Css Styles ,font -->
    <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
    <meta charset="UTF-8">
    <title>장바구니</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp" />
<jsp:include page="/WEB-INF/views/modules/header.jsp" />

<!-- ****************************** cart ************************** -->
<section class="shopping-cart spad">
<h2 style="display: flex;align-content:center;padding-bottom:30px;">
<i class="fa fa-shopping-basket" style="margin:auto">장바구니</i></h2>
    <div class="container">
        <div class="row" id="cartList">

        </div>
    </div>
    
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
</section>
<!-- Shopping Cart Section End -->

<!-- ****************************** footer ************************** -->
<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
<!-- ****************************** end footer ************************** -->

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />

<script type="text/javascript">
$(function(){
	
	$('#cartList').load("cartlist");
    var quantity = 0;
	$('#cartList').on('click','#orderAllCart',function(event){//장바구니 전체 주문
		quantity = 0;
		chkedList=[];
		$.ajax({//전체 주문시 장바구니 비어있으면 주문 못함
			url:"/userOrder/cartOrnot",
		    type : 'post',
		    dataType : 'text', // 반환 데이터 타입 (html, xml, json, text 등등)
		    success(data) { // 결과 성공 콜백함수
		    	console.log(data);
		    if(data=="nothing"){
				$("#myModal").modal();
				$('.modal-body').html("<p>장바구니에 상품이 없습니다.</p>");
		    	return false;
		    }
		    },//success
		    error(err){
	    		console.log(err);	
		    }
	    });//ajax
		    

	    $('input[id *= "cartEA"]').each(function(){//전체 속성 번호 배열 저장
			var propertyNo = $(this).data('prono');
			chkedList.push(propertyNo);
	    });
	    
	    for(var i=0; i<chkedList.length;i++){
	    	doAllCartOrder(i);
	    }
	});//장바구니 전체주문 끝
	
    function doAllCartOrder(i){	// 전체 주문시 장바구니 수량과 주문 수량 비교하기
		$.ajax({
			url:"/product/getPropertyInfo",
			type:"post",
			data:{"propertyNo":chkedList[i]},
			dataType:"text",
			success(data){
				var newMaxEA = Number(data);
				if( Number($('#cartEA'+chkedList[i]).val()) <= newMaxEA ){
					quantity=quantity+1;
			  	}else{
					$("#myModal").modal();
					$('.modal-body').html("<p>["+$('#productName'+chkedList[i]).val()+"]의 주문 가능 수량은 "+newMaxEA+"개 입니다.</p>");
					$('#cartEA'+chkedList[i]).focus();
					return false;
			  	}
				if(quantity==chkedList.length){
					location.href="/userOrder/doCartOrder";
		  		}
			},
			error(err){
				console.log(err)
			}
		});//ajax
    }//doAllCartOrder
	
	$('#cartList').on('click','#deleteAllCart',function(event){ //장바구니 전체 비우기
		
		var ok = confirm('장바구니에 담긴 상품을 모두 삭제할까요?');
		if(!ok){
			return false;
		}
		$.ajax({
			url:"/userOrder/deleteAllCart",
		    type : 'get',
		    dataType : 'text',       // 반환 데이터 타입 (html, xml, json, text 등등)
		    success(data) { // 결과 성공 콜백함수
		    	$('#cartList').load("cartlist");
		    },
		    error(error) { // 결과 에러 콜백함수
		        console.log(error);
		    }
	    });
	});
	
	$('#cartList').on('click',"i[id *= 'cartDelete']",function(event){// 상품 하나 카트에서 삭제하기
		var deleteNo = $(this).data("propertyno");
		$.ajax({
			url:"/userOrder/deleteFromCart",
		    type : 'get',
		    dataType : 'text',// 반환 데이터 타입 (html, xml, json, text 등등)
		    data : {"propertyNo":deleteNo},
		    success : function(result) { // 결과 성공 콜백함수
		    	$('#cartList').load("cartlist");
		    },
		    error : function(request, status, error) { // 결과 에러 콜백함수
		        console.log(error);
		    }
	    });
	});
	
	$('.modal-footer').on('click','button',function(event){
		$("#myModal").modal('hide');
	});

	$('#cartList').on("click",".pro-qty-2 i",function(event){//상품 갯수 수정+전체 금액 수정(화살표 클릭)
		var proNo = $(this).data("prono");
		var cartEA = Number($("#cartEA"+proNo).val());
		var maxEA = Number($("#maxEA"+proNo).val());
		if($(this).hasClass("fa fa-arrow-up")){
			if(cartEA>=maxEA){
				$("#myModal").modal();
				$('.modal-body').html("<p>재고가 "+maxEA+"개 남은 상품 입니다.</p>");
				return false;
			}
			cartEA = cartEA + 1;
		}else if($(this).hasClass("fa fa-arrow-down")){
			if(cartEA<=5){
				$("#myModal").modal();
				$('.modal-body').html("<p>최소 주문수량은 5개입니다.</p>");
				return false;
			}
			cartEA = cartEA - 1;
		}
		$.ajax({
			url:"/userOrder/updateCartInfo",
		    type : 'post',
		    dataType : 'text',       // 반환 데이터 타입 (html, xml, json, text 등등)
		    data : {"propertyNo":proNo,"cartEA":cartEA,"productPrice":$(this).data("singleprice")},
		    success : function(result) { // 결과 성공 콜백함수
		    	$('#cartList').load("cartlist");
		    },
		    error : function(request, status, error) { // 결과 에러 콜백함수
		        console.log(error);
		    }
	    });
	});

	$('#cartList').on("change",".pro-qty-2 input",function(event){//상품 갯수 수정+전체 금액 수정(숫자 입력)
		var proNo = $(this).data("prono");
		var cartEA = Number($("#cartEA"+proNo).val());
		var maxEA = Number($("#maxEA"+proNo).val());
		if(cartEA<5){
			$("#myModal").modal();
			$('.modal-body').html("<p>최소 주문수량은 5개입니다.</p>");
			$("#cartEA"+proNo).val(5);
			cartEA=5;
		}else if(cartEA>maxEA){
			$("#myModal").modal();
			$('.modal-body').html("<p>재고가 "+maxEA+"개 남은 상품 입니다.</p>");
			$("#cartEA"+proNo).val(maxEA);
			cartEA =$("#cartEA"+proNo).val();
		}
		$.ajax({
			url:"/userOrder/updateCartInfo",
		    type : 'post',
		    dataType : 'text',       // 반환 데이터 타입 (html, xml, json, text 등등)
		    data : {"propertyNo":proNo,"cartEA":cartEA,"productPrice":$(this).data("singleprice")},
		    success : function(result) { // 결과 성공 콜백함수
		    	$('#cartList').load("cartlist");
		    },
		    error : function(request, status, error) { // 결과 에러 콜백함수
		        console.log(error);
		    }
	    });
	});
	
	$('#cartList').on("click","#chkAll",function(event){//전체선택
		if (!$('.chk i').hasClass('fa-square-o')){//모든 상품이 선택된 상태면 체크 다 풀어줌
			$.ajax({
				url:"/userOrder/setUnChkAll",
			    type : 'post',
			    dataType : 'text',       // 반환 데이터 타입 (html, xml, json, text 등등)
			    success : function(result) { // 결과 성공 콜백함수
			    	$('#cartList').load("cartlist");
			    },
			    error : function(request, status, error) { // 결과 에러 콜백함수
			        console.log(error);
			    }
		    });
		}else{//체크 안된게 하나라도 있는 상태면 모두 다 선택 해주기
			$.ajax({
				url:"/userOrder/setChkAll",
			    type : 'post',
			    dataType : 'text',       // 반환 데이터 타입 (html, xml, json, text 등등)
			    success : function(result) { // 결과 성공 콜백함수
			    	$('#cartList').load("cartlist");
			    },
			    error : function(request, status, error) { // 결과 에러 콜백함수
			        console.log(error);
			    }
		    });
		}
	});
	
	$('#cartList').on("click",".chk i",function(event){//체크박스 클릭
		var proNo = $(this).data("prono");
		if($(this).hasClass('fa-square-o')){
			$(this).removeClass();
			$(this).addClass('fa fa-check-square-o');
		}else if($(this).hasClass('fa-check-square-o')){
			$(this).removeClass();
			$(this).addClass('fa fa-square-o');
		}
 		$.ajax({
			url:"/userOrder/updateCartChk",
		    type : 'post',
		    dataType : 'text',       // 반환 데이터 타입 (html, xml, json, text 등등)
		    data : {"propertyNo":proNo},
		    success : function(result) { // 결과 성공 콜백함수
		    	$('#cartList').load("cartlist");
		    },
		    error : function(request, status, error) { // 결과 에러 콜백함수
		        console.log(error);
		    }
	    });
	});
	
	var chkedList = [];
	$("#cartList").on('click',"#chk-order",function(event){//선택상품 주문
    	quantity = 0;
    	chkedList = [];
		if (!$('.chk i').hasClass('fa-check-square-o')){//선택된 상품이 없으면 주문 못함
			return false;
		}
	    $('.fa-check-square-o').each(function(){// 선택된 상품 속성 번호만 저장하기
			var propertyNo = $(this).data('prono');
			chkedList.push(propertyNo);
	    });
		for(var i=0;i<chkedList.length;i++){// 선택 주문시 장바구니 수량과 주문 수량 비교하기
			chkedQuantity(i);
	    }
	});//선택상품 주문
	
	function chkedQuantity(i){ //선택 상품 주문시 재고량 확인을 위한 ajax를 for문 돌리려고 함수로 밖에 빼둠.
		$.ajax({
			url:"/product/getPropertyInfo",
			type:"post",
			data:{"propertyNo":chkedList[i]},
			dataType:"text",
			success(data){
				var newMaxEA = Number(data);
				if( Number($('#cartEA'+chkedList[i]).val()) <= newMaxEA ){
					quantity = quantity+1;
			  	}else{
					$("#myModal").modal();
					$('.modal-body').html("<p>["+$('#productName'+chkedList[i]).val()+"]의 주문 가능 수량은 "+newMaxEA+"개 입니다.</p>");
					$('#cartEA'+chkedList[i]).focus();
					quantity = 0;
					return false;
			  	}
			    if(quantity==chkedList.length){
			    	location.href="/userOrder/doOrderCheckedCart";
			    }
			},
			error(err){
				console.log(err)
			}
		});//ajax
	}//chkedQuantity
	
	$("#cartList").on('click',"#chk-delete",function(event){//선택상품 삭제
		if (!$('.chk i').hasClass('fa-check-square-o')){
			return false;
		}
		$.ajax({
			url:"/userOrder/deleteCheckedFromCart",
		    type : 'get',
		    dataType : 'text',// 반환 데이터 타입 (html, xml, json, text 등등)
		    success : function(result) { // 결과 성공 콜백함수
		    	$('#cartList').load("cartlist");
		    },
		    error : function(request, status, error) { // 결과 에러 콜백함수
		        console.log(error);
		    }
	    });
	});
	
	
});
</script>

</body>
</html>