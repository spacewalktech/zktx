<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
//新增

// 修改 
function upd_task(id){
    layer.open({
	  type: 2,
	  title: '修改任务',
	  shadeClose: true,
	  shade: 0.2,
	  area: ['65%', '60%'],
	  content: 'mrTask/updatePage?id='+id
	}); 
}

// 删除
function del_task(id){
    layer.confirm('确认删除?', {
	  btn: ['删除','取消'], //按钮
	  icon: 3
	}, function(){
	    $.ajax({
			type : 'post',
			url : 'mrTask/deleteByid',
			data : {
			    id : id
			},
	    	success : function(result){
	    	    if(result == true){
	    			layer.msg('删除成功', {icon: 1});
	    			$('#task_list').bootstrapTable('refresh');
	    	    }else{
	    			layer.msg('删除失败', {icon: 5});
	    	    }
	    	}
	    })
	});
}


function showImg(){
	
}


var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#task_list').bootstrapTable({
				url : 'mrTask/queryRunningTaskList', //请求后台的URL（*）
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
				search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch : true,
				smartDisplay:false,
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
					title : 'ID'
				}, {
					field : 'taskWithBLOBs',
					title : '流程名称',
					formatter : function (value, row, index){
				    	return value.name;
				    }
				},  {
					field : 'taskWithBLOBs',
					title : '类型',
					formatter : function (value, row, index){
				    	return value.task_type;
				    }
				}, {
					field : 'create_time',
					title : '触发时间',
					formatter : function (value, row, index){
				    	return value == null ? null : new Date(value).format('yyyy-MM-dd hh:mm:ss');
				    }
				}, {
					field : 'begin_time',
					title : '开始时间',
					formatter : function (value, row, index){
				    	return value == null ? null : new Date(value).format('yyyy-MM-dd hh:mm:ss');
				    }
					
				}, {
					field : 'end_time',
					title : '结束时间',
					formatter : function (value, row, index){
				    	return value == null ? null : new Date(value).format('yyyy-MM-dd hh:mm:ss');
				    }
				}, {
					field : 'taskWithBLOBs',
					title : '状态',
					formatter : function (value, row, index){
				    	return value.latest_running_status;
				    }
				}, {
					field : 'taskWithBLOBs',
					title : '原因',
					formatter : function (value, row, index){
				    	return value.latest_running_info;
				    }
				}]
			});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
		    
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				search_name : $("#search_name").val(),
				search_type : $("#search_type").val(),
				search_triggle_tables : $("#search_triggle_tables").val(),
				search_active : $("#search_active").val(),
				search_create_time_begin : $("#search_create_time_begin").val(),
				search_create_time_end : $("#search_create_time_end").val()
			};
			return temp;
		};
		return oTableInit;
	};
	
	function queryTable(){
	    $('#task_list').bootstrapTable("refresh")
	}
$(document).ready(function(){
  	//1.初始化Table
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
	
	
	$("#search_create_time_begin").datetimepicker({
	    format: 'YYYY-MM-DD HH:mm:ss',
	    locale:  'zh-cn'
	});
	
	$("#search_create_time_end").datetimepicker({
	    format: 'YYYY-MM-DD HH:mm:ss',
	    locale:  'zh-cn'
	});
	
	
});
</script>
</head>
<body>
		<div id="ribbon">
			<ol class="breadcrumb">
				<li>首页</li>
				<li>运行监控</li>
				<li>任务监控</li>
			</ol>
		</div>
		<div id="content">

			<!-- 任务管理主表 -->
			<div class="panel">
				<div>
					<div id="toolbar" class="btn-group">
						
					</div>
				</div>
			</div>
			
			<table id="task_list"></table>
			</div>	

</body>
</html>