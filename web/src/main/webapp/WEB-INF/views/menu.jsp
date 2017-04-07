
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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




<!-- 头部 -->
<header id="header">

	<!--logo -->
	<div id="logo-group">
		<span id="titlogo">中坤天行数据平台</span>
	</div>

	<!-- 右侧操作 -->
	<div class="pull-right">

		<!-- 合并菜单 -->
		<div id="hide-menu" class="btn-header pull-right">
			<span>
				<a href="javascript:void(0);" data-action="toggleMenu" title="Collapse Menu">
					<i class="fa fa-reorder"></i>
				</a>
			</span>
		</div>

		<!-- 登出 -->
		<div id="logout" class="btn-header transparent pull-right">
			<span>
				<a href="login.html" title="Sign Out" data-action="userLogout" data-logout-msg="You can improve your security further after logging out by closing this opened browser">
					<i class="fa fa-sign-out"></i>
				</a>
			</span>
		</div>

		<!-- 全屏 -->
		<div id="fullscreen" class="btn-header transparent pull-right">
			<span>
				<a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen">
					<i class="fa fa-arrows-alt"></i>
				</a>
			</span>
		</div>

	</div>

</header>

<!-- 导航 -->
<aside id="left-panel">

	<!-- 用户信息 -->
	<div class="login-info">
		<span>
			<a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
				<img src="${root }/resources/img/avatars/sunny.png" alt="me" class="online" />
				<span> Admin </span>
				<!-- <i class="fa fa-angle-down"></i> -->
			</a>
		</span>
	</div>

	<!-- 菜单 -->
	<nav>
		<ul>
			<li class="active open">
				<a>
					<i class="fa fa-lg fa-fw fa-database"></i>
					<span class="menu-item-parent">数据管理</span>
				</a>
				<ul style="display: block;">
					<li>
					<li>
						<a href="orgTableList">导入表</a>
					</li>
					<li>
						<a href="perTableList">派生表</a>
					</li>
					<li>
						<a href=" orgWarnTable">导入表预警</a>
					</li>
					<li>
						<a href="perWarnTable">派生表预警</a>
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

	<!-- 收缩按钮 -->
	<span class="minifyme" data-action="minifyMenu">
		<i class="fa fa-arrow-circle-left hit"></i>
	</span>

</aside>


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
					$(this).removeClass("ui-corner-all").addClass('progress').find(">:first-child")
						.removeClass("ui-corner-left").addClass(
							'progress-bar progress-bar-success');
				    }
				});

		    })
</script>