<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="header_con">
	<div class="header">
		<div class="welcome fl">欢迎来到草原兴发!</div>
		<div class="fr">
			<c:choose>
				<c:when test="${not empty sessionScope.name}">
					<div class="login_info fl">
						欢迎您：<em>${sessionScope.name}</em>
					</div>
					<div class="user_link fl">
						<span>|</span>
						<a href="user_center_info.html">用户中心</a>
						<span>|</span>
						<a href="cart.html">我的购物车</a>
						<span>|</span>
						<a href="user_center_order.html">我的订单</a>
						<span>|</span>
						<a href="${PATH}/customer/loginOut">退出登录</a>
					</div>
				</c:when>
				<c:when test="${empty sessionScope.name}">
					<div class="login_btn fl">
						<span>|</span>
						<a href="${PATH}/pages/login.jsp">登录</a>
						<span>|</span>
						<a href="${PATH}/pages/register.jsp">注册</a>
					</div>
				</c:when>
			</c:choose>
		</div>
	</div>		
</div>