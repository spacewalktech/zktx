<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var TableInit = function() {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function() {
		$('#task_list').bootstrapTable({
			url : 'user/queryList.do', //请求后台的URL（*）
			method : 'get', //请求方式（*）
// 			toolbar : '#toolbar', //工具按钮用哪个容器
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
			search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			strictSearch : true,
			smartDisplay:false,
			showColumns : false, //是否显示所有的列
			showRefresh : false, //是否显示刷新按钮
			minimumCountColumns : 2, //最少允许的列数
			clickToSelect : true, //是否启用点击选中行
			// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId : "id", //每一行的唯一标识，一般为主键列
			showToggle : false, //是否显示详细视图和列表视图的切换按钮
			cardView : false, //是否显示详细视图
			detailView : false, //是否显示父子表
			columns : [{  
			    field: 'Number',  
			    title: '序号',  
			    formatter: function (value, row, index) {  
			    return index+1;  
			    }  
			} ,{
				field : 'id',
				title : 'ID'
			}, {
				field : 'name',
				title : '用户名'
			}, {
				field : 'pwd',
				title : '密码'
			}, {
				field : 'emial',
				title : '邮件'
			}, {
				field : 'phone',
				title : '电话'
			}, {
				field : 'status',
				title : '状态'
			}, {
				field : 'create_time',
				title : '注册时间',
				formatter : function (value, row, index){
			    	return null!=value?new Date(value).format('yyyy-MM-dd hh:mm:ss'):null;
			    }
			},{
			    title : '操作',
			    formatter : function(value,row,index){
					return '<div class="btn-group" style="width: 100px;">'
					+	'<a class="btn btn-default" href="javascript:void(0);">操作</a>'
					+	'<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>'
					+	'<ul class="dropdown-menu">'
					+	'	<li><a href="javascript:void(0);onclick=tableDefine('+ row.id +')">角色定义</a></li>'
					+	'	<li><a href="javascript:void(0);onclick=tableUpdate('+ row.id +')">编辑</a></li>'
					+	'	<li><a href="javascript:void(0);onclick=tableDelete('+ row.id +')">删除</a></li>'
					+	'</ul></div>'
			    }
			}]
		});
	};
	
	
	//得到查询的参数
	oTableInit.queryParams = function(params) {
	    
		var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
			limit : params.limit, //页面大小
			offset : params.offset
		};
		return temp;
	};
	return oTableInit;
};
$("#add_table").bind("click",function(){
	layer.open({
		  type: 2,
		  title: '新增用户',
		  shadeClose: true,
		  shade: 0.3,
		  area: ['60%', '70%'],
		  content: "user/toAdd.do"
		}); 
});
function tableDefine(id){
	
}
$(document).ready(function(){

	var oTable = new TableInit();
	oTable.Init();
});
</script>
</head>
<body>
      <div id="ribbon">
				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>首页</li><li>权限管理</li><li>用户管理</li>
				</ol>
			</div>
			<!-- END RIBBON -->
			<!-- MAIN CONTENT -->
			<div id="content">
<!-- 				<div id="toolbar" class="btn-group"> -->
<!-- 					<button id="add_table" type="button" class="btn btn-primary"> -->
<!-- 						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> -->
<!-- 								新增用户 -->
<!-- 					</button> -->
<!-- 				</div>				 -->
				<table id="task_list"></table>
			</div>
			
</body>
</html>