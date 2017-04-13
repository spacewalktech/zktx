<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
//新增
$("#btn_add").bind('click' , function(){
    layer.open({
	  type: 2,
	  title: '新建任务',
	  shadeClose: true,
	  shade: 0.2,
	  area: ['65%', '60%'],
	  content: 'mrTask/addPage.do'
	}); 
})	

// 修改 
function upd_task(id){
    layer.open({
	  type: 2,
	  title: '修改任务',
	  shadeClose: true,
	  shade: 0.2,
	  area: ['65%', '60%'],
	  content: 'mrTask/updatePage.do?id='+id
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
			url : 'mrTask/deleteByid.do',
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

function show_task_queue(id){
    layer.open({
	  type: 2,
	  title: '新建任务',
	  shadeClose: true,
	  shade: 0.2,
	  area: ['65%', '50%'],
	  content: 'mrTask/addPage.do' //iframe的url
	}); 
}


var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#task_list').bootstrapTable({
				url : 'mrTask/query.do', //请求后台的URL（*）
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
				smartDisplay:false,
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
					field : 'information',
					title : '任务说明'
				}, {
					field : 'type',
					title : '创建派生表',
					formatter : function (value, row, index){
				    	return value == true ? '创建' : '不创建';
				    }
				}, {
					field : 'triggle_tables',
					title : '触发条件'
				}, {
					field : 'active',
					title : '是否激活',
					formatter : function (value, row, index){
				    	return value == true ? '激活' : '未激活';
				    }
				}, {
					field : 'create_time',
					title : '创建时间',
					formatter : function (value, row, index){
				    	return value == null ? null : new Date(value).format('yyyy-MM-dd hh:mm:ss');
				    }
				},{
				    title : '操作',
				    formatter : function(value,row,index){
						return '<div class="btn-group" style="width: 100px;">'
						+	'<a class="btn btn-default" href="javascript:void(0);">操作</a>'
						+	'<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>'
						+	'<ul class="dropdown-menu">'
						+	'	<li><a href="javascript:void(0);onclick=upd_task('+ row.id +')">修改</a></li>'
						+	'	<li><a href="javascript:void(0);onclick=del_task('+ row.id +')">删除</a></li>'
						+	'</ul></div>'
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
				<li>任务管理</li>
				<li>任务列表</li>
			</ol>
		</div>

		<div id="content">
			<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable no-padding">
				<!-- Widget ID (each widget will need unique ID)-->
				<div class="jarviswidget jarviswidget-sortable" id="wid-id-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="border-top: 1px solid #CCC !important;">
					<div role="content" style="padding: 0;">
						<div class="widget-body no-padding">
							<form class="smart-form">
								<header> 查询 </header>
								<fieldset class="padding-top-20">

									<div class="row">

										<section class="col col-1 text-right">
											<label class="text">任务名称</label>
										</section>

										<section class="col col-3">
											<label class="input">
												<input type="text" placeholder="请输入任务名称" id="search_name">
											</label>
										</section>

										<section class="col col-1 text-right">
											<label class="text">生成派生表</label>
										</section>

										<section class="col col-3">
											<label class="select">
												<select id="search_type">
													<option value="">请选择</option>
													<option value="0">否</option>
													<option value="1">是</option>
												</select>
												<i></i>
											</label>
										</section>

										<section class="col col-1 text-right">
											<label class="text">触发表</label>
										</section>
										<section class="col col-3">
											<label class="input">
												<input type='text' placeholder='输入触发表，多个按,号隔开' id="search_triggle_tables">
											</label>
										</section>

									</div>
									<div class="row">
										<section class="col col-1 text-right">
											<label class="text">激活</label>
										</section>
										<section class="col col-3">
											<label class="select">
												<select id="search_active">
													<option value="">请选择</option>
													<option value="1">是</option>
													<option value="0">否</option>
												</select>
												<i></i>
											</label>
										</section>
										<section class="col col-1 text-right">
											<label class="text">创建时间</label>
										</section>
										<section class="col col-4">
											<section class="col col-4" style="padding: 0; margin: 0;">
												<label class="input">
													<i class="icon-append fa fa-calendar"></i>
													<input type="text" name="search_create_time_begin" id="search_create_time_begin">
												</label>
											</section>
											<section class="col col-1" style="padding: 1; margin: 2;">
												<label>－</label>
											</section>
											<section class="col col-4" style="padding: 0; margin: 0;">
												<label class="input">
													<i class="icon-append fa fa-calendar"></i>
													<input type="text" name="search_create_time_end" id="search_create_time_end">
												</label>
											</section>
										</section>
									</div>
								</fieldset>
								<footer>
									<button type="button" class="btn btn-primary" onclick="queryTable()">查询</button>
								</footer>
							</form>
						</div>
					</div>
				</div>
				<!-- end widget -->
			</article>

			<!-- 任务管理主表 -->
			<div class="panel">
				<div>
					<div id="toolbar" class="btn-group">
						<button id="btn_add" type="button" class="btn btn-primary">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
							新增
						</button>
					</div>
				</div>
			</div>
			<table id="task_list"></table>
			</div>	
	
</body>
</html>