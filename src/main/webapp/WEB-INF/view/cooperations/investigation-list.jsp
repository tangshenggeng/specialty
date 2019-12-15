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
					class="layui-icon layui-icon-layer"></i> 主页</a> / <a>合作考察中</a>
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
							<h2>合作考察中</h2>
							<br>
							<button class="layui-btn layui-btn-danger" type="button"
								id="delByIds">
								<i class="layui-icon layui-icon-delete"></i>删除选中
							</button>
							<button class="layui-btn" type="button"
								id="abnormalByIds">
								<i class="layui-icon layui-icon-close"></i>未通过选中
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
	<div style="display: none;" id="editModal">
		<div class="layui-card">
			<form class="layui-form" style="margin: 20px">
				<input type="hidden" id="cooperationId_edit" name="cooperationId" />
				<div class="layui-row">
					<div class="layui-col-sm6">
						<div class="layui-form-item">
							<label class="layui-form-label">称呼</label>
							<div class="layui-input-block">
								<input type="text" id="coopName_edit" name="coopName"
									lay-verify="required" placeholder="请输入" autocomplete="off"
									class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">电话</label>
							<div class="layui-input-block">
								<input type="text" id="coopPhone_edit" name="coopPhone"
									lay-verify="phone" placeholder="请输入" autocomplete="off"
									class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">Email</label>
							<div class="layui-input-block">
								<input type="text" id="coopEmail_edit" name="coopEmail"
									lay-verify="email" placeholder="请输入" autocomplete="off"
									class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">省份</label>
							<div class="layui-input-block">
								<input type="text" id="coopProvince_edit" name="coopProvince"
									lay-verify="required" placeholder="请输入" autocomplete="off"
									class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">市区</label>
							<div class="layui-input-block">
								<input type="text" id="coopCity_edit" name="coopCity"
									lay-verify="required" placeholder="请输入" autocomplete="off"
									class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">乡镇</label>
							<div class="layui-input-block">
								<input type="text" id="coopCounty_edit" name="coopCounty"
									lay-verify="required" placeholder="请输入" autocomplete="off"
									class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-sm6">
						<div class="layui-form-item">
							<label class="layui-form-label">详细地址</label>
							<div class="layui-input-block">
								<textarea name="detailAddr" id="detailAddr_edit" required
									lay-verify="required" placeholder="请输入" lay-verify="required"
									class="layui-textarea"></textarea>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">备注</label>
							<div class="layui-input-block">
								<textarea name="coopRemark" id="coopRemark_edit" required
									lay-verify="required" placeholder="请输入" lay-verify="required"
									class="layui-textarea"></textarea>
							</div>
						</div>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit lay-filter="coopEdit">修改</button>
					</div>
				</div>
				<!-- 更多表单结构排版请移步文档左侧【页面元素-表单】一项阅览 -->
			</form>

		</div>
	</div>
	<div style="display: none;" id="cooperationModal">
		<form class="layui-form"  style="margin: 20px">
			<input type="hidden" id="cooperationId_coop" name="cooperationId" />	
			<div class="layui-form-item">
				<label class="layui-form-label range-label">日期</label>
				<div class="layui-input-inline">
					<input type="text" id="start_date_coop" placeholder="合作开始时间"
						name="startTime" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid">-</div>
				<div class="layui-input-inline">
					<input type="text" id="end_date_coop" placeholder="合作结束时间"
						name="endTime" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit lay-filter="cooperationing">确认合作</button>
					</div>
				</div>
		</form>
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
					url : '${PATH}/cooperation/getInvestigationList',
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
						width : 175,
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
							area : [ '1000px', '600px' ],
							shadeClose : false,
							type : 1,
							content : $('#detailModal'),
							cancel : function(index, layero) {
								$('#detailModal').css("display", "none")
							}
						});

					} else if (layEvent === 'edit') { //编辑
						$("#cooperationId_edit").val(data.cooperationId)
						$("#coopName_edit").val(data.coopName)
						$("#coopPhone_edit").val(data.coopPhone)
						$("#coopCity_edit").val(data.coopCity)
						$("#coopProvince_edit").val(data.coopProvince)
						$("#coopCounty_edit").val(data.coopCounty)
						$("#coopEmail_edit").val(data.coopEmail)
						$("#detailAddr_edit").val(data.detailAddr)
						$("#coopRemark_edit").val(data.coopRemark)
						var index = layer.open({
							title : '修改',
							fix : true,
							resize : false,
							move : false,
							area : [ '1000px', '450px'],
							shadeClose : false,
							type : 1,
							content : $('#editModal'),
							cancel : function(index, layero) {
								$('#editModal').css("display", "none")
							}
						});
					} else if (layEvent === 'cooperation') { //编辑
						$("#cooperationId_coop").val(data.cooperationId)
						var index = layer.open({
							title : '合作',
							fix : true,
							resize : false,
							move : false,
							area : [ '600px', '200px'],
							shadeClose : false,
							type : 1,
							content : $('#cooperationModal'),
							cancel : function(index, layero) {
								$('#cooperationModal').css("display", "none")
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
		//批量未通过
		$("#abnormalByIds").click(function() {
			layui.use([ 'table', 'layer' ], function() {
				var table = layui.table, layer = layui.layer;
				layer.confirm('真的未通过行么', function(index) {
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
						url : "${PATH}/cooperation/abnormalCoopByIds",
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
		layui.use('laydate', function() {
			var laydate = layui.laydate;
			laydate.render({
				elem : '#start_date_coop',
				min: 0,
				eventElem : '#start_date_coop',
				trigger : 'click'
			});
			laydate.render({
				elem : '#end_date_coop' ,
				eventElem : '#end_date_coop',
				min: 1,
				trigger : 'click'
			});
		});
		//筛选
		$("#kwFormBtn").click(function() {
			renderTb();
		});
		layui.use([ 'form', 'layer' ], function() {
			var form = layui.form, layer = layui.layer;
			form.on('submit(coopEdit)', function(data) {
				console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
				var datas = data.field
				$.ajax({
					url : "${PATH}/cooperation/editCoop",
					method : "POST",
					data : datas,
					success : function(res) {
						if (res.code == 100) {
							layer.msg(res.extend.msg, {
								icon : 6
							}, function() {
								$('#editModal').css("display", "none")
								renderTb();
								layer.closeAll()
							})
						} else {
							layer.msg(res.extend.msg, {
								icon : 5
							}, function() {
								$('#editModal').css("display", "none")
								renderTb();
								layer.closeAll()
							})
						}
					},
					error : function() {
						layer.msg("系统错误")
					}
				});
				return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
			});
			form.on('submit(cooperationing)', function(data) {
				console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
				var datas = data.field
				$.ajax({
					url : "${PATH}/cooperation/cooperationing/"+datas.cooperationId+"/"+datas.startTime+"/"+datas.endTime,
					method : "get",
					success : function(res) {
						if (res.code == 100) {
							layer.msg(res.extend.msg, {
								icon : 6
							}, function() {
								$('#cooperationModal').css("display", "none")
								renderTb();
								layer.closeAll()
							})
						} else {
							layer.msg(res.extend.msg, {
								icon : 5
							}, function() {
								$('#cooperationModal').css("display", "none")
								renderTb();
								layer.closeAll()
							})
						}
					},
					error : function() {
						layer.msg("系统错误")
					}
				});
				return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
			});
		})
	</script>
	<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="edit">修改</a>
  <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="cooperation">合作</a>
</script>
</body>
</html>