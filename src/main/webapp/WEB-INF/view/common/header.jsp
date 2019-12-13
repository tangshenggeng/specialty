<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="layui-header" >
    <div class="layui-logo"><img src="${PATH}/pages/images/logo.png" class="layui-nav-img"></div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="${PATH}/admin/index"><span style="color: white;font-family: monospace;">草原兴发后台管理系统</span></a></li>
      <!-- <li class="layui-nav-item"><a href="">商品管理</a></li>
      <li class="layui-nav-item"><a href="">用户</a></li>
      <li class="layui-nav-item">
        <a href="javascript:;">其它系统</a>
        <dl class="layui-nav-child">
          <dd><a href="">邮件管理</a></dd>
          <dd><a href="">消息管理</a></dd>
          <dd><a href="">授权管理</a></dd>
        </dl>
      </li> -->
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          ${sessionScope.admin}
        </a>
        <dl class="layui-nav-child">
          <dd><a href="">基本资料</a></dd>
          <dd><a href="">安全设置</a></dd>
          <dd><a href="${PATH}/admin/loginOut">退出登录</a></dd>
        </dl>
      </li>
      <!-- <li class="layui-nav-item"><a href="">退了</a></li> -->
    </ul>
    <script type="text/javascript">
    	var admin = "${sessionScope.admin}"
    	if(admin==""){
    		alert("登录超时！请重新登录")
    		window.location.href="${PATH}/admin/loginOut";
    	}
    </script>
  </div>