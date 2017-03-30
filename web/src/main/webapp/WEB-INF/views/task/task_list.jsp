<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-us">
<head>
<meta charset="utf-8">
<!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

<title>任务列表</title>
<meta name="description" content="">
<meta name="author" content="">

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

<!-- Basic Styles -->
<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/font-awesome.min.css">

<!-- SmartAdmin Styles : Caution! DO NOT change the order -->
<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-production-plugins.min.css">
<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-production.min.css">
<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-skins.min.css">

<!-- SmartAdmin RTL Support  -->
<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-rtl.min.css">


<!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/demo.min.css">

<!-- FAVICONS -->
<link rel="shortcut icon" href="${root}/resources/img/favicon/favicon.ico" type="image/x-icon">
<link rel="icon" href="${root}/resources/img/favicon/favicon.ico" type="image/x-icon">

<!-- GOOGLE FONT -->
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

<!-- Specifying a Webpage Icon for Web Clip 
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
<link rel="apple-touch-icon" href="${root}/resources/img/splash/sptouch-icon-iphone.png">
<link rel="apple-touch-icon" sizes="76x76" href="${root}/resources/img/splash/touch-icon-ipad.png">
<link rel="apple-touch-icon" sizes="120x120" href="${root}/resources/img/splash/touch-icon-iphone-retina.png">
<link rel="apple-touch-icon" sizes="152x152" href="${root}/resources/img/splash/touch-icon-ipad-retina.png">

<!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<!-- Startup image for web apps -->
<link rel="apple-touch-startup-image" href="${root}/resources/img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
<link rel="apple-touch-startup-image" href="${root}/resources/img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
<link rel="apple-touch-startup-image" href="${root}/resources/img/splash/iphone.png" media="screen and (max-device-width: 320px)">

</head>

<style type="text/css">
#titlogo {
	width: 220px;
	height: 39px;
	float: left;
	font-size: 20px;
	color: #fff;
	line-height: 2.5;
	text-align: center;
	font-weight: bold;
}

.indoxnum>div {
	background-color: #fff;
}

.isize {
	font-size: 20px;
}

#project-context, .project-context {
	padding: 17px 13px 0;
}

#activity b.badge {
	top: 9px;
}

.ajax-dropdown {
	left: -152px;
}

.bordertop {
	border-top: 1px solid #ccc !important;
}

td, th {
	display: table-cell;
	vertical-align: inherit;
}

.table>thead>tr>th {
	vertical-align: inherit;
}

#ico {
	font-size: 4em;
	padding-bottom: 15px;
}

.fontsize {
	display: block;
	float: left;;
	line-height: 24px;
	font-size: 16px;
	padding-left: 5px;
}

.fontsize i {
	font-size: 1.8em;
	font-style: normal;
}

.numcon {
	border-top: 1px solid #ccc !important;
}

.numcon i {
	display: block;
	float: left;
}

.widget-body.no-padding {
	margin: 0;
}

table.dataTable {
	margin: 0 !important;
}

.margin-bottom-30 {
	margin-bottom: 30px;
}

