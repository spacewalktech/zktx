<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>待运行任务列表</title>
<meta name="description" content="">
<meta name="author" content="">

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

<link rel="stylesheet" href="${root }/resources/js/bootstrap-table/bootstrap-table.css">

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
			<span id="titlogo">中坤天行数据平台</span>
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
							<a href="mrTaskWait">待运行任务列表</a>
						</li>
						<li>
							<a href="mrTaskError">任务运行预警</a>
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
				<li>待任务列表</li>
			</ol>
		</div>

		<div id="content">
			<table id="task_wait"</table>
		</div>
		
	</div>
	<script data-pace-options='{ "restartOnRequestAfter": true }' src="${root}/resources/js/plugin/pace/pace.min.js"></script>
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
	<script src="${root}/resources/js/app.config.js"></script>
	<script src="${root}/resources/js/bootstrap/bootstrap.min.js"></script>
	<script src="${root}/resources/js/smartwidgets/jarvis.widget.min.js"></script>
	<script src="${root}/resources/js/demo.min.js"></script>
	<script src="${root}/resources/js/app.min.js"></script>
	<script src="${root}/resources/layer/layer.js"></script>
	<script type="text/javascript">
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

<script src="${root }/resources/js/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
<script src="${root }/resources/js/bootstrap-table/bootstrap-table-zh-CN.js" type="text/javascript"></script>
	<script>
	
	$("#task_add").bind('click' , function(){
	    layer.open({
		  type: 2,
		  title: '新建任务',
		  shadeClose: true,
		  shade: 0.2,
		  area: ['60%', '50%'],
		  content: 'mrTask/addPage' //iframe的url
		}); 
	})	
	
	function show_task_queue(id){
	    layer.open({
		  type: 2,
		  title: '新建任务',
		  shadeClose: true,
		  shade: 0.2,
		  area: ['60%', '50%'],
		  content: 'mrTask/addPage' //iframe的url
		}); 
	}
	
	
	$(function(){
	    
	  	//1.初始化Table
		var oTable = new TableInit();
		oTable.Init();

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();
	    
	})
	
	var TableInit = function() {
			var oTableInit = new Object();
			//初始化Table
			oTableInit.Init = function() {
				$('#task_wait').bootstrapTable({
					url : 'mrTask/findTaskToRun.do', //请求后台的URL（*）
					method : 'get', //请求方式（*）
					toolbar : '', //工具按钮用哪个容器
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
					columns : [ {
						checkbox : true
					}, {
						field : 'id',
						title : '任务ID'
					}, {
						field : 'name',
						title : '任务名称'
					}, {
						field : 'priority',
						title : '优先级'
					}, {
						field : 'type',
						title : '是否创建派生表'
					}, {
						field : 'bin_file_uri',
						title : '触发条件'
					}, {
						field : 'active',
						title : '是否激活'
					}, {
						field : 'task_schedule',
						title : '定时运行表达式'
					}, {
						field : 'latest_running_time',
						title : '上次运行时间'
					}, {
						field : 'latest_running_status',
						title : '是否成功'
					} , {
						field : 'latest_running_info',
						title : '失败信息'
					}, {
						field : 'create_time',
						title : '创建时间'
					}, {
						field : '',
						title : '操作'
					}]
				});
			};

			//得到查询的参数
			oTableInit.queryParams = function(params) {
				var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
					limit : params.limit, //页面大小
					offset : params.offset, //页码
					departmentname : $("#txt_search_departmentname").val(),
					statu : $("#txt_search_statu").val()
				};
				return temp;
			};
			return oTableInit;
		};

		var ButtonInit = function() {
			var oInit = new Object();
			var postdata = {};

			oInit.Init = function() {
				//初始化页面上面的按钮事件
			};

			return oInit;
		};
	
	</script>

</body>

</html>