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
    <div style="padding: 15px;">内容主体区域</div>
  </div>
  
  <div class="layui-footer">
    © 草原兴发特产商城	
  </div>
</div>
<script src="${PATH}/static/layui/layui.all.js"></script>	
<script>
//JavaScript代码区域
/* layui.use('element', function(){
  var element = layui.element;
}); */
</script>
</body>
</html>