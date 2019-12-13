<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>后台登录</title>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css">
</head>
<body>
	<div class="login_top clearfix">
		<a href="${PATH}/pages/index.jsp" class="login_logo"><img style="border:0;width:100px;height:75px;" src="${PATH}/pages/images/logo.png"></a>	
	</div>

	<div class="login_form_bg">
		<div class="login_form_wrap clearfix">
			<div class="login_banner fl"></div>
			<div class="slogan fl">草原兴发后台登录</div>
			<div class="login_form fr">
				<div class="login_title clearfix">
					<h1>管理员登录</h1>
				</div>
				<div class="form_input">
					<form action="${PATH}/admin/loginInto" method="post">
						<input type="text" name="adminName" class="name_input" placeholder="请输入用户名或邮箱">
						<div class="user_error">输入错误</div>
						<input type="password" name="adminPassword" class="pass_input" placeholder="请输入密码">
						<div class="pwd_error">输入错误</div>
						<div class="more_input clearfix">
							<input type="checkbox" >
							<label>记住用户名</label>
							<!-- <a href="#">忘记密码</a> -->
						</div>
						<input type="submit" value="登录" class="input_submit">
					</form>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/pages/common/footer.jsp"%>
	<script src="${PATH}/static/layui/layui.all.js"></script>
</body>
<script type="text/javascript">
	var msg = "${msg}"
	if(msg!=""){
		layui.layer.msg(msg,{icon:5})
	}
</script>
</html>