<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
	<title>表查询</title>
	<%@ include file="../header.jsp"%>
	
		<script type="text/javascript">
			$(document).ready(function(){
				var oTable = new TableInit();
				oTable.Init();
				
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
						sortable : true, //是否启用排序
						sortOrder : "asc", //排序方式
						queryParams : oTableInit.queryParams,//传递参数（*）
						sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
						pageNumber : 1, //初始化加载第一页，默认第一页
						pageSize : 10, //每页的记录行数（*）
						pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
						search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
						smartDisplay:false,//分页完全显示
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
						    field: 'Number',  
						    title: '序号',  
						    formatter: function (value, row, index) {  
						    return index+1;  
						    }  
						} ,{
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
	<body class="style='width: 99.5%'">
			<div id="content">
				<input id="table_id" type="hidden" name="table_id" value="${table_id }" />
				<table id="task_list_"></table>
			</div>

	</body>

</html>