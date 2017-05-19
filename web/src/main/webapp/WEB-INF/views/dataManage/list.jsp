<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
    function tableUpdate(id) {
	layer.open({
	    type : 2,
	    title : '更新表信息',
	    shadeClose : true,
	    shade : 0.3,
	    area : [
		    '60%', '70%'
	    ],
	    content : 'dataManage/toUpdatePage?id=' + id //iframe的url
	});
    }
    function tableDefine(id) {
	layer.open({
	    type : 2,
	    title : '查看表定义',
	    shadeClose : true,
	    shade : 0.3,
	    area : [
		    '60%', '80%'
	    ],
	    content : 'tableSchema/tableDdf?id=' + id
	});
    }
    //删除
    function tableDelete(id) {
		layer.confirm('确认删除?', {
		    btn : [
			    '删除', '取消'
		    ], //按钮
		    icon : 3
		}, function() {
		    $.ajax({
			type : 'post',
			url : 'dataManage/delete',
			data : {
			    id : id
			},
			success : function(result) {
			    if (result == 'success') {
				layer.msg('删除成功', {
				    icon : 1
				});
				$('#task_list').bootstrapTable('refresh');
			    } else {
				layer.msg('删除失败', {
				    icon : 5
				});
			    }
			}
		    })
		});
    }
    
    function tableHistory(id){
	$("#content_").load('stage/toHistoryInfo?tbid=' + id);
    }
    
    $("#add_table").bind("click", function() {
		layer.open({
		    type : 2,
		    title : '新建表',
		    shadeClose : true,
		    shade : 0.3,
		    area : [
			    '60%', '70%'
		    ],
		    content : "dataManage/toAddPage"
		});
    });
    var TableInit = function() {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function() {
	    $('#task_list')
		    .bootstrapTable(
			    {
				url : 'dataManage/query', //请求后台的URL（*）
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
				pageList : [
					10, 25, 50, 100
				], //可供选择的每页的行数（*）
				search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch : false,
				smartDisplay : false,
				showColumns : false, //是否显示所有的列
				showRefresh : false, //是否显示刷新按钮
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				uniqueId : "id", //每一行的唯一标识，一般为主键列
				showToggle : false, //是否显示详细视图和列表视图的切换按钮
				cardView : false, //是否显示详细视图
				detailView : false, //是否显示父子表
				columns : [
					{
					    field : 'id',
					    title : 'ID'
					},
					{
					    field : 'dbname',
					    title : '库名'
					},
					{
					    field : 'table_name',
					    title : '表名',
					    formatter : function(value, row, index) {
						var array = new Array();
						var c = value.split(";");
						var ss = "";
						$.each(c, function(index, vav) {
						    ss += vav + "\n"
						})

						return ss;
					    }
					},
					{
					    field : 'src_db_type',
					    title : '源库类型'
					},
					{
					    field : 'src_db',
					    title : '源库名'
					},
					{
					    field : 'src_table',
					    title : '源表名',
					    formatter : function(value, row, index) {
						var array = new Array();
						var c = value.split(";");
						var ss = "";
						$.each(c, function(index, vav) {
						    ss += vav + "\n"
						})

						return ss;
					    }

					},
					{
					    field : 'table_type',
					    title : '表类型',
					    formatter : function(value, row, index) {
						return value ? "逻辑表" : "导入表";
					    }
					},
					{
					    field : 'export_to_sql_warehouse',
					    title : '即席查询',
					    formatter : function(value, row, index) {
						return value ? "是" : "否";
					    }
					},
					{
					    field : 'export_to_es_index_warehouse',
					    title : '全文检索',
					    formatter : function(value, row, index) {
						return value ? "是" : "否";
					    }
					},
					{
					    field : 'create_time',
					    title : '创建时间',
					    formatter : function(value, row, index) {
						return null != value ? new Date(value).format('yyyy-MM-dd hh:mm:ss')
							: null;
					    }
					},
					{
					    field : 'update_time',
					    title : '更新时间',
					    formatter : function(value, row, index) {
						return null != value ? new Date(value).format('yyyy-MM-dd hh:mm:ss')
							: null;
					    }
					},
					{
					    field : 'creatorUser',
					    title : '创建人',
					    formatter : function(value, row, index) {
						return value != null ? value.name : ""
					    }
					},
					{
					    field : 'active',
					    title : '状态',
					    formatter : function(value, row, index) {
						return value == false ? '激活' : '未激活';
					    }
					},
					{
					    field : '',
					    title : '总大小'
					},
					{
					    field : '',
					    title : '记录数'
					},
					{
					    title : '操作',
					    formatter : function(value, row, index) {
						return '<div class="btn-group" style="width: 100px;">'
							+ '<a class="btn btn-default" href="javascript:void(0);">操作</a>'
							+ '<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>'
							+ '<ul class="dropdown-menu">'
							+ '	<li><a href="javascript:void(0);onclick=tableDefine('
							+ row.id + ')">结构</a></li>'
							+ '	<li><a href="javascript:void(0);onclick=tableUpdate('
							+ row.id + ')">编辑</a></li>'
							+ '	<li><a href="javascript:void(0);onclick=tableDelete('
							+ row.id + ')">删除</a></li>'
							+ '	<li><a href="javascript:void(0);onclick=tableHistory('
							+ row.id + ')">轨迹</a></li>' + '</ul></div>'
					    }
					}
				]
			    });
	};

	//得到查询的参数
	oTableInit.queryParams = function(params) {
	    var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
			limit : params.limit, //页面大小
			offset : params.offset
		    //页码
		    };
		    return temp;
		};
		return oTableInit;
    };
    
    function doSubmit() {
		$('#task_list').bootstrapTable("refresh");
    }
    
    $(document).ready(function() {
		var oTable = new TableInit();
		oTable.Init();
		$("#create_time_from").datetimepicker({
		    format : 'YYYY-MM-DD HH:mm:ss',
		    locale : 'zh-cn'
		});
		$("#create_time_to").datetimepicker({
		    format : 'YYYY-MM-DD HH:mm:ss',
		    locale : 'zh-cn'
		});
    });
</script>
</head>
<body>
	<!-- RIBBON -->
	<div id="ribbon">
		<!-- breadcrumb -->
		<ol class="breadcrumb">
			<li>首页</li>
			<li>数据管理</li>
			<li>库表管理</li>
		</ol>
	</div>
	<div id="content">
		<div id="toolbar" class="row">
			<div class="btn-group col-lg-6">
				<button id="add_table" type="button" class="btn btn-primary">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					导入新表
				</button>
			</div>
		</div>
		<table id="task_list" class="table-responsive"></table>
	</div>
</body>
</html>