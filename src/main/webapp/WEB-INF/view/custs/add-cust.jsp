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
		<a>添加客户</a>
	</blockquote>
		<form class="layui-form layui-col-md4 layui-col-md-offset3" style="margin-top: 150px">
			<div class="layui-form-item">
				<label class="layui-form-label">登录名</label>
				<div class="layui-input-inline">
					<input type="text" name="custName" required lay-verify="required"
						placeholder="请输入标题" autocomplete="off" class="layui-input">
				</div>
				 <div class="layui-form-mid layui-word-aux">默认密码：123456</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">邮箱</label>
				<div class="layui-input-block">
					<input type="email" name="custEmail" required lay-verify="email"
						placeholder="请输入标题" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit lay-filter="addCust">立即提交</button>
					<button type="reset" id="resetBtn" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form>
  </div>
  
  <div class="layui-footer">
    © 草原兴发特产商城	
  </div>
</div>
<script src="${PATH}/static/layui/layui.all.js"></script>	
<script src="${PATH}/static/js/jquery2.0-min.js"></script>	
<script>
//JavaScript代码区域
layui.use(['layer','form'], function(){
	var layer = layui.layer,
	form = layui.form;
	form.on('submit(addCust)', function(data){
		  var datas = data.field
		  $.ajax({
			url:"${PATH}/customer/addCust",
			data:datas,
			method:"post",
			success:function(res){
				if(res.code==100){
					layer.msg(res.extend.msg,{icon:6},function(){
						$("#resetBtn").click();
					})
				}else{
					layer.msg(res.extend.msg,{icon:5},function(){
						$("#resetBtn").click();
					})	
				}
			},error:function(){
				layer.msg("系统错误")
			}
		  });
		  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
});
</script>
</body>
</html>