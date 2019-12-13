<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>草原兴发-用户中心</title>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css"/>
</head>
<body>
	<%@ include file="/pages/common/header.jsp"%>

	<div class="main_con clearfix">
		<div class="left_menu_con clearfix">
			<h3>用户中心</h3>
			<ul>
				<li><a href="${PATH}/pages/user_center_info.jsp">· 个人信息</a></li>
				<li><a href="${PATH}/pages/user_center_order.jsp">· 全部订单</a></li>
				<li><a href="${PATH}/pages/user_center_site.jsp" class="active">· 收货地址</a></li>
			</ul>
		</div>
		<div class="right_content clearfix">
				<h3 class="common_title2">收货地址</h3>
				<div class="site_con">
					<dl>
						<dt>当前地址：</dt>
						<dd>北京市 海淀区 东北旺西路8号中关村软件园 （李思 收） 182****7528</dd>
					</dl>					
				</div>
				<h3 class="common_title2">编辑地址</h3>
				<div class="site_con">
					<form>
						<div class="form_group">
							<label>收件人：</label>
							<input type="text" name="">
						</div>
						<div class="form_group form_group2">
							<label>详细地址：</label>
							<textarea class="site_area"></textarea>
						</div>
						<div class="form_group">
							<label>邮编：</label>
							<input type="text" name="">
						</div>
						<div class="form_group">
							<label>手机：</label>
							<input type="text" name="">
						</div>

						<input type="submit" name="" value="提交" class="info_submit">
					</form>
				</div>
		</div>
	</div>



	<%@ include file="/pages/common/footer.jsp"%>
	
</body>
</html>