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
					class="layui-icon layui-icon-layer"></i> 主页</a> / <a>停止合作</a>
			</blockquote>
			<form class="layui-form" id="kwCustForm">
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">称呼</label>
						<div class="layui-input-block">
							<input type="text" name="coopName" placeholder="请输入"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-input-block">
							<button class="layui-btn" type="button" id="kwFormBtn">筛选</button>
							<button type="reset" id="resetBtn"
								class="layui-btn layui-btn-primary">重置</button>
						</div>
					</div>
				</div>
				<div class="layui-col-md8">
					<div class="layui-form-item">
						<label class="layui-form-label">请选择地区</label>
						<div class="layui-inline">
							<select name="coopProvince" id="province" lay-verify="required"
								lay-search lay-filter="province">
								<option value="">省份</option>
							</select>
						</div>
						<div class="layui-inline">
							<select name="coopCity" id="city" lay-verify="required"
								lay-search lay-filter="city">
								<option value="">地级市</option>
							</select>
						</div>
						<div class="layui-inline">
							<select name="coopCounty" id="district" lay-verify="required"
								lay-search>
								<option value="">县/区</option>
							</select>
						</div>
					</div>
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
			</form>
			<div class="row">
				<div class="layui-col-md10  layui-col-md-offset1">
					<div class="card">
						<div class="card-header">
							<h2>停止合作</h2>
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
	<div style="display: none;" id="detailModal" align="center">
		<div class="layui-card">
			<div>
				<video
					style="width: 800px; height: 400px; padding: 10px 10px; margin: 0 auto;"
					id="coopVideo" data-ckin="default" data-overlay="1"
					data-title="申请合作附件"></video>
			</div>
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
					url : '${PATH}/cooperation/getAbnormalList',
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
						field : 'cooperationId',
						title : '#',
						type : "checkbox",
						rowspan : 2,
						align : "center"
					}, {
						field : 'coopIdent',
						title : '序号',
						width : 120,
						rowspan : 2,
						align : "center"
					}, {
						field : 'coopName',
						title : '称呼',
						rowspan : 2,
						align : "center"
					}, {
						field : 'coopEmail',
						title : '邮箱',
						rowspan : 2,
						width : 200,
						align : "center"
					}, {
						field : 'coopPhone',
						title : '电话',
						width : 120,
						rowspan : 2,
						align : "center"
					}, {
						title : '地址',
						colspan : 4,
						align : "center"
					}, {
						field : 'coopRemark',
						title : '备注',
						rowspan : 2,
						align : "center"
					}, {
						field : 'createTime',
						title : '申请时间',
						rowspan : 2,
						width : 161,
						sort : true,
						align : "center",
						templet : "<div>{{layui.util.toDateString(d.createTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
					}, {
						title : '操作',
						rowspan : 2,
						align : "center",
						width : 127,
						fixed : "right",
						toolbar : '#barDemo'
					} ], [ {
						field : 'coopProvince',
						title : '省份',
						width : 84,
						align : "center"
					}, {
						field : 'coopCity',
						title : '市区',
						width : 84,
						align : "center"
					}, {
						field : 'coopCounty',
						title : '乡镇',
						width : 84,
						align : "center"
					}, {
						field : 'detailAddr',
						title : '详细地址',
						width : 96,
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
					if (layEvent === 'detail') { //查看
						$("#coopVideo").attr("src", data.coopVideo)
						$("#coopEmailInput").val(data.coopEmail)
						$("#coopIdInput").val(data.cooperationId)
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

					}  else if (layEvent === 'LAYTABLE_TIPS') {
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
						ids.push($(this)[0].cooperationId);
					})
					if (ids.length == 0) {
						layer.msg("请选择数据！");
						return false;
					}
					$.ajax({
						url : "${PATH}/cooperation/delCoopByIds",
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
</script>
</body>
</html>