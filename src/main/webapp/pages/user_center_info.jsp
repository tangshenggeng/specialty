<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>草原兴发-用户中心</title>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css"/>
</head>
<body>
	<%@ include file="/pages/common/header.jsp"%>

	<div class="main_con clearfix">
		<div class="left_menu_con clearfix">
			<h3>用户中心</h3>
			<ul>
				<li><a href="${PATH}/pages/user_center_info.jsp" class="active">· 个人信息</a></li>
				<li><a href="${PATH}/pages/user_center_order.jsp">· 全部订单</a></li>
				<li><a href="${PATH}/pages/user_center_site.jsp">· 收货地址</a></li>
			</ul>
		</div>
		<div class="right_content clearfix">
				<div class="info_con clearfix">
				<h3 class="common_title2">基本信息</h3>
						<ul class="user_info_list">
							<li><span>用户名：</span>18210569700</li>
							<li><span>联系方式：</span>18210569700</li>
							<li><span>联系地址：</span>北京市昌平区</li>			
						</ul>
				</div>
				
				<h3 class="common_title2">最近浏览</h3>
				<div class="has_view_list">
					<ul class="goods_type_list clearfix">
				<li>
					<a href="detail.html"><img src="images/goods/goods003.jpg"></a>
					<h4><a href="detail.html">大兴大棚草莓</a></h4>
					<div class="operate">
						<span class="prize">￥16.80</span>
						<span class="unit">16.80/500g</span>
						<a href="#" class="add_goods" title="加入购物车"></a>
					</div>
				</li>

				<li>
					<a href="#"><img src="images/goods/goods004.jpg"></a>
					<h4><a href="#">吐鲁番梨光杏</a></h4>
					<div class="operate">
						<span class="prize">￥5.50</span>
						<span class="unit">5.50/500g</span>
						<a href="#" class="add_goods" title="加入购物车"></a>
					</div>
				</li>

				<li>
					<a href="#"><img src="images/goods/goods005.jpg"></a>
					<h4><a href="#">黄肉桃</a></h4>
					<div class="operate">
						<span class="prize">￥10.00</span>
						<span class="unit">10.00/500g</span>
						<a href="#" class="add_goods" title="加入购物车"></a>
					</div>
				</li>

				<li>
					<a href="#"><img src="images/goods/goods006.jpg"></a>
					<h4><a href="#">进口西梅</a></h4>
					<div class="operate">
						<span class="prize">￥28.80</span>
						<span class="unit">28.8/500g</span>
						<a href="#" class="add_goods" title="加入购物车"></a>
					</div>
				</li>

				<li>
					<a href="#"><img src="images/goods/goods007.jpg"></a>
					<h4><a href="#">香梨</a></h4>
					<div class="operate">
						<span class="prize">￥6.45</span>
						<span class="unit">6.45/500g</span>
						<a href="#" class="add_goods" title="加入购物车"></a>
					</div>
				</li>
			</ul>
		</div>
		</div>
	</div>



	<%@ include file="/pages/common/footer.jsp"%>
	
</body>
</html>