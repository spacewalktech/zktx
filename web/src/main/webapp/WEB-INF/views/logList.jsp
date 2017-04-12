<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
			url : '', //请求后台的URL（*）
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
				field : 'id',
				title : 'ID'
			}, {
				field : 'guid',
				title : '操作人'
			}, {
				field : 'upload_id',
				title : '动作'
			}, {
				field : 'image_uri',
				title : '对象'
			},{
				field : 'create_time',
				title : '时间',
				formatter : function (value, row, index){
			    	return new Date(value).format('yyyy-MM-dd hh:mm:ss');
			    }
			}, {
				field : 'upload_id',
				title : '等级'
			}, {
				field : 'image_uri',
				title : '状态'
			},{
				 title : '操作',
				    formatter : function(value,row,index){
				    	 var str ="";
						str+='<button type="submit"  class="btn btn-primary btn-xs">删除</button>  ';
						return str;
				    }
			}]
		});
	};
	//得到查询的参数
	oTableInit.queryParams = function(params) {
	    
		var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
		};
		return temp;
	};
	return oTableInit;
};
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
</script>
</head>
<body>
		<!-- RIBBON -->
			<div id="ribbon">
				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>首页</li><li>日志管理</li>
				</ol>
			</div>
			<!-- END RIBBON -->
			<!-- MAIN CONTENT -->
			<div id="content">
				<table id="task_list"></table>
			</div>
			<!-- END MAIN CONTENT -->
</body>
</html>