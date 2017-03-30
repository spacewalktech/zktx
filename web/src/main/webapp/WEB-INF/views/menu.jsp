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
			<li class="top-menu-invisible">
				<a>
					<i class="fa fa-lg fa-fw fa-database"></i>
					<span class="menu-item-parent">数据管理</span>
				</a>
				<ul>
					<li>
					<li>
						<a href="orgTableList">导入表</a>
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

	<!-- 收缩按钮 -->
	<span class="minifyme" data-action="minifyMenu">
		<i class="fa fa-arrow-circle-left hit"></i>
	</span>

</aside>