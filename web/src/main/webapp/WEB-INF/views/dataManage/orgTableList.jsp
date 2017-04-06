<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">

		<title> SmartAdmin </title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
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
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
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
				
				<!-- PLACE YOUR LOGO HERE -->
				<span id="titlogo">人保健康险数据系统</span>
				<!-- END LOGO PLACEHOLDER -->
				
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

				<!-- logout button -->
				<div id="logout" class="btn-header transparent pull-right">
					<span> <a href="login.html" title="Sign Out" data-action="userLogout" data-logout-msg="You can improve your security further after logging out by closing this opened browser"><i class="fa fa-sign-out"></i></a> </span>
				</div>
				<!-- end logout button -->

				<!-- end search mobile button -->

				<!-- input: search field -->
			
				<!-- end input: search field -->

				<!-- fullscreen button -->
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
								<a href="orgTableList">导入表</a>
							</li>
							<li>
								<a href="perTableList">派生表</a>
							</li>
							<li>
								<a href="orgWarnTable">导入表预警</a>
							</li>
							<li>
								<a href="perWarnTable">派生表预警</a>
							</li>
						</ul>
					</li>
					<li  class="top-menu-invisible">
						<a><i class="fa fa-lg fa-fw fa-desktop"></i> <span class="menu-item-parent">任务管理</span></a>
						<ul>
							<li><a href="mrTaskList">任务列表</a></li>
							<li><a href="mrTaskWait">待运行任务列表</a></li>
							<li><a href="mrTaskError">任务运行预警</a></li>
							
							
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

			<!-- RIBBON -->
			<div id="ribbon">

				<span class="ribbon-button-alignment"> 
					<span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh"  rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true">
						<i class="fa fa-refresh"></i>
					</span> 
				</span>

				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>首页</li><li>数据管理</li><li>${table_type==1?"派生表":"导入表" }</li>
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
				
										<form class="smart-form" id="smartForm">
											<header>
												查询
											</header>
				
											<fieldset class="padding-top-0">
												　
												<div class="row">
													<section class="col col-1 text-right"><label class="text">源库</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="库名" name="src_db" id="src_db"></label></section>
													<section class="col col-1 text-right"><label class="text">源表</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="表名" name="src_table" id="src_table"></label></section>
													
													<section class="col col-1 text-right"><label class="text">源库类型</label></section>
													<section class="col col-3">
														<label class="select">
														<select id="src_db_type" name="src_db_type">
															<option value="">-请选择-</option>
															<option value="Oracle">Oracle</option>
															<option value="DB2">DB2</option>
															<option value="Sybase">Sybase</option>
															<option value="SQL">SQL</option>
															<option value="Server">Server</option>
															<option value="Informax">Informax</option>
															<option value="MySQL">MySQL</option>
														</select> <i></i> </label>
													</section>
											</div>
											<div class="row">
													<section class="col col-1 text-right"><label class="text">库名</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="库名" name="dbname" id="dbname"></label></section>
													<section class="col col-1 text-right"><label class="text">表名</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="表名" name="table_name" id="table_name"></label></section>
													
													<section class="col col-1 text-right"><label class="text">创建时间</label></section>
													<section class="col col-3">
														<section class="col col-5" style="padding: 0; margin: 0;">
															<label class="input">
																<i class="icon-append fa fa-calendar"></i>
																<input type="text"name="create_time_from" id="create_time_from">
															</label>
														</section>
														<section class="col col-1" style="padding: 0; margin: 0;">
														<label>－</label>
														</section>
														<section class="col col-6" style="padding: 0; margin: 0;">
															<label class="input">
															<i class="icon-append fa fa-calendar"></i>
															<input type="text" name="create_time_to" id="create_time_to"></label>
														</section>
													</section>
												</div>
												
												<input type="hidden" id="table_type" name="table_type" value="${table_type }">
												<input type="hidden" name="pageNum" value="1">
												<input type="hidden" id="perNum" name="perNum" value="10">
											</fieldset>
				
										
				
											<footer>
												
												<button type="reset" class="btn btn-default">
													重置
												</button>
												<button type="button" class="btn btn-primary" onclick="doSubmit()">
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
				<!-- end widget grid -->
				<div class="panel">
				<div>
					<div id="toolbar" class="btn-group">
						<button id="add_table" type="button" class="btn btn-primary">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
							创建表
						</button>
					</div>
				</div>
			</div>
				<table id="task_list"></table>
			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<!-- END MAIN PANEL -->

		<!-- PAGE FOOTER -->
	
		<!-- END PAGE FOOTER -->

	
		<!-- END SHORTCUT AREA -->

		<!--================================================== -->

		<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)-->
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
		<script src="${root}/resources/js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script> 

		<!-- BOOTSTRAP JS -->
		<script src="${root}/resources/js/bootstrap/bootstrap.min.js"></script>

		<!-- CUSTOM NOTIFICATION --
		<script src="${root}/resources/js/notification/SmartNotification.min.js"></script>

		<!-- JARVIS WIDGETS -->
		<script src="${root}/resources/js/smartwidgets/jarvis.widget.min.js"></script>

		<!-- EASY PIE CHARTS --
		<script src="${root}/resources/js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>

		<!-- SPARKLINES --
		<script src="${root}/resources/js/plugin/sparkline/jquery.sparkline.min.js"></script>

		<!-- JQUERY VALIDATE --
		<script src="${root}/resources/js/plugin/jquery-validate/jquery.validate.min.js"></script>

		<!-- JQUERY MASKED INPUT --
		<script src="${root}/resources/js/plugin/masked-input/jquery.maskedinput.min.js"></script>

		<!-- JQUERY SELECT2 INPUT --
		<script src="${root}/resources/js/plugin/select2/select2.min.js"></script>

		<!-- JQUERY UI + Bootstrap Slider --
		<script src="${root}/resources/js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>

		<!-- browser msie issue fix --
		<script src="${root}/resources/js/plugin/msie-fix/jquery.mb.browser.min.js"></script>

		<!-- FastClick: For mobile devices --
		<script src="${root}/resources/js/plugin/fastclick/fastclick.min.js"></script>

		<!--[if IE 8]>

		<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>

		<![endif]-->

		<!-- Demo purpose only -->
		<script src="${root}/resources/js/demo.min.js"></script>

		<!-- MAIN APP JS FILE -->
		<script src="${root}/resources/js/app.min.js"></script>

		<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
		<!-- Voice command : plugin --
		<script src="${root}/resources/js/speech/voicecommand.min.js"></script>

		<!-- SmartChat UI : plugin --
		<script src="${root}/resources/js/smart-chat-ui/smart.chat.ui.min.js"></script>
		<script src="${root}/resources/js/smart-chat-ui/smart.chat.manager.min.js"></script>
		
		<!-- PAGE RELATED PLUGIN(S) -->
		
		<!-- Flot Chart Plugin: Flot Engine, Flot Resizer, Flot Tooltip --
		<script src="${root}/resources/js/plugin/flot/jquery.flot.cust.min.js"></script>
		<script src="${root}/resources/js/plugin/flot/jquery.flot.resize.min.js"></script>
		<script src="${root}/resources/js/plugin/flot/jquery.flot.time.min.js"></script>
		<script src="${root}/resources/js/plugin/flot/jquery.flot.tooltip.min.js"></script>
		
		<!-- Vector Maps Plugin: Vectormap engine, Vectormap language --
		<script src="${root}/resources/js/plugin/vectormap/jquery-jvectormap-1.2.2.min.js"></script>
		<script src="${root}/resources/js/plugin/vectormap/jquery-jvectormap-world-mill-en.js"></script>
		
		<!-- Full Calendar --
		<script src="${root}/resources/js/plugin/moment/moment.min.js"></script>
		<script src="${root}/resources/js/plugin/fullcalendar/jquery.fullcalendar.min.js"></script>
