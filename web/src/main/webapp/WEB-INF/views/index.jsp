<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

		<title> SmartAdmin </title>
		<meta name="description" content="">
		<meta name="author" content="">
			
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root }/resources/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root }/resources/css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root }/resources/css/smartadmin-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root }/resources/css/smartadmin-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root }/resources/css/smartadmin-skins.min.css">

		<!-- SmartAdmin RTL Support  -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root }/resources/css/smartadmin-rtl.min.css">


		<!-- We recommend you use "your_style.css" to override SmartAdmin
		     specific styles this will also ensure you retrain your customization with each SmartAdmin update.
		<link rel="stylesheet" type="text/css" media="screen" href="css/your_style.css"> -->

		<!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root }/resources/css/demo.min.css">

		<!-- FAVICONS -->
		<link rel="shortcut icon" href="img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="img/favicon/favicon.ico" type="image/x-icon">

		<!-- GOOGLE FONT -->
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

		<!-- Specifying a Webpage Icon for Web Clip 
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
		<link rel="apple-touch-icon" href="${root }/resources/img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="${root }/resources/img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="${root }/resources/img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="${root }/resources/img/splash/touch-icon-ipad-retina.png">
		
		<!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="${root }/resources/img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="${root }/resources/img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="${root }/resources/img/splash/iphone.png" media="screen and (max-device-width: 320px)">

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
	<script type="text/javascript">
		function perSubmit(tableType){
			if('orgTableType'==tableType){
				$("#content").load("importTables/query.do?table_type=false");
			}
			
		}
	</script>
	<body class="desktop-detected pace-done smart-style-2">

		<!-- HEADER -->
		<header id="header">
			<div id="logo-group">
				
				<!-- PLACE YOUR LOGO HERE -->
				<span id="titlogo">人保健康险数据系统</span>
				<!-- END LOGO PLACEHOLDER -->

				<!-- Note: The activity badge color changes when clicked and resets the number to 0
				Suggestion: You may want to set a flag when this happens to tick off all checked messages / notifications -->
				
			</div>
			<div class="project-context ">
			<span id="activity" class="activity-dropdown"> <i class="fa fa-user isize"></i> <b class="badge"> 21 </b> </span>

				<!-- AJAX-DROPDOWN : control this dropdown height, look and feel from the LESS variable file -->
				<div class="ajax-dropdown">

					<!-- the ID links are fetched via AJAX to the ajax container "ajax-notifications" -->
					<div class="btn-group btn-group-justified" data-toggle="buttons">
						<label class="btn btn-default">
							<input type="radio" name="activity" id="ajax/notify/mail.html">
							Msgs (14) </label>
						<label class="btn btn-default">
							<input type="radio" name="activity" id="ajax/notify/notifications.html">
							notify (3) </label>
						<label class="btn btn-default">
							<input type="radio" name="activity" id="ajax/notify/tasks.html">
							Tasks (4) </label>
					</div>

					<!-- notification content -->
					<div class="ajax-notifications custom-scroll">

						<div class="alert alert-transparent">
							<h4>Click a button to show messages here</h4>
							This blank page message helps protect your privacy, or you can show the first message here automatically.
						</div>

						<i class="fa fa-lock fa-4x fa-border"></i>

					</div>
					<!-- end notification content -->

					<!-- footer: refresh area -->
					<span> Last updated on: 12/12/2013 9:43AM
						<button type="button" data-loading-text="<i class='fa fa-refresh fa-spin'></i> Loading..." class="btn btn-xs btn-default pull-right">
							<i class="fa fa-refresh"></i>
						</button> 
					</span>
					<!-- end footer -->

				</div>
				<!-- END AJAX-DROPDOWN -->
			 </div>

			<!-- pulled right: nav area -->
			<div class="pull-right">
				
				<!-- collapse menu button -->
				<div id="hide-menu" class="btn-header pull-right">
					<span> <a href="javascript:void(0);" data-action="toggleMenu" title="Collapse Menu"><i class="fa fa-reorder"></i></a> </span>
				</div>
				<!-- end collapse menu -->
				
				<!-- #MOBILE -->
				<!-- Top menu profile link : this shows only when top menu is active -->
				<ul id="mobile-profile-img" class="header-dropdown-list hidden-xs padding-5">
					<li class="">
						<a href="#" class="dropdown-toggle no-margin userdropdown" data-toggle="dropdown"> 
							<img src="img/avatars/sunny.png" alt="John Doe" class="online" />  
						</a>
						<ul class="dropdown-menu pull-right">
							<li>
								<a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0"><i class="fa fa-cog"></i> Setting</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="profile.html" class="padding-10 padding-top-0 padding-bottom-0"> <i class="fa fa-user"></i> <u>P</u>rofile</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" data-action="toggleShortcut"><i class="fa fa-arrow-down"></i> <u>S</u>hortcut</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" data-action="launchFullscreen"><i class="fa fa-arrows-alt"></i> Full <u>S</u>creen</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="login.html" class="padding-10 padding-top-5 padding-bottom-5" data-action="userLogout"><i class="fa fa-sign-out fa-lg"></i> <strong><u>L</u>ogout</strong></a>
							</li>
						</ul>
					</li>
				</ul>

				<!-- logout button -->
				<div id="logout" class="btn-header transparent pull-right">
					<span> <a href="login.html" title="Sign Out" data-action="userLogout" data-logout-msg="You can improve your security further after logging out by closing this opened browser"><i class="fa fa-sign-out"></i></a> </span>
				</div>
				<!-- end logout button -->

				<!-- search mobile button (this is hidden till mobile view port) -->
				<div id="search-mobile" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0)" title="Search"><i class="fa fa-search"></i></a> </span>
				</div>
				<!-- end search mobile button -->

				<!-- input: search field -->
				<form action="search.html" class="header-search pull-right">
					<input id="search-fld"  type="text" name="param" placeholder="Find reports and more" data-autocomplete='[
					"ActionScript",
					"AppleScript",
					"Asp",
					"BASIC",
					"C",
					"C++",
					"Clojure",
					"COBOL",
					"ColdFusion",
					"Erlang",
					"Fortran",
					"Groovy",
					"Haskell",
					"Java",
					"JavaScript",
					"Lisp",
					"Perl",
					"PHP",
					"Python",
					"Ruby",
					"Scala",
					"Scheme"]'>
					<button type="submit">
						<i class="fa fa-search"></i>
					</button>
					<a href="javascript:void(0);" id="cancel-search-js" title="Cancel Search"><i class="fa fa-times"></i></a>
				</form>
				<!-- end input: search field -->

				<!-- fullscreen button -->
				<div id="fullscreen" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen"><i class="fa fa-arrows-alt"></i></a> </span>
				</div>
				<!-- end fullscreen button -->
			</div>
			<!-- end pulled right: nav area -->

		</header>
		<!-- END HEADER -->

		<!-- Left panel : Navigation area -->
		<!-- Note: This width of the aside area can be adjusted through LESS variables -->
		<aside id="left-panel">

			<!-- User info -->
			<div class="login-info">
				<span> <!-- User image size is adjusted inside CSS, it should stay as it --> 
					
					<a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
						<img src="img/avatars/sunny.png" alt="me" class="online" /> 
						<span>
							廖梓帆 
						</span>
						<i class="fa fa-angle-down"></i>
					</a> 
					
				</span>
			</div>
			<!-- end user info -->

			<!-- NAVIGATION : This navigation is also responsive-->
			<form action="" id="ifrom">
				<nav>
					<ul>
						<li class="active open">
							<a><i class="fa fa-lg fa-fw fa-database"></i> <span class="menu-item-parent">数据管理</span></a>
							<ul style="display: block;">
								<li>
								<li><a href="#" onclick="perSubmit('orgTableType')">导入表</a></li>
								<li><a href="logic_tables.html">派生表</a></li>
								<li><a href=" import_tables_error.html">导入表预警</a></li>
								<li><a href="logic_tables_error.html">派生表预警</a></li>
							</ul>	
						</li>
						<li  class="top-menu-invisible">
							<a><i class="fa fa-lg fa-fw fa-desktop"></i> <span class="menu-item-parent">任务管理</span></a>
							<ul>
								<li><a href="task_list.html">任务列表</a></li>
								<li><a href="task_wait.html">待运行任务列表</a></li>
								<li><a href="task_error.html">任务运行预警</a></li>
							</ul>	
						</li>
					</ul>
				</nav>	
			</form>
			<span class="minifyme" data-action="minifyMenu"> 
				<i class="fa fa-arrow-circle-left hit"></i> 
			</span>

		</aside>
		<!-- END NAVIGATION -->

		<!-- MAIN PANEL -->
		<div id="main" role="main">

			<!-- RIBBON -->
			<div id="ribbon">

				<span class="ribbon-button-alignment"> 
					<span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh"  rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true">
						<i class="fa fa-refresh"></i>
					</span> 
				</span>

				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>首页</li><li>数据管理</li><li>导入表</li>
				</ol>
				

			</div>
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content">
				
				<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable no-padding">
				
							<!-- Widget ID (each widget will need unique ID)-->
							<div class="jarviswidget jarviswidget-sortable" id="wid-id-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="border-top:1px solid #CCC!important;" >
							
								<!-- widget div-->
								<div role="content" style=" padding: 0; ">
				
									
				
									<!-- widget content -->
									<div class="widget-body no-padding">
				
										<form class="smart-form">
											<header>
												查询
											</header>
				
											<fieldset class="padding-top-0">
												　
												<div class="row">
													<section class="col col-1 text-right"><label class="text">源表</label></section>
													<section class="col col-3">
														<label class="input">
														<input type="text" list="list">
														<datalist id="list">
															<option value="Alexandra">库名一</option>
															<option value="Alice">库名二</option>
															<option value="Anastasia">库名三</option>
															
														</datalist> </label>
													</section>
													
													<section class="col col-1 text-right"><label class="text">源库</label></section>
													<section class="col col-3">
														<label class="input">
														<input type="text" list="list">
														<datalist id="list">
															<option value="Alexandra">库名一</option>
															<option value="Alice">库名二</option>
															<option value="Anastasia">库名三</option>
															
														</datalist> </label>
													</section>
													<section class="col col-1 text-right"><label class="text">源库类型</label></section>
													<section class="col col-3">
														<label class="select">
														<select>
															<option value="0">Oracle</option>
															<option value="1">DB2</option>
															<option value="2">Sybase</option>
															<option value="3">SQL</option>
															<option value="4">Server</option>
															<option value="5">Informax</option>
															<option value="6">MySQL</option>
														</select> <i></i> </label>
													</section>
											</div>
											<div class="row">
													<section class="col col-1 text-right"><label class="text">表名</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="表名"></label></section>
													<section class="col col-1 text-right"><label class="text">库名</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="表名"></label></section>
													<section class="col col-1 text-right"><label class="text">创建时间</label></section>
													<section class="col col-3">
														<section class="col col-5" style="padding: 0; margin: 0;">
															<label class="input"><input type="text" placeholder=""></label>
														</section>
														<section class="col col-1" style="padding: 0; margin: 0;">
														<label>－</label>
														</section>
														<section class="col col-6" style="padding: 0; margin: 0;">
															<label class="input"><input type="text" placeholder=""></label>
														</section>
													</section>
												</div>
												
												
											</fieldset>
				
										
				
											<footer>
												
												<button type="button" class="btn btn-default" onclick="window.history.back();">
													重置
												</button>
												<button type="submit" class="btn btn-primary">
													查询
												</button>
											</footer>
										</form>
				
									</div>
									<!-- end widget content -->
				
								</div>
								<!-- end widget div -->
				
							</div>
							<!-- end widget -->
				
						</article>

							<!-- widget grid -->
				<section id="widget-grid" class="">

					<!-- row -->
					<div class="row">
						<article class="col-sm-12">
							<!-- new widget -->
							<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
								
								<button id="add_tab"  class="btn btn-primary btn-lg">创建表</button><br><br>
				   				 <div id="addtab" title="<div class='widget-header'><h4><i class='fa fa-plus'></i> 新建表</h4></div>">
										<form class="smart-form">
										
				
											<fieldset>
												<div class="row">
													<section class="col col-1 text-right"><label class="text">源库</label></section>
													<section class="col col-5">
														<label class="input">
														<input type="text" list="list">
														<datalist id="list">
															<option value="Alexandra">库名一</option>
															<option value="Alice">库名二</option>
															<option value="Anastasia">库名三</option>
															
														</datalist> </label>
													</section>
													
													<section class="col col-1 text-right"><label class="text">库名</label></section>
													<section class="col col-5"><label class="input"><input type="text" placeholder="表名"></label></section>
													<section class="col col-1 text-right"><label class="text">源表</label></section>
													<section class="col col-5">
														<label class="input">
														<input type="text" list="list">
														<datalist id="list">
															<option value="Alexandra">库名一</option>
															<option value="Alice">库名二</option>
															<option value="Anastasia">库名三</option>
															
														</datalist> </label>
													</section>
													<section class="col col-1 text-right"><label class="text">表名</label></section>
													<section class="col col-5"><label class="input"><input type="text" placeholder="表名"></label></section>
													<section class="col col-1 text-right"><label class="text">源库类型</label></section>
													<section class="col col-5">
														<label class="select">
														<select>
															<option value="0">Oracle</option>
															<option value="1">DB2</option>
															<option value="2">Sybase</option>
															<option value="3">SQL</option>
															<option value="4">Server</option>
															<option value="5">Informax</option>
															<option value="6">MySQL</option>
														</select> <i></i> </label>
													</section>
													<section class="col col-1 text-right"><label class="text">是否激活</label></section>
													<section class="col col-5">
														
														<div class="inline-group">
															<label class="radio">
																<input type="radio" name="radio-inline" checked="checked">
																<i></i>激活</label>
															<label class="radio">
																<input type="radio" name="radio-inline">
																<i></i>不激活</label>
														</div>
													</section>
												</div>
												<div class="row">
													<section class="col col-1 text-right"><label class="text">源库版本</label></section>
													<section class="col col-5"><label class="input"><input type="text" placeholder="表名"></label></section>
													<section class="col col-1 text-right"><label class="text">描述</label></section>
													<section class="col col-5">
														
														<label class="textarea textarea-resizable"> 										
															<textarea rows="3" class="custom-scroll"></textarea> 
														</label>
														
													 </section>
													
												</div>
											</fieldset>
											<footer>
												<button type="button" class="btn btn-default" onclick="window.history.back();">
													重置
												</button>
												<button type="submit" class="btn btn-primary">
													新建
												</button>
												
											</footer>
										</form>
								</div>
								
								<div class="widget-body no-padding bordertop">
									<!-- content -->
									
									<div id="dt_basic_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
									<table id="dt_basic" class="table table-striped table-bordered table-hover dataTable no-footer" width="100%" role="grid" aria-describedby="dt_basic_info" style="width: 100%;">
											<thead>			                
												<tr role="row">
													<th data-hide="phone" class="sorting_asc" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-sort="ascending" aria-label="ID: activate to sort column descending">序号</th>
													<th data-class="expand" class="expand sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Name: activate to sort column ascending">数据库名称</th>
													<th data-class="expand" class="expand sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Name: activate to sort column ascending">表名称</th>
													<th data-hide="phone" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Phone: activate to sort column ascending">源库类型</th>
													<th class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="Company: activate to sort column ascending">源库名称</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">源表名称</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Date: activate to sort column ascending">创建时间</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">更新时间</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">创建人</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">状态</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">文件大小</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">总记录数</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">操作</th>
												</tr>
											</thead>
											<tbody>
												
											<tr role="row" class="odd" aria-selected="false">
													<td class="sorting_1">1</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>copymain</td>
													<td>informix</td>
													<td>car3g</td>
													<td>prpcopymain</td>
													<td>2017-03-01 10:00:00</td>
													<td>2017-03-01 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>200MB</td>
													<td>2999776</td>
													<td>
													 <div class="btn-group" style="width: 100px;">
															<a class="btn btn-default" href="javascript:void(0);">操作</a>
															<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>
															<ul class="dropdown-menu">
																<li><a href="javascript:void(0);">查看表</a></li>
																<li>
																	<a href="javascript:void(0);">查看表定义</a>
																</li>
																<li>
																	<a href="javascript:void(0);">编辑</a>
																</li>
																<li>
																	<a href="javascript:void(0);">删除表</a>
																</li>
															
																<li>
																	<a href="javascript:void(0);">删除外部文件</a>
																</li>
															</ul>
														</div>
													<button type="submit"  class="btn btn-primary btn-lg" onclick="window.open ('数据管理查看表.html','newwindow','height=500,width=900,top=100,left=200,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') " style="margin-bottom: 20px;">查看表</button>
													<button type="submit"  class="btn btn-primary btn-lg" onclick="window.open ('数据管理查看表定义.html','newwindow') " style="margin-bottom: 20px;">查看表定义</button>
								
													</td>
												</tr>
												<tr role="row" class="even">
													<td class="sorting_1">2</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>third_car</td>
													<td>infromix</td>
													<td>lp3g</td>
													<td>prplthird_car</td>
													<td>2017-03-05 10:00:00</td>
													<td>2017-03-05 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>500MB</td>
													<td>5999776</td>
													<td>
													 
													</td>
												</tr>
											<tr role="row" class="odd" aria-selected="false">
													<td class="sorting_1">3</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>copyitemkind</td>
													<td>informix</td>
													<td>car3g</td>
													<td>prpcopyitemkind</td>
													<td>2017-03-01 10:00:00</td>
													<td>2017-03-01 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>2000MB</td>
													<td>30999776</td>
													<td>
													  
													</td>
												</tr>
												<tr role="row" class="even">
													<td class="sorting_1">4</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>copyitem_car</td>
													<td>infromix</td>
													<td>car3g</td>
													<td>prpcopyitem_car</td>
													<td>2017-03-05 10:00:00</td>
													<td>2017-03-05 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>500MB</td>
													<td>5999776</td>
													<td>
													 
													</td>
												</tr>
											<tr role="row" class="odd" aria-selected="false">
													<td class="sorting_1">5</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>copyinsured</td>
													<td>informix</td>
													<td>car3g</td>
													<td>prpcopyinsured</td>
													<td>2017-03-01 10:00:00</td>
													<td>2017-03-01 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>50MB</td>
													<td>9770</td>
													<td>
													 
													</td>
												</tr>
												<tr role="row" class="even">
													<td class="sorting_1">6</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>copyitem_car</td>
													<td>infromix</td>
													<td>car3g</td>
													<td>prpcopyitem_car</td>
													<td>2017-03-05 10:00:00</td>
													<td>2017-03-05 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>500MB</td>
													<td>5999776</td>
													<td>
													 
													</td>
												</tr>
											<tr role="row" class="odd" aria-selected="false">
													<td class="sorting_1">7</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>copycoins</td>
													<td>informix</td>
													<td>car3g</td>
													<td>prpcopycoins</td>
													<td>2017-03-01 10:00:00</td>
													<td>2017-03-01 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>200MB</td>
													<td>2999776</td>
													<td>
													  
													</td>
												</tr>
												<tr role="row" class="even">
													<td class="sorting_1">8</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>dcompany</td>
													<td>infromix</td>
													<td>car3g</td>
													<td>prpdcompany</td>
													<td>2017-03-05 10:00:00</td>
													<td>2017-03-05 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>50MB</td>
													<td>99776</td>
													<td>
													  
													</td>
												</tr>
											<tr role="row" class="odd" aria-selected="false">
													<td class="sorting_1">9</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>deflossmain</td>
													<td>informix</td>
													<td>car3g</td>
													<td>prpdeflossmain</td>
													<td>2017-03-01 10:00:00</td>
													<td>2017-03-01 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>2000MB</td>
													<td>29997760</td>
													<td>
													 
													</td>
												</tr>
												<tr role="row" class="even">
													<td class="sorting_1">10</td>
													<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
													<td>compensate</td>
													<td>infromix</td>
													<td>car3g</td>
													<td>prplcompensate</td>
													<td>2017-03-05 10:00:00</td>
													<td>2017-03-05 10:00:00</td>
													<td>张三</td>
													<td>激活</td>
													<td>500MB</td>
													<td>5999776</td>
													<td>
													  
													</td>
												</tr>


									</table>
										
										<div class="dt-toolbar-footer">
											<div class="col-sm-6 col-xs-12 hidden-xs">
												<div class="dataTables_info" id="dt_basic_info" role="status" aria-live="polite">Showing 1 to 10 of 100 entries</div>
											</div>
											<div class="col-xs-12 col-sm-6">
												<div class="dataTables_paginate paging_simple_numbers" id="dt_basic_paginate">
													<ul class="pagination">
														<li class="paginate_button previous disabled" id="dt_basic_previous"><a href="#" aria-controls="dt_basic" data-dt-idx="0" tabindex="0">Previous</a></li>
														<li class="paginate_button active"><a href="#" aria-controls="dt_basic" data-dt-idx="1" tabindex="0">1</a></li>
														<li class="paginate_button "><a href="#" aria-controls="dt_basic" data-dt-idx="2" tabindex="0">2</a></li>
														<li class="paginate_button "><a href="#" aria-controls="dt_basic" data-dt-idx="3" tabindex="0">3</a></li>
														<li class="paginate_button "><a href="#" aria-controls="dt_basic" data-dt-idx="4" tabindex="0">4</a></li>
														<li class="paginate_button "><a href="#" aria-controls="dt_basic" data-dt-idx="5" tabindex="0">5</a></li>
														<li class="paginate_button disabled" id="dt_basic_ellipsis"><a href="#" aria-controls="dt_basic" data-dt-idx="6" tabindex="0">…</a></li>
														<li class="paginate_button "><a href="#" aria-controls="dt_basic" data-dt-idx="7" tabindex="0">10</a></li>
														<li class="paginate_button next" id="dt_basic_next"><a href="#" aria-controls="dt_basic" data-dt-idx="8" tabindex="0">Next</a></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									
									
									<!-- end content -->
								</div>

						
								<!-- end widget div -->
							</div>
							<!-- end widget -->

						</article>
					</div>

					<!-- end row -->

					

				</section>
				<!-- end widget grid -->

			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<!-- END MAIN PANEL -->

		<!-- PAGE FOOTER -->
		<div class="page-footer">
			<div class="row">
				<div class="col-xs-12 col-sm-6">
					<span class="txt-color-white">SmartAdmin 1.8.2 <span class="hidden-xs"> - Web Application Framework</span> © 2014-2015</span>
				</div>

				<div class="col-xs-6 col-sm-6 text-right hidden-xs">
					<div class="txt-color-white inline-block">
						<i class="txt-color-blueLight hidden-mobile">Last account activity <i class="fa fa-clock-o"></i> <strong>52 mins ago &nbsp;</strong> </i>
						<div class="btn-group dropup">
							<button class="btn btn-xs dropdown-toggle bg-color-blue txt-color-white" data-toggle="dropdown">
								<i class="fa fa-link"></i> <span class="caret"></span>
							</button>
							<ul class="dropdown-menu pull-right text-left">
								<li>
									<div class="padding-5">
										<p class="txt-color-darken font-sm no-margin">Download Progress</p>
										<div class="progress progress-micro no-margin">
											<div class="progress-bar progress-bar-success" style="width: 50%;"></div>
										</div>
									</div>
								</li>
								<li class="divider"></li>
								<li>
									<div class="padding-5">
										<p class="txt-color-darken font-sm no-margin">Server Load</p>
										<div class="progress progress-micro no-margin">
											<div class="progress-bar progress-bar-success" style="width: 20%;"></div>
										</div>
									</div>
								</li>
								<li class="divider"></li>
								<li>
									<div class="padding-5">
										<p class="txt-color-darken font-sm no-margin">Memory Load <span class="text-danger">*critical*</span></p>
										<div class="progress progress-micro no-margin">
											<div class="progress-bar progress-bar-danger" style="width: 70%;"></div>
										</div>
									</div>
								</li>
								<li class="divider"></li>
								<li>
									<div class="padding-5">
										<button class="btn btn-block btn-default">refresh</button>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- END PAGE FOOTER -->

		<!-- SHORTCUT AREA : With large tiles (activated via clicking user name tag)
		Note: These tiles are completely responsive,
		you can add as many as you like
		-->
		<div id="shortcut">
			<ul>
				<li>
					<a href="inbox.html" class="jarvismetro-tile big-cubes bg-color-blue"> <span class="iconbox"> <i class="fa fa-envelope fa-4x"></i> <span>Mail <span class="label pull-right bg-color-darken">14</span></span> </span> </a>
				</li>
				<li>
					<a href="calendar.html" class="jarvismetro-tile big-cubes bg-color-orangeDark"> <span class="iconbox"> <i class="fa fa-calendar fa-4x"></i> <span>Calendar</span> </span> </a>
				</li>
				<li>
					<a href="gmap-xml.html" class="jarvismetro-tile big-cubes bg-color-purple"> <span class="iconbox"> <i class="fa fa-map-marker fa-4x"></i> <span>Maps</span> </span> </a>
				</li>
				<li>
					<a href="invoice.html" class="jarvismetro-tile big-cubes bg-color-blueDark"> <span class="iconbox"> <i class="fa fa-book fa-4x"></i> <span>Invoice <span class="label pull-right bg-color-darken">99</span></span> </span> </a>
				</li>
				<li>
					<a href="gallery.html" class="jarvismetro-tile big-cubes bg-color-greenLight"> <span class="iconbox"> <i class="fa fa-picture-o fa-4x"></i> <span>Gallery </span> </span> </a>
				</li>
				<li>
					<a href="profile.html" class="jarvismetro-tile big-cubes selected bg-color-pinkDark"> <span class="iconbox"> <i class="fa fa-user fa-4x"></i> <span>My Profile </span> </span> </a>
				</li>
			</ul>
		</div>
		<!-- END SHORTCUT AREA -->

		<!--================================================== -->

		<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)-->
		<script data-pace-options='{ "restartOnRequestAfter": true }' src="js/plugin/pace/pace.min.js"></script>

		<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
		<script>
			if (!window.jQuery) {
				document.write('<script src="js/libs/jquery-2.1.1.min.js"><\/script>');
			}
		</script>

		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
		<script>
			if (!window.jQuery.ui) {
				document.write('<script src="js/libs/jquery-ui-1.10.3.min.js"><\/script>');
			}
		</script>

		<!-- IMPORTANT: APP CONFIG -->
		<script src="js/app.config.js"></script>

		<!-- JS TOUCH : include this plugin for mobile drag / drop touch events--
		<script src="js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script> 

		<!-- BOOTSTRAP JS -->
		<script src="js/bootstrap/bootstrap.min.js"></script>

		<!-- CUSTOM NOTIFICATION --
		<script src="js/notification/SmartNotification.min.js"></script>

		<!-- JARVIS WIDGETS -->
		<script src="js/smartwidgets/jarvis.widget.min.js"></script>

		<!-- EASY PIE CHARTS --
		<script src="js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>

		<!-- SPARKLINES --
		<script src="js/plugin/sparkline/jquery.sparkline.min.js"></script>

		<!-- JQUERY VALIDATE --
		<script src="js/plugin/jquery-validate/jquery.validate.min.js"></script>

		<!-- JQUERY MASKED INPUT --
		<script src="js/plugin/masked-input/jquery.maskedinput.min.js"></script>

		<!-- JQUERY SELECT2 INPUT --
		<script src="js/plugin/select2/select2.min.js"></script>

		<!-- JQUERY UI + Bootstrap Slider --
		<script src="js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>

		<!-- browser msie issue fix --
		<script src="js/plugin/msie-fix/jquery.mb.browser.min.js"></script>

		<!-- FastClick: For mobile devices --
		<script src="js/plugin/fastclick/fastclick.min.js"></script>

		<!--[if IE 8]>

		<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>

		<![endif]-->

		<!-- Demo purpose only -->
		<script src="js/demo.min.js"></script>

		<!-- MAIN APP JS FILE -->
		<script src="js/app.min.js"></script>

		<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
		<!-- Voice command : plugin --
		<script src="js/speech/voicecommand.min.js"></script>

		<!-- SmartChat UI : plugin --
		<script src="js/smart-chat-ui/smart.chat.ui.min.js"></script>
		<script src="js/smart-chat-ui/smart.chat.manager.min.js"></script>
		
		<!-- PAGE RELATED PLUGIN(S) -->
		
		<!-- Flot Chart Plugin: Flot Engine, Flot Resizer, Flot Tooltip --
		<script src="js/plugin/flot/jquery.flot.cust.min.js"></script>
		<script src="js/plugin/flot/jquery.flot.resize.min.js"></script>
		<script src="js/plugin/flot/jquery.flot.time.min.js"></script>
		<script src="js/plugin/flot/jquery.flot.tooltip.min.js"></script>
		
		<!-- Vector Maps Plugin: Vectormap engine, Vectormap language --
		<script src="js/plugin/vectormap/jquery-jvectormap-1.2.2.min.js"></script>
		<script src="js/plugin/vectormap/jquery-jvectormap-world-mill-en.js"></script>
		
		<!-- Full Calendar --
		<script src="js/plugin/moment/moment.min.js"></script>
		<script src="js/plugin/fullcalendar/jquery.fullcalendar.min.js"></script>
