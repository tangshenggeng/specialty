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
<script type="text/javascript" src="${PATH}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${PATH}/static/vue/vue-resource.min.js"></script>
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
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@ include file="/WEB-INF/view/common/header.jsp"%>
  <%@ include file="/WEB-INF/view/common/left-nav.jsp"%>
  <div class="layui-body">
    <blockquote class="layui-elem-quote">
		<a href="${PATH}/admin/index"><i class="layui-icon layui-icon-layer"></i> 主页</a> /
		<a>添加食品</a>
	</blockquote>
		<form class="layui-form layui-col-md6 layui-col-md-offset3" style="margin-top: 50px">
			<div class="layui-form-item">
			    <label class="layui-form-label">名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="foodName" required lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			<div class="layui-form-item">
			    <label class="layui-form-label">描述</label>
			    <div class="layui-input-block">
			      <input type="text" name="foodDesc" required lay-verify="required"  placeholder="请输入" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			<label class="layui-form-label">介绍</label>
			    <div class="layui-input-block">
			    	<div id="introduceDiv">
				        <p>商品介绍</p>
				    </div>
			    </div>
			    <div class="layui-input-block" style="display: none;">
			    	<textarea id="introduceText"  name="foodIntroduce"  placeholder="请输入" class="layui-textarea"></textarea>
			    </div>
			  </div>
			<div class="layui-form-item">
			    <label class="layui-form-label">原价</label>
			    <div class="layui-input-block">
			      <input type="number" required lay-verify="required" name="foodOldPrice" placeholder="请输入" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			<div class="layui-form-item">
			    <label class="layui-form-label">现价</label>
			    <div class="layui-input-block">
			      <input type="number" required lay-verify="required" name="foodPresentPrice" placeholder="请输入" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			<div class="layui-form-item">
			    <label class="layui-form-label">单位</label>
			    <div class="layui-input-block">
			      <input type="text"  required lay-verify="required" name="foodMassUnit" placeholder="500g" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">数量</label>
			    <div class="layui-input-block">
			      <input type="number" required lay-verify="required" name="foodStock" placeholder="请输入" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">分类</label>
			    <div class="layui-input-block">
			      <select name="foodSort" lay-verify="required">
			        <option value="">---请选择---</option>
			        <option value="新鲜水果">新鲜水果</option>
			        <option value="海鲜水产">海鲜水产</option>
			        <option value="猪牛羊肉">猪牛羊肉</option>
			        <option value="禽类蛋品">禽类蛋品</option>
			        <option value="新鲜蔬菜">新鲜蔬菜</option>
			        <option value="速冻食品">速冻食品</option>
			      </select>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">展示图</label>
			    <div class="layui-input-block">
			   <input type="hidden" id="showImgInput" name="foodImg">
			    	<div class="layui-upload-drag" id="showImg">
					  <i class="layui-icon"></i>
					  <p>点击上传，或将图片拖拽到此处，一次只能上传一张图片</p>
					</div>
					<div class="layui-upload-list">
					    <img class="layui-upload-img" id="previewImg">
					    <p id="demoText"></p>
					  </div>	
			    </div>
			  </div>
			   <div class="layui-form-item">
			    <label class="layui-form-label">供应商</label>
			    <div class="layui-input-block">
			      <select name="foodSupplier" lay-verify="required" id="selectCoop">
			        <option value="">---请选择---</option>
			        <option  v-for="item in coops" :value="item.coopIdent" >{{item.coopName}}</option>
			      </select>
			    </div>
			  </div>
			 <div class="layui-form-item">
			    <div class="layui-input-block">
			      <input type="radio" name="isShow" value="展示" title="展示" checked>
			      <input type="radio" name="isShow" value="隐藏" title="隐藏">
			    </div>
			  </div>
			
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit lay-filter="*">立即提交</button>
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
<script src="${PATH}/static/wangEditor/release/wangEditor.min.js"></script>
<script type="text/javascript">
	var selectCoop = new Vue({
		el:"#selectCoop",
		data:{
			coops:[]
		},created: function () {
			//供应商
			this.$http.get("${PATH}/cooperation/getCoopsBySelect").then(function(response){
				//成功
				this.coops=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
		},updated:function(){
			layui.form.render('select')
		}
	})

	//富文本编辑器
    var E = window.wangEditor
    var editor = new E('#introduceDiv')
    var $introduceText = $('#introduceText')
    // 自定义菜单配置
    editor.customConfig.menus = [
    	'head',  // 标题
        'bold',  // 粗体
        'fontSize',  // 字号
        'fontName',  // 字体
        'italic',  // 斜体
        'underline',  // 下划线
        'strikeThrough',  // 删除线
        'foreColor',  // 文字颜色
        'backColor',  // 背景颜色
        'link',  // 插入链接
        'list',  // 列表
        'justify',  // 对齐方式
        'quote',  // 引用
        'image',  // 插入图片
    ]
	// 隐藏“网络图片”tab
    editor.customConfig.showLinkImg = false
	editor.customConfig.uploadImgShowBase64 = true   // 使用 base64 保存图片
   	// 将图片大小限制为 1M
   	editor.customConfig.uploadImgMaxSize = 1*1024*1024
 	// 限制一次最多上传 5 张图片
   	editor.customConfig.uploadImgMaxLength = 5
    // 配置服务器端地址
    editor.customConfig.uploadImgServer = '${PATH}/food/introduceImg'
    //自定义文件名字
    editor.customConfig.uploadFileName = 'file';
    editor.customConfig.customAlert = function (info) {
    	layui.layer.msg("图片格式或大小有误",{icon:5})
    }
    editor.customConfig.uploadImgHooks = {
    	    before: function (xhr, editor, files) {
    	    },
    	    success: function (xhr, editor, result) {
    	    },
    	    fail: function (xhr, editor, result) {
    	    	layui.layer.msg(result.msg,{icon:5})
    	    },
    	    error: function (xhr, editor) {
    	    	layui.layer.msg("图片格式或大小有误",{icon:5})
    	    },
    	    timeout: function (xhr, editor) {
    	    	layui.layer.msg("图片上传超时！",{icon:5})
    	    },
    	    // 如果服务器端返回的不是 {errno:0, data: [...]} 这种格式，可使用该配置
    	    customInsert: function (insertImg, result, editor) {
    	    var url = result.data
	        insertImg(url)	//回显
    	    }
    	}
    editor.customConfig.onchange = function (html) {
        // 监控变化，同步更新到 textarea
        $introduceText.val(html)
    }
    editor.create()
    // 初始化 textarea 的值
    $introduceText.val(editor.txt.html())
</script>
<script type="text/javascript">
layui.use(['layer','upload'], function(){
	var layer = layui.layer,
	upload = layui.upload;
	upload.render({
	    elem: '#showImg'
	    ,url: '${PATH}/food/showImg'
	   	,accept: 'images' //视频
	    ,acceptMime:"image/*"
	    ,exts:'jpg|png'
	    ,size:1024	//视频不超过1M
	    ,done: function(res){
	      console.log(res)
	      //如果上传失败
	      if(res.code > 0){
	        return layer.msg(res.msg,{icon:5});
	      }
	      //上传成功
	      $("#showImgInput").val(res.data);
	      $("#previewImg").attr("src",res.data);
	      layer.msg(res.msg,{icon:6})
	    },error: function(){
	      //演示失败状态，并实现重传
	      var demoText = $('#demoText');
	      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
	      demoText.find('.demo-reload').on('click', function(){
	        uploadInst.upload();
	      });
		 }
	  });
})
</script>
<script>
//JavaScript代码区域
layui.use(['layer','form'], function(){
	var layer = layui.layer,
	form = layui.form;
	form.on('submit(*)', function(data){
	  var datas = data.field
	  $.ajax({
		url:"${PATH}/food/addFood",
		data:datas,
		method:"post",
		success:function(res){
			if(res.code==100){
				layer.msg(res.extend.msg,{icon:6},function(){
					location.reload() 
				})
			}else{
				layer.msg(res.extend.msg,{icon:5})	
			}
		},error:function(){
			layer.msg("系统错误")
		}
	  })
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
});
</script>
</body>
</html>