<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>表查询</title>
		<script type="text/javascript">
			
			var TableInit = function() {
				var oTableInit = new Object();
				//初始化Table
				oTableInit.Init = function() {
					$('#task_list_').bootstrapTable({
						url : 'stage/querHistoryInfo', //请求后台的URL（*）
						method : 'get', //请求方式（*）
// 						toolbar : '#toolbar', //工具按钮用哪个容器
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
						search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
						smartDisplay:false,//分页完全显示
						showColumns : false, //是否显示所有的列
						showRefresh : false, //是否显示刷新按钮
						minimumCountColumns : 2, //最少允许的列数
						clickToSelect : true, //是否启用点击选中行
						// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
						uniqueId : "ID", //每一行的唯一标识，一般为主键列
						showToggle : false, //是否显示详细视图和列表视图的切换按钮
						cardView : false, //是否显示详细视图
						detailView : false, //是否显示父子表
						columns : [{
							field : 'id',
							title : '操作ID'
						},{
							field : 'importTables',
							title : '库名',
							formatter:function(value,row,index){
								return value.dbname
							}
						},{
							field : 'importTables',
							title : '表名',
							formatter:function(value,row,index){
								return value.table_name
							}
						}, {
							field : 'import_type',
							title : '更新类型',
							formatter : function (value, row, index){
						    	return value?"增量":"全量";
						    }
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
						    	return null!=value?new Date(value).format('yyyy-MM-dd hh:mm:ss'):null;
						    }
						},{
							field : 'end_time',
							title : '结束时间',
							formatter : function (value, row, index){
						    	return null!=value?new Date(value).format('yyyy-MM-dd hh:mm:ss'):null;
						    }
						}, {
							field : 'status',
							title : '状态',
							formatter : function (value, row, index){
								var res ="";
								if(value==1){
									res ='<font color="green"><b>成功</b></font>';
								}else if(value==-2){
									res ='<font color="red"><b>失败</b></font>';
								}else if(row.begin_time!=null&&row.end_time==null){
									res ='<font color="black"><b>进行中</b></font>';
								}
						    	return res;
						    }
						}, {
							field : 'fail_info',
							title : '原因'
						}]
					});
				};
				//得到查询的参数
				oTableInit.queryParams = function(params) {
					var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
							limit : params.limit, //页面大小
							offset : params.offset //页码
					};
					return temp;
				};
				return oTableInit;
			};
			$(document).ready(function(){
				var oTable = new TableInit();
				oTable.Init();
				
			});
		</script>
	</head>
	<body class="style='width: 99.5%'">
			<div id="content">
				<table id="task_list_"></table>
			</div>

	</body>

</html>