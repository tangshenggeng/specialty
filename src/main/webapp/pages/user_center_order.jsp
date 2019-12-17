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
				<li><a href="${PATH}/pages/user_center_info.jsp">· 个人信息</a></li>
				<li><a href="${PATH}/order/getMyOrders/${sessionScope.ident}" class="active">· 全部订单</a></li>
				<%-- <li><a href="${PATH}/pages/user_center_site.jsp">· 收货地址</a></li> --%>
			</ul>
		</div>
		<div class="right_content clearfix">
				<h3 class="common_title2">全部订单</h3>
				<!-- 订单 -->
				<div id="myOrders">
					<div v-for="item in orders">
					<ul class="order_list_th w978 clearfix">
						<li class="col01">{{item.createTime | moment}}</li>
						<li class="col02">订单号：{{item.orderNum}}</li>
						<li class="col02 stress">{{item.orderState}}</li>		
					</ul>
					<table class="order_list_table w980">
						<tbody>
							<tr>
								<td width="55%">
									<ul class="order_goods_list clearfix" v-for="food in item.items">					
										<li class="col01"><img :src="food.foodImg"></li>
										<li class="col02">{{food.foodName}}<em>{{food.foodPrice}} 元/ {{food.foodMassUnit}}</em></li>	
										<li class="col03">数量：{{food.foodNum}}</li>
										<li class="col04">小计：{{food.foodNum * food.foodPrice}}</li>	
									</ul>
									
								</td>
								<td width="15%">总价格：{{item.totalPrice}} 元</td>
								<td width="15%" style="color: orange;">状态：{{item.orderState}}</td>
								<td width="15%">
									<a v-if="item.orderState==='待发货'" href="javascript:;"  v-on:click="urgeDeliver()" class="oper_btn">催一催</a>
									<a v-if="item.orderState==='待发货'" href="javascript:;"  v-on:click="modifyAddr(item.orderNum,item.myAddr)" class="oper_btn">修改地址</a>
									<a v-if="item.orderState==='已发货'" href="javascript:;"  v-on:click="lookExpress(item.expressCom,item.expressNum)" class="oper_btn">查看物流</a>
									<a v-if="item.orderState==='已发货'" href="javascript:;"  v-on:click="confirmGet(item.orderNum)" class="oper_btn">确认收货</a>
									<a v-if="item.orderState==='确认收货'" href="javascript:;"  v-on:click="evaluate(item.orderNum)" class="oper_btn">评价</a>
									<a v-if="item.orderState==='确认收货'" href="javascript:;"  v-on:click="askReturn(item.orderNum)" class="oper_btn">申请退货</a>
								</td>
							</tr>
						</tbody>
					</table>
					</div>
				</div>
				<!-- <div class="pagenation">
					<a href="#">上一页</a>
					<a href="#" class="active">1</a>
					<a href="#">2</a>
					<a href="#">3</a>
					<a href="#">4</a>
					<a href="#">5</a>
					<a href="#">下一页></a>
				</div> -->
		</div>
	</div>
	<div style="display: none;" id="writeAddrModal">
	<div class="layui-card">
		<div  style="margin: 20px 20px">
			<div class="site_con">
				<div class="form_group">
					<label>物流公司：</label>
					<input type="text" id="expressComInput" readonly="readonly">
				</div>
				<div class="form_group">
					<label>物流订单号：</label>
					<input type="text" id="expressNumInput"  readonly="readonly">
				</div>
			</div>
		</div>
	</div>
</div>
	<div style="display: none;" id="writeReasonModal">
	<div class="layui-card">
		<div  style="margin: 20px 20px">
			<div class="site_con">
				<form id="orderInfoReason">	
					<input type="hidden" id="returnReasonOrderNum"  name="orderNum"/>
					<div class="form_group form_group2">
						<label>退货原因：</label>
						<textarea class="site_area" placeholder="请寄回江西省南昌市南昌县江西服装学院" id="myReason" required="required" name="returnReason"></textarea>
					</div>
					<input type="button" id="sumbitReasonBtn"  value="提交" class="info_submit">
				</form>
			</div>
		</div>
	</div>
</div>
	<div style="display: none;" id="modifyAddrModel">
	<div class="layui-card">
		<div  style="margin: 20px 20px">
			<div class="site_con">
				<form id="orderInfoModifyAddr">	
					<input type="hidden" id="modifyAddrOrderNum"  name="orderNum"/>
					<div class="form_group form_group2">
						<label>修改地址：</label>
						<textarea class="site_area" id="orderAddrInput" required="required" name="address"></textarea>
					</div>
					<input type="button" id="sumbitModifyAddrBtn"  value="提交" class="info_submit">
				</form>
			</div>
		</div>
	</div>
</div>
	<div style="display: none;" id="evaluateModel">
	<div class="layui-card">
		<div  style="margin: 20px 20px">
			<div class="site_con">
				<form id="orderInfoEvaluate">	
					<input type="hidden" id="evaluateOrderNum"  name="orderNum"/>
					<div class="form_group form_group2">
						<label>内容：</label>
						<textarea class="site_area" id="evaluateInput" required="required" name="returnReason"></textarea>
					</div>
					<input type="button" id="sumbitEvaluateBtn"  value="提交" class="info_submit">
				</form>
			</div>
		</div>
	</div>
