<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var TableInit = function() {
	
	$("#task_add").bind('click' , function(){
	    layer.open({
		  type: 2,
		  title: '新建任务',
		  shadeClose: true,
		  shade: 0.2,
		  area: ['60%', '50%'],
		  content: 'mrTask/addPage.do' //iframe的url
		}); 
	})	
	
	function show_task_queue(id){
	    layer.open({
		  type: 2,
		  title: '新建任务',
		  shadeClose: true,
		  shade: 0.2,
		  area: ['60%', '50%'],
		  content: 'mrTask/addPage.do' //iframe的url
		}); 
	}
	
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function() {
		$('#task_wait').bootstrapTable({
			url : 'mrTask/findByProper.do', //请求后台的URL（*）
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
				title : '任务ID'
			}, {
				field : 'name',
				title : '任务名称'
			}, {
				field : 'priority',
				title : '优先级'
			}, {
				field : 'type',
				title : '是否创建派生表',
				formatter : function (value, row, index){
			    	return value == true ? '创建' : '不创建';
			    }
			}, {
				field : 'bin_file_uri',
				title : '触发条件'
			}, {
				field : 'active',
				title : '是否激活',
				formatter : function (value, row, index){
			    	return value == true ? '激活' : '未激活';
			    }
			}, {
				field : 'task_schedule',
				title : '定时运行表达式'
			}, {
				field : 'latest_running_time',
				title : '上次运行时间',
			    formatter : function (value, row, index){
					if (value != null) {
			    		return new Date(value).format('yyyy-MM-dd hh:mm:ss')
					}
			    }
			}, {
				field : 'latest_running_status',
				title : '是否成功',
				formatter : function (value, row, index){
			    	return value == true ? '成功' : '失败';
			    }
			} , {
				field : 'latest_running_info',
				title : '失败信息'
			}, {
				field : 'create_time',
				title : '创建时间',
				formatter : function (value, row, index){
					if (value != null) {
			    		return new Date(value).format('yyyy-MM-dd hh:mm:ss')
					}
			    }
			}/* , {
				field : '',
				title : '操作',
				formatter : function(value,row,index){
				    //return '<button class="btn btn-mini btn-danger" type="button" onclick=del_queue('+ row.queue_id +')>删除</button>'
			    }
			} */]
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
		
});
</script>
</head>
<body>
		<div id="ribbon">
			<ol class="breadcrumb">
				<li>首页</li>
				<li>任务管理</li>
				<li>任务预警</li>
			</ol>
		</div>

		<div id="content">
			<table id="task_wait"></table>
		</div>
		
	
</body>
</html>