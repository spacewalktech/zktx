<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ tagliburi="http://shiro.apache.org/tags" prefix="shiro" %>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<title>健康医疗保险大数据</title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="shortcut icon" href="${root }/resources/img/logo_title.ico" type="image/x-icon">
		<link rel="icon" href="${root }/resources/img/logo_title.ico" type="image/x-icon">
		<style>
		html,body {
		    margin:0;
		    height:100%;
		}
		#test {
		    width:100%;
		    height:100%;
		    background-color:#000;
		    position:absolute;
		    top:0;
		    left:0;
		    z-index:1000;
		    opacity:0.3;
		    /*兼容IE8及以下版本浏览器*/
		    filter: alpha(opacity=30);
		    display:none;
		}
		
		#log_window {
		    width:200px;
		    height:200px;
		    background-color:#FF0;    
		    margin: auto;
		    position: absolute;
		    z-index:3;
		    top: 0;
		    bottom: 0;
		    left: 0;
		    right: 0;
		    display:none;
		}
		</style>
				
		<script>
		function shield(){
		    var s = document.getElementById("test");
		    s.style.display = "block";
		    
		//     var l = document.getElementById("log_window");
		//     l.style.display = "block";
		}
		
		function cancel_shield(){
		    var s = document.getElementById("test");
		    s.style.display = "none";
		    
		//     var l = document.getElementById("log_window");
		//     l.style.display = "none";
		}
</script>
	</head>

	<body class="desktop-detected pace-done smart-style-2">

		<!-- HEADER -->
		<header id="header">
			<div id="logo-group">
				<span id="titlogo" style="height: 32px;font-size: 22px">健康医疗保险大数据</span>
			</div>
			<!-- pulled right: nav area -->
			<div class="pull-right">
				
				<!-- collapse menu button -->
				<div id="hide-menu" class="btn-header pull-right">
					<span> <a href="javascript:void(0);" data-action="toggleMenu" title="Collapse Menu"><i class="fa fa-reorder"></i></a> </span>
				</div>
				<div id="logout" class="btn-header transparent pull-right">
					<span> <a href="logout" title="Sign Out" data-action="userLogout" data-logout-msg="You can improve your security further after logging out by closing this opened browser"><i class="fa fa-sign-out"></i></a> </span>
				</div>
				<div id="fullscreen" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen"><i class="fa fa-arrows-alt"></i></a> </span>
				</div>
				<div id="" class="btn-header transparent pull-right">
				<span> <!-- User image size is adjusted inside CSS, it should stay as it --> 
					
					<a>
						<img src="${root}/resources/img/avatars/sunny.png" alt="me" class="online" style="height: 32px"> 
						<span>
							${ sessionScope.user.name}
						</span>
						<i class="fa fa-angle-down"></i>
					</a> 
					
				</span>
			</div>
				
			</div>

		</header>
		<!-- END HEADER -->
		<aside id="left-panel">

			<!-- User info -->
			<div class="login-info" style="display: none;">
				<span > <!-- User image size is adjusted inside CSS, it should stay as it --> 
					
					<a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
						<img src="${root}/resources/img/avatars/sunny.png" alt="me" class="online" /> 
						<span>
							廖梓帆 
						</span>
						<i class="fa fa-angle-down"></i>
					</a> 
					
				</span>
			</div>
			<!-- end user info -->

			<!-- NAVIGATION : This navigation is also responsive-->
			<nav>
				<ul>
					<li>
						<a href="javascript:void(0);" onclick="testList('action/initList')"><i class="fa fa-lg fa-fw fa-home"></i> <span class="menu-item-parent">控制面板</span></a>
							
					</li>
					
					<li>
						<a><i class="fa fa-lg fa-fw fa-database"></i> <span class="menu-item-parent">数据管理</span></a>
						<ul>
							<li>
								<a href="javascript:void(0);" onclick="testList('dataManage/list')">库表管理</a>
							</li>
							
							<li>
								<a href="javascript:void(0);" onclick="testList('stage/toHistoryInfo')">导入轨迹</a>
							</li>
							
						</ul>
					</li>
					<li  class="top-menu-invisible">
						<a><i class="fa fa-lg fa-fw fa-picture-o"></i> <span class="menu-item-parent">非结构化数据</span></a>
						<ul>
							
							<li><a href="javascript:void(0);" onclick="testList('uploadBatRecord/index')">批量上传记录</a></li>
							<li><a href="javascript:void(0);" onclick="testList('annotation/index')">已识别非结构化数据</a></li>
							<li><a href="javascript:void(0);" onclick="testList('healthImg/index')">医学图像</a></li>
							<li><a href="javascript:void(0);" onclick="testList('inlineIdentify/index')">非结构化数据在线识别</a></li>
							
						</ul>	
					</li>
					<li  class="top-menu-invisible">
							<a href="javascript:void(0);" onclick="testList()"><i class="fa fa-lg fa-fw fa-inbox"></i> <span class="menu-item-parent">慢病模型</span></a>
						</li>
					<li  class="top-menu-invisible">
						<a><i class="fa fa-lg fa-fw fa-picture-o"></i> <span class="menu-item-parent">流程管理</span></a>
						<ul>
							
							<li><a href="javascript:void(0);" onclick="testList('mrTask/addPage')">流程注册</a></li>
							<li><a href="javascript:void(0);" onclick="testList('mrTask/index')">流程管理</a></li>
						</ul>	
					</li>
					<li  class="top-menu-invisible">
						<a><i class="fa fa-lg fa-fw fa-inbox"></i> <span class="menu-item-parent">运行监控</span></a>
						<ul>
							<li><a href="javascript:void(0);" onclick="testList('mrTask/taskMonitor')">任务监控</a></li>
							<li><a href="javascript:void(0);" onclick="testList('dataMonitor/getData')">资源监控</a></li>
							<li><a href="javascript:void(0);" onclick="testList('annotation/index')">搜索监控</a></li>
						</ul>	
					</li>
					<li  class="top-menu-invisible">
						<a><i class="fa fa-lg fa-fw fa-th-list"></i> <span class="menu-item-parent">数据字典</span></a>
						<ul>
							<li><a href="javascript:void(0);" onclick="testList('uploadBatRecord/index')">计数指标</a></li>
						</ul>	
					</li>
					<li  class="top-menu-invisible">
						<a><i class="fa fa-lg fa-fw fa-cog"></i> <span class="menu-item-parent">系统管理</span></a>
						<ul>
							<li><a href="javascript:void(0);" onclick="testList('log/index')">日志管理</a></li>
							<li><a href="javascript:void(0);" onclick="testList('sysSet/index')">参数配置</a></li>
							<li><a href="javascript:void(0);" onclick="testList('user/index')">用户管理</a></li>
						</ul>	
					</li>
					
