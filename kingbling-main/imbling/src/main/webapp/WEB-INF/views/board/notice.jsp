<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <!-- meta -->
    <%--    <jsp:include page="/WEB-INF/views/modules/common-meta.jsp" />--%>
    <!-- Css Styles ,font -->
    <jsp:include page="/WEB-INF/views/modules/common-css.jsp"/>
    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp"/>
    <style>

    </style>
    <title>notice</title>
</head>
<body>

<div class="container">
    <jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp"/>
    <jsp:include page="/WEB-INF/views/modules/header.jsp"/>

    <a href="event" class="btn btn-secondary">게시판홈</a>
    <a href="notice" class="btn btn-secondary">공지사항</a>
    <a href="review" class="btn btn-secondary">상품후기</a>
    <br><br>


    <!-- ****************************** accordion(자주 묻는 질문) ************************** -->


    <!-- ****************************** card header ************************** -->
    <div class="card shadow mb-4">
        <div class="card">
            <div class="card-header py-3">
                <div style="float: right;">
                    <c:if test="${loginuser.userId=='admin'}">
                    <a href="faqWrite" class="btn btn-dark" style="margin-bottom: 10px;">글쓰기</a></button>
                    </c:if>
                </div>
                <ul class="nav nav-pills">
                    <li class="nav-item"><a class="nav-link active" href="#order" data-toggle="tab">주문/결제</a></li>
                    <li class="nav-item"><a class="nav-link" href="#delivery" data-toggle="tab">배송문의</a></li>
                    <li class="nav-item"><a class="nav-link" href="#registration" data-toggle="tab">회원가입, 로그인</a></li>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                        1:1문의
                    </button>
                </ul>
            </div>
            <!-- ****************************** end of card header ************************** -->
            <!-- ****************************** accordion(자주 묻는 질문) ************************** -->
            <div class="card-body">
                <div class="tab-content">
                    <!-- ****************************** 주문, 결제 ************************** -->
                    <div class="active tab-pane" id="order">
                        <c:forEach var="faq" items="${faqs}">
                            <c:set var="i" value="${i+1}"/>
                            <div class="accordion" id="orderExample${i}">
                                <div class="card">
                                    <div class="card-header" id="orderHeadingOne${i}">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link" type="button" data-toggle="collapse"
                                                    data-target="#orderCollapseOne${i}" aria-expanded="true"
                                                    aria-controls="orderCollapseOne${i}">
                                                ❤️ ${faq.faqTitle}
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="orderCollapseOne${i}" class="collapse"
                                         aria-labelledby="orderHeadingOne${i}"
                                         data-parent="#orderExample${i}">
                                        <div class="card-body">
                                                ${faq.faqContent}
                                            <c:choose>
                                                <c:when test="${loginuser.userId=='admin'}">
                                                    <hr>
                                                    <a class="btn btn-success"
                                                       href="faqEdit?faqNo=${faq.faqNo}&pageNo=${pageNo}&faqCategory=${faq.faqCategory}">글
                                                        수정</a>
                                                </c:when>
                                                <c:otherwise>
                                                    ❤️
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <!-- ****************************** end of 주문, 결제 ************************** -->
                    <!-- ****************************** 배송문의 ************************** -->
                    <div class="tab-pane" id="delivery">
                        <c:forEach var="faq2" items="${faq2s}">
                            <c:set var="k" value="${k+1}"></c:set>
                        <div class="accordion" id="accordionExample${k}">
                            <div class="card">
                                <div class="card-header" id="headingOne${k}">
                                    <h2 class="mb-0">
                                        <button class="btn btn-link" type="button" data-toggle="collapse"
                                                data-target="#collapseOne${k}" aria-expanded="true"
                                                aria-controls="collapseOne${k}">
                                            🧡${faq2.faqTitle}
                                        </button>
                                    </h2>
                                </div>

                                <div id="collapseOne${k}" class="collapse" aria-labelledby="headingOne${k}"
                                     data-parent="#accordionExample${k}">
                                    <div class="card-body">
                                            ${faq2.faqContent}
                                                <c:choose>
                                                    <c:when test="${loginuser.userId=='admin'}">
                                                    <hr>
                                                        <a class="btn btn-success"
                                                           href="faqEdit?faqNo=${faq2.faqNo}&pageNo=${pageNo}&faqCategory=${faq2.faqCategory}">글
                                                            수정</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        🧡
                                                    </c:otherwise>
                                                </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                    <!-- ****************************** end of 회원가입, 로그인 ************************** -->
                    <div class="tab-pane" id="registration">
                        <c:forEach var="faq3" items="${faq3s}">
                        <c:set var="j" value="${j+1}"></c:set>
                        <div class="accordion" id="registExample${j}">
                            <div class="card">
                                <div class="card-header" id="headingOne">
                                    <h2 class="mb-0">
                                        <button class="btn btn-link" type="button" data-toggle="collapse"
                                                data-target="#collapseOne${j}" aria-expanded="true"
                                                aria-controls="collapseOne${j}">
                                            💛${faq3.faqTitle}
                                        </button>
                                    </h2>
                                </div>

                                <div id="collapseOne${j}" class="collapse" aria-labelledby="headingOne${j}"
                                     data-parent="#registExample${j}">
                                    <div class="card-body">
                                            ${faq3.faqContent}
                                                <c:choose>
                                                    <c:when test="${loginuser.userId=='admin'}">
                                                        <hr>
                                                        <a class="btn btn-success"
                                                           href="faqEdit?faqNo=${faq3.faqNo}&pageNo=${pageNo}&faqCategory=${faq3.faqCategory}">글
                                                            수정</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        💛
                                                    </c:otherwise>
                                                </c:choose>
                                    </div>
                                </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- ******************************  1:1문의 ************************** -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
                         aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <form name="boardModal" method="post" action="boardModal" id="boardModal">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">1:1문의</h5>
                                    <div> 작성자: ${loginuser.userId} </div>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                        <div class="form-group">
                                            <label for="recipient-name" class="col-form-label">제목:</label>
                                            <input type="text" class="form-control" id="recipient-name"
                                                   name="boardTitle">
                                            <input type="hidden" class="form-control" name="boardCategory" value="3">
                                            <input type="hidden" name="userId" value="${loginuser.userId}">
                                        </div>
                                        <div class="form-group">
                                            <label for="message-text" class="col-form-label">내용:</label>
                                            <textarea class="form-control" id="message-text"
                                                      name="boardContent"></textarea>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기
                                            </button>
                                            <input id="submitBtn" type="submit" class="btn btn-primary" value="작성완료">
                                        </div>
                                </div>
                            </div>
                                    </form>
                    <!-- ****************************** end of 1:1문의 ************************** -->
                </div>
            </div>
        </div>
    </div>
    <!-- ****************************** end of accordion ************************** -->
    <!-- ****************************** qna 리스트 보여주기 ************************** -->
    <br>
    <br>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <span>공지사항 리스트</span>
            <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                           aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
            </form>
            <%--    c:if 활용하여 adminuser일 때만 편집 가능하도록 구현--%>
            <div style="float: right;">
                <c:if test="${loginuser.userId=='admin'}">
                <a href="noticeWrite" class="btn btn-dark" style="margin-bottom: 10px;">글쓰기</a></button>
                </c:if>
            </div>
        </div>
        <form method="get" name="noticeWrite">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>글번호</th>
                            <th>카테고리</th>
                            <th>작성자</th>
                            <th>제목</th>
                            <th>작성날짜</th>
                            <th>조회수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="board" items="${boards}">
                            <tr>
                                <td>${board.boardNo}</td>
                                <td>${board.boardCategory}</td>
                                <td>${board.userId}</td>
                                    <%--                                <td><a href="noticeDetail?boardCategory=${board.boardCategory}&boardNo=${board.boardNo}&pageNo=${pageNo}">${board.boardContent}</a></td>--%>
                                <td>
                                    <a href="noticeDetail?boardNo=${board.boardNo}&pageNo=${pageNo}&boardCategory=${board.boardCategory}">${board.boardTitle}</a>
                                </td>
                                <td><fmt:formatDate pattern="yy-MM-dd" value="${board.boardRegDate1}"/></td>
                                <td>${board.boardCount}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </form>
    </div>
    <!-- ****************************** end of qna 리스트 보여주기 ************************** -->
    <!-- ****************************** 1:1 문의사항 리스트 보여주기 ************************** -->
    <!--답변 버튼누르면 모달로 답변 조회 가능함; 열람은 로그인 한 사람과 관리자만 볼 수 있도록 구현-->
    <br>
    <br>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <span>1:1 문의사항 리스트</span>
            <%--    c:if 활용하여 adminuser일 때만 편집 가능하도록 구현--%>
            <div style="float: right;">
                <c:if test="${loginuser.userId=='admin'}">
                <button type="button" class="btn btn-dark" style="margin-bottom: 10px;">편집하기</button>
                </c:if>
            </div>
        </div>
        <form method="get" name=showModal action="showModal" id="showModal">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>작성날짜</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>답변</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="board2" items="${boards2}">
                            <tr>
                                <td>${board2.boardNo}</td>
                                <td><fmt:formatDate pattern="yy-MM-dd" value="${board2.boardRegDate1}"/></td>
                                <td>${board2.boardTitle}</td>
                                <td>${board2.userId}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${loginuser.userId == 'admin'}">
                                            <button type="button" class="btn btn-primary btnShowAnswerModal" data-boardno="${board2.boardNo}">1:1문의</button>
                                            <a href="modalDetail?boardNo=${board2.boardNo}&pageNo=${pageNo}&boardCategory=${board2.boardCategory}"class="btn btn-dark"><i class="fas fa-sticky-note"></i>상세보기</a>
                                        </c:when>
                                        <c:when test="${loginuser.userId eq board2.userId}">
                                            <button type="button" class="btn btn-primary btnShowAnswerModal" data-boardno="${board2.boardNo}">1:1문의</button>
                                            <a href="modalDetail?boardNo=${board2.boardNo}&pageNo=${pageNo}&boardCategory=${board2.boardCategory}"class="btn btn-dark"><i class="fas fa-sticky-note"></i>상세보기</a>
                                        </c:when>
                                    </c:choose>

                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>
        <%-- =======================================모달창 상세보기==========================================       --%>
        <div class="modal fade" id="modalDetail" tabindex="-1" role="dialog"
             aria-hidden="true">
            <div class="modal-dialog" role="document"style="background-color: white">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalDetailLabel">1:1문의</h5>
                    <div> &nbsp;&nbsp;작성자: <span id="boardDetailUserId" style="color:#393E46"></span></div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
