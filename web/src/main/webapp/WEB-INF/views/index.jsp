<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<title> SmartAdmin </title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-skins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-rtl.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/demo.min.css">
		<link rel="shortcut icon" href="${root}/resources/img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="${root}/resources/img/favicon/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">
		<link rel="apple-touch-icon" href="${root}/resources/img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="${root}/resources/img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="${root}/resources/img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="${root}/resources/img/splash/touch-icon-ipad-retina.png">
		<link rel="apple-touch-startup-image" href="${root}/resources/img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="${root}/resources/img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="${root}/resources/img/splash/iphone.png" media="screen and (max-device-width: 320px)">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/bootstrap-datetimepicker.min.css">
	</head>

	<style type="text/css">
		#titlogo{width: 220px; height: 39px; float: left; font-size: 20px; color: #fff; line-height: 2.5; text-align: center; font-weight: bold;}
		.indoxnum>div{ background-color: #fff; }
		.isize{ font-size: 20px;}
		#project-context, .project-context{padding: 17px 13px 0;}
		#activity b.badge {top: 9px;}
		 .ajax-dropdown {left: -152px;}
		  .bordertop{border-top: 1px solid #ccc!important; }
		  td, th {display: table-cell; vertical-align: inherit;}
		  .table>thead>tr>th {vertical-align: inherit;}
		 #ico{font-size: 4em;padding-bottom: 15px;}
		.fontsize{ display: block; float: left;; line-height: 24px;font-size: 16px; padding-left: 5px;}
		 .fontsize i{ font-size: 1.8em; font-style: normal;}
		 .numcon{border-top: 1px solid #ccc!important; }
		 .numcon i{ display: block; float: left; }
		 .widget-body.no-padding { margin: 0;}
		 table.dataTable { margin: 0!important;}
		 .margin-bottom-30{ margin-bottom: 30px;}
		 select.input-sm{
		    height: 20px;
		    line-height: 20px;
		    padding: 0 5px;
		}

	</style>
	<body class="desktop-detected pace-done smart-style-2">

		<!-- HEADER -->
		<header id="header">
			<div id="logo-group">
				<span id="titlogo"><img src="${root }/resources/img/logo.png"  height="30"/></span>
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

			</div>

		</header>
		<!-- END HEADER -->
		<aside id="left-panel">

			<!-- User info -->
			<div class="login-info">
				<span> <!-- User image size is adjusted inside CSS, it should stay as it --> 
					
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
					<li class="active open">
						<a><i class="fa fa-lg fa-fw fa-database"></i> <span class="menu-item-parent">数据管理</span></a>
						<ul style="display: block;">
							<li>
								<a href="javascript:void(0);" onclick="testList('orgTableList')">导入表</a>
							</li>
							<li>
								<a href="javascript:void(0);" onclick="testList('perTableList')">派生表</a>
							</li>
							<li>
								<a href="javascript:void(0);" onclick="testList('orgWarnTable')">导入表预警</a>
							</li>
							<li>
								<a href="javascript:void(0);" onclick="testList('perWarnTable')">派生表预警</a>
							</li>
						</ul>
					</li>
					<li  class="top-menu-invisible">
						<a><i class="fa fa-lg fa-fw fa-desktop"></i> <span class="menu-item-parent">任务管理</span></a>
						<ul>
							<li><a href="javascript:void(0);" onclick="testList('mrTaskList')">任务列表</a></li>
							<li><a href="javascript:void(0);" onclick="testList('mrTaskWait')">待运行任务列表</a></li>
							<li><a href="javascript:void(0);" onclick="testList('mrTaskError')">任务运行预警</a></li>
						</ul>	
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
			<div id="content"></div>

		</div>

		<script data-pace-options='{ "restartOnRequestAfter": true }' src="${root}/resources/js/plugin/pace/pace.min.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
		<script>
			if (!window.jQuery) {
				document.write('<script src="${root}/resources/js/libs/jquery-2.1.1.min.js"><\/script>');
			}
			if (!window.jQuery.ui) {
				document.write('<script src="${root}/resources/js/libs/jquery-ui-1.10.3.min.js"><\/script>');
			}
		</script>

		<!-- IMPORTANT: APP CONFIG -->
		<script src="${root}/resources/js/app.config.js"></script>
		<script src="${root}/resources/js/bootstrap/bootstrap.min.js"></script>
		<!-- JARVIS WIDGETS -->
		<script src="${root}/resources/js/smartwidgets/jarvis.widget.min.js"></script>
		<!-- Demo purpose only -->
		<script src="${root}/resources/js/demo.min.js"></script>
		<!-- MAIN APP JS FILE -->
		<script src="${root}/resources/js/app.min.js"></script>
		<script src="${root }/resources/js/except.js"></script>	
		<script src="${root}/resources/layer/layer.js"></script>
		<script src="${root }/resources/js/moment.js" type="text/javascript"></script>
		<script src="${root }/resources/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
		<script src="${root }/resources/js/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
		<script src="${root }/resources/js/bootstrap-table/bootstrap-table-zh-CN.js" type="text/javascript"></script>
		<script type="text/javascript">
			function testList(index){
				$("#content").load(index+".do");
			}
			$(document).ready(function(){
				$("#content").load('orgTableList.do');
			});
		</script>
	</body>

</html>