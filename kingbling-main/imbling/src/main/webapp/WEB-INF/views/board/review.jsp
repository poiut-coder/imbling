<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <!-- meta -->
    <%--    <jsp:include page="/WEB-INF/views/modules/common-meta.jsp" />--%>
    <!-- Css Styles ,font -->
    <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
    <jsp:include page="/WEB-INF/views/modules/admin/common-css.jsp" />

    <title>상품후기</title>
</head>


<body>

<div class="container">
    <jsp:include page="/WEB-INF/views/modules/common-offcanvas.jsp" />
    <jsp:include page="/WEB-INF/views/modules/header.jsp" />
<!-- ****************************** 바로가기메뉴 ************************** -->
    <a href="event"class="btn btn-secondary">게시판홈</a>
    <a href="notice"class="btn btn-secondary">공지사항</a>
    <a href="review"class="btn btn-secondary">상품후기</a>
    <br><br>
<!-- ****************************** end of 바로가기메뉴 ************************** -->
<!-- ****************************** 상품후기 상단바 ************************** -->
    <div>
        <section class="breadcrumb-blog set-bg" data-setbg="/resources/dist/img/banner/review4.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <h2 style="color: black">상품후기</h2>
                    </div>
                </div>
            </div>
        </section>
<!-- ****************************** end of 상품후기 상단바 ************************** -->
<!-- ****************************** 베스트리뷰 ************************** -->
        <section class="blog spad">
            <div class="container">
                <h2>베스트 상품후기</h2>
                <div class="row">
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic set-bg" data-setbg="/resources/dist/img/banner/review1.png"></div>
                            <div class="blog__item__text">
                                <span><img src="/resources/dist/img/icon/calendar.png" alt="">2023.02.10</span>
                                <h5>로즈골드 티타늄 귀걸이</h5>
                                <span>₩6,400</span>
                                <span>로즈골드 티타늄 샤이닝 컷팅 원터치 링귀걸이</span>
                                <a href="/product/detail?productNo=3789&categoryNo=1641">Read More</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic set-bg" data-setbg="/resources/dist/img/banner/review2.png"></div>
                            <div class="blog__item__text">
                                <span><img src="/resources/dist/img/icon/calendar.png" alt=""> 2023.03.10</span>
                                <h5>볼드 진주 이어커프</h5>
                                <span>₩4,900</span>
                                <span>볼드 진주  이어커프 링 귀찌 피어싱 귀걸이</span>
                                <a href="/product/detail?productNo=3789&categoryNo=1641">Read More</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic set-bg" data-setbg="/resources/dist/img/banner/review3.png"></div>
                            <div class="blog__item__text">
                                <span><img src="/resources/dist/img/icon/calendar.png" alt="">2023.02.10</span>
                                <h5>볼라레 더블큐빅 귀걸이</h5>
                                <span>₩16,490</span>
                                <span>볼라레 더블큐빅 투웨이 귀걸이</span>
                                <a href="/product/detail?productNo=3713&categoryNo=1641">Read More</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <hr>
<!-- ****************************** end of 베스트리뷰 ************************** -->
<!-- ****************************** 후기리스트 ************************** -->
        <h2>후기리스트</h2>
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <span>후기</span>
                <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
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
                    <a href="writeReview"class="btn btn-secondary">후기 작성하기</a>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="reviewTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>상품명</th>
                            <th>제목</th>
                            <th>별점</th>
                            <th>작성자</th>
                            <th>조회수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="review" items="${reviews}">
                            <tr>
                                <td>
                                    ${review.productDto.productName}
                                </td>
                                <td><a href="reviewDetail?reviewNo=${review.reviewNo}">${review.reviewTitle}</a></td>
                                    <c:choose>
                                        <c:when test="${review.reviewStar == 5}">
                                            <td>⭐️⭐️⭐️⭐️⭐️</td>
                                        </c:when>
                                        <c:when test="${review.reviewStar == 4}">
                                            <td>⭐️⭐️⭐️⭐️️</td>
                                        </c:when>
                                        <c:when test="${review.reviewStar == 3}">
                                            <td>⭐️⭐️⭐️️</td>
                                        </c:when>
                                        <c:when test="${review.reviewStar == 2}">
                                            <td>⭐️⭐️</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>⭐️</td>
                                        </c:otherwise>
                                    </c:choose>
                                <td>${review.userId}</td>
                                <td>
                                    ${review.reviewCount}
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
<!-- ****************************** end of ************************** -->
    </div>
</div>
<jsp:include page="/WEB-INF/views/modules/footer.jsp" />

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<jsp:include page="/WEB-INF/views/modules/admin/common-js.jsp"/>
<script type="text/javascript">

    $(function (){
        $('#reviewTable').dataTable({

        });
    });

</script>



</body>
</html>