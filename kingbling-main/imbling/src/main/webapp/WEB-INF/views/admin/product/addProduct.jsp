<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<!DOCTYPE html>
<html lang="ko">

<head>
    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />
    <title>상품 등록</title>
<style type="text/css">
.mb-sm-0 i{
font-size:12px;
font-weight:bold;
cursor:pointer;
}
</style>
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

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">새로운 상품을 등록합니다.</h1>
                            </div>
                            <form class="user" action="/admin/productRegister" id="addProductForm" method="post" enctype="multipart/form-data">
                                <div class="form-group row">
                                			<input type="hidden" id="hiddenCategoryNo" name="categoryNo" />
                                			<input type="hidden" id="sizes" name="sizes" />
                                			<input type="hidden" id="colors" name="colors" />
                                			<input type="hidden" id="hiddenCategoryNo" name="categoryNo" />
                                		     <div class="dropdown no-arrow mb-4" style="width:50%;padding:0 1rem">
		                                        <button class="btn btn-white dropdown-toggle" type="button"
		                                        style="border:solid 1px lightgray;border-radius:10rem;width:100%;height:50px"
		                                            id="categoryNo"data-toggle="dropdown" aria-haspopup="true"
		                                            aria-expanded="false">
		                                              상품 분류 선택 <i class="fa fa-arrow-down"></i>
		                                        </button>
		                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		                                            <button type="button" data-cateno="1641" class="dropdown-item">귀걸이</button>
		                                            <button type="button" data-cateno="1642" class="dropdown-item">목걸이</button>
		                                            <button type="button" data-cateno="1643" class="dropdown-item">반지</button>
		                                            <button type="button" data-cateno="1644" class="dropdown-item">팔찌</button>
		                                            <button type="button" data-cateno="1645" class="dropdown-item">발찌</button>
		                                        </div>
		                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" id="productName"
                                            placeholder="상품명 입력" name="adminProductName">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="productContent"
                                        placeholder="상품 설명 입력" name="adminProductContent">
                                </div>
                                <input type="hidden" id="productIndex" value=1 />
                                <div class="form-group row" id="propertyRow">
                                    <div class="col-sm-6 mb-3 mb-sm-0" id="addedSize1">
                                        <input type="text" class="form-control form-control-user"
                                            id="productSize1" placeholder="상품 사이즈 입력">
                                            <i style="float:left;display:none;" id="deleteProperty1" data-propertyrow=1>- 속성 입력 행 삭제</i>
                                    </div>
                                    <div class="col-sm-6  mb-3 mb-sm-0" id="addedColor1">
                                        <input type="text" class="form-control form-control-user"
                                            id="productColor1" placeholder="상품 색상 입력">
                                        <i style="float:right;" class="add-property" 
                                        id="addProperty1">+ 속성 입력 행 추가</i>
                                    </div>
                                    <input type='hidden' id='propertyLocation1' />
                                </div>
                                <div class="form-group">
                                    <input type="number" class="form-control form-control-user" id="productPrice"
                                        placeholder="상품 가격 입력" name="adminProductPrice">
                                </div>
                                <div class="form-group">
                                    <input type="file" class="form-control form-control-user" id="productAttach" style="padding-bottom:45px"
                                        placeholder="상품 이미지 업로드" name="productAttach" />
                                </div>
                                <button class="btn btn-primary btn-user btn-block" id="addNewProduct" type="button">
                                    상품 등록
                                </button>
                            </form>
                            <hr>

                        </div>
                    </div>
                    <div class="col-lg-5">
                    	<img id="showProductImage" src="/resources/dist/img/skyblue-gem.png" style="width:400px;height:400px;margin:20px"></img>
                    </div>
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

	<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp" />

