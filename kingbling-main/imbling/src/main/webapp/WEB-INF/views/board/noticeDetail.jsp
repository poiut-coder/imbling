<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />
    <title>상세보기</title>

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
            <form method="post" id="noticeDetail" action="noticeDetail">
            <div style="float: right;">
<%--      내가 하고 싶은 것          --%>
                <c:choose>
                    <c:when test="${board.boardCategory == 1}">
                        <a href="event"class="btn btn-dark"><i class="fas fa-sticky-note"></i>목록보기</a>
                    </c:when>
                    <c:otherwise>
                        <a href="notice"class="btn btn-dark"><i class="fas fa-sticky-note"></i>목록보기</a>
                    </c:otherwise>
                </c:choose>
                <c:if test="${ not empty loginuser and loginuser.userId eq board.userId}">
                <input type="button" id="editBtn" value="글 수정" class="btn btn-success">
                <input type="button" id="deleteBtn" value="글 삭제" class="btn btn-warning">
                </c:if>
            </div>
            <h5>상세보기</h5>
            <%--    c:if 활용하여 adminuser일 때만 편집 가능하도록 구현--%>
        </div>
            <div class="card-body">
                <div class="col-sm-6" style="float: right;">
                    <div class="form-group">
                        <label>게시판 종류</label>
                        <select class="form-control" id="boardCategory" name="boardCategory">
                            <c:choose>
                                <c:when test="${board.boardCategory==1}">
                                    <option name="boardCategory" value="1" selected>이벤트</option>
                                </c:when>
                                <c:otherwise>
                                    <option name="boardCategory" value="2" selected>공지사항</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <div class="form-group">
                            <label for="userId">작성자</label>
                            <input type="text" class="form-control" id="userId" name="userId" value="${board.userId}" readonly>
                            <input type="hidden" class="form-control" id="boardRegDate1" name="boardRegDate1" value="${board.boardRegDate1}">
                            <input type="hidden" class="form-control" id="boardRegDate2" name="boardRegDate2" value="${board.boardRegDate2}">
                            <input type="hidden" class="form-control" id="boardDeleted" name="boardDeleted" value="true">
                            <input type="hidden" class="form-control" id="boardNo" name="boardNo" value="${board.boardNo}">
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="form-group">
                        <label for="boardTitle">제목</label>
                        <input type="text" class="form-control" name="boardTitle"  id="boardTitle" value="${board.boardTitle}" readonly>
                        <input type="hidden" class="form-control" name="boardNo" value="${board.boardNo}">
<%--                        <input type="hidden" class="form-control" readonly value="userNo">--%>
                    </div>
                </div>
                <div class="col-lg-12">
                <div class="table-responsive">
                    <label> 글 내용</label>
                    <table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
                        <thead hidden>
                        <tr>
                            <th>글 내용</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <input type="hidden" class="form-control" id=boardContent" name="boardContent" value="${board.boardContent}">
                            <td style="align-content: center;">
                                ${board.boardContent}
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>
<%--   댓글작성     --%>

        <form id="commentForm" action="commentForm" method="post">
            <input type="hidden" name="boardNo" value="${ board.boardNo }" />
            <input type="hidden" name="pageNo" value="${ pageNo }" />
            <div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
                <div class="row">
                    <div class="col-sm-10">
                        <textarea id="commentContent" name="commentContent" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></textarea>
                    </div>
                        <div class="col-sm-2">
                            <input class="form-control" value="${loginuser.userId}" name="writer" readonly>
                            <a id="writeComment" href="javascript:" class="btn btn-warning" style="width: 100%; margin-top: 10px"> 댓글 등록 </a>
                        </div>
                    </div>
            </div>

<%--      목록샘플      --%>

            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="commentList" width="100%" cellspacing="0">

                    </table>
                </div>
            </div>

        <br>


<%--대댓글쓰기--%>

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


    $(function (){
        $('#editBtn').on('click', function (event){
            location.href='noticeEdit?boardNo=${board.boardNo}&pageNo=${pageNo}&boardCategory=${board.boardCategory}';
        });
        $('#deleteBtn').on('click', function (event){

            const agree = confirm("${board.boardNo}글을 삭제 할까요?");
            if (!agree) return;
            $('#noticeDetail')[0].submit();
        });

        $('#commentList').load("commentList?boardNo=${board.boardNo}");
        $('#writeComment').on('click',function (event){
            const formData = $('#commentForm').serialize();
            $.ajax({
                "url":"/board/commentForm",
                "method":"post",
                "data":formData,
                "success":function(data, status, xhr){
                    if(data == "success"){
                        alert("댓글등록 성공");
                        $('#commentList').load("commentList?boardNo=${board.boardNo}");
                        $('#commentForm textarea').val("");
                    }
                },
                "error": function (xhr, status, err){

                }
            });

        });

    });






</script>
</body>
</html>
