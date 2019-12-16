<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
  <head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>草原兴发-首页</title>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css"/>
	<script src="${PATH}/static/js/jquery2.0-min.js"></script>
	<script type="text/javascript" src="${PATH}/pages/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${PATH}/pages/js/slide.js"></script>
</head>
<style>
	.goods_list li  a {
    font-size: 14px;
    color: #666;
    font-weight: normal;
    line-height: 24px;
}

</style>
<body>
	<%@ include file="/pages/common/header.jsp"%>

	<div class="navbar_con">
		<div class="navbar">
			<h1 class="fl">全部商品分类</h1>
			<ul class="navlist fl">
				<li><a href="${PATH}/pages/index.jsp">首页</a></li>
				<li class="interval">|</li>
				<li><a href="#">手机生鲜</a></li>
				<li class="interval">|</li>
				<li><a href="#">抽奖</a></li>
			</ul>
		</div>
	</div>

	<div class="center_con clearfix">
		<ul class="subnav fl">
			<li><a href="#model01" class="fruit">新鲜水果</a></li>
			<li><a href="#model02" class="seafood">海鲜水产</a></li>
			<li><a href="#model03" class="meet">猪牛羊肉</a></li>
			<li><a href="#model04" class="egg">禽类蛋品</a></li>
			<li><a href="#model05" class="vegetables">新鲜蔬菜</a></li>
			<li><a href="#model06" class="ice">速冻食品</a></li>
		</ul>
		<div class="slide fl">
			<ul class="slide_pics">
				<li><img style="width: 760px;height: 270px" src="${PATH}/pages/images/slide.jpg" alt="幻灯片"></li>
				<li><img style="width: 760px;height: 270px"  src="${PATH}/pages/images/slide02.jpg" alt="幻灯片"></li>
				<li><img style="width: 760px;height: 270px"  src="${PATH}/pages/images/slide03.jpg" alt="幻灯片"></li>
				<li><img style="width: 760px;height: 270px"  src="${PATH}/pages/images/slide04.jpg" alt="幻灯片"></li>
			</ul>
			<div class="prev"></div>
			<div class="next"></div>
			<ul class="points"></ul>
		</div>
		<div class="adv fl">
			<a href="#"><img style="width: 240px;height: 135px" src="${PATH}/pages/images/adv01.jpg"></a>
			<a href="#"><img style="width: 240px;height: 135px" src="${PATH}/pages/images/adv02.jpg"></a>
		</div>
	</div>

	<div class="list_model">
		<div class="list_title clearfix">
			<h3 class="fl" id="model01">新鲜水果</h3>
			<div class="subtitle fl">
				<!-- <span>|</span>
				<a href="#">鲜芒</a>
				<a href="#">加州提子</a>
				<a href="#">亚马逊牛油果</a> -->
			</div>
			<a href="${PATH}/food/getBySort/1" class="goods_more fr" id="fruit_more">查看更多 ></a>
		</div>
		<div class="goods_con clearfix">
			<div class="goods_banner fl"><img src="${PATH}/pages/images/banner01.jpg"></div>
			<ul class="goods_list fl"  id="freshFruit">
				<li v-for="item in fruits">
				<a :href="'${PATH}/food/getFoodById/'+item.foodId">
					<h4>{{item.foodName}}</h4>
					<img style="width: 180px;height: 180px;" :src="item.foodImg">
					<div class="prize"><del style="text-align: center;font-size: 14px;color: #666;">¥ {{item.foodOldPrice}}</del> ¥ {{item.foodPresentPrice}}</div>
					</a>
				</li>
			</ul>
		</div>
	</div>

	<div class="list_model">
		<div class="list_title clearfix">
			<h3 class="fl" id="model02">海鲜水产</h3>
			<div class="subtitle fl">
				<!-- <span>|</span>
				<a href="#">河虾</a>
				<a href="#">扇贝</a>	 -->			
			</div>
			<a href="${PATH}/food/getBySort/2" class="goods_more fr">查看更多 ></a>
		</div>

		<div class="goods_con clearfix" >
			<div class="goods_banner fl"><img src="${PATH}/pages/images/banner02.jpg"></div>
			<ul class="goods_list fl"  id="seafood">
				<li v-for="item in seafoods">
				<a :href="'${PATH}/food/getFoodById/'+item.foodId">
					<h4>{{item.foodName}}</h4>
					<img style="width: 180px;height: 180px;" :src="item.foodImg">
					<div class="prize"><del style="text-align: center;font-size: 14px;color: #666;">¥ {{item.foodOldPrice}}</del> ¥ {{item.foodPresentPrice}}</div>
					</a>
				</li>
			</ul>
		</div>
	</div>

	<div class="list_model">
		<div class="list_title clearfix">
			<h3 class="fl" id="model03">猪牛羊肉</h3>
			<div class="subtitle fl">
				<!-- <span>|</span>
				<a href="#">鲜芒</a>
				<a href="#">加州提子</a>
				<a href="#">亚马逊牛油果</a> -->
			</div>
			<a href="${PATH}/food/getBySort/3" class="goods_more fr">查看更多 ></a>
		</div>

		<div class="goods_con clearfix">
			<div class="goods_banner fl"><img src="${PATH}/pages/images/banner03.jpg"></div>
			<ul class="goods_list fl"  id="meetfood">
				<li v-for="item in meetfoods">
				<a :href="'${PATH}/food/getFoodById/'+item.foodId">
					<h4>{{item.foodName}}</h4>
					<img style="width: 180px;height: 180px;" :src="item.foodImg">
					<div class="prize"><del style="text-align: center;font-size: 14px;color: #666;">¥ {{item.foodOldPrice}}</del> ¥ {{item.foodPresentPrice}}</div>
					</a>
				</li>
			</ul>
		</div>
	</div>

	<div class="list_model">
		<div class="list_title clearfix">
			<h3 class="fl" id="model04">禽类蛋品</h3>
			<div class="subtitle fl">
				<!-- <span>|</span>
				<a href="#">鲜芒</a>
				<a href="#">加州提子</a>
				<a href="#">亚马逊牛油果</a> -->
			</div>
			<a href="${PATH}/food/getBySort/4" class="goods_more fr">查看更多 ></a>
		</div>

		<div class="goods_con clearfix">
			<div class="goods_banner fl"><img src="${PATH}/pages/images/banner04.jpg"></div>
			<ul class="goods_list fl"  id="eggfood">
				<li v-for="item in eggfoods">
				<a :href="'${PATH}/food/getFoodById/'+item.foodId">
					<h4>{{item.foodName}}</h4>
					<img style="width: 180px;height: 180px;" :src="item.foodImg">
					<div class="prize"><del style="text-align: center;font-size: 14px;color: #666;">¥ {{item.foodOldPrice}}</del> ¥ {{item.foodPresentPrice}}</div>
					</a>
				</li>
			</ul>
		</div>
	</div>

	<div class="list_model">
		<div class="list_title clearfix">
			<h3 class="fl" id="model05">新鲜蔬菜</h3>
			<div class="subtitle fl">
				<!-- <span>|</span>
				<a href="#">鲜芒</a>
				<a href="#">加州提子</a>
				<a href="#">亚马逊牛油果</a> -->
			</div>
			<a href="${PATH}/food/getBySort/5" class="goods_more fr">查看更多 ></a>
		</div>

		<div class="goods_con clearfix">
			<div class="goods_banner fl"><img src="${PATH}/pages/images/banner05.jpg"></div>
			<ul class="goods_list fl"  id="vegetables">
				<li v-for="item in vegetablesFoods">
				<a :href="'${PATH}/food/getFoodById/'+item.foodId">
					<h4>{{item.foodName}}</h4>
					<img style="width: 180px;height: 180px;" :src="item.foodImg">
					<div class="prize"><del style="text-align: center;font-size: 14px;color: #666;">¥ {{item.foodOldPrice}}</del> ¥ {{item.foodPresentPrice}}</div>
					</a>
				</li>
			</ul>
		</div>
	</div>

	<div class="list_model">
		<div class="list_title clearfix">
			<h3 class="fl" id="model06">速冻食品</h3>
			<div class="subtitle fl">
				<!-- <span>|</span>
				<a href="#">鲜芒</a>
				<a href="#">加州提子</a>
				<a href="#">亚马逊牛油果</a> -->
			</div>
			<a href="${PATH}/food/getBySort/6" class="goods_more fr">查看更多 ></a>
		</div>

		<div class="goods_con clearfix">
			<div class="goods_banner fl"><img src="${PATH}/pages/images/banner06.jpg"></div>
			<ul class="goods_list fl"  id="iceFood">
				<li v-for="item in iceFoods">
				<a :href="'${PATH}/food/getFoodById/'+item.foodId">
					<h4>{{item.foodName}}</h4>
					<img style="width: 180px;height: 180px;" :src="item.foodImg">
					<div class="prize"><del style="text-align: center;font-size: 14px;color: #666;">¥ {{item.foodOldPrice}}</del> ¥ {{item.foodPresentPrice}}</div>
					</a>
				</li>
			</ul>
		</div>
	</div>