</div>
<%@ include file="/pages/common/footer.jsp"%>
	<script src="${PATH}/static/js/jquery2.0-min.js"></script>
	<script src="${PATH}/static/js/comment.js"></script>
<script src="${PATH}/static/layui/layui.all.js"></script>
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
	var myOrders = new	Vue({
		el:"#myOrders",
		data:{
			orders:[],
			custId:"${custId}"
		},created:function(){
			//购物车
			this.$http.get("${PATH}/order/getMyOrdersByShow/"+this.custId).then(function(response){
				console.log(response.body)
				//成功
				this.orders=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			}); 
		},methods:{
			urgeDeliver:function(){		//催货
				layui.layer.msg("催货成功!")
			},
			lookExpress:function(com,num){	//查看物流
				$("#expressComInput").val(com)
				$("#expressNumInput").val(num)
				layui.layer.open({
					title : '查看物流',
					fix : true,
					resize : false,
					move : false,
					area : [ '600px', '230px' ],
					shadeClose : false,
					type : 1,
					anim: 5,
					content : $('#writeAddrModal'),
					cancel : function(index, layero) {
						$('#writeAddrModal').css("display", "none")
					}
				 })
			},confirmGet:function(orderNum){	//确认收货
				layer.confirm('确认收货吗?', {icon: 3, title:'提示'}, function(index){
					$.ajax({
						url:"${PATH}/order/confirmGetByCust/"+orderNum,
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
				  layer.close(index);
				});
			},askReturn:function(orderNum){		//申请退货
				layer.confirm('退货请寄回发货地，邮费自理，您确认退货吗?', {icon: 3, title:'提示'}, function(index){
					$("#returnReasonOrderNum").val(orderNum)
					layui.layer.open({
						title : '填写退货理由',
						fix : true,
						resize : false,
						move : false,
						area : [ '600px', '330px' ],
						shadeClose : false,
						type : 1,
						anim: 3,
						content : $('#writeReasonModal'),
						cancel : function(index, layero) {
							$('#writeReasonModal').css("display", "none")
						}
					 })
				  layer.close(index);
				});
			},modifyAddr:function(orderNum,myAddr){	//修改地址
				$("#modifyAddrOrderNum").val(orderNum)
				$("#orderAddrInput").val(myAddr)
				layui.layer.open({
					title : '修改地址',
					fix : true,
					resize : false,
					move : false,
					area : [ '600px', '330px' ],
					shadeClose : false,
					type : 1,
					anim: 3,
					content : $('#modifyAddrModel'),
					cancel : function(index, layero) {
						$('#modifyAddrModel').css("display", "none")
					}
				 })
			},evaluate:function(orderNum){	//评价
				$("#evaluateOrderNum").val(orderNum)
				layui.layer.open({
					title : '评价',
					fix : true,
					resize : false,
					move : false,
					area : [ '600px', '330px' ],
					shadeClose : false,
					type : 1,
					anim: 3,
					content : $('#evaluateModel'),
					cancel : function(index, layero) {
						$('#evaluateModel').css("display", "none")
					}
				 })	
			}
		}
	});
	Vue.filter('moment', function (value, formatString) {
        formatString = formatString || 'YYYY-MM-DD HH:mm:ss';
        return moment(value).format(formatString);
    });
	//申请退货
	$("#sumbitReasonBtn").click(function(){
		layui.use('layer' , function() {
			var layer = layui.layer;
			var name = $("#myReason").val()
			if(name==""){
				layer.msg("请正确填写信息！")
				return false;
			}
			var datas = $("#orderInfoReason").serialize() 		 
		 	$.ajax({
		 		url:"${PATH}/order/askReturnByCust",
		 		method:"POST",
		 		data:datas,
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
		 })
	});
	//修改地址
	$("#sumbitModifyAddrBtn").click(function(){
		layui.use('layer' , function() {
			var layer = layui.layer;
			var name = $("#orderAddrInput").val()
			if(name==""){
				layer.msg("请正确填写信息！")
				return false;
			}
			var datas = $("#orderInfoModifyAddr").serialize() 		 
		 	$.ajax({
		 		url:"${PATH}/order/modifyAddrByCust",
		 		method:"POST",
		 		data:datas,
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
		 })
	});
	//评价
	$("#sumbitEvaluateBtn").click(function(){
		layui.use('layer' , function() {
			var layer = layui.layer;
			var name = $("#evaluateInput").val()
			if(name==""){
				layer.msg("请正确填写信息！")
				return false;
			}
			var datas = $("#orderInfoEvaluate").serialize() 		 
		 	$.ajax({
		 		url:"${PATH}/evaluate/addEvaluateByCust",
		 		method:"POST",
		 		data:datas,
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
		 })
	});
</script>
</body>
</html>