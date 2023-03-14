<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />
    <title>게시판 편집</title>

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
            <form method="post" id="noticeEdit" action="noticeEdit">
                <input type="hidden" name="attach" value="">
                <input type="hidden" name="savedFileName" value="">
            <div style="float: right;">
                <input id="cancelBtn" type="button" class="btn btn-danger" value="취소하기">
                <input id="submitBtn" type="submit" class="btn btn-success" value="작성완료">
            </div>
            <h5>게시글 수정</h5>
            <%--    c:if 활용하여 adminuser일 때만 편집 가능하도록 구현--%>
        </div>
            <div class="card-body">
                <div class="col-sm-6" style="float: right;">
                    <div class="form-group">
                        <label for="boardCategory">게시판 종류</label>
                        <select class="form-control" id="boardCategory" name="boardCategory">
                        <c:choose>
                        <c:when test="${board.boardCategory==1}">
                            <option name="boardCategory" value="1" selected>이벤트</option>
                            <option name="boardCategory" value="2">공지사항</option>
                        </c:when>
                        <c:otherwise>
                            <option name="boardCategory" value="2" selected>공지사항</option>
                            <option name="boardCategory" value="1">이벤트</option>
                        </c:otherwise>
                        </c:choose>
                        </select>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="userId">작성자</label>
                        <input type="text" class="form-control" id="userId" name="userId" value="${loginuser.userId}" readonly>
                        <input type="hidden" class="form-control" id="boardRegDate1" name="boardRegDate1" value="${board.boardRegDate1}">
                        <input type="hidden" class="form-control" id="boardRegDate2" name="boardRegDate2" value="${board.boardRegDate2}">
                    </div>
                </div>
<%--                <div class="col-sm-6"style="float: right;">--%>
<%--                    <div class="form-group">--%>
<%--                        <label for="boardRegDate2">이벤트 마감날짜</label>--%>
<%--                        <input type="hidden" class="form-control" id="boardRegDate2" name="boardRegDate2" value="${board.boardRegDate2}">--%>
<%--                        --%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-sm-6">--%>
<%--                    <div class="form-group">--%>
<%--                        <label for="boardRegDate1">이벤트 시작날짜</label>--%>
<%--                        <input type="hiddn" class="form-control" id="boardRegDate1" name="boardRegDate1" value="${board.boardRegDate1}">--%>
<%--                    </div>--%>
<%--                </div>--%>

                <div class="col-lg-12">
                    <div class="form-group">
                        <label>제목</label>
                        <input type="text" class="form-control" placeholder="공지사항제목" name="boardTitle" value="${board.boardTitle}">
                        <input type="hidden" class="form-control" readonly name="boardNo" value="${board.boardNo}">
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
                                <textarea id="boardContent" name="boardContent">${board.boardContent}</textarea>
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

        $('#boardContent').summernote({
            placeholder: '관리자가 공지사항 작성',
            tabsize: 2,
            height: 500,
            lang:'ko-KR',
            callbacks: {	//여기 부분이 이미지를 첨부하는 부분
                onImageUpload : function(files) {
                    editSummernoteImageFile(files[0],this);
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

        function editSummernoteImageFile(file, editor){
            data = new FormData();
            data.append("file", file);
            $.ajax({
                data : data,
                type : "POST",
                url:"/board/editNoticeImageFile",
                contentType: false,
                processData: false,
                success: function(data){
                    $(editor).summernote('insertImage', data.url)
                    $('#noticeEdit input[name=attach]').val(data.attach);
                    $('#noticeEdit input[name=savedFileName]').val(data.savedFileName);
                }
            });

        }

        $(function (){
            $('#cancelBtn').on('click', function (event){
                location.href='noticeDetail?boardNo=${board.boardNo}&pageNo=${pageNo}';
            });

            $('#submitBtn').on('click', function (event){
                event.preventDefault();
                const boardTitle = $('input[name = boardTitle]').val();
                const boardContent = $('textarea[name = boardContent]').val();
                //const boardCategory = $('select[name="boardCategory"]').val();


                if (boardTitle.length==0){
                    alert("제목 빠짐")
                    return;
                }else if(boardContent.length==0){
                    alert("내용이 없다")
                    return;
                }else if(boardCategory == null){
                    alert("아이고오 카테고리가 빠졌슈")
                    return;
                }else{
                    $('#noticeEdit')[0].submit();
                }
            });

        });

</script>
</body>
</html>