<%--         화면에 보여지는 것           --%>
                    <form method="get">
                        <div class="form-group">
                            <label for="boardDetailTitle" class="col-form-label">제목:</label>
                            <input type="text" class="form-control" name="boardTitle" id="boardDetailTitle"
                                   value="" style="color:#393E46">
                            <input type="hidden" class="form-control" name="boardCategory" id="boardDetailCategory"
                                   value="">
                        </div>
                        <div class="form-group">
                            <label for="boardDetailContent" class="col-form-label">내용:</label>
                            <textarea class="form-control" id="boardDetailContent"
                                      name="boardContent" style="color: #393E46"></textarea>
                        </div>
                    </form>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="comments">답변달기</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        </div>

                </div>
            </div>
        </div>
        <!-- ****************************** end of 1:1문의 ************************** -->
    </div>
</div>
    </div>
</div>


<jsp:include page="/WEB-INF/views/modules/footer.jsp"/>
<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp"/>

<script type="text/javascript">
    //

    $("document").ready(function () {
        const accordion = $(".btn-link");
        let i;

        for (i = 0; i < accordion.length; i++) {
            accordion.click(function () {

                accordion.removeClass("active");
                accordion.next().css("display", "none");
                $(this).toggleClass("active");
                $(this).next().toggle();
            })
        }
    });

    $(function () {
        $('#exampleModal').on('show.bs.modal', function (event) {
        });
        $('#comments').on('click', function(event){

            $('#commentTest').modal('show');
        });


        $('.btnShowAnswerModal').on('click', function (event) {
            // 데이터 조
            $.ajax({
                "url": "showModalDetail",
                "method": "get",
                "data": { "boardNo" : $(this).data("boardno"), "categoryNo" : 3 },
                "success": function (data, status, xhr) {
                    $('#modalDetail #boardDetailUserId').text(data.userId);
                    $('#modalDetail #boardDetailTitle').val(data.boardTitle);
                    $('#modalDetail #boardDetailContent').val(data.boardContent);
                    $('#modalDetail').modal('show');
                },
                "error": function (xhr, status, err) {
                    alert('데이터 조회 오류');
                }
            });

        });

        $('#submitBtn').on('click', function(event) {
            event.preventDefault();

            const modalData = $('#boardModal').serialize();
            $.ajax({
                "url": "qnaBoardModal",
                "method": "post",
                "data": modalData,
                "success": function (data, status, xhr) {
                    if (data == "success") {
                        $('#exampleModal').modal('hide');
                    }
                },
                "error": function (xhr, status, err) {

                }
            });
        });

        $('#dataTable1').dataTable({

        });

    });
</script>
</body>
</html>