<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-skins.min.css">

		<!-- SmartAdmin RTL Support -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-rtl.min.css"> 

		<!-- We recommend you use "your_style.css" to override SmartAdmin
		     specific styles this will also ensure you retrain your customization with each SmartAdmin update.
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/your_style.css"> -->

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
		<script src="${root }/resources/js/jquery.min.js"></script>	
		<script src="${root }/resources/js/except.js"></script>	
		<script src="${root }/resources/js/moment.js" type="text/javascript"></script>
		<script src="${root}/resources/layer/layer.js"></script>
		<script src="${root }/resources/js/bootstrap-table/bootstrap-table.js" type="text/javascript"></script>
		<script src="${root }/resources/js/bootstrap-table/bootstrap-table-zh-CN.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function(){
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
			});
			var TableInit = function() {
				var oTableInit = new Object();
				//初始化Table
				oTableInit.Init = function() {
					$('#task_list_').bootstrapTable({
						url : 'stage/queryTable.do', //请求后台的URL（*）
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
						clickToSelect : false, //是否启用点击选中行
						// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
						uniqueId : "ID", //每一行的唯一标识，一般为主键列
						showToggle : true, //是否显示详细视图和列表视图的切换按钮
						cardView : false, //是否显示详细视图
						detailView : false, //是否显示父子表
						columns : [{
							field : 'stage_id',
							title : 'STAGE_ID'
						},{
							field : 'inserted_num',
							title : '新增记录数'
						}, {
							field : 'updated_num',
							title : '修改记录数'
						}, {
							field : 'deleted_num',
							title : '删除记录数'
						}, {
							field : 'record_num',
							title : '总记录数'
						},{
							field : 'begin_time',
							title : '开始时间',
							formatter : function (value, row, index){
						    	return new Date(value).format('yyyy-MM-dd hh:mm:ss');
						    }
						},{
							field : 'end_time',
							title : '结束时间',
							formatter : function (value, row, index){
						    	return new Date(value).format('yyyy-MM-dd hh:mm:ss');
						    }
						}, {
							field : 'status',
							title : '状态',
							formatter : function (value, row, index){
						    	return value?"失败":"成功";
						    }
						}, {
							field : 'import_type',
							title : '更新类型',
							formatter : function (value, row, index){
						    	return value?"增量":"全量";
						    }
						}]
					});
				};
				//得到查询的参数
				oTableInit.queryParams = function(params) {
					var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
							limit : params.limit, //页面大小
							offset : params.offset, //页码
							table_id : $("#table_id").val()
					};
					return temp;
				};
				return oTableInit;
			};
			
		</script>
	</head>
	<body class="">
			<input id="table_id" type="hidden" name="table_id" value="${table_id }" />

				<!-- 由主表滑出的表 -->
					<table id="task_list_"></table>
				<!-- 由主表滑出的表 -->
	</body>

</html>