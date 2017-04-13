<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
					<span> <a href="logout.do" title="Sign Out" data-action="userLogout" data-logout-msg="You can improve your security further after logging out by closing this opened browser"><i class="fa fa-sign-out"></i></a> </span>
				</div>
				<div id="fullscreen" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen"><i class="fa fa-arrows-alt"></i></a> </span>
				</div>
				<div id="" class="btn-header transparent pull-right">
				<span> <!-- User image size is adjusted inside CSS, it should stay as it --> 
					
					<a>
						<img src="${root}/resources/img/avatars/sunny.png" alt="me" class="online" style="height: 32px"> 
						<span>
							admin
						</span>
						<!--<i class="fa fa-angle-down"></i>-->
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
						<a href="javascript:void(0);" onclick="testList('initList')"><i class="fa fa-lg fa-fw fa-home"></i> <span class="menu-item-parent">总览</span></a>
							
					</li>
					
					<li>
						<a><i class="fa fa-lg fa-fw fa-database"></i> <span class="menu-item-parent">结构化数据管理</span></a>
						<ul>
							<li>
								<a href="javascript:void(0);" onclick="testList('orgTableList')">导入表</a>
							</li>
							
							<li>
								<a href="javascript:void(0);" onclick="testList('orgWarnTable')">导入表预警</a>
							</li>
							
						</ul>
					</li>
					<li  class="top-menu-invisible">
						<a><i class="fa fa-lg fa-fw fa-picture-o"></i> <span class="menu-item-parent">非结构化数据</span></a>
						<ul>
							
							<li><a href="javascript:void(0);" onclick="testList('uploadRcord')">批量上传记录</a></li>
							<li><a href="javascript:void(0);" onclick="testList('annotationList')">已识别非结构化数据</a></li>
							<li><a href="javascript:void(0);" onclick="testList('healthImg')">医学图像</a></li>
							<li><a href="javascript:void(0);" onclick="testList('inlineIdentify')">非结构化数据在线识别</a></li>
							
						</ul>	
					</li>
					<li  class="top-menu-invisible">
						<a href="javascript:void(0);" onclick="testList('sysSet')"><i class="fa fa-lg fa-fw fa-cog"></i> <span class="menu-item-parent">系统设置</span></a>
					</li>
					<li  class="top-menu-invisible">
						<a href="javascript:void(0);" onclick="testList('logList')"><i class="fa fa-lg fa-fw fa-list-alt"></i> <span class="menu-item-parent">日志管理</span></a>
					</li>
					<li  class="top-menu-invisible">
						<a href="javascript:void(0);" onclick="testList('userList')"><i class="fa fa-lg fa-fw fa-cog"></i> <span class="menu-item-parent">用户管理</span></a>
					</li>
					<li  class="top-menu-invisible">
						<a href="javascript:void(0);" onclick=""><i class="fa fa-lg fa-fw fa-list-alt"></i> <span class="menu-item-parent">慢病模型</span></a>
					</li>
					
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


		<%@ include file="./header.jsp"%>
		<script type="text/javascript">
			function testList(index){
				$("#content_").load(index+".do");
			}
			$(document).ready(function(){
				$("#content_").load('initList.do');
			});
		</script>
	</body>

</html>