<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

function tableQuery(id){
	layer.open({
		  type: 2,
		  title: '查看表信息',
		  shadeClose: true,
		  shade: 0.8,
		  area: ['70%', '70%'],
		  content: 'toQueryTable.do?table_id='+id //iframe的url
		}); 
}
function tableUpdate(id){
	layer.open({
		  type: 2,
		  title: '更新表信息',
		  shadeClose: true,
		  shade: 0.8,
		  area: ['60%', '70%'],
		  content: 'importTables/toUpdatePage.do?id='+id //iframe的url
		}); 
}
function tableDefine(id){
	layer.open({
		  type: 2,
		  title: '查看表定义',
		  shadeClose: true,
		  shade: 0.8,
		  area: ['60%', '80%'],
		  content: 'tableSchema/tableDdf.do?id='+id
		}); 
}
//删除
function tableDelete(id){
    layer.confirm('确认删除?', {
	  btn: ['删除','取消'], //按钮
	  icon: 3
	}, function(){
	    $.ajax({
			type : 'post',
			url : 'importTables/delete.do',
			data : {
			    id : id
			},
	    	success : function(result){
	    	    if(result == 'success'){
	    			layer.msg('删除成功', {icon: 1});
	    			$('#task_list').bootstrapTable('refresh');
	    	    }else{
	    			layer.msg('删除失败', {icon: 5});
	    	    }
	    	}
	    })
	});
}
$("#add_table").bind("click",function(){
	layer.open({
		  type: 2,
		  title: '新建表',
		  shadeClose: true,
		  shade: 0.8,
		  area: ['60%', '70%'],
		  content: "importTables/toAddPage.do?table_type="+$("#table_type").val()
		}); 
});
var TableInit = function() {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function() {
		$('#task_list').bootstrapTable({
			url : 'importTables/query.do', //请求后台的URL（*）
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
				title : '序号'
			}, {
				field : 'dbname',
				title : '数据库名称'
			}, {
				field : 'table_name',
				title : '表名称'
			}, {
				field : 'src_db_type',
				title : '源库类型'
			}, {
				field : 'src_db',
				title : '源库名称'
			}, {
				field : 'src_table',
				title : '源表名称'
			}, {
				field : 'create_time',
				title : '创建时间',
				formatter : function (value, row, index){
			    	return new Date(value).format('yyyy-MM-dd hh:mm:ss');
			    }
			},{
				field : 'update_time',
				title : '更新时间',
				formatter : function (value, row, index){
			    	return new Date(value).format('yyyy-MM-dd hh:mm:ss');
			    }
			}, {
				field : 'creator_username',
				title : '创建人'
			}, {
				field : 'active',
				title : '状态',
				formatter : function (value, row, index){
			    	return value == false ? '激活' : '未激活';
			    }
			}, {
				field : '',
				title : '文件大小'
			}, {
				field : '',
				title : '总记录数'
			},{
			    title : '操作',
			    formatter : function(value,row,index){
					return '<div class="btn-group">'
					+	'<a class="btn btn-default" href="javascript:void(0);">操作</a>'
					+	'<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>'
					+	'<ul class="dropdown-menu" >'
					+      '<li style="height: 20px"><a href="javascript:void(0);" onclick="tableQuery('+row.id+')">查看表</a></li>'
					+	   '<li style="height: 20px"><a href="javascript:void(0);" onclick="tableDefine('+row.id+')">查看表定义</a></li>'
					+		'<li style="height: 20px"><a href="javascript:void(0);" onclick="tableUpdate('+row.id+')">编辑</a></li>'
					+      '<li style="height: 20px"><a href="javascript:void(0);" onclick="tableDelete('+row.id+')">删除表</a></li>'
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
			src_db : $("#src_db").val(),
			src_table : $("#src_table").val(),
			src_db_type : $("#src_db_type").val(),
			dbname : $("#dbname").val(),
			table_name : $("#table_name").val(),
			table_type : $("#table_type").val(),
			create_time_from : $("#create_time_from").val(),
			create_time_to : $("#create_time_to").val()
		};
		return temp;
	};
	return oTableInit;
};
function doSubmit(){
	$('#task_list').bootstrapTable("refresh");
}
$(document).ready(function(){
	var oTable = new TableInit();
	oTable.Init();
	$("#create_time_from").datetimepicker({
	    format: 'YYYY-MM-DD HH:mm:ss',
	    locale:  'zh-cn'
	});
	$("#create_time_to").datetimepicker({
	    format: 'YYYY-MM-DD HH:mm:ss',
	    locale:  'zh-cn'
	});
});
</script>
</head>
<body>
	
			<!-- RIBBON -->
			<div id="ribbon">
				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>首页</li><li>数据管理</li><li>${table_type==1?"派生表":"导入表"}</li>
				</ol>
			</div>
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content">
				
				<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable no-padding">
				
							<!-- Widget ID (each widget will need unique ID)-->
							<div class="jarviswidget jarviswidget-sortable" id="wid-id-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="border-top:1px solid #CCC!important;" >
							
								<!-- widget div-->
								<div role="content" style=" padding: 0; ">
				
				
									<!-- widget content -->
									<div class="widget-body no-padding">
				
										<form class="smart-form" id="smartForm">
											<header>
												查询
											</header>
				
											<fieldset class="padding-top-0">
												　
												<div class="row">
													<section class="col col-1 text-right"><label class="text">源库</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="库名" name="src_db" id="src_db"></label></section>
													<section class="col col-1 text-right"><label class="text">源表</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="表名" name="src_table" id="src_table"></label></section>
													
													<section class="col col-1 text-right"><label class="text">源库类型</label></section>
													<section class="col col-3">
														<label class="select">
														<select id="src_db_type" name="src_db_type">
															<option value="">-请选择-</option>
															<option value="Oracle">Oracle</option>
															<option value="DB2">DB2</option>
															<option value="Sybase">Sybase</option>
															<option value="SQL">SQL</option>
															<option value="Server">Server</option>
															<option value="Informax">Informax</option>
															<option value="MySQL">MySQL</option>
														</select> <i></i> </label>
													</section>
											</div>
											<div class="row">
													<section class="col col-1 text-right"><label class="text">库名</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="库名" name="dbname" id="dbname"></label></section>
													<section class="col col-1 text-right"><label class="text">表名</label></section>
													<section class="col col-3"><label class="input"><input type="text" placeholder="表名" name="table_name" id="table_name"></label></section>
													
													<section class="col col-1 text-right"><label class="text">创建时间</label></section>
													<section class="col col-3">
														<section class="col col-5" style="padding: 0; margin: 0;">
															<label class="input">
																<i class="icon-append fa fa-calendar"></i>
																<input type="text"name="create_time_from" id="create_time_from">
															</label>
														</section>
														<section class="col col-1" style="padding: 0; margin: 0;">
														<label>－</label>
														</section>
														<section class="col col-6" style="padding: 0; margin: 0;">
															<label class="input">
															<i class="icon-append fa fa-calendar"></i>
															<input type="text" name="create_time_to" id="create_time_to"></label>
														</section>
													</section>
												</div>
												
												<input type="hidden" id="table_type" name="table_type" value="${table_type }">
											</fieldset>
				
										
				
											<footer>
												
												<button type="reset" class="btn btn-default">
													重置
												</button>
												<button type="button" class="btn btn-primary" onclick="doSubmit()">
													查询
												</button>
											</footer>
										</form>
				
									</div>
									<!-- end widget content -->
				
								</div>
								<!-- end widget div -->
				
							</div>
							<!-- end widget -->
				
						</article>

							<!-- widget grid -->
				<!-- end widget grid -->
						<div id="toolbar" class="btn-group">
							<button id="add_table" type="button" class="btn btn-primary">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								创建表
							</button>
						</div>
						<table id="task_list" class="table-responsive"></table>
			</div>
			<!-- END MAIN CONTENT -->
	
</body>
</html>