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
					<input type="hidden" id="videoInput" name="coopVideo"/>
z					<div class="layui-form-item">
						<label class="layui-form-label">称呼</label>
						<div class="layui-input-block">
							<input type="text" name="coopName" lay-verify="required" placeholder="请输入" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">电话</label>
						<div class="layui-input-block">
							<input type="text" name="coopPhone" lay-verify="phone" placeholder="请输入" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">Email</label>
						<div class="layui-input-block">
							<input type="text" name="coopEmail" lay-verify="email" placeholder="请输入" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">上传视频</label>
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="test5"><i class="layui-icon"></i>选择视频</button>
							<span id="demoText"></span>	
							<button type="button" class="layui-btn layui-btn-normal" id="uploadAction"><i class="layui-icon layui-icon-ok"></i>确认上传</button>
						</div>
					</div>
					<div class="layui-form-item" id="area-picker">
			            <div class="layui-form-label">地址</div>
			            <div class="layui-input-inline" style="width: 200px;">
			                <select name="coopProvince" class="province-selector" data-value="内蒙古自治区" lay-filter="province-1">
			                    <option value="">请选择省</option>
			                </select>
			            </div>
			            <div class="layui-input-inline" style="width: 200px;">
			                <select name="coopCity" class="city-selector" data-value="呼和浩特市" lay-filter="city-1">
			                    <option value="">请选择市</option>
			                </select>
			            </div>
			            <div class="layui-input-inline" style="width: 200px;">
			                <select name="coopCounty" class="county-selector" data-value="新城区" lay-filter="county-1">
			                    <option value="">请选择区</option>
			                </select>
			            </div>
			        </div>
			        <div class="layui-form-item">
						<label class="layui-form-label">详细地址</label>
						<div class="layui-input-block">
							<textarea name="detailAddr" required lay-verify="required" placeholder="请输入"  lay-verify="required" class="layui-textarea"></textarea>
						</div>
					</div>
			        <div class="layui-form-item">
						<label class="layui-form-label">备注</label>
						<div class="layui-input-block">
							<textarea name="coopRemark" required lay-verify="required" placeholder="请输入"  lay-verify="required" class="layui-textarea"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-input-block">
							<button class="layui-btn" lay-submit lay-filter="coopSumbit">立即提交</button>
							<button type="reset" id="resetBtn" class="layui-btn layui-btn-primary">重置</button>
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
<script src="${PATH}/static/js/jquery2.0-min.js"></script>
<script type="text/javascript">
//配置地址
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
        }
    });
});
layui.use(['layer','upload'],function(){
	var layer = layui.layer
    , upload = layui.upload;
	 upload.render({
	    elem: '#test5'
	    ,url: '${PATH}/cooperation/uploadVideo'
	    ,accept: 'video' //视频
	    ,acceptMime:"video/mp4"
	    ,exts:'mp4|m4v'
	    ,size:51200	//视频不超过50M
	    ,auto:false
	    ,bindAction:"#uploadAction"
	    ,done: function(res){
    	 //如果上传失败
	      if(res.code > 0){
	        return layer.msg(res.msg,{icon:6});
	      }
	      //上传成功
	      $("#videoInput").val(res.data);
	      return layer.msg(res.msg,{icon:6});
	    }
	    ,error: function(){
	      //演示失败状态，并实现重传
	      var demoText = $('#demoText');
	      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
	      demoText.find('.demo-reload').on('click', function(){
	        uploadInst.upload();
	      });
	    }
	  });
});
layui.use(['layer', 'form'], function () {
    var layer = layui.layer
        , form = layui.form;
    form.on('submit(coopSumbit)', function(data){
    	 var videoPath = $("#videoInput").val();
    	 if(videoPath == ''){
    		 layer.msg("请选择视频并上传！")
    		 return false;
    	 }
    	 var datas = data.field 
    	 $.ajax({
    		 url:"${PATH}/cooperation/addCoopera",
    		 method:"POST",
    		 data:datas,
    		 success:function(res){
   				if(res.code==100){
   					layer.msg(res.extend.msg,{icon:6},function(){
   						$("#resetBtn").click();
   					})
   				}else{
   					layer.msg(res.extend.msg,{icon:5})	
   				}
   			},error:function(){
   				layer.msg("系统错误")
   			}
    	 });
    	 return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
    });
})
</script>
</html>