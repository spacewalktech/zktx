<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>任务监控</title>
<script type="text/javascript">
var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#table').bootstrapTable({
				url : 'mrTask/queryTask', //请求后台的URL（*）
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
				// search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
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
				columns : getColums()
			});
		};

		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				type : $("#type").val()
			};
			return temp;
		};
		return oTableInit;
	};
	
	function queryTable(){
	    $('#task_list').bootstrapTable("refresh")
	}
	
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
	
	$("#search_create_time_begin").datetimepicker({
	    format: 'YYYY-MM-DD HH:mm:ss',
	    locale:  'zh-cn'
	});
	
	$("#search_create_time_end").datetimepicker({
	    format: 'YYYY-MM-DD HH:mm:ss',
	    locale:  'zh-cn'
	});
	
});


function refresh(type){
    // alert(tbid)
   	/* var oTable = new TableInit(tbid);
	oTable.Init(); */
	$("#type").val(type)
	$('#table').bootstrapTable("destroy")
	var oTable = new TableInit();
	oTable.Init();
	
	// $('#table').bootstrapTable("refresh",{columns: getColums()})
}

function getColums(){
    
    // type 为 1 需要加上 状态条；2需要加上是失败原因；
    var type = $("#type").val()
    if(type == 0){
		
	    var colums = [{
			field : 'id',
			title : 'ID',
			width : '50'
		}, {
			field : 'name',
			title : '流程名称'
		},  {
			field : 'type',
			title : '类型'
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
		}]
	
	    return colums;
	    
    }else if (type == 4){
			var colums = [{
				field : 'id',
				title : 'ID',
				width : '50'
			}, {
				field : 'taskWithBLOBs',
				title : '流程名称',
				formatter : function (value, row, index){
				    return value.name
				}
			},  {
				field : 'taskWithBLOBs',
				title : '类型',
				formatter : function (value, row, index){
				    return value.task_type
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
			}]
		
		return colums;
    }else if (type == 1){
		var colums = [{
			field : 'id',
			title : 'ID',
			width : '50'
		}, {
			field : 'name',
			title : '流程名称'
		},  {
			field : 'type',
			title : '类型'
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
			field : 'taskWithBLOBs',
			title : '状态',
			width : '300',
			formatter : function (value, row, index){
		    	return '<div class="progress progress-striped active" style="margin-bottom: 0px;height: 15px" >' + 
					   '<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 40%;">' + 
					   '<span class="sr-only">40% 完成</span></div></div>'
		    }
		}]
		return colums;
    }else if ( type == 2){
	
		var colums = [{
			field : 'id',
			title : 'ID',
			width : '50px'
		}, {
			field : 'name',
			title : '流程名称'
		},  {
			field : 'type',
			title : '类型'
		}, {
			field : 'create_time',
			title : '触发时间',
			width : '100px',
			formatter : function (value, row, index){
		    	return value == null ? null : new Date(value).format('yyyy-MM-dd hh:mm:ss');
		    }
		}, {
			field : 'begin_time',
			title : '开始时间',
			width : '100px',
			formatter : function (value, row, index){
		    	return value == null ? null : new Date(value).format('yyyy-MM-dd hh:mm:ss');
		    }
		}, {
			field : 'end_time',
			title : '结束时间',
			width : '100px',
			formatter : function (value, row, index){
		    	return value == null ? null : new Date(value).format('yyyy-MM-dd hh:mm:ss');
		    }
		}, {
			field : 'reason',
			title : '原因',
			formatter : function (value, row, index){
		    	return "<a onclick='showError(\"" + row.result + "\")' data-toggle='modal' data-target='#myModal'>查看错误信息</a>"
		    }
		}]
	
		return colums;
    }
    
}

function showError(msg){
	$('#myModal').on('show.bs.modal', function () {
		$("#show_div").html(msg);
	})
}

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
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active">
				<a href="#succ" aria-controls="succ" role="tab" data-toggle="tab" onclick="refresh('0')">运行成功</a>
			</li>
			<li role="presentation">
				<a href="#runing" aria-controls="runing" role="tab" data-toggle="tab" onclick="refresh('1')">运行中</a>
			</li>
			<li role="presentation">
				<a href="#fail" aria-controls="fail" role="tab" data-toggle="tab" onclick="refresh('2')">运行失败</a>
			</li>
			<li role="presentation">
				<a href="#fail" aria-controls="fail" role="tab" data-toggle="tab" onclick="refresh('4')">未运行</a>
			</li>
		</ul>
		<div class="tab-content">
			<!-- <div role="tabpanel" class="tab-pane active" id="succ">
			</div>
			<div role="tabpanel" class="tab-pane" id="runing">
				<table id="table_runing"></table>
			</div>
			<div role="tabpanel" class="tab-pane" id="fail">
				<table id="table_fail"></table>
			</div> -->
			<table id="table"></table>
			<input type='hidden' id='type' value="0"/>
		</div>
	</div>
	
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" 
							aria-hidden="true">×
					</button>
					<h4 class="modal-title" id="myModalLabel">
						数据展示
					</h4>
				</div>
				<div class="modal-body" id="show_div">
					...
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" 
							data-dismiss="modal">关闭
					</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
	
</body>
</html>