-->
			

		<script type="text/javascript">
		
		// DO NOT REMOVE : GLOBAL FUNCTIONS!
		
		$(document).ready(function() {
			
			pageSetUp();
			
			// menu
			$("#menu").menu();
		
			/*
			 * AUTO COMPLETE AJAX
			 */
		
			function log(message) {
				$("<div>").text(message).prependTo("#log");
				$("#log").scrollTop(0);
			}
		
			$("#city").autocomplete({
				source : function(request, response) {
					$.ajax({
						url : "http://ws.geonames.org/searchJSON",
						dataType : "jsonp",
						data : {
							featureClass : "P",
							style : "full",
							maxRows : 12,
							name_startsWith : request.term
						},
						success : function(data) {
							response($.map(data.geonames, function(item) {
								return {
									label : item.name + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
									value : item.name
								}
							}));
						}
					});
				},
				minLength : 2,
				select : function(event, ui) {
					log(ui.item ? "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
				}
			});
		
			/*
			 * Spinners
			 */
			$("#spinner").spinner();
			$("#spinner-decimal").spinner({
				step : 0.01,
				numberFormat : "n"
			});
		
			$("#spinner-currency").spinner({
				min : 5,
				max : 2500,
				step : 25,
				start : 1000,
				numberFormat : "C"
			});
		
			/*
			 * CONVERT DIALOG TITLE TO HTML
			 * REF: http://stackoverflow.com/questions/14488774/using-html-in-a-dialogs-title-in-jquery-ui-1-10
			 */
			$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
				_title : function(title) {
					if (!this.options.title) {
						title.html("&#160;");
					} else {
						title.html(this.options.title);
					}
				}
			}));
		
		
			/*
			* DIALOG SIMPLE
			*/
		
			
			
			/*
			* DIALOG HEADER ICON
			*/
		

			/*
			 * Remove focus from buttons
			 */
			$('.ui-dialog :button').blur();
		
			/*
			 * Just Tabs
			 */
		
			$('#tabs').tabs();
		
			/*
			 *  Simple tabs adding and removing
			 */
		
			$('#tabs2').tabs();
		
			// Dynamic tabs
			var tabTitle = $("#tab_title"), tabContent = $("#tab_content"), tabTemplate = "<li style='position:relative;'> <span class='air air-top-left delete-tab' style='top:7px; left:7px;'><button class='btn btn-xs font-xs btn-default hover-transparent'><i class='fa fa-times'></i></button></span></span><a href=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </a></li>", tabCounter = 2;
		
			var tabs = $("#tabs2").tabs();
		
			// modal dialog init: custom buttons and a "close" callback reseting the form inside
			var dialog = $("#addtab").dialog({
				autoOpen : false,
				width : 800,
				resizable : false,
				modal : true,
				buttons : [{
					html : "<i class='fa fa-times'></i>&nbsp; Cancel",
					"class" : "btn btn-default",
					click : function() {
						$(this).dialog("close");
		
					}
				}, {
		
					html : "<i class='fa fa-plus'></i>&nbsp; Add",
					"class" : "btn btn-danger",
					click : function() {
						addTab();
						$(this).dialog("close");
					}
				}]
			});
		
			// addTab form: calls addTab function on submit and closes the dialog
			var form = dialog.find("form").submit(function(event) {
				addTab();
				dialog.dialog("close");
				event.preventDefault();
			});
		
			// actual addTab function: adds new tab using the input from the form above
			function addTab() {
				var label = tabTitle.val() || "Tab " + tabCounter, id = "tabs-" + tabCounter, li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label)), tabContentHtml = tabContent.val() || "Tab " + tabCounter + " content.";
		
				tabs.find(".ui-tabs-nav").append(li);
				tabs.append("<div id='" + id + "'><p>" + tabContentHtml + "</p></div>");
				tabs.tabs("refresh");
				tabCounter++;
		
				// clear fields
				$("#tab_title").val("");
				$("#tab_content").val("");
			}
		
			// addTab button: just opens the dialog
			$("#add_tab").button().click(function() {
				dialog.dialog("open");
			});
		
			// close icon: removing the tab on click
			$("#tabs2").on("click", 'span.delete-tab', function() {
		
				var panelId = $(this).closest("li").remove().attr("aria-controls");
				$("#" + panelId).remove();
				tabs.tabs("refresh");
			});
		
			/*
			* ACCORDION
			*/
			//jquery accordion
			
		     var accordionIcons = {
		         header: "fa fa-plus",    // custom icon class
		         activeHeader: "fa fa-minus" // custom icon class
		     };
		     
			$("#accordion").accordion({
				autoHeight : false,
				heightStyle : "content",
				collapsible : true,
				animate : 300,
				icons: accordionIcons,
				header : "h4",
			})
		
			/*
			 * PROGRESS BAR
			 */
			$("#progressbar").progressbar({
		     	value: 25,
		     	create: function( event, ui ) {
		     		$(this).removeClass("ui-corner-all").addClass('progress').find(">:first-child").removeClass("ui-corner-left").addClass('progress-bar progress-bar-success');
				}
			});			

		})

		</script>

	</body>

</html>