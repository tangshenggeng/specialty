<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
%>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>草原兴发后台</title>
<link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
<link rel="stylesheet" href="${PATH}/static/css/ckin.css">
<!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="/WEB-INF/view/common/header.jsp"%>
		<%@ include file="/WEB-INF/view/common/left-nav.jsp"%>
		<div class="layui-body">
			<blockquote class="layui-elem-quote">
				<a href="${PATH}/admin/index"><i
					class="layui-icon layui-icon-layer"></i> 主页</a> / <a>待发货</a>
			</blockquote>
			<form class="layui-form" id="kwCustForm">
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">订单号</label>
						<div class="layui-input-block">
							<input type="text" name="orderNum" placeholder="请输入"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					
				</div>
				<div class="layui-col-md8">
					<div class="layui-form-item">
						<label class="layui-form-label range-label">日期</label>
						<div class="layui-input-inline">
							<input type="text" id="start_date" placeholder="请选择"
								name="start_date" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-form-mid">-</div>
						<div class="layui-input-inline">
							<input type="text" id="end_date" placeholder="请选择"
								name="end_date" autocomplete="off" class="layui-input">
						</div>
					</div>
				</div>
				<div class="layui-form-item">
						<div class="layui-input-block">
							<button class="layui-btn" type="button" id="kwFormBtn">筛选</button>
							<button type="reset" id="resetBtn"
								class="layui-btn layui-btn-primary">重置</button>
						</div>
					</div>
			</form>
			<div class="row">
				<div class="layui-col-md10  layui-col-md-offset1">
					<div class="card">
						<div class="card-header">
							<h2>待发货订单</h2>
							<br>
							<button class="layui-btn layui-btn-danger" type="button"
								id="delByIds">
								<i class="layui-icon layui-icon-delete"></i>删除选中
							</button>
						</div>
						<div class="card-body">
							<table id="dataListTb" class="table table-responsive table-hover"
								lay-filter="datasTbFilter">

							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="layui-footer">© 草原兴发特产商城</div>
	</div>
	<!-- 模态框 -->
	<div style="display: none;" id="deliveryModal">
		<div class="layui-card">
			<form class="layui-form" style="margin: 20px">
			<input type="hidden" id="deliveryOrderId" name="orderId">
			  <div class="layui-form-item">
			    <label class="layui-form-label">快递公司</label>
			    <div class="layui-input-block">
			      <input type="text" name="expressCom" required  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">快递单号</label>
			    <div class="layui-input-block">
			      <input type="text" name="expressNum" required  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      <button class="layui-btn" lay-submit lay-filter="formDelivery">立即提交</button>
			      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
			    </div>
			  </div>
			</form>
		</div>
	</div>
	<div style="display: none;" id="detailInfoModal">
		<div class="layui-card">
			<blockquote class="layui-elem-quote layui-quote-nm" style="margin: 20px">购买人：<span  id="custInfo"></span></blockquote>
			<!-- <blockquote class="layui-elem-quote layui-quote-nm" id="foodInfo" style="margin: 20px">引用区域的文字</blockquote> -->
		</div>
	</div>
	<script src="${PATH}/static/layui/layui.all.js"></script>
	<script src="${PATH}/static/js/jquery2.0-min.js"></script>
	<script src="${PATH}/static/layui/mods/area.js"></script>
	<script src="${PATH}/static/layui/mods/select.js"></script>
	<script src="${PATH}/static/js/ckin.js"></script>
	<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
  </div>

