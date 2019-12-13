<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
%>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>草原兴发-申请合作</title>
<link rel="stylesheet" type="text/css"
	href="${PATH}/pages/css/reset.css">
<link rel="stylesheet" type="text/css" href="${PATH}/pages/css/main.css">
<link rel="stylesheet" type="text/css" href="${PATH}/static/layui/css/layui.css">
<script type="text/javascript"
	src="${PATH}/pages/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${PATH}/pages/js/register.js"></script>
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
<body>
<div class="layui-container" >
	<div class="layui-row">
		<div class="layui-col-md4" style="margin: 50px auto;">
			<a class="reg_logo" href="${PATH}/pages/index.jsp"><img
				style="border: 0; width: 100px; height: 75px;"
				src="${PATH}/pages/images/logo.png"></a>
			<div class="reg_slogan">加入我们！共创辉煌！</div>
			<div class="reg_banner"></div>
		</div>
		<div class="layui-col-md8">
			<div class="reg_title clearfix" style="margin: 50px auto;">
				<h1>申请合作</h1>
			</div>
				<form class="layui-form">
					<!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
					<div class="layui-form-item">
						<label class="layui-form-label">称呼</label>
						<div class="layui-input-block">
							<input type="text" name="" placeholder="请输入" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">联系方式</label>
						<div class="layui-input-block">
							<input type="text" name="" placeholder="请输入" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">上传视频</label>
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="test5"><i class="layui-icon"></i>上传视频</button>
						</div>
					</div>
					<div class="layui-form-item" id="area-picker">
			            <div class="layui-form-label">地址</div>
			            <div class="layui-input-inline" style="width: 200px;">
			                <select name="province" class="province-selector" data-value="内蒙古自治区" lay-filter="province-1">
			                    <option value="">请选择省</option>
			                </select>
			            </div>
			            <div class="layui-input-inline" style="width: 200px;">
			                <select name="city" class="city-selector" data-value="呼和浩特市" lay-filter="city-1">
			                    <option value="">请选择市</option>
			                </select>
			            </div>
			            <div class="layui-input-inline" style="width: 200px;">
			                <select name="county" class="county-selector" data-value="新城区" lay-filter="county-1">
			                    <option value="">请选择区</option>
			                </select>
			            </div>
			        </div>
			        <div class="layui-form-item">
						<label class="layui-form-label">备注</label>
						<div class="layui-input-block">
							<textarea name="" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-input-block">
							<button class="layui-btn" lay-submit lay-filter="*">立即提交</button>
							<button type="reset" class="layui-btn layui-btn-primary">重置</button>
						</div>
					</div>
					<!-- 更多表单结构排版请移步文档左侧【页面元素-表单】一项阅览 -->
				</form>

		</div>

	</div>
</div>
	<%@ include file="/pages/common/footer.jsp"%>

</body>
<script src="${PATH}/static/layui/layui.all.js"></script>
<script type="text/javascript">
//配置插件目录
layui.config({
    base: '${PATH}/static/layui/mods/'
    , version: '1.0'
});
//一般直接写在一个js文件中
layui.use(['layer', 'form', 'layarea'], function () {
    var layer = layui.layer
        , form = layui.form
        , layarea = layui.layarea;
    layarea.render({
        elem: '#area-picker',
        change: function (res) {
            //选择结果
            console.log(res);
        }
    });
});
layui.use(['layer','upload'],function(){
	var layer = layui.layer
    , upload = layui.upload;
	 upload.render({
	    elem: '#test5'
	    ,url: '/upload/'
	    ,accept: 'video' //视频
	    ,acceptMime:"video/mp4,video/Ogg"
	    ,exts:'mp4|ogm|m4v|ogv'
	    ,done: function(res){
	      console.log(res)
	    }
	  });
	
});
</script>
</html>