<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


    <thead>
    <tr>
        <th>날짜</th>
        <th>작성자</th>
        <th>내용</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="comment" items="${comments}">
    <tr>
        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${comment.commentRegDate}"/></td>
        <td>${comment.writer}</td>
        <td>${comment.commentContent}</td>
    </tr>
    </c:forEach>



<script type="text/javascript">

</script>
