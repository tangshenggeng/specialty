<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>天天生鲜-购物车</title>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css"/>
</head>
<body>
	<%@ include file="/pages/common/header.jsp"%>	

	<div class="total_count">全部商品<em>2</em>件</div>	
	<ul class="cart_list_th clearfix">
		<li class="col01">商品名称</li>
		<li class="col02">商品单位</li>
		<li class="col03">商品价格</li>
		<li class="col04">数量</li>
		<li class="col05">小计</li>
		<li class="col06">操作</li>
	</ul>
	<ul class="cart_list_td clearfix">
		<li class="col01"><input type="checkbox" name="" checked></li>
		<li class="col02"><img src="images/goods/goods012.jpg"></li>
		<li class="col03">奇异果<br><em>25.80元/500g</em></li>
		<li class="col04">500g</li>
		<li class="col05">25.80元</li>
		<li class="col06">
			<div class="num_add">
				<a href="javascript:;" class="add fl">+</a>
				<input type="text" class="num_show fl" value="1">	
				<a href="javascript:;" class="minus fl">-</a>	
			</div>
		</li>
		<li class="col07">25.80元</li>
		<li class="col08"><a href="javascript:;">删除</a></li>
	</ul>

	<ul class="cart_list_td clearfix">
		<li class="col01"><input type="checkbox" name="" checked></li>
		<li class="col02"><img src="images/goods/goods003.jpg"></li>
		<li class="col03">大兴大棚草莓<br><em>16.80元/500g</em></li>
		<li class="col04">500g</li>
		<li class="col05">16.80元</li>
		<li class="col06">
			<div class="num_add">
				<a href="javascript:;" class="add fl">+</a>
				<input type="text" class="num_show fl" value="1">	
				<a href="javascript:;" class="minus fl">-</a>	
			</div>
		</li>
		<li class="col07">16.80元</li>
		<li class="col08"><a href="javascript:;">删除</a></li>
	</ul>
	

	<ul class="settlements">
		<li class="col01"><input type="checkbox" name="" checked=""></li>
		<li class="col02">全选</li>
		<li class="col03">合计(不含运费)：<span>¥</span><em>42.60</em><br>共计<b>2</b>件商品</li>
		<li class="col04"><a href="place_order.html">去结算</a></li>
	</ul>

	<%@ include file="/pages/common/footer.jsp"%>
	
</body>
</html>