-->
		<script src="${root }/resources/js/except.js"></script>	
		<script src="${root}/resources/layer/layer.js"></script>
		<script src="${root }/resources/js/moment.js" type="text/javascript"></script>
		<script src="${root }/resources/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
	
	<script src="${root }/resources/js/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
	<script src="${root }/resources/js/bootstrap-table/bootstrap-table-zh-CN.js" type="text/javascript"></script>
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
			var tabTitle = $("#tab_title"), tabContent = $("#tab_content"), tabTemplate = "<li style='position:relative;'> <span class='air air-top-left delete-tab' style='top:7px; left:7px;'><button class='btn btn-xs font-xs btn-default hover-transparent'><i class='fa fa-times'></i></button></span></span><a href=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>", tabCounter = 2;
		
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
			var oTable = new TableInit();
			oTable.Init();
			Date.prototype.format =function(format){
				var o = {
					"M+" : this.getMonth()+1, //month
					"d+" : this.getDate(), //day
					"h+" : this.getHours(), //hour
					"m+" : this.getMinutes(), //minute
					"s+" : this.getSeconds(), //second
					"q+" : Math.floor((this.getMonth()+3)/3), //quarter
					"S" : this.getMilliseconds() //millisecond
				}
				if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
				(this.getFullYear()+"").substr(4- RegExp.$1.length));
				for(var k in o)if(new RegExp("("+ k +")").test(format))
				format = format.replace(RegExp.$1,
				RegExp.$1.length==1? o[k] :
				("00"+ o[k]).substr((""+ o[k]).length));
				return format;
			}
			$("#create_time_from").datetimepicker({
			    format: 'YYYY-MM-DD HH:mm:ss',
			    locale:  'zh-cn'
			});
			$("#create_time_to").datetimepicker({
			    format: 'YYYY-MM-DD HH:mm:ss',
			    locale:  'zh-cn'
			});
		})
	

		function PreviousQuery(pageNum,pageCount){
			if(pageNum==0){
				alert("已经是第一页");
			}else if(pageNum>pageCount){
				alert("已是最后一页");
			}else{
				orgTableSubmit(pageNum);
			}
		}
		
		function tableQuery(id){
			layer.open({
				  type: 2,
				  title: '查看表',
				  shadeClose: true,
				  shade: 0.8,
				  area: ['70%', '70%'],
				  content: 'toQueryTable.do?table_id='+id //iframe的url
				}); 
		}
		function tableUpdate(id){
			layer.open({
				  type: 2,
				  title: '跟新任务',
				  shadeClose: true,
				  shade: 0.8,
				  area: ['60%', '90%'],
				  content: 'importTables/toUpdatePage.do?id='+id //iframe的url
				}); 
		}
		function tableDefine(id){
			layer.open({
				  type: 2,
				  title: '表定义',
				  shadeClose: true,
				  shade: 0.8,
				  area: ['60%', '80%'],
				  content: 'tableSchema/tableDdf.do?id='+id
				}); 
		}
		function tableDelete(id){
			$.post("importTables/delete.do?id="+id,function(msg){
				alert(msg);
				$('#task_list').bootstrapTable('refresh')
			});
		}
		$("#add_table").bind("click",function(){
			layer.open({
				  type: 2,
				  title: '新建任务',
				  shadeClose: true,
				  shade: 0.8,
				  area: ['60%', '90%'],
				  content: "importTables/toAddPage.do?table_type="+$("#table_type").val()
				}); 
		});
		
		var TableInit = function() {
			var oTableInit = new Object();
			//初始化Table
			oTableInit.Init = function() {
				$('#task_list').bootstrapTable({
					url : 'importTables/query.do', //请求后台的URL（*）
					method : 'get', //请求方式（*）
					toolbar : '#toolbar', //工具按钮用哪个容器
					striped : true, //是否显示行间隔色
					cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
					pagination : true, //是否显示分页（*）
					sortable : false, //是否启用排序
					sortOrder : "asc", //排序方式
					queryParams : oTableInit.queryParams,//传递参数（*）
					sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
					pageNumber : 1, //初始化加载第一页，默认第一页
					pageSize : 10, //每页的记录行数（*）
					pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
					search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
					strictSearch : true,
					showColumns : true, //是否显示所有的列
					showRefresh : true, //是否显示刷新按钮
					minimumCountColumns : 2, //最少允许的列数
					clickToSelect : true, //是否启用点击选中行
					// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
					uniqueId : "ID", //每一行的唯一标识，一般为主键列
					showToggle : true, //是否显示详细视图和列表视图的切换按钮
					cardView : false, //是否显示详细视图
					detailView : false, //是否显示父子表
					columns : [{
						field : 'id',
						title : '序号'
					}, {
						field : 'dbname',
						title : '数据库名称'
					}, {
						field : 'table_name',
						title : '表名称'
					}, {
						field : 'src_db_type',
						title : '源库类型'
					}, {
						field : 'src_db',
						title : '源库名称'
					}, {
						field : 'src_table',
						title : '源表名称'
					}, {
						field : 'create_time',
						title : '创建时间',
						formatter : function (value, row, index){
					    	return new Date(value).format('yyyy-MM-dd hh:mm:ss');
					    }
					},{
						field : 'update_time',
						title : '更新时间',
						formatter : function (value, row, index){
					    	return new Date(value).format('yyyy-MM-dd hh:mm:ss');
					    }
					}, {
						field : 'creator_username',
						title : '创建人'
					}, {
						field : 'active',
						title : '状态',
						formatter : function (value, row, index){
					    	return value == false ? '激活' : '未激活';
					    }
					}, {
						field : '',
						title : '文件大小'
					}, {
						field : '',
						title : '总记录数'
					},{
					    title : '操作',
					    formatter : function(value,row,index){
							return '<div class="btn-group" style="width: 100px;">'
							+	'<a class="btn btn-default" href="javascript:void(0);">操作</a>'
							+	'<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>'
							+	'<ul class="dropdown-menu">'
							+      '<li><a href="javascript:void(0);" onclick="tableQuery('+row.id+')">查看表</a></li>'
							+	   '<li><a href="javascript:void(0);" onclick="tableDefine('+row.id+')">查看表定义</a></li>'
							+		'<li><a href="javascript:void(0);" onclick="tableUpdate('+row.id+')">编辑</a></li>'
							+      '<li><a href="javascript:void(0);" onclick="tableDelete('+row.id+')">删除表</a></li>'
							+	'</ul></div>'
					    }
					}]
				});
			};
			//得到查询的参数
			oTableInit.queryParams = function(params) {
			    
				var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
					limit : params.limit, //页面大小
					offset : params.offset, //页码
					src_db : $("#src_db").val(),
					src_table : $("#src_table").val(),
					src_db_type : $("#src_db_type").val(),
					dbname : $("#dbname").val(),
					table_name : $("#table_name").val(),
					table_type : $("#table_type").val(),
					create_time_from : $("#create_time_from").val(),
					create_time_to : $("#create_time_to").val()
				};
				return temp;
			};
			return oTableInit;
		};
		function doSubmit(){
			$('#task_list').bootstrapTable("refresh");
		}
		</script>

	</body>

</html>