</body>
<script type="text/javascript">
$(function(){
	
	$('.modal-footer').on('click','button',function(event){
		$("#myModal").modal('hide');
	});
	
	if(${categoryNo!=1}){
		$("#myModal").modal();
		$('.modal-body').html("<p>상품이 등록되었습니다.</p>");
	}
	
	var categoryNo = "";
	$('.dropdown-menu').on('click','.dropdown-item',function(event){
		categoryNo = $(this).data("cateno");
		$('#categoryNo').text($(this).text());
		$('#hiddenCategoryNo').val(categoryNo);
	});
	
	var propertyIndexList = [1];
  	var productIndex = Number($('#productIndex').val());
	$('#propertyRow').on('click',"i[id*='addProperty']",function(event){ // 속성 입력 행 추가하기
		productIndex = Number(productIndex)+1;
		$('#productIndex').val(productIndex);
		
		for(var i=0;i<propertyIndexList.length;i++ ){
			$('#deleteProperty'+propertyIndexList[i]).show();
		}
		var formerRow = propertyIndexList[(propertyIndexList.length-1)];
		propertyIndexList.push(productIndex);
        
		var propertyStr = "<div class='col-sm-6 mb-3 mb-sm-0' id='addedSize"+productIndex+"'>";
		propertyStr+="<input type='text' class='form-control form-control-user' id='productSize"+productIndex+"' placeholder='상품 사이즈 입력'>";
		propertyStr+="<i style='float:left;' id='deleteProperty"+productIndex+"' data-propertyrow="+productIndex+" >- 속성 입력 행 삭제</i></div>";
		propertyStr+="<div class='col-sm-6 mb-3 mb-sm-0' id='addedColor"+productIndex+"'>";
		propertyStr+="<input type='text' class='form-control form-control-user' id='productColor"+productIndex+"' placeholder='상품 색상 입력'>";
		propertyStr+="<i style='float:right;' id='addProperty"+productIndex+"' >+ 속성 입력 행 추가</i></div>";
		propertyStr+="<input type='hidden' id='propertyLocation"+productIndex+"' />";
		
		$("#propertyLocation"+formerRow).after(propertyStr);
		$('#addProperty'+formerRow).hide();
	});  
	
	$('#propertyRow').on('click',"i[id*='deleteProperty']",function(event){ // 속성 입력 행 삭제하기
        var thisRow = $(this).data('propertyrow');
		$('#addedSize'+thisRow).remove();
		$('#addedColor'+thisRow).remove();
		$('#propertyLocation'+thisRow).remove();
		
		propertyIndexList = propertyIndexList.filter(function(idx) {
			  return idx != thisRow;
		});
		if(propertyIndexList.length==1){
			$('#addProperty'+propertyIndexList[0]).show();
			$('#deleteProperty'+propertyIndexList[0]).hide(); 
		}else{
			for(var i=0;i<propertyIndexList.length;i++ ){
				$('#deleteProperty'+propertyIndexList[i]).show();
			}
		}
		$('#addProperty'+propertyIndexList[(propertyIndexList.length-1)]).show();
	});  
	
	$("#productAttach").on('change',function(event) { //상품 파일 올리면 이미지파일 형식인지 확인, 이미지파일이면 미리보기
				const productImage = $("#productAttach");
				const formData = new FormData();
				formData.append("attach", productImage.file);// hashmap 형식 
				var extensionLocation = $("#productAttach").val()
						.lastIndexOf(".")
				var extension = $("#productAttach").val().substr(
						extensionLocation + 1);
				if (extension == "jpeg" || extension == "jfif"
						|| extension == "gif" || extension == "jpg"
						|| extension == "png" || extension == "ppm") {
							var uploadImage = event.target.files[0];
						    var reader = new FileReader();
						    reader.onload = function(event) {
						      $('#showProductImage').attr('src',event.target.result);
						    };
						    reader.readAsDataURL(uploadImage);
				} else {
					$("#myModal").modal();
					$('.modal-body').html("<p>이미지 파일을 업로드하세요.</p>");
					$("#productAttach").val("")
				}
			});
	
	var colors = [];
	var sizes = [];
	$('#addNewProduct').on('click',function(event){
		if(categoryNo==""){
			$("#myModal").modal();
			$('.modal-body').html("<p>상품 분류를 선택하세요.</p>");
			return false;
		}else if($("#productName").val()==""){
			$("#myModal").modal();
			$('.modal-body').html("<p>상품 이름을 입력하세요.</p>");
			return false;
		}else if($("#productContent").val()==""){
			$("#myModal").modal();
			$('.modal-body').html("<p>상품 설명을 입력하세요.</p>");
			return false;
		}
		
		
		for(var i=0;i<propertyIndexList.length;i++){
			if($('#productSize'+propertyIndexList[i]).val()==""){
				$("#myModal").modal();
				$('.modal-body').html("<p>상품 사이즈를 입력하세요.</p>");
				return false;
			}else if($('#productColor'+propertyIndexList[i]).val()==""){
				$("#myModal").modal();
				$('.modal-body').html("<p>상품 색상을 입력하세요.</p>");
				return false;
			}
		}
		
		for(var i=0;i<propertyIndexList.length;i++){
			for(var j=0;j<propertyIndexList.length;j++){
				if(i!=j&&($('#productSize'+propertyIndexList[i]).val()==$('#productSize'+propertyIndexList[j]).val()
						&&$('#productColor'+propertyIndexList[i]).val()==$('#productColor'+propertyIndexList[j]).val())){
					$("#myModal").modal();
					$('.modal-body').html("<p>중복된 옵션 값이 있습니다.</p>");
					return false;
				}
			}
		}
		
		if($("#productPrice").val()==""){
			$("#myModal").modal();
			$('.modal-body').html("<p>상품 가격을 입력하세요.</p>");
			return false;
		}else if($("#productAttach").val()==""){
			$("#myModal").modal();
			$('.modal-body').html("<p>상품 이미지를 등록하세요.</p>");
			return false;
		}
		
		for(var i=0;i<propertyIndexList.length;i++){
			colors.push($('#productColor'+propertyIndexList[i]).val());
			sizes.push($('#productSize'+propertyIndexList[i]).val());
		}
		$('#sizes').val(sizes);
		$('#colors').val(colors);
		
		$('#addProductForm').submit();
	});

	
});
</script>

</html>