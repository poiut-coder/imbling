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
    <title>공지사항 홈</title>
</head>


<body>
<div class="container">
    <jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp"/>
    <jsp:include page="/WEB-INF/views/modules/header.jsp"/>
    <!-- ****************************** 바로가기메뉴 ************************** -->
    <a href="event" class="btn btn-secondary">게시판홈</a>
    <a href="notice" class="btn btn-secondary">공지사항</a>
    <a href="review" class="btn btn-secondary">상품후기</a>
    <br><br>
    <!-- ****************************** end of 바로가기메뉴 ************************** -->

    <!-- ******************************  메인이벤트 ************************** -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <div style="float: right;">
                <c:if test="${loginuser.userId=='admin'}">
                    <a href="#" class="btn btn-secondary">편집하기</a>
                </c:if>
            </div>
            <h5>새로운 이벤트</h5>
        </div>
        <div class="card-body">
            <div class="blog__details__pic">
                <img src="/resources/dist/img/event.png" alt="">
            </div>
        </div>
    </div>
    <!-- ****************************** end of 메인이벤트 ************************** -->
    <!-- ****************************** 이벤트리스트 ************************** -->
    <div class="card shadow mb-4">

        <%--현재날짜--%>
        <jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
        <%--시작날짜 지정--%>
        <fmt:parseDate value="${boardRegDate1}" pattern="yy-MM-dd" var="startDate"></fmt:parseDate>
        <%--마감날짜 지정--%>
        <fmt:parseDate value="${boardRegDate2}" pattern="yy-MM-dd" var="endDate"></fmt:parseDate>
        <%--오늘날짜--%>
        <fmt:formatDate value="${now}" pattern="yy-MM-dd" var="nowDate"></fmt:formatDate>
        <%--시작날짜--%>
        <fmt:formatDate value="${startDate}" pattern="yy-MM-dd" var="openDate"></fmt:formatDate>
        <%--마감날짜--%>
        <fmt:formatDate value="${endDate}" pattern="yy-MM-dd" var="closeDate"></fmt:formatDate>

        <div class="card-header py-3">
            <div>
                <h5>이벤트리스트</h5>
            </div>
            <div class="btn-group dropright">
                <button type="button" class="btn btn-secondary">
                    조회하기
                </button>
                <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="sr-only">Toggle Dropright</span>
                </button>
            </div>
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
                            <th>이벤트기간</th>
                            <th>제목</th>
                            <th>진행상황</th>
                            <th>작성자</th>
                            <th>조회수</th>
                        </tr>
                        </thead>
                        <tbody style="align-content: center;">
                        <c:forEach var="board" items="${boards}">
                            <tr>
                                <td><fmt:formatDate pattern="yy-MM-dd" value="${board.boardRegDate1}"/>
                                    <br>
                                    ~<fmt:formatDate pattern="yy-MM-dd" value="${board.boardRegDate2}"/></td>
                                <td>
                                    <a href="noticeDetail?boardNo=${board.boardNo}&pageNo=${pageNo}&boardCategory=${board.boardCategory}">${board.boardTitle}</a>
                                </td>
                                    <%--                        <td><a href="noticeDetail?boardCategory=${board.boardCategory}&boardNo=${board.boardNo}&pageNo=${pageNo}">${board.boardContent}</a></td>--%>
                                <td>
                                    <c:choose>
                                        <c:when test="${board.boardRegDate2 > now}">
                                            <a href="#" class="btn btn-success btn-icon-split">
                                            <span class="icon text-white-50">
                                                <i class="fas fa-check"></i>
                                            </span>
                                                <span class="text">진행중</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#" class="btn btn-danger btn-icon-split">
                                                <span class="icon text-white-50">
                                                    <i class="fas fa-trash"></i>
                                                </span>
                                                <span class="text">종료됨</span>
                                            </a>

                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${board.userId}</td>
                                <td>${board.boardCount}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>
    </div>
    <!-- ****************************** end of 이벤트리스트 ************************** -->

</div>

<jsp:include page="/WEB-INF/views/modules/footer.jsp"/>
<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp"/>
<script type="text/javascript">


</script>

</body>
</html>