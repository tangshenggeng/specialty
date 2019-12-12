<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>天天生鲜-登录</title>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css">
</head>
<body>
	<div class="login_top clearfix">
		<a href="${PATH}/pages/index.jsp" class="login_logo"><img src="${PATH}/pages/images/logo.png"></a>	
	</div>

	<div class="login_form_bg">
		<div class="login_form_wrap clearfix">
			<div class="login_banner fl"></div>
			<div class="slogan fl">日夜兼程 · 急速送达</div>
			<div class="login_form fr">
				<div class="login_title clearfix">
					<h1>用户登录</h1>
					<a href="${PATH}/pages/register.jsp">立即注册</a>
				</div>
				<div class="form_input">
					<form action="${PATH}/customer/loginInto" method="post">
						<input type="text" name="formCode" class="name_input" placeholder="请输入用户名或邮箱">
						<div class="user_error">输入错误</div>
						<input type="password" name="custPwd" class="pass_input" placeholder="请输入密码">
						<div class="pwd_error">输入错误</div>
						<div class="more_input clearfix">
							<input type="checkbox" >
							<label>记住用户名</label>
							<a href="#">忘记密码</a>
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
	var error = "${error}"
	if(error!=""){
		layui.layer.msg(error,{icon:5})
	}

</script>
</html>