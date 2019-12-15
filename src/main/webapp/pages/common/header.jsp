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
						<a href="${PATH}/pages/user_center_info.jsp">用户中心</a>
						<span>|</span>
						<a href="cart.html">我的购物车</a>
						<span>|</span>
						<a href="${PATH}/pages/user_center_order.jsp">我的订单</a>
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
						<span>|</span>
						<a href="${PATH}/pages/admin-login.jsp">后台登录</a>
					</div>
				</c:when>
			</c:choose>
		</div>
	</div>		
</div>
<div class="search_bar clearfix">
		<a href="index.html" class="logo fl"><img style="border:0;width:100px;height:75px;" src="${PATH}/pages/images/logo.png"></a>
		<div class="search_con fl">
			<input type="text" class="input_text fl" name="" placeholder="搜索商品">
			<input type="button" class="input_btn fr" name="" value="搜索">
		</div>
		<c:choose>
		<c:when test="${not empty sessionScope.name}">
			<div class="guest_cart fr">
				<a href="#" class="cart_name fl">我的购物车</a>
				<div class="goods_count fl" id="show_count">1</div>
			</div>
		</c:when>
		</c:choose>
	</div>