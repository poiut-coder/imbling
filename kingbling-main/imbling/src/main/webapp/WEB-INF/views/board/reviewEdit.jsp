<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />
    <title>상품후기수정</title>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp" />
    <jsp:include page="/WEB-INF/views/modules/header.jsp" />
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <form method="post" id="reviewEdit" action="reviewEdit" name="reviewEdit">
                <input type="hidden" name="attach" value="">
                <input type="hidden" name="savedFileName" value="">
            <div style="float: right;">
                <input id="submitBtn" type="button" class="btn btn-success" value="수정완료">
            </div>
            <h5>소중한 리뷰</h5>
            <%--    c:if 활용하여 adminuser일 때만 편집 가능하도록 구현--%>
        </div>
        <div class="card-body">
            <div class="col-sm-6" style="float: right;">
                <div class="form-group">
                    <label>별점</label>
                    <select class="form-control" id="reviewStar" name="reviewStar">
                        <option selected value="5">별점을 선택해 주세요</option>
                                    <option value="5">⭐️⭐️⭐️⭐️⭐️</option>
                                    <option value="4">⭐️⭐️⭐️⭐️️</option>
                                    <option value="3">⭐️⭐️⭐️️</option>
                                    <option value="2">⭐️⭐️</option>
                                    <option value="1">⭐️</option>

                    </select>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label>주문명</label>
                    <input type="text" class="form-control" id="orderNo" name="orderNo" value="${review.orderDto.orderNo}" readonly>
                </div>
            </div>

            <div class="col-sm-6" style="float: right;">
                <div class="form-group">
                    <label>상품명</label>
                    <input type="hidden" class="form-control" id="propertyNo" name="propertyNo" value="${review.propertyDto.propertyNo}">
                    <input type="hidden" class="form-control" id="productNo" name="productNo" value="${review.productDto.productNo}">
                    <input type="text" class="form-control" id="propertyName" value="${review.productDto.productName}" readonly>
                    <input type="hidden" class="form-control" id="reviewNo" value="${review.reviewNo}" name="reviewNo" readonly>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label>작성자</label>
                    <input type="text" class="form-control" id="userId" name="userId" value="${review.userId}" readonly>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="form-group">
                    <label>제목</label>
                    <input type="text" class="form-control" placeholder="후기제목" id="reviewTitle" name="reviewTitle" value="${review.reviewTitle}">
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
                    <thead hidden>
                    <tr>
                        <th>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <textarea id="reviewContent" name="reviewContent">${review.reviewContent}</textarea>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        </form>
    </div>
</div>
<br>
<br>

<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="/resources/dist/js/summernote-ko-KR.js"></script>
<script type="text/javascript">

    $('#reviewContent').summernote({
        placeholder: '리뷰',
        tabsize: 2,
        height: 500,
        lang:'ko-KR',
        callbacks: {	//여기 부분이 이미지를 첨부하는 부분
            onImageUpload: function (files) {
                uploadSummernoteImageFile(files[0], this);
            },
            onPaste: function (e) {
                var clipboardData = e.originalEvent.clipboardData;
                if (clipboardData && clipboardData.items && clipboardData.items.length) {
                    var item = clipboardData.items[0];
                    if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
                        e.preventDefault();
                    }
                }
            }
        }

    });


    function uploadSummernoteImageFile(file, editor){
        data = new FormData();
        data.append("file", file);
        $.ajax({
            data : data,
            type : "POST",
            url:"/board/editReviewImageFile",
            contentType: false,
            processData: false,
            success: function(data){
                $(editor).summernote('insertImage', data.url)
                $('#reviewEdit input[name=attach]').val(data.attach);
                $('#reviewEdit input[name=savedFileName]').val(data.savedFileName);

            }
        });
    }

    $(function (){
        $('#submitBtn').on('click', function (event){
            event.preventDefault();
            $('#reviewEdit')[0].submit();
        });

    });

</script>
</body>
</html>
