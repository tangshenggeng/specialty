<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>天天生鲜-注册</title>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css">
	<script type="text/javascript" src="${PATH}/pages/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="${PATH}/pages/js/register.js"></script>
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
	<div class="register_con">
		<div class="l_con fl">
			<a class="reg_logo"  href="${PATH}/pages/index.jsp"><img src="${PATH}/pages/images/logo.png"></a>
			<div class="reg_slogan">足不出户  ·  新鲜每一天</div>
			<div class="reg_banner"></div>
		</div>

		<div class="r_con fr">
			<div class="reg_title clearfix">
				<h1>用户注册</h1>
				<a href="${PATH}/pages/login.jsp">登录</a>
			</div>
			<div class="reg_form clearfix">
				<form action="${PATH}/customer/registerCust" method="post">
				<ul>
					<li>
						<label>用户名:</label>
						<input type="text" name="custName" id="user_name">
						<span class="error_tip">提示信息</span>
					</li>					
					<li>
						<label>密码:</label>
						<input type="password" name="formPwd1" id="pwd">
						<span class="error_tip">提示信息</span>
					</li>
					<li>
						<label>确认密码:</label>
						<input type="password" name="formPwd2" id="cpwd">
						<span class="error_tip">提示信息</span>
					</li>
					<li>
						<label>邮箱:</label>
						<input type="text" name="custEmail" id="email">
						<span class="error_tip">提示信息</span><br>
						
					</li>
					<li>
						<label>验证码:</label>
						<input type="number" name="formCode" id="code" style="width: 180px">
						<input type="button" onclick="sendemail()" id="codeBtn" value="获取验证码" style="width: 108px;height: 40px;font-size: 14px;">
						<span class="error_tip">提示信息</span>
					</li>
					<li class="agreement">
						<input type="checkbox" name="allow" id="allow" checked="checked">
						<label>同意”天天生鲜用户使用协议“</label>
						<span class="error_tip2">提示信息</span>
					</li>
					<li class="reg_sub">
						<input type="submit" value="注 册">
					</li>
				</ul>				
				</form>
			</div>

		</div>

	</div>

	<%@ include file="/pages/common/footer.jsp"%>
	
</body>
<script src="${PATH}/static/layui/layui.all.js"></script>
<script type="text/javascript">
//验证码
var countdown=60; 
function sendemail(){
	layui.use('layer', function(){
	  	var layer = layui.layer;
	  	var obj = $("#codeBtn");
	    var email = $("#email").val();
	    var reg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	    if(!reg.test(email)){
	    	layer.msg("请输入正确的邮箱！",{icon:5});
	    	return;
	    }
	    $.ajax({
	    	url:"${PATH}/regiterCode/createEmailCode?regEmail="+email,
	    	method:"get",
	    	success:function(res){
	    		if(res.code==100){
	    			layer.msg(res.extend.msg,{icon:6});
	    		}else{
	    			layer.msg(res.extend.msg,{icon:5});
	    		}
	    	},error:function(){
	    		layer.msg("系统错误！",{icon:5});
	    		return;
	    	}
	    });
	    settime(obj);
	});
    }
function settime(obj) { //发送验证码倒计时
    if (countdown == 0) { 
        obj.attr('disabled',false); 
        //obj.removeattr("disabled"); 
        obj.val("点击获取验证码");
        countdown = 60; 
        return;
    } else { 
        obj.attr('disabled',true);
        obj.val("重新发送(" + countdown + ")");
        countdown--; 
    } 
setTimeout(function() { 
    settime(obj) }
    ,1000) 
}
var error = "${error}"
if(error!=""){
	layui.layer.msg(error,{icon:5})
}
var success = "${success}"
if(success!=""){
	layui.layer.msg(success,{icon:6},function(){
		window.location.href="${PATH}/pages/login.jsp";
	})
}
</script>
</html>