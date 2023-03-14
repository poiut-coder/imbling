<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<ul style="float: right;" class="login">
	<c:choose>
		<c:when test="${empty loginuser}">
			<li><a href="/member/login">로그인</a></li>
			<li><a href="/member/register">회원가입</a></li>
		</c:when>
		<c:otherwise>
			<li>${ loginuser.userId }님안녕하세요~!</li>
			<li><a href="/member/logout">로그아웃 </a></li>
		</c:otherwise>
	</c:choose>
</ul>