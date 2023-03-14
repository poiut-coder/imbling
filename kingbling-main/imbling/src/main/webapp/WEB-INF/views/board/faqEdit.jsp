<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />
    <title>faq</title>

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
            <!--=============form start========================================-->
            <form method="post" id="faqEdit" action="faqEdit">
                <input type="hidden" name="attach" value="">
                <input type="hidden" name="savedFileName" value="">
                <div style="float: right;">
                    <a href="notice"class="btn btn-warning"><i class="fas fa-close"></i> 취소하기</a>
                    <input id="submitBtn" type="button" class="btn btn-success" value="작성완료">
                    <input id="deleteBtn" type="button" class="btn btn-secondary" value="삭제하기">
                </div>
                <h5>게시글 작성</h5>
                <%--    c:if 활용하여 adminuser일 때만 편집 가능하도록 구현--%>
        </div>

        <div class="card-body">
            <div class="col-sm-6" style="float: right;">
                <div class="form-group">
                    <label for="faqCategory">게시판 종류</label>
                    <select class="form-control" id="faqCategory" name="faqCategory" required>
                        <c:choose>
                            <c:when test="${faq.faqCategory==1}">
                                <option selected value="1">주문, 결제</option>
                                <option value="2">배송문의</option>
                                <option value="3">회원가입, 로그인</option>
                            </c:when>
                            <c:when test="${faq.faqCategory==2}">
                                <option selected value="2">배송문의</option>
                                <option value="1">주문, 결제</option>
                                <option value="3">회원가입, 로그인</option>
                            </c:when>
                            <c:when test="${faq.faqCategory==3}">
                                <option selected value="3">회원가입, 로그인</option>
                                <option value="1">주문, 결제</option>
                                <option value="2">배송문의</option>
                            </c:when>
                            <c:otherwise>
                                <option selected value="1">주문, 결제</option>
                                <option value="2">배송문의</option>
                                <option value="3">회원가입, 로그인</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label for="faq">게시판</label>
                    <input type="text" class="form-control" id="faq" value="faq 게시판 편집" readonly>
                    <input type="hidden" class="form-control" id="faqRegDate" value="faqRegDate">
                </div>
            </div>
            <div class="col-lg-12">
                <div class="form-group">
                    <label for="faqTitle">제목</label>
                    <input type="hidden" name="updateType" value="">
                    <input type="text" class="form-control" placeholder="자주묻는질문" name="faqTitle" id="faqTitle" value="${faq.faqTitle}">
                    <input type="hidden" class="form-control" readonly name="faqNo" value="${faq.faqNo}">
                    <input type="hidden" class="form-control" readonly name="userId" value="${faq.userId}">
                    <input type="hidden" class="form-control" readonly name="faqDeleted" value="false">
                    <%--                        <input type="hidden" class="form-control" readonly value="userNo">--%>
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
                            <textarea id="faqContent" name="faqContent">${faq.faqContent}</textarea>
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

    $('#faqContent').summernote({
        placeholder: '자주묻는질문 편집게시판',
        tabsize: 2,
        height: 500,
        lang:'ko-KR',
        callbacks: {	//여기 부분이 이미지를 첨부하는 부분
            onImageUpload : function(files) {
                uploadSummernoteImageFile(files[0],this);
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
            url:"/board/uploadFaqImageFile",
            contentType: false,
            processData: false,
            success: function(data){
                $(editor).summernote('insertImage', data.url)
                $('#faqEdit input[name=attach]').val(data.attach);
                $('#faqEdit input[name=savedFileName]').val(data.savedFileName);

            }
        });

    }

    $(function (){


        $('#submitBtn').on('click', function (event){
            event.preventDefault();
            $('input[name=updateType]').val("update");
            const faqTitle = $('input[name=faqTitle]').val();
            const faqContent = $('textarea[name=faqContent]').val();
            const faqCategory = $('select[name=faqCategory]').val();

            if (faqTitle.length==0){
                alert("제목 빠짐")
                return;
            }else if(faqContent.length==0){
                alert("내용빠짐")
                return;
            }else if(faqCategory == null){
                alert("아이고오 카테고리가 빠졌슈")
                return;
            }else{
                $('#faqEdit')[0].submit();
            }
        });

        $('#deleteBtn').on('click', function (event){

            const deleted = $('input[name=faqDeleted]').val()
            $(deleted).on('change', function (event){
                this.value=true;
            });
            const agree = confirm("${faq.faqNo}글을 삭제 할까요?");
            if (!agree) return;

            $('input[name=updateType]').val("delete");
            $('#faqEdit')[0].submit();
        });
    });
</script>
</body>
</html>