select.input-sm {
	height: 20px;
	line-height: 20px;
	padding: 0 5px;
}
</style>
<body class="desktop-detected pace-done smart-style-2">

	<!-- HEADER -->
	<header id="header">
		<div id="logo-group">

			<!-- PLACE YOUR LOGO HERE -->
			<span id="titlogo">中坤天行数据平台</span>
			<!-- END LOGO PLACEHOLDER -->

			<!-- Note: The activity badge color changes when clicked and resets the number to 0
				Suggestion: You may want to set a flag when this happens to tick off all checked messages / notifications -->

		</div>

		<div class="pull-right">

			<div id="hide-menu" class="btn-header pull-right">
				<span>
					<a href="javascript:void(0);" data-action="toggleMenu" title="Collapse Menu">
						<i class="fa fa-reorder"></i>
					</a>
				</span>
			</div>

			<div id="logout" class="btn-header transparent pull-right">
				<span>
					<a href="login.html" title="Sign Out" data-action="userLogout" data-logout-msg="You can improve your security further after logging out by closing this opened browser">
						<i class="fa fa-sign-out"></i>
					</a>
				</span>
			</div>

			<div id="fullscreen" class="btn-header transparent pull-right">
				<span>
					<a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen">
						<i class="fa fa-arrows-alt"></i>
					</a>
				</span>
			</div>

		</div>

	</header>

	<aside id="left-panel">

		<div class="login-info">
			<span>
				<a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
					<img src="${root}/resources/img/avatars/sunny.png" alt="me" class="online" />
					<span> Admin </span>
					<i class="fa fa-angle-down"></i>
				</a>
			</span>
		</div>

		<!-- NAVIGATION : This navigation is also responsive-->
		<nav>
			<ul>
				<li class="active open">
					<a>
						<i class="fa fa-lg fa-fw fa-database"></i>
						<span class="menu-item-parent">数据管理</span>
					</a>
					<ul style="display: block;">
						<li>
							<a href="import_tables.html">导入表</a>
						</li>
						<li>
							<a href="logic_tables.html">派生表</a>
						</li>
						<li>
							<a href=" import_tables_error.html">导入表预警</a>
						</li>
						<li>
							<a href="logic_tables_error.html">派生表预警</a>
						</li>
					</ul>
				</li>
				<li class="top-menu-invisible">
					<a>
						<i class="fa fa-lg fa-fw fa-desktop"></i>
						<span class="menu-item-parent">任务管理</span>
					</a>
					<ul>
						<li>
							<a href="mrTaskList">任务列表</a>
						</li>
						<li>
							<a href="task_wait.html">待运行任务列表</a>
						</li>
						<li>
							<a href="task_error.html">任务运行预警</a>
						</li>


					</ul>
				</li>



			</ul>
		</nav>

		<span class="minifyme" data-action="minifyMenu">
			<i class="fa fa-arrow-circle-left hit"></i>
		</span>

	</aside>

	<div id="main" role="main">
		<div id="ribbon">
			<span class="ribbon-button-alignment">
				<span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh" rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true">
					<i class="fa fa-refresh"></i>
				</span>
			</span>
			<ol class="breadcrumb">
				<li>首页</li>
				<li>任务管理</li>
				<li>任务列表</li>
			</ol>
		</div>

		<div id="content">

			<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable no-padding">

				<!-- Widget ID (each widget will need unique ID)-->
				<div class="jarviswidget jarviswidget-sortable" id="wid-id-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="border-top: 1px solid #CCC !important;">

					<!-- widget div-->
					<div role="content" style="padding: 0;">



						<!-- widget content -->
						<div class="widget-body no-padding">

							<form class="smart-form">
								<header> 查询 </header>
								<fieldset class="padding-top-20">

									<div class="row">

										<section class="col col-1 text-right">
											<label class="text">任务名称</label>
										</section>

										<section class="col col-3">
											<label class="input">
												<input type="text" placeholder="请输入任务名称">
											</label>
										</section>

										<section class="col col-1 text-right">
											<label class="text">生成逻辑表</label>
										</section>

										<section class="col col-3">
											<label class="select">
												<select>
													<option value="0">否</option>
													<option value="1">是</option>
												</select>
												<i></i>
											</label>
										</section>

										<section class="col col-1 text-right">
											<label class="text">触发表</label>
										</section>
										<section class="col col-3">
											<label class="input">
												<input type='text' placeholder='输入触发表，多个按,号隔开' >
											</label>
										</section>
										
									</div>
									<div class="row">
										<section class="col col-1 text-right">
											<label class="text">激活</label>
										</section>
										<section class="col col-3">
											<label class="select">
												<select>
													<option value="1">是</option>
													<option value="0">否</option>
												</select>
												<i></i>
											</label>
										</section>
										<section class="col col-1 text-right">
											<label class="text">创建时间</label>
										</section>
										<section class="col col-3">
											<section class="col col-5" style="padding: 0; margin: 0;">
												<label class="input">
													<input type="text" placeholder="">
												</label>
											</section>
											<section class="col col-1" style="padding: 0; margin: 0;">
												<label>－</label>
											</section>
											<section class="col col-6" style="padding: 0; margin: 0;">
												<label class="input">
													<input type="text" placeholder="">
												</label>
											</section>
										</section>
									</div>


								</fieldset>
								<footer>
									<button type="submit" class="btn btn-primary">查询</button>
									<button type="button" class="btn btn-default" onclick="window.history.back();">重置</button>
								</footer>
							</form>

						</div>
						<!-- end widget content -->

					</div>
					<!-- end widget div -->

				</div>
				<!-- end widget -->

			</article>

			<!-- 任务管理主表 -->
			<section id="widget-grid" class="">

				<!-- row -->
				<div class="row">
					<article class="col-sm-12">
						<!-- new widget -->
						<button id="task_add" class="btn btn-primary btn-lg mb">创建任务</button>
						<br>
						<br>
						<div id="addtab" title="<div class='widget-header'><h4><i class='fa fa-plus'></i> 创建任务</h4></div>">
							<form class="smart-form">

								<fieldset>
									<div class="row">
										<section class="col col-2 text-right">
											<label class="text">任务名称</label>
										</section>
										<section class="col col-10">
											<label class="input">
												<input type="text" placeholder="任务名称" disabled="true">
											</label>
										</section>

									</div>
									<div class="row">
										<section class="col col-2 text-right">
											<label class="text">定时触发</label>
										</section>
										<section class="col col-10">
											<label class="input">
												<input type="text" placeholder="">
											</label>
										</section>
									</div>
									<div class="row">

										<section class="col col-2 text-right">
											<label class="text">条件触发</label>
										</section>
										<section class="col col-10">

											<div class="row">

												<section class="col col-4">
													<label class="input">
														<input type="text" list="list" placeholder="库名">
														<datalist id="list">
															<option value="Alexandra">库名一</option>
															<option value="Alice">库名二</option>
															<option value="Anastasia">库名三</option>

														</datalist>
													</label>
												</section>

												<section class="col col-4">
													<label class="input">
														<input type="text" list="list" placeholder="表名">
														<datalist id="list">
															<option value="Alexandra">库名一</option>
															<option value="Alice">库名二</option>
															<option value="Anastasia">库名三</option>

														</datalist>
													</label>
												</section>

												<section class="col col-4">
													<label class="input">
														<input type="text" list="list" placeholder="全量/增量">
														<datalist id="list">
															<option value="Alexandra">库名一</option>
															<option value="Alice">库名二</option>
															<option value="Anastasia">库名三</option>

														</datalist>
													</label>
												</section>
											</div>
										</section>
									</div>
									<div class="row">
										<section class="col col-2 text-right">
											<label class="text">优先级</label>
										</section>
										<section class="col col-10">
											<label class="input">
												<input type="text" placeholder="">
											</label>
										</section>
									</div>
									<div class="row">
										<section class="col col-2 text-right">
											<label class="text">描述</label>
										</section>
										<section class="col col-10">

											<label class="textarea textarea-resizable">
												<textarea rows="3" class="custom-scroll"></textarea>
											</label>

										</section>
									</div>


									<div class="row">

										<section class="col col-2 text-right">
											<label class="text">上传文件</label>
										</section>
										<section class="col col-10">
											<div class="input input-file">
												<span class="button">
													<input type="file" id="file" name="file" onchange="this.parentNode.nextSibling.value = this.value">
													浏览...
												</span>
												<input type="text" placeholder="Include some files" readonly="">
											</div>
										</section>

									</div>

									<div class="row">
										<section class="col col-2 text-right">
											<label class="text">是否激活</label>
										</section>
										<section class="col col-10">
											<div class="inline-group">
												<label class="radio">
													<input type="radio" name="radio" checked="checked">
													<i></i>
													是
												</label>
												<label class="radio">
													<input type="radio" name="radio">
													<i></i>
													否
												</label>

											</div>

										</section>
									</div>
									<div class="row">
										<section class="col col-2 text-right">
											<label class="text">是否创建派生表</label>
										</section>
										<section class="col col-10">

											<div class="inline-group">
												<label class="radio">
													<input type="radio" name="radio-inline" checked="checked">
													<i></i>
													是
												</label>
												<label class="radio">
													<input type="radio" name="radio-inline">
													<i></i>
													否
												</label>

											</div>
										</section>
									</div>


								</fieldset>
								<footer>
									<button type="button" class="btn btn-default" onclick="window.history.back();">重置</button>
									<button type="submit" class="btn btn-primary">新建</button>

								</footer>
							</form>
						</div>

						<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">



							<div class="widget-body no-padding bordertop">
								<!-- content -->
								<div id="dt_basic_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
									<table id="dt_basic" class="table table-striped table-bordered table-hover dataTable no-footer" width="100%" role="grid" aria-describedby="dt_basic_info" style="width: 100%;">
										<thead>
											<tr role="row">
												<th data-hide="phone" class="sorting_asc" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-sort="ascending" aria-label="ID: activate to sort column descending">任务ID</th>
												<th data-class="expand" class="expand sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Name: activate to sort column ascending">任务名称</th>
												<th data-hide="phone" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Phone: activate to sort column ascending">任务说明</th>
												<th class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="Company: activate to sort column ascending">优先级</th>
												<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Zip: activate to sort column ascending">是否创建派生表</th>
												<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">触发条件</th>
												<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Date: activate to sort column ascending">是否激活</th>
												<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">定时运行表达式</th>
												<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">上次运行时间</th>
												<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">是否成功</th>
												<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">失败信息</th>
												<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">创建时间</th>
												<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">操作</th>
											</tr>
										</thead>
										<tbody>

											<tr role="row" class="odd" aria-selected="false">

												<td class="sorting_1">1</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成保单宽表
												</td>
												<td>由保单相关的信息生成保单宽表</td>
												<td>999</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td>WIN 0 0 30 2</td>
												<td>2017-03-15 11:30:20</td>
												<td>成功</td>
												<td></td>
												<td>2015-12-20 11:30:20</td>
												<td>

													<!-- Demo -->

													<div class="btn-group" style="width: 100px;">
														<a class="btn btn-default" href="javascript:void(0);">操作</a>
														<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
															<span class="caret"></span>
														</a>
														<ul class="dropdown-menu">
															<li id="add_tab">
																<a href="javascript:void(0);">查看表</a>
															</li>

															<!-- <div id="addtab" title="<div class='widget-header'><h4><i class='fa fa-plus'></i> 创建任务</h4></div>">11111111111</div>-->
															<li>
																<a href="javascript:void(0);">修改</a>
															</li>
															<li>
																<a href="javascript:void(0);">删除</a>
															</li>
															<li>
																<a href="javascript:void(0);">激活</a>
															</li>

															<li>
																<a href="javascript:void(0);">停止</a>
															</li>
														</ul>
													</div>
													<button type="submit" class="btn btn-primary btn-lg" onclick="window.open ('任务查看表.html','newwindow','height=500,width=900,top=100,left=200,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') " style="margin-bottom: 20px;">查看表</button>

												</td>
											</tr>
											<tr role="row" class="even">

												<td class="sorting_1">2</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成理赔宽表
												</td>
												<td>由保单理赔信息生成理赔宽表</td>
												<td>998</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td>FEB 0 1 30 2</td>
												<td>2017-03-15 12:30:20</td>
												<td>失败</td>
												<td>连接超时</td>
												<td>2015-12-20 12:30:20</td>
												<td></td>
											</tr>
											<tr role="row" class="odd">

												<td class="sorting_1">3</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成定损宽表
												</td>
												<td>由保单定损信息生成定损宽表</td>
												<td>998</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td></td>
												<td>2017-03-18 12:30:20</td>
												<td>成功</td>
												<td></td>
												<td>2016-12-20 12:30:20</td>
												<td></td>
											</tr>
											<tr role="row" class="even">

												<td class="sorting_1">4</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成保单宽表
												</td>
												<td>由保单相关的信息生成保单宽表</td>
												<td>999</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td>WIN 0 0 30 2</td>
												<td>2017-03-16 11:30:20</td>
												<td>成功</td>
												<td></td>
												<td>2015-12-20 11:30:20</td>
												<td></td>
											</tr>
											<tr role="row" class="odd">

												<td class="sorting_1">5</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成保单宽表
												</td>
												<td>由保单相关的信息生成保单宽表</td>
												<td>999</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td>WIN 0 0 30 2</td>
												<td>2017-03-17 11:30:20</td>
												<td>成功</td>
												<td></td>
												<td>2015-12-20 11:30:20</td>
												<td></td>
											</tr>
											<tr role="row" class="even">

												<td class="sorting_1">6</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成保单宽表
												</td>
												<td>由保单相关的信息生成保单宽表</td>
												<td>999</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td>WIN 0 0 30 2</td>
												<td>2017-03-18 11:30:20</td>
												<td>成功</td>
												<td></td>
												<td>2015-12-20 11:30:20</td>
												<td></td>
											</tr>
											<tr role="row" class="odd">

												<td class="sorting_1">7</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成保单宽表
												</td>
												<td>由保单相关的信息生成保单宽表</td>
												<td>999</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td>WIN 0 0 30 2</td>
												<td>2017-03-19 11:30:20</td>
												<td>成功</td>
												<td></td>
												<td>2015-12-20 11:30:20</td>
												<td></td>
											</tr>
											<tr role="row" class="even">

												<td class="sorting_1">8</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成保单宽表
												</td>
												<td>由保单相关的信息生成保单宽表</td>
												<td>999</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td>WIN 0 0 30 2</td>
												<td>2017-03-20 11:30:20</td>
												<td>成功</td>
												<td></td>
												<td>2015-12-20 11:30:20</td>
												<td></td>
											</tr>
											<tr role="row" class="odd">

												<td class="sorting_1">9</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成保单宽表
												</td>
												<td>由保单相关的信息生成保单宽表</td>
												<td>999</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td>WIN 0 0 30 2</td>
												<td>2017-03-21 11:30:20</td>
												<td>成功</td>
												<td></td>
												<td>2015-12-20 11:30:20</td>
												<td></td>
											</tr>
											<tr role="row" class="even">

												<td class="sorting_1">10</td>
												<td class=" expand">
													<span class="responsiveExpander"></span>
													生成保单宽表
												</td>
												<td>由保单相关的信息生成保单宽表</td>
												<td>999</td>
												<td>是</td>
												<td>[{“table”：a，“type”：“full”}，{“table”：b，“type”：“incremental”}]</td>
												<td>是</td>
												<td>WIN 0 0 30 2</td>
												<td>2017-03-22 11:30:20</td>
												<td>成功</td>
												<td></td>
												<td>2015-12-20 11:30:20</td>
												<td></td>
											</tr>
										</tbody>
									</table>
									<div class="dt-toolbar-footer">
										<div class="col-sm-6 col-xs-12 hidden-xs">
											<div class="dataTables_info" id="dt_basic_info" role="status" aria-live="polite">Showing 1 to 10 of 100 entries</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="dataTables_paginate paging_simple_numbers" id="dt_basic_paginate">
												<ul class="pagination">
													<li class="paginate_button previous disabled" id="dt_basic_previous">
														<a href="#" aria-controls="dt_basic" data-dt-idx="0" tabindex="0">Previous</a>
													</li>
													<li class="paginate_button active">
														<a href="#" aria-controls="dt_basic" data-dt-idx="1" tabindex="0">1</a>
													</li>
													<li class="paginate_button ">
														<a href="#" aria-controls="dt_basic" data-dt-idx="2" tabindex="0">2</a>
													</li>
													<li class="paginate_button ">
														<a href="#" aria-controls="dt_basic" data-dt-idx="3" tabindex="0">3</a>
													</li>
													<li class="paginate_button ">
														<a href="#" aria-controls="dt_basic" data-dt-idx="4" tabindex="0">4</a>
													</li>
													<li class="paginate_button ">
														<a href="#" aria-controls="dt_basic" data-dt-idx="5" tabindex="0">5</a>
													</li>
													<li class="paginate_button disabled" id="dt_basic_ellipsis">
														<a href="#" aria-controls="dt_basic" data-dt-idx="6" tabindex="0">…</a>
													</li>
													<li class="paginate_button ">
														<a href="#" aria-controls="dt_basic" data-dt-idx="7" tabindex="0">10</a>
													</li>
													<li class="paginate_button next" id="dt_basic_next">
														<a href="#" aria-controls="dt_basic" data-dt-idx="8" tabindex="0">Next</a>
													</li>
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
			<!-- 任务管理主表 -->

		</div>
		<!-- END MAIN CONTENT -->

	</div>

	<script data-pace-options='{ "restartOnRequestAfter": true }' src="${root}/resources/js/plugin/pace/pace.min.js"></script>

	<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script>
	if (!window.jQuery) {
	    document.write('<script src="${root}/resources/js/libs/jquery-2.1.1.min.js"><\/script>');
	}
    </script>

	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
	<script>
	if (!window.jQuery.ui) {
	    document.write('<script src="${root}/resources/js/libs/jquery-ui-1.10.3.min.js"><\/script>');
	}
    </script>

	<!-- IMPORTANT: APP CONFIG -->
	<script src="${root}/resources/js/app.config.js"></script>

	<!-- JS TOUCH : include this plugin for mobile drag / drop touch events--
		<script src="js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script> 

		<!-- BOOTSTRAP JS -->
	<script src="${root}/resources/js/bootstrap/bootstrap.min.js"></script>

	<!-- CUSTOM NOTIFICATION --
		<script src="${root}/resources/js/notification/SmartNotification.min.js"></script>

		<!-- JARVIS WIDGETS -->
	<script src="${root}/resources/js/smartwidgets/jarvis.widget.min.js"></script>

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
	<script src="${root}/resources/js/demo.min.js"></script>

	<!-- MAIN APP JS FILE -->
	<script src="${root}/resources/js/app.min.js"></script>
	
	<script src="${root}/resources/layer/layer.js"></script>

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

	$(document)
		.ready(
			function() {

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

			    $("#city").autocomplete(
				    {
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
							    label : item.name
								    + (item.adminName1 ? ", " + item.adminName1 : "")
								    + ", " + item.countryName,
							    value : item.name
							}
						    }));
						}
					    });
					},
					minLength : 2,
					select : function(event, ui) {
					    log(ui.item ? "Selected: " + ui.item.label : "Nothing selected, input was "
						    + this.value);
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
				buttons : [
					{
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
					}
				]
			    });

			    // addTab form: calls addTab function on submit and closes the dialog
			    var form = dialog.find("form").submit(function(event) {
				addTab();
				dialog.dialog("close");
				event.preventDefault();
			    });

			    // actual addTab function: adds new tab using the input from the form above
			    function addTab() {
				var label = tabTitle.val() || "Tab " + tabCounter, id = "tabs-" + tabCounter, li = $(tabTemplate
					.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label)), tabContentHtml = tabContent
					.val()
					|| "Tab " + tabCounter + " content.";

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
				header : "fa fa-plus", // custom icon class
				activeHeader : "fa fa-minus" // custom icon class
			    };

			    $("#accordion").accordion({
				autoHeight : false,
				heightStyle : "content",
				collapsible : true,
				animate : 300,
				icons : accordionIcons,
				header : "h4",
			    })

			    /*
			     * PROGRESS BAR
			     */
			    $("#progressbar").progressbar(
				    {
					value : 25,
					create : function(event, ui) {
					    $(this).removeClass("ui-corner-all").addClass('progress').find(
						    ">:first-child").removeClass("ui-corner-left").addClass(
						    'progress-bar progress-bar-success');
					}
				    });

			})
			
			

			
    </script>


	<script>
	
	$("#task_add").bind('click' , function(){
	    layer.open({
		  type: 2,
		  title: '新建任务',
		  shadeClose: true,
		  shade: 0.8,
		  area: ['380px', '90%'],
		  content: 'mrTask/addPage' //iframe的url
		}); 
	})	
	
	
	
	</script>

</body>

</html>