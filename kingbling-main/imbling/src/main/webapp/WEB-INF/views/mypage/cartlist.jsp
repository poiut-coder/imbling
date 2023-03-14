<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

            <div class="col-lg-8">
                <div class="shopping__cart__table">
                    <table>
                        <thead>
                        <tr>
                        	<th style="width:30px;"><button type="button" id="chkAll" style="font-size:9px;width:46px;float:left;border:1px solid lightgray" class="btn btn-light">전체<br />선택</button></th>
                            <th style="padding-left:20px">주문 제품</th>
                            <th>주문 수량</th>
                            <th>주문 금액</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${carts}" var="cart">
                        <input type="hidden" id="maxEA${cart.propertyNo}" value="${cart.property.productEA}" />
                        <input type="hidden" id="productName${cart.propertyNo}" value="${cart.product.productName}" />
                           <tr id="cartRow" >
                           	<td class="chk">
                           	<c:choose>
                           	<c:when test="${cart.cartChk}"><i class="fa fa-check-square-o" data-proNo="${cart.propertyNo}"></i></c:when>
                           	<c:otherwise><i class="fa fa-square-o" data-proNo="${cart.propertyNo}"></i></c:otherwise>
                           	</c:choose>
                           	</td>
                            <td class="product__cart__item">
                                <div class="product__cart__item__pic">
                                    <img src="${cart.product.productImage}" alt="" style="height:120px; weight: 120px">
                                </div>
                                <div class="product__cart__item__text">
                                    <h6>${cart.product.productName}</h6>
                                    <a>${cart.property.productSize}/${cart.property.productColor}</a>
                                    <h5><fmt:formatNumber value="${cart.product.productPrice}" pattern="₩#,###" /></h5>
                                    
                                </div>
                            </td>
                            <td class="quantity__item">
                                <div class="quantity">
                                    <div class="pro-qty-2">
                                        <i class="fa fa-arrow-down" style="float:left;border:solid 1px lightgray;border-radius:50px" data-proNo="${cart.propertyNo}" data-singleprice="${cart.product.productPrice}"></i>
                                        <input id="cartEA${cart.propertyNo}" type="text" value="${cart.cartEA}" style="border:solid 1px lightgray;border-radius:50px"
                                        data-prono="${cart.propertyNo}" data-singleprice="${cart.product.productPrice}">
                                        <i class="fa fa-arrow-up" style="float:right;border:solid 1px lightgray;border-radius:50px" data-proNo="${cart.propertyNo}" data-singleprice="${cart.product.productPrice}"></i>
                                    </div>
                                </div>
                            </td>
                            <td class="cart__price"><fmt:formatNumber value="${cart.cartTotalPrice}" pattern="₩#,###" /></td>
                            <td class="cart__close"><i class="fa fa-close" id="cartDelete${cart.propertyNo}" data-propertyno="${cart.propertyNo}"></i></td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="continue__btn">
                        	<a href="/product/list">쇼핑 계속 하기</a>
                        	<button style="width:50%" id="chk-order">선택 상품 주문</button>
                            <button style="width:50%" id="chk-delete">선택 상품 삭제</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="cart__total">
                    <h6>장바구니 주문 총계</h6>
                    <ul>
                        <li>주문 총액 <span id="cartTotalPriceResult"><fmt:formatNumber value="${cartTotalPrice}" pattern="₩#,###" /></span></li>
                    </ul>
                    <button id="orderAllCart" class="primary-btn">전체 상품 주문하기</button>
                    <button id="deleteAllCart" class="primary-btn" style="border:1px solid;background:gray">장바구니 🛒 비우기</button>
                </div>
            </div>
        