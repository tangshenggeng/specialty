<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>草原兴发-商品详情</title>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css"/>
	<link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
<style>

		input[type=number] {  
    -moz-appearance:textfield;  
}  
input[type=number]::-webkit-inner-spin-button,  
input[type=number]::-webkit-outer-spin-button {  
    -webkit-appearance: none;  
    margin: 0;  
}  
	
	
</style>
</head>
<body>
	<%@ include file="/pages/common/header.jsp"%>
	<div class="navbar_con">
		<div class="navbar clearfix">
			<div class="subnav_con fl">
				<h1>全部商品分类</h1>	
				<span></span>			
				<ul class="subnav">
					<li><a href="${PATH}/food/getBySort/1" class="fruit">新鲜水果</a></li>
					<li><a href="${PATH}/food/getBySort/2" class="seafood">海鲜水产</a></li>
					<li><a href="${PATH}/food/getBySort/3" class="meet">猪牛羊肉</a></li>
					<li><a href="${PATH}/food/getBySort/4" class="egg">禽类蛋品</a></li>
					<li><a href="${PATH}/food/getBySort/5" class="vegetables">新鲜蔬菜</a></li>
					<li><a href="${PATH}/food/getBySort/6" class="ice">速冻食品</a></li>
				</ul>
			</div>
			<ul class="navlist fl">
				<li><a href="${PATH}/pages/index.jsp">首页</a></li>
				<li class="interval">|</li>
				<li><a href="#">手机生鲜</a></li>
				<li class="interval">|</li>
				<li><a href="#">抽奖</a></li>
			</ul>
		</div>
	</div>

	<div class="breadcrumb">
		<a href="${PATH}/food/getBySort/7">全部分类</a>
		<span>></span>
		<a href="#">商品详情</a>
	</div>

	<div class="goods_detail_con clearfix">
		<div class="goods_detail_pic fl"><img style="width: 350px;height: 350px" src="${food.foodImg}"></div>

		<div class="goods_detail_list fr">
			<h3>${food.foodName}</h3>
			<p >${food.foodDesc}</p>
			<div class="prize_bar">
				<span class="show_pirze">原价：<del>¥ ${food.foodOldPrice}</del><em>现价：¥ ${food.foodPresentPrice}</em></span>
				<span class="show_unit" >单  位：${food.foodMassUnit}</span>
				<span class="show_unit">库存：<span >${food.foodStock}</span></span>
			</div>
			<div class="total">总价：<em id="totalPrice">${food.foodPresentPrice}</em> 元</div>
			<div class="goods_num clearfix">
				<div class="num_name fl">数 量：</div>
				<div class="num_add fl">
					<input type="hidden" value="${food.foodId}" id="foodIdInput"/>
					<input type="number" id="foodCount" class="num_show fl" value="1" style="width: 100%">
				</div> 
			</div>
			<div class="operate_btn">
				<!-- <a href="javascript:;" class="buy_btn">立即购买</a> -->
				<a href="javascript:;" class="add_cart" id="add_cart">加入购物车</a>				
			</div>
		</div>
	</div>

	<div class="main_wrap clearfix">
		<div class="l_wrap fl clearfix">
			<%@ include file="/pages/common/newFoods.jsp"%>
		</div>
		<div class="layui-tab layui-tab-brief layui-col-md10 layui-col-md-offset1" style="margin-bottom: 50px" lay-filter="docDemoTabBrief">
		  <ul class="layui-tab-title">
		    <li class="layui-this">商品介绍</li>
		    <li>商品评论</li>
		  </ul>
		  <div class="layui-tab-content">
		    <div class="layui-tab-item layui-show">
		    	<dl>
					<button class="layui-btn layui-btn-radius layui-btn-normal">商品详情：</button><hr>
					<div>${food.foodIntroduce}</div>
				</dl>
		    </div>
		    <div class="layui-tab-item" id="evaShow">
		    	<blockquote class="layui-elem-quote layui-quote-nm" v-for="item in evas">
					<h1>{{item.custName}} <span>{{item.time | moment}}</span></h1><br>
					<p>{{item.text}}</p>
				</blockquote>
		    </div>
		  </div>
		</div> 
	</div>
	<%@ include file="/pages/common/footer.jsp"%>
	<script src="${PATH}/static/js/comment.js"></script>
	<script src="${PATH}/static/js/jquery2.0-min.js"></script>
	<script src="${PATH}/static/layui/layui.all.js"></script>
	<script>
		var evaShow = new Vue({
			el:"#evaShow",
			 data:{
				 evas:[],
				 foodId:"${food.foodId}"
			 },created:function(){
				//购物车
				this.$http.get("${PATH}/evaluate/getEvaByShow/"+this.foodId).then(function(response){
					console.log(response.body)
					//成功
					this.evas=response.body;
				},function(response) {
					//错误
					console.log("系统错误！")
				}); 
			 }
		});
		Vue.filter('moment', function (value, formatString) {
	        formatString = formatString || 'YYYY-MM-DD';
	        return moment(value).format(formatString);
	    });
	</script>
<script>
	//联动
	$("#foodCount").bind('input propertychange', function() {
		var num1 = $(this).val();
		var total = '${food.foodStock}' //库存
		var price = '${food.foodPresentPrice}'	//现价
	    $("#totalPrice").html(num1 * price)
	});
	
	//加入购物车
	$("#add_cart").click(function(){
		layui.use('layer',function(){
			var ident = "${sessionScope.ident}"
			if(ident==""){
				layer.msg("请您先登录！")
				return false;
			}
			var foodId = $("#foodIdInput").val()			
			var foodCount = $("#foodCount").val()			
			var foodStockSpan = '${food.foodStock}'
			if(parseInt(foodCount)>parseInt(foodStockSpan)||parseInt(foodCount)==0||foodCount==""){
				layer.msg("输入的数量有误！")
				return false;
			}
			$.ajax({
				url:"${PATH}/cart/addCartByCust/"+ident+"/"+foodId+"/"+foodCount,
				method:"get",
				success:function(res){
					if(res.code==100){
						layer.msg(res.extend.msg,{icon:6},function(){
							location.reload()
						})
					}else{
						layer.msg(res.extend.msg,{icon:5})	
					}
				},error:function(){
					layer.msg("系统错误")
				}

			});
		});
	});
	
</script>
	
</body>
</html>