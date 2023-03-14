<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />
    <title>상품후기작성</title>

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
            <form method="post" id="reviewDetail" name="reviewDetail" action="reviewDetail">
                <input type="hidden" name="attach" value="">
                <input type="hidden" name="savedFileName" value="">
            <div style="float: right;">
                <a href="/board/review"class="btn btn-success">목록보기</a>
                <c:choose>
                    <c:when test="${loginuser.userId eq review.userId}">
                        <input id="editBtn" type="button" class="btn btn-warning" value="수정하기">
                        <input type="submit" id="deleteBtn" value="글 삭제" class="btn btn-secondary">
                    </c:when>
                    <c:when test="${loginuser.userId =='admin'}">
                        <input id="editBtn" type="button" class="btn btn-warning" value="수정하기">
                        <input type="submit" id="deleteBtn" value="글 삭제" class="btn btn-secondary">
                    </c:when>
                </c:choose>
            </div>
            <h5>소중한 리뷰</h5>
            <%--    c:if 활용하여 adminuser일 때만 편집 가능하도록 구현--%>
        </div>
        <div class="card-body">
            <div class="col-sm-6" style="float: right;">
                <div class="form-group">
                    <label>별점</label>
                    <select class="form-control" id="reviewStar" name="reviewStar">
                            <c:choose>
                                <c:when test="${review.reviewStar == 5}">
                                    <option selected value="5">⭐️⭐️⭐️⭐️⭐️</option>
                                </c:when>
                                <c:when test="${review.reviewStar == 4}">
                                    <option selected value="4">⭐️⭐️⭐️⭐️️</option>
                                </c:when>
                                <c:when test="${review.reviewStar == 3}">
                                    <option selected value="3">⭐️⭐️⭐️️</option>
                                </c:when>
                                <c:when test="${review.reviewStar == 2}">
                                    <option selected value="2">⭐️⭐️</option>
                                </c:when>
                                <c:otherwise>
                                    <option selected value="1">⭐️</option>
                                </c:otherwise>
                            </c:choose>
                    </select>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label>주문명</label>
                    <input type="text" class="form-control" id="orderNo" value="${review.orderDto.orderNo}" name="orderNo" readonly>
                </div>
            </div>

            <div class="col-sm-6" style="float: right;">
                <div class="form-group">
                    <label>상품명</label>
                    <input type="hidden" class="form-control" id="propertyNo" name="propertyNo" value="${review.propertyDto.propertyNo}">
                    <input type="text" class="form-control" id="propertyName" value="${review.productDto.productName}"readonly>
                    <input type="hidden" class="form-control" id="productNo" name="productNo" value="${review.productDto.productNo}">
                    <input type="hidden" class="form-control" id="reviewNo" name="reviewNo" value="${review.reviewNo}">
                    <input type="hidden" class="form-control" id="reviewDeleted" name="reviewDeleted" value="true">
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label>작성자</label>
                    <input type="text" class="form-control" value="${review.userId}" readonly>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="form-group">
                    <label>제목</label>
                    <input type="text" class="form-control" placeholder="후기제목" id="reviewTitle" name="reviewTitle" value="${review.reviewTitle}" readonly>
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
                        <td style="align-content: center;">
                        ${review.reviewContent}
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

    });


    $(function (){
        $('#editBtn').on('click', function (event){
            location.href='reviewEdit?reviewNo=${review.reviewNo}';
        });

        $('#DeleteBtn').on('click', function (event){
            event.preventDefault();

            const agree = confirm("${review.reviewNo}글을 삭제 할까요?");
            if (!agree) return;

            $('#reviewDetail')[0].submit();

        });

    });

</script>
</body>
</html>