<%@ include file="/pages/common/footer.jsp"%>
<script src="${PATH}/static/layui/layui.all.js"></script>	
<script type="text/javascript">
  var freshFruit = new Vue({
	  el:"#freshFruit",
		data:{
			fruits:[]
		},created: function () {
			//新鲜水果
			this.$http.get("${PATH}/food/getFruitsByShow").then(function(response){
				console.log(response.body)
				//成功
				this.fruits=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		}	  
  })
  var seafood = new Vue({
	  el:"#seafood",
		data:{
			seafoods:[]
		},created: function () {
			//新鲜水果
			this.$http.get("${PATH}/food/getSeafoodsByShow").then(function(response){
				console.log(response.body)
				//成功
				this.seafoods=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		}	  
  })
  var meetfood = new Vue({
	  el:"#meetfood",
		data:{
			meetfoods:[]
		},created: function () {
			//新鲜水果
			this.$http.get("${PATH}/food/getMeetfoodsByShow").then(function(response){
				console.log(response.body)
				//成功
				this.meetfoods=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		}	  
  })
  var eggfood = new Vue({
	  el:"#eggfood",
		data:{
			eggfoods:[]
		},created: function () {
			//新鲜水果
			this.$http.get("${PATH}/food/getEggfoodsByShow").then(function(response){
				console.log(response.body)
				//成功
				this.eggfoods=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		}	  
  })
  var vegetables = new Vue({
	  el:"#vegetables",
		data:{
			vegetablesFoods:[]
		},created: function () {
			//新鲜水果
			this.$http.get("${PATH}/food/getVegetablesByShow").then(function(response){
				console.log(response.body)
				//成功
				this.vegetablesFoods=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		}	  
  })
  var iceFood = new Vue({
	  el:"#iceFood",
		data:{
			iceFoods:[]
		},created: function () {
			//新鲜水果
			this.$http.get("${PATH}/food/getIceFoodsByShow").then(function(response){
				console.log(response.body)
				//成功
				this.iceFoods=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		}	  
  })
</script>	
</body>
</html>