<!-- 					<li  class="top-menu-invisible"> -->
<!-- 							<a><i class="fa fa-lg fa-fw fa-list-alt"></i> <span class="menu-item-parent">权限管理</span></a> -->
<!-- 							<ul> -->
							
<!-- 							<li><a href="javascript:void(0);" onclick="testList('user/index')">用户管理</a></li> -->
<!-- 							<li><a href="javascript:void(0);" onclick="testList('role/index')">权限分配</a></li> -->
<!-- 							<li><a href="javascript:void(0);" onclick="testList('module/index')">菜单管理</a></li> -->
<!-- 						</ul>	 -->
<!-- 					</li> -->
<!-- 						<li  class="top-menu-invisible"> -->
<!-- 							<a href="javascript:void(0);" onclick="testList('sysSet/index')"><i class="fa fa-lg fa-fw fa-cog"></i> <span class="menu-item-parent">系统设置</span></a> -->
<!-- 						</li> -->
<!-- 						<li  class="top-menu-invisible"> -->
<!-- 							<a href="javascript:void(0);" onclick="testList('log/index')"><i class="fa fa-lg fa-fw fa-th-list"></i> <span class="menu-item-parent">日志管理</span></a> -->
<!-- 						</li> -->
						
				</ul>
			</nav>	
			<span class="minifyme" data-action="minifyMenu"> 
				<i class="fa fa-arrow-circle-left hit"></i> 
			</span>

		</aside>
		<!-- END NAVIGATION -->
	
		<!-- MAIN PANEL -->
		<div id="main" role="main">
			<div id="content_">
			
			</div>
			
		</div>
		<!-- 遮罩层 -->
		<div id="test" >
			<div style="position:absolute;top:50%;left:49%;">
				<font color="red" size="24" style="line-height: 100%;top: 50%">上传中请稍后......</font>
			</div>
		</div>
<!-- 		<div id="log_window"> -->
		
		<%@ include file="./header.jsp"%>
		<script type="text/javascript">
			function testList(index){
				$("#content_").load(index);
			}
			$(document).ready(function(){
				$("#content_").load('action/initList');
			});
		</script>
	</body>

</html>