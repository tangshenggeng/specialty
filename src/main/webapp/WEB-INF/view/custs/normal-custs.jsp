<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>草原兴发后台</title>
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
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
		<a href="${PATH}/admin/index"><i class="layui-icon layui-icon-layer"></i> 主页</a> /
		<a>正常客户</a>
	</blockquote>
		<form class="layui-form" id="kwCustForm">
			<div class="layui-col-md3">
				<div class="layui-form-item">
					<label class="layui-form-label">用户名</label>
					<div class="layui-input-block">
						<input type="text" name="custName"  placeholder="请输入" autocomplete="off"
							class="layui-input">
					</div>
				</div>
			</div>
			<div class="layui-col-md3">
				<div class="layui-form-item">
					<label class="layui-form-label">邮箱</label>
					<div class="layui-input-block">
						<input type="text" name="custEmail"  placeholder="请输入" autocomplete="off"
							class="layui-input">
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label range-label">日期</label>
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
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" type="button" id="kwFormBtn">筛选</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form>
		<div class="row">
			<div class="layui-col-md10  layui-col-md-offset1">
				<div class="card">
					<div class="card-header">
						<h2>客户列表</h2><br>
						<button class="layui-btn layui-btn-danger" type="button" id="delByIds"><i class="layui-icon layui-icon-delete"></i>删除选中</button>
						<button class="layui-btn " type="button" id="exceptionCustBtn"><i class="layui-icon layui-icon-face-surprised"></i>拉黑选中</button>
					</div>
					<div class="card-body">
						<table id="dataListTb"
							class="table table-responsive table-hover"
							>

						</table>
					</div>
				</div>
			</div>
		</div>
  </div>
  
  <div class="layui-footer">
    © 草原兴发特产商城	
  </div>
</div>
<script src="${PATH}/static/layui/layui.all.js"></script>	
<script src="${PATH}/static/js/jquery2.0-min.js"></script>	
<script>
$(function() {
	renderTb();
});
function renderTb() {
	var data = $("#kwCustForm").serializeArray();
	layui.use(['table','util'], function() {
		var table = layui.table
		,util = layui.util;
		//第一个实例
		table.render({
			elem : '#dataListTb',
			height :400,
			url : '${PATH}/customer/getNormalCustList',
			text : {
				none : '未找到顾客'
			},
			id:"datListTbId",
			size : 'sm ',
			contentType: "application/json",//必须指定，否则会报415错误
		    dataType : 'json',
			method:"POST",
			id:"dataListTbId",
			page : true //开启分页
			,
			where : {
				kwdata : data
			},
			cols : [ [ //表头
			{
				field : 'custId',
				title : '#',
				type:"checkbox",
				align : "center"
			}, {
				field : 'custIdent',
				title : '用户序号',
				align : "center"
			},{
				field : 'custName',
				title : '用户名',
				align : "center"
			}, {
				field : 'custEmail',
				title : '邮箱',
				align : "center"
			},{
				field : 'createTime',
				title : '创建时间',
				sort:true,
				align : "center"
				,templet:"<div>{{layui.util.toDateString(d.createTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
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
	});
}
//批量删除
$("#delByIds").click(function(){
	layui.use(['table','layer'], function() {
		var table = layui.table
		,layer = layui.layer;
		layer.confirm('真的删除行么', function(index){
			var checkStatus = table.checkStatus('dataListTbId');
			var datas = checkStatus.data
			var ids = new Array();
			$(datas).each(function(){
				ids.push($(this)[0].id);
			})
			
			if(ids.length==0){
				layer.msg("请选择数据！");
				return false;
			}
			$.ajax({
				url:"${PATH}/customer/delCustByIds",
				method:"POST",
				contentType: "application/json",//必须指定，否则会报415错误
			    dataType : 'json',
				data:JSON.stringify(ids),
				success:function(res){
					console.log(res)
					if(res.code == 100){
						layer.msg(res.extend.msg,{icon:6},function(){
							renderTb();
						});
					}else{
						layer.msg(res.extend.msg,{icon:5},function(){
							renderTb();
						});
					}
				},error:function(){
					layer.msg("系统错误！",{icon:5},function(){
						renderTb();
					});
				}
			});	
		  layer.close(index);
		});
	});
})
//批量异常
$("#exceptionCustBtn").click(function(){
	layui.use(['table','layer'], function() {
		var table = layui.table
		,layer = layui.layer;
		layer.confirm('确认拉黑用户吗？', function(index){
			var checkStatus = table.checkStatus('dataListTbId');
			var datas = checkStatus.data
			var ids = new Array();
			$(datas).each(function(){
				ids.push($(this)[0].id);
			})
			if(ids.length==0){
				layer.msg("请选择数据！");
				return false;
			}
			$.ajax({
				url:"${PATH}/customer/exceptionCustByIds",
				method:"POST",
				contentType: "application/json",//必须指定，否则会报415错误
			    dataType : 'json',
				data:JSON.stringify(ids),
				success:function(res){
					console.log(res)
					if(res.code == 100){
						layer.msg(res.extend.msg,{icon:6},function(){
							renderTb();
						});
					}else{
						layer.msg(res.extend.msg,{icon:5},function(){
							renderTb();
						});
					}
				},error:function(){
					layer.msg("系统错误！",{icon:5},function(){
						renderTb();
					});
				}
			});	
		  layer.close(index);
		});
	});
})
layui.use('laydate', function(){
  var laydate = layui.laydate;
  //执行一个laydate实例
  laydate.render({
    elem: '#start_date' //指定元素,
    ,eventElem: '#start_date'
    ,trigger: 'click'
  });
  laydate.render({
    elem: '#end_date' //指定元素,
    ,eventElem: '#end_date'
    ,trigger: 'click'
  });
});
//筛选
$("#kwFormBtn").click(function(){
	renderTb();
});
</script>
</body>
</html>