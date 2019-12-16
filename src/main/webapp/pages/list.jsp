<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>草原兴发-商品列表</title>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css"/>
	
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
		<!-- <a href="#">新鲜水果</a> -->
	</div>

	<div class="main_wrap clearfix">
		<%@ include file="/pages/common/newFoods.jsp"%>

		<div class="r_wrap fr clearfix" id="listFoods">
			<div class="sort_bar">
				<a href="javascript:void(0);" v-on:click="getByKW('default')"  v-bind:class="{active: sortOrder==='default'}">默认</a>
				<a href="javascript:void(0);" v-on:click="getByKW('price')" v-bind:class="{active: sortOrder==='price'}">价格</a>
				<a href="javascript:void(0);" v-on:click="getByKW('popularity')" v-bind:class="{active: sortOrder==='popularity'}">人气</a>
			</div>

			<ul class="goods_type_list clearfix">
				<li v-for="item in foods">
					<a :href="'${PATH}/food/getFoodById/'+item.foodId"><img :src="item.foodImg"></a>
					<h4><a :href="'${PATH}/food/getFoodById/'+item.foodId">{{item.foodName}}</a></h4>
					<div class="operate">
						<span class="prize">￥ {{item.foodPresentPrice}}</span>
						<span class="unit">{{item.foodPresentPrice}} / {{item.foodMassUnit}}</span>
						<a :href="'${PATH}/food/getFoodById/'+item.foodId" class="add_goods" title="加入购物车"></a>
					</div>
				</li>
			</ul>

			<div class="pagenation">
				<a href="javascript:void(0);" v-on:click="previous(current-1)">上一页</a>
				<a href="javascript:void(0);" v-for="item in pages"  v-bind:class="{active: item==current }" v-on:click="jumpToPage(item)">{{item}}</a>
				<a href="javascript:void(0);" v-on:click="next(current+1)">下一页</a>
			</div>
		</div>
	</div>

<%@ include file="/pages/common/footer.jsp"%>
<script src="${PATH}/static/layui/layui.all.js"></script>	
<script>
var error = "${error}"
if(error!=""){
	layui.layer.msg(error)
}
var listFoods = new Vue({
	  el:"#listFoods",
	  data:{
			foods:[],
			pages:[],
			sortOrder:"default",  //分类条件
			sort:"${sort}",
			current:1,		//当前页初始化
		},created: function () {
			//新鲜水果
			this.$http.post("${PATH}/food/getFoodsByList",{
				sort:this.sort,
				page:1,
				sortOrder:this.sortOrder
			}).then(function(response){
				//成功
				this.foods=response.body.records;
				this.pages=response.body.pages;
				this.current=response.body.current;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		},methods:{
			previous:function(page){	//上一页
				console.log(page)
				if(page<1){
					layui.layer.msg("不存在上一页！")
				}else{
					this.$http.post("${PATH}/food/getFoodsByList",{
						sort:this.sort,
						page:page,
						sortOrder:this.sortOrder
					}).then(function(response){
						//成功
						this.foods=response.body.records;
						this.pages=response.body.pages;
						this.current=response.body.current;
					},function(response) {
						console.log("系统错误！")
					});
				}
			},next:function(page){	//下一页
				console.log(page)
				if(page>this.pages){
					layui.layer.msg("不存在下一页！")
				}else{
					this.$http.post("${PATH}/food/getFoodsByList",{
						sort:this.sort,
						page:page,
						sortOrder:this.sortOrder
					}).then(function(response){
						console.log(response.body)
						//成功
						this.foods=response.body.records;
						this.pages=response.body.pages;
						this.current=response.body.current;
					},function(response) {
						console.log("系统错误！")
					});
				}
			},jumpToPage:function(page){
				this.$http.post("${PATH}/food/getFoodsByList",{
					sort:this.sort,
					page:page,
					sortOrder:this.sortOrder
				}).then(function(response){
					//成功
					this.foods=response.body.records;
					this.pages=response.body.pages;
					this.current=response.body.current;
				},function(response) {
					console.log("系统错误！")
				});
			},getByKW:function(kw){
				this.sortOrder = kw
				this.$http.post("${PATH}/food/getFoodsByList",{
					sort:this.sort,
					page:this.current,
					sortOrder:this.sortOrder
				}).then(function(response){
					//成功
					this.foods=response.body.records;
					this.pages=response.body.pages;
					this.current=response.body.current;
				},function(response) {
					console.log("系统错误！")
				});
			}
		}
})
</script>
</body>
</html>