</script>

	<script>
		$(function() {
			renderTb();
		});
		function renderTb() {
			var data = $("#kwCustForm").serializeArray();
			layui.use([ 'table', 'util', 'form' ], function() {
				var table = layui.table, util = layui.util;
				//第一个实例
				table.render({
					elem : '#dataListTb',
					height : 500,
					url : '${PATH}/order/getWaitList',
					text : {
						none : '未找到数据'
					},
					id : "datListTbId",
					size : 'sm ',
					contentType : "application/json",//必须指定，否则会报415错误
					dataType : 'json',
					method : "POST",
					toolbar : "#toolbarDemo",
					defaultToolbar : [ 'filter' ],
					id : "dataListTbId",
					page : true //开启分页
					,
					where : {
						kwdata : data
					},
					cols : [ [ //表头
					{
						field : 'orderId',
						title : '#',
						type : "checkbox",
						rowspan : 2,
						align : "center"
					}, {
						field : 'orderNum',
						title : '订单号',
						rowspan : 2,
						align : "center"
					},{
						title : '收货人',
						colspan : 3,
						align : "center"
					}, {
						field : 'payWay',
						title : '支付方式',
						rowspan : 2,
						align : "center"
					},  {
						field : 'totalPrice',
						title : '支付金额',
						rowspan : 2,
						align : "center"
					},{
						field : 'createTime',
						title : '下单时间',
						rowspan : 2,
						sort : true,
						align : "center",
						templet : "<div>{{layui.util.toDateString(d.createTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
					}, {
						title : '操作',
						rowspan : 2,
						align : "center",
						fixed : "right",
						toolbar : '#barDemo'
					} ], [ {
						field : 'consignee',
						title : '姓名',
						align : "center"
					}, {
						field : 'address',
						title : '地址',
						align : "center"
					}, {
						field : 'phone',
						title : '电话',
						align : "center"
					} ] ],
					parseData : function(res) { //res 即为原始返回的数据
						console.log(res)
						return {
							"code" : res.status, //解析接口状态
							"msg" : res.message, //解析提示文本
							"count" : res.total, //解析数据长度
							"data" : res.data
						//解析数据列表
						};
					}
				});
				//监听工具条 
				table.on('tool(datasTbFilter)', function(obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
					var data = obj.data; //获得当前行数据
					var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
					if (layEvent === 'delivery') { //查看
						$("#deliveryOrderId").val(data.orderId)
						var index = layer.open({
							title : '填写物流信息',
							fix : true,
							resize : false,
							move : false,
							area : [ '800px', '300px' ],
							shadeClose : false,
							type : 1,
							content : $('#deliveryModal'),
							cancel : function(index, layero) {
								$('#deliveryModal').css("display", "none")
							}
						});

					}else if (layEvent === 'detail') {
						$.ajax({
							url:"${PATH}/order/getFoodInfoByOrderNum/"+data.orderNum,
							method:"get",
							success:function(res){
								console.log(res)
								$("#custInfo").text(res[0].custName)
								var foodInfo =res[1] 
								/* var info
								$(foodInfo).each(function(){
									info += "<h4>"+$(this).foodName+"</h4>"
								});
								$("#foodInfo").text(info) */
							}
						})
						
						var index = layer.open({
							title : '购买信息',
							fix : true,
							resize : false,
							move : false,
							area : [ '800px', '300px' ],
							shadeClose : false,
							type : 1,
							content : $('#detailInfoModal'),
							cancel : function(index, layero) {
								$('#detailInfoModal').css("display", "none")
							}
						});
						
						
					}else if (layEvent === 'LAYTABLE_TIPS') {
						layer.alert('Hi，头部工具栏扩展的右侧图标。');
					}
				});

			});
		}
		//批量删除
		$("#delByIds").click(function() {
			layui.use([ 'table', 'layer' ], function() {
				var table = layui.table, layer = layui.layer;
				layer.confirm('真的删除行么', function(index) {
					var checkStatus = table.checkStatus('dataListTbId');
					var datas = checkStatus.data
					var ids = new Array();
					$(datas).each(function() {
						ids.push($(this)[0].orderId);
					})
					if (ids.length == 0) {
						layer.msg("请选择数据！");
						return false;
					}
					$.ajax({
						url : "${PATH}/order/delOrdersByIds",
						method : "POST",
						contentType : "application/json",//必须指定，否则会报415错误
						dataType : 'json',
						data : JSON.stringify(ids),
						success : function(res) {
							console.log(res)
							if (res.code == 100) {
								layer.msg(res.extend.msg, {
									icon : 6
								}, function() {
									renderTb();
								});
							} else {
								layer.msg(res.extend.msg, {
									icon : 5
								}, function() {
									renderTb();
								});
							}
						},
						error : function() {
							layer.msg("系统错误！", {
								icon : 5
							}, function() {
								renderTb();
							});
						}
					});
					layer.close(index);
				});
			});
		})

		layui.use('laydate', function() {
			var laydate = layui.laydate;
			//执行一个laydate实例
			laydate.render({
				elem : '#start_date' //指定元素,
				,
				eventElem : '#start_date',
				trigger : 'click'
			});
			laydate.render({
				elem : '#end_date' //指定元素,
				,
				eventElem : '#end_date',
				trigger : 'click'
			});
		});
		//筛选
		$("#kwFormBtn").click(function() {
			renderTb();
		});
		
		layui.use([ 'form', 'layer' ], function() {
			var form = layui.form, layer = layui.layer;
			form.on('submit(formDelivery)', function(data){
			  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
			  var datas = data.field
			 $.ajax({
				url:"${PATH}/order/writeExpressInfo",
				method:"post",
				data:datas,
				success:function(res){
					if(res.code==100){
						layer.msg(res.extend.msg,{icon:6},function(){
							layer.closeAll();
							renderTb();
						})
					}else{
						layer.msg(res.extend.msg,{icon:5})	
					}
				},error:function(){
					layer.msg("系统错误")
				}

			 });
			  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
			});
		
		})
		
		
		
	</script>
	<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs  layui-btn-normal" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-xs" lay-event="delivery">发货</a>
</script>
</body>
</html>