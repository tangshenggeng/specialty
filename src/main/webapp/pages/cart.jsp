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
<body>
	<%@ include file="/pages/common/header.jsp"%>	

	<ul class="cart_list_th clearfix">
		<li class="col01" style="width: 22%;">商品名称</li>
		<li class="col02">商品单位</li>
		<li class="col03">商品价格</li>
		<li class="col04">数量</li>
		<li class="col05">小计</li>
		<li class="col06">操作</li>
	</ul>
	<div id="cartItems">
	<ul class="cart_list_td clearfix" v-for="item in carts">
		<li class="col02"><img :src="item.foodImg"></li>
		<li class="col03">{{item.foodName}}<br><em>{{item.foodPrice}} 元/{{item.foodMassUnit}}</em></li>
		<li class="col04">{{item.foodMassUnit}}</li>
		<li class="col05">{{item.foodPrice}} 元</li>
		<li class="col06">
			<div class="num_add">
				<a href="javascript:;" class="add fl" v-on:click="updateFoodNum(item.cartId,++item.foodNum)">+</a>
				<input type="text" class="num_show fl" :value="item.foodNum">	
				<a href="javascript:;" class="minus fl" v-on:click="updateFoodNum(item.cartId,--item.foodNum)">-</a>	
			</div>
		</li>
		<li class="col07">{{item.foodPrice * item.foodNum}} 元</li>
		<li class="col08"><a href="javascript:;" v-on:click="delCart(item.cartId)">删除</a></li>
	</ul>
	

	<ul class="settlements">
		<li class="col03" style="width: 85%">合计：<span>¥</span><em>{{getTotal.totalPrice}}</em><br>共计<b>{{getTotal.totalNum}}</b>件商品</li>
		<li class="col04"><a href="javascript:;" v-on:click="sumbitOrder(getTotal.cartIds,getTotal.totalPrice)">结算</a></li>
	</ul>
</div>
<%@ include file="/pages/common/footer.jsp"%>
<!-- 模态框 -->
<div style="display: none;" id="writeAddrModal">
	<div class="layui-card">
		<div  style="margin: 20px 20px">
			<div class="site_con">
				<form id="orderInfo">	
					<input type="hidden" id="cartIds" name="cartIds"/>
					<input type="hidden" value="${custId}" name="custId"/>
					<input type="hidden" id="totalPriceInput" name="totalPrice"/>
					<div class="common_list_con clearfix"  style="width: 800px">
						<div class="pay_style_con clearfix">
							<input type="radio" name="payWay" value="到付" checked="checked">
							<label class="cash">货到付款</label>
							
							<input type="radio" value="微信" name="payWay">
							<label class="weixin">微信支付</label>
							
							<input type="radio" value="支付宝" name="payWay">
							<label class="zhifubao"></label>
							
							<input type="radio" value="银联" name="payWay">
							<label class="bank">银行卡支付</label>
						</div>
					</div>
					<div class="form_group">
						<label>收件人：</label>
						<input type="text" id="myname" required="required" name="consignee">
					</div>
					<div class="form_group form_group2">
						<label>详细地址：</label>
						<textarea class="site_area" id="myaddr" required="required" name="address"></textarea>
					</div>
					<div class="form_group">
						<label>手机：</label>
						<input type="number" id="myphone"  required="required" name="phone">
					</div>
					<input type="button" id="sumbitOrderBtn"  value="提交" class="info_submit">
				</form>
			</div>
		</div>
	</div>
</div>
	<script src="${PATH}/static/js/jquery2.0-min.js"></script>
<script src="${PATH}/static/layui/layui.all.js"></script>
</body>
<script>
 var error = "${error}"
	if(error!=""){
		layui.layer.msg(error)
	}
 var cust  = "${sessionScope.ident}"
 if(cust==""){
		layui.layer.msg("登录超时！请重新登录！",function(){
			location.href="${PATH}/pages/login.jsp";
		})
	}
 var cartItems = new Vue({
	 el:"#cartItems",
	 data:{
		 carts:[],
		 custId:"${custId}"
	 },created:function(){
		//购物车
		this.$http.get("${PATH}/cart/getMyCartsByShow/"+this.custId).then(function(response){
			console.log(response.body)
			//成功
			this.carts=response.body;
		},function(response) {
			//错误
			console.log("系统错误！")
		}); 
	 },computed:{
		 //获取总价和产品总件数
	    getTotal:function(){
	        //获取productList中select为true的数据。
	        var _proList=this.carts,
			        totalPrice=0, 
			        totalNum =0
			        cartIds = new Array();;
	        for(var i=0,len=_proList.length;i<len;i++){
	            //总价累加
	            totalPrice+=_proList[i].foodNum*_proList[i].foodPrice;
	            totalNum += _proList[i].foodNum
	            cartIds.push(_proList[i].cartId);
	        }
	        //选择产品的件数就是_proList.length，总价就是totalPrice
	        return {totalNum:totalNum,totalPrice:totalPrice,cartIds:cartIds}
	    }
	 },methods:{
		 delCart:function(cartId){
			$.ajax({
				url:"${PATH}/cart/delById/"+cartId,
				method:"get",
				success:function(res){
					if(res.code==100){
						layui.layer.msg(res.extend.msg,{icon:6},function(){
							location.reload()   
						})
					}else{
						layui.layer.msg(res.extend.msg,{icon:5})	
					}
				},error:function(){
					layui.layer.msg("系统错误")
				}
			});
		 },sumbitOrder:function(cartIds,totalPrice){	//提交订单
			 layui.use('layer' , function() {
				 var layer = layui.layer;
				 $("#cartIds").val(cartIds)
				 $("#totalPriceInput").val(totalPrice)
				 layui.layer.open({
					title : '确认订单',
					fix : true,
					resize : false,
					move : false,
					area : [ '1000px', '500px' ],
					shadeClose : false,
					type : 1,
					content : $('#writeAddrModal'),
					cancel : function(index, layero) {
						$('#writeAddrModal').css("display", "none")
					}
				 })
			 })
		 },updateFoodNum:function(cartId,num){
			 $.ajax({
				 url:"${PATH}/cart/updateNum/"+cartId+"/"+num,
				 method:"get",
			 });
			 
		 }
	 }
 })
 $("#sumbitOrderBtn").click(function(){
	 layui.use('layer' , function() {
		var layer = layui.layer;
		var name = $("#myname").val()
		var addr = $("#myaddr").val()
		var phone = $("#myphone").val()
		if(name==""||addr==""||phone==""){
			layer.msg("请正确填写信息！")
			return false;
		}
		var datas = $("#orderInfo").serialize() 		 
	 	$.ajax({
	 		url:"${PATH}/order/addOrderByCust",
	 		method:"POST",
	 		data:datas,
	 		success:function(res){
				if(res.code==100){
					layer.msg("正在支付中...请稍等!",{icon:6,time: 10*1000},function(){
						location.reload()   
					})
				}else{
					layer.msg(res.extend.msg,{icon:5})	
				}
			},error:function(){
				layer.msg("系统错误")
			}
	 	});
	 })
 });

</script>
</html>