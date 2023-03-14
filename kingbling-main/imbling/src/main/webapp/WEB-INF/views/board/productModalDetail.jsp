<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />
    <title>1:1 제품문의 상세</title>

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
                <div style="float: right;">
                    <a href="/product/detail?productNo=${productNo}&categoryNo=${categoryDto.categoryNo}"class="btn btn-success">목록보기</a>
                </div>
                <h5>1:1 문의 상세보기</h5>
                <%--    c:if 활용하여 adminuser일 때만 편집 가능하도록 구현--%>
        </div>
        <div class="card-body">
            <div class="col-sm-6" style="float: right;">
                <div class="form-group">
                    <label>상품명</label>
                    <input type="text" class="form-control" id="" value="${productName}" name="orderNo" readonly>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label>작성자</label>
                    <input type="text" class="form-control" id="orderNo" value="${board.userId}" name="orderNo" readonly>
                </div>
            </div>

            <div class="col-lg-12">
                <div class="form-group">
                    <label>제목</label>
                    <input type="text" class="form-control" placeholder="후기제목" value="${board.boardTitle}" readonly>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="form-group">
                    <label>내용</label>
                    <input type="text" class="form-control" placeholder="후기제목" value="${board.boardContent}" readonly>
                </div>
            </div>

        </div>
        </form>
        <form id="questionCommentForm" action="questionCommentForm" method="post">
            <input type="hidden" name="boardNo" value="${ board.boardNo }" />
            <div class="col-sm-9" style="float: right;">
                <div class="form-group">
                    <textarea id="questionCommentContent" name="commentContent" class="form-control" rows="3" placeholder="답변하기"></textarea>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <input class="form-control" value="${loginuser.userId}" name="writer" readonly >
                    <a id="questionCommentBtn" href="javascript:" class="btn btn-primary" style="width: 100%; margin-top: 10px"> 답변하기 </a>
                </div>
            </div>
        </form>
    </div>
</div>
<br>
<br>

<div class="container">
    <div class="table-responsive">
        <table class="table table-bordered" id="questionCommentList" width="100%" cellspacing="0">

        </table>
    </div>
</div>

<br>

<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script src="/resources/dist/js/summernote-ko-KR.js"></script>
<script type="text/javascript">

    $(function (){
        $('#questionCommentList').load("questionCommentList?boardNo=${board.boardNo}");
        $('#questionCommentBtn').on('click',function (event){
            const formData = $('#questionCommentForm').serialize();
            $.ajax({
                "url":"/board/questionCommentForm",
                "method":"post",
                "data":formData,
                "success":function (data, status, xhr){
                    if(data=="success"){
                        alert("답변등록을 완료했습니다");
                        $('#questionCommentFaqList').load("questionCommentList?boardNo=${board.boardNo}");
                        $('#questionCommentForm textarea').val("");
                    }
                },
                "error":function (xhr, status, err){

                }
            });
        });

    });

</script>
</body>
</html>
