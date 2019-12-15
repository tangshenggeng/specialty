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
<!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="${PATH}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${PATH}/static/vue/vue-resource.min.js"></script>
</head>
<style>
input[type=number] {
	-moz-appearance: textfield;
}

input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}
</style>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@ include file="/WEB-INF/view/common/header.jsp"%>
		<%@ include file="/WEB-INF/view/common/left-nav.jsp"%>
		<div class="layui-body">
			<blockquote class="layui-elem-quote">
				<a href="${PATH}/admin/index"><i
					class="layui-icon layui-icon-layer"></i> 主页</a> / <a>展示商品</a>
			</blockquote>
			<form class="layui-form" id="kwCustForm" style="margin: 10px 50px">
			<div class="layui-row">
				<div class="layui-col-md6">
					<div class="layui-form-item">
						<label class="layui-form-label">商品名称</label>
						<div class="layui-input-block">
							<input type="text" name="foodName" placeholder="请输入"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">供应商</label>
						<div class="layui-input-block">
							<input type="text" name="foodSupplier" placeholder="请输入供应商序列号"
								autocomplete="off" class="layui-input">
						</div>
					</div>
				</div>
					<div class="layui-col-md6">
						<div class="layui-form-item">
						    <label class="layui-form-label">分类</label>
						    <div class="layui-input-block">
						      <select name="foodSort">
						        <option value="">---请选择---</option>
						        <option value="新鲜水果">新鲜水果</option>
						        <option value="海鲜水产">海鲜水产</option>
						        <option value="猪牛羊肉">猪牛羊肉</option>
						        <option value="禽类蛋品">禽类蛋品</option>
						        <option value="新鲜蔬菜">新鲜蔬菜</option>
						        <option value="速冻食品">速冻食品</option>
						      </select>
						    </div>
						  </div>
						  <div class="layui-form-item">
							<label class="layui-form-label range-label">上架时间</label>
							<div class="layui-input-inline">
								<input type="text" id="start_date" placeholder="请选择" name="start_date"
									autocomplete="off" class="layui-input">
							</div>
							<div class="layui-form-mid">-</div>
							<div class="layui-input-inline">
								<input type="text" id="end_date" placeholder="请选择" name="end_date"
									autocomplete="off" class="layui-input">
							</div>
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
							<h2>展示商品</h2>
							<br>
							<button class="layui-btn layui-btn-danger" type="button"
								id="delByIds">
								<i class="layui-icon layui-icon-delete"></i>删除选中
							</button>
							<button class="layui-btn layui-btn-warm" type="button"
								id="hideByIds">
								<i class="layui-icon layui-icon-download-circle"></i>选中下架
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
	<div style="display: none;" id="detailModal">
		<div class="layui-card">
			<div id="foodIntroduceDiv" style="margin: 20px 20px">
				
			</div>
		</div>
	</div>
	<div style="display: none;" id="editModal">
		<div class="layui-card">
			<div style="margin: 20px 20px">
				<form class="layui-form">
					<input type="hidden" name="foodId" id="foodId_edit" />
					<div class="layui-form-item">
					    <label class="layui-form-label">名称</label>
					    <div class="layui-input-block">
					      <input type="text" name="foodName" id="foodName_edit" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
					    </div>
					  </div>
					<div class="layui-form-item">
					    <label class="layui-form-label">描述</label>
					    <div class="layui-input-block">
					      <input type="text" name="foodDesc" id="foodDesc_edit" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
					    </div>
					  </div>
					<div class="layui-form-item">
					    <label class="layui-form-label">原价</label>
					    <div class="layui-input-block">
					      <input type="number" lay-verify="required" id="foodOldPrice_edit" name="foodOldPrice" placeholder="请输入" autocomplete="off" class="layui-input">
					    </div>
					  </div>
					<div class="layui-form-item">
					    <label class="layui-form-label">现价</label>
					    <div class="layui-input-block">
					      <input type="number" lay-verify="required" id="foodPresentPrice_edit" name="foodPresentPrice" placeholder="请输入" autocomplete="off" class="layui-input">
					    </div>
					  </div>
					<div class="layui-form-item">
					    <label class="layui-form-label">单位</label>
					    <div class="layui-input-block">
					      <input type="text" lay-verify="required" id="foodMassUnit_edit" name="foodMassUnit" placeholder="500g" autocomplete="off" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">数量</label>
					    <div class="layui-input-block">
					      <input type="number" lay-verify="required" id="foodStock_edit" name="foodStock" placeholder="请输入" autocomplete="off" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">分类</label>
					    <div class="layui-input-block">
					      <select name="foodSort" lay-verify="required" id="foodSort_edit">
					        <option value="">---请选择---</option>
					        <option value="新鲜水果">新鲜水果</option>
					        <option value="海鲜水产">海鲜水产</option>
					        <option value="猪牛羊肉">猪牛羊肉</option>
					        <option value="禽类蛋品">禽类蛋品</option>
					        <option value="新鲜蔬菜">新鲜蔬菜</option>
					        <option value="速冻食品">速冻食品</option>
					      </select>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">展示图</label>
					    <div class="layui-input-block">
					   <input type="hidden" id="showImgInput" name="foodImg">
					    	<div class="layui-upload-drag" id="showImg">
							  <i class="layui-icon"></i>
							  <p>点击上传，或将图片拖拽到此处，一次只能上传一张图片</p>
							</div>
							<div class="layui-upload-list">
							    <img class="layui-upload-img" id="previewImg">
							    <p id="demoText"></p>
							  </div>	
					    </div>
					  </div>
					   <div class="layui-form-item">
					    <label class="layui-form-label">供应商</label>
					    <div class="layui-input-block">
					      <select name="foodSupplier" lay-verify="required" id="selectCoop">
					        <option value="">---请选择---</option>
					        <option  v-for="item in coops" :value="item.coopIdent" >{{item.coopName}}</option>
					      </select>
					    </div>
					  </div>
					<div class="layui-form-item">
						<div class="layui-input-block">
							<button class="layui-btn" id="addFoodBtn" lay-submit lay-filter="editFood">修改</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script src="${PATH}/static/layui/layui.all.js"></script>
	<script src="${PATH}/static/js/jquery2.0-min.js"></script>
	<script src="${PATH}/static/layui/mods/area.js"></script>
	<script src="${PATH}/static/layui/mods/select.js"></script>
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
					url : '${PATH}/food/getShowFoodList',
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
						field : 'foodId',
						title : '#',
						type : "checkbox",
						align : "center"
					}, {
						field : 'foodIdent',
						title : '序号',
						width:105,
						align : "center"
					}, {
						field : 'foodName',
						title : '名称',
						width:125,
						align : "center"
					}, {
						field : 'foodSupplier',
						title : '供应商序列号',
						width:120,
						align : "center"
					}, {
						field : 'foodImg',
						title : '展示图',
						width:75,
						align : "center",
						templet: function(d){
					        return '<img src="'+d.foodImg+'" style="with:30px;height:30px;" />'
					      }
					}, {
						field : 'foodStock',
						title : '库存',
						width:100,
						sort : true,
						align : "center"
					}, {
						field : 'foodOldPrice',
						title : '原价（￥）',
						width:125,
						sort : true,
						align : "center"
					}, {
						field : 'foodPresentPrice',
						title : '现价（￥）',
						sort : true,
						width:125,
						align : "center"
					} ,{
						field : 'foodMassUnit',
						title : '单位',
						width:75,
						align : "center"
					} ,{
						field : 'foodSort',
						title : '分类',
						width:130,
						align : "center"
					},{
						field : 'foodDesc',
						title : '描述',
						width:130,
						align : "center"
					}, {
						field : 'createTime',
						title : '上架时间',
						sort : true,
						width:107,
						align : "center",
						templet : "<div>{{layui.util.toDateString(d.createTime, 'yyyy-MM-dd')}}</div>"
					}, {
						title : '操作',
						align : "center",
						fixed : "right",
						width:150,
						toolbar : '#barDemo'
					}]],
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
					if (layEvent === 'detail') { //查看
						$("#foodIntroduceDiv").html(data.foodIntroduce)
						var index = layer.open({
							title : '查看',
							fix : true,
							resize : false,
							move : false,
							area : [ '1000px', '500px' ],
							shadeClose : false,
							type : 1,
							content : $('#detailModal'),
							cancel : function(index, layero) {
								$('#detailModal').css("display", "none")
							}
						});

					}else if (layEvent === 'edit') { //查看
						$("#foodId_edit").val(data.foodId)
						$("#foodName_edit").val(data.foodName)
						$("#foodDesc_edit").val(data.foodDesc)
						$("#foodOldPrice_edit").val(data.foodOldPrice)
						$("#foodPresentPrice_edit").val(data.foodPresentPrice)
						$("#foodMassUnit_edit").val(data.foodMassUnit)
						$("#foodStock_edit").val(data.foodStock)
						$("#showImgInput").val(data.foodImg)
						$("#previewImg").attr("src",data.foodImg)
						$("#foodSort_edit option").each(function(){
							var val = $(this).val()
							if(val == data.foodSort){
								$(this).attr("selected","selected")
							}
						});
						$("#selectCoop option").each(function(){
							var val = $(this).val()
							if(val == data.foodSupplier){
								$(this).attr("selected","selected")
							}
						});
						layui.form.render('select');
						var index = layer.open({
							title : '修改',
							fix : true,
							resize : false,
							move : false,
							area : [ '1000px', '500px' ],
							shadeClose : false,
							type : 1,
							content : $('#editModal'),
							cancel : function(index, layero) {
								$('#editModal').css("display", "none")
							}
						});

					} else if (layEvent === 'LAYTABLE_TIPS') {
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
						ids.push($(this)[0].foodId);
					})
					if (ids.length == 0) {
						layer.msg("请选择数据！");
						return false;
					}
					$.ajax({
						url : "${PATH}/food/delFoodByIds",
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
		//批量下架
		$("#hideByIds").click(function() {
			layui.use([ 'table', 'layer' ], function() {
				var table = layui.table, layer = layui.layer;
				layer.confirm('真的下架行么', function(index) {
					var checkStatus = table.checkStatus('dataListTbId');
					var datas = checkStatus.data
					var ids = new Array();
					$(datas).each(function() {
						ids.push($(this)[0].foodId);
					})
					if (ids.length == 0) {
						layer.msg("请选择数据！");
						return false;
					}
					$.ajax({
						url : "${PATH}/food/hideFoodByIds",
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
	</script>
	<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="edit">修改</a>
</script>
<script type="text/javascript">
	var selectCoop = new Vue({
		el:"#selectCoop",
		data:{
			coops:[]
		},created: function () {
			//供应商
			this.$http.get("${PATH}/cooperation/getCoopsBySelect").then(function(response){
				//成功
				this.coops=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		},updated:function(){
			layui.form.render('select')
		}
	})

</script>
<script type="text/javascript">
layui.use(['layer','upload'], function(){
	var layer = layui.layer,
	upload = layui.upload;
	upload.render({
	    elem: '#showImg'
	    ,url: '${PATH}/food/showImg'
	   	,accept: 'images' //视频
	    ,acceptMime:"image/*"
	    ,exts:'jpg|png'
	    ,size:1024	//视频不超过1M
	    ,done: function(res){
	      console.log(res)
	      //如果上传失败
	      if(res.code > 0){
	        return layer.msg(res.msg,{icon:5});
	      }
	      //上传成功
	      $("#showImgInput").val(res.data);
	      $("#previewImg").attr("src",res.data);
	      layer.msg(res.msg,{icon:6})
	    },error: function(){
	      //演示失败状态，并实现重传
	      var demoText = $('#demoText');
	      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
	      demoText.find('.demo-reload').on('click', function(){
	        uploadInst.upload();
	      });
		 }
	  });
})
</script>
<script type="text/javascript">
layui.use(['layer','form'], function(){
	var layer = layui.layer,
	form = layui.form;
	form.on('submit(editFood)', function(data){
		  layer.confirm('确认修改吗？', {icon: 3, title:'提示'}, function(index){
			   var datas = data.field
				  $.ajax({
					url:"${PATH}/food/editFood",
					data:datas,
					method:"post",
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
			  layer.close(index);
			});
		  return false; 
		});
	})
</script>
</body>
</html>