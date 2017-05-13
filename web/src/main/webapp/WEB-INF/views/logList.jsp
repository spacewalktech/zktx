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
			url : 'log/queryList', //请求后台的URL（*）
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
			showColumns : false, //是否显示所有的列
			showRefresh : false, //是否显示刷新按钮
			minimumCountColumns : 2, //最少允许的列数
			clickToSelect : false, //是否启用点击选中行
			// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId : "ID", //每一行的唯一标识，一般为主键列
			showToggle : false, //是否显示详细视图和列表视图的切换按钮
			cardView : false, //是否显示详细视图
			detailView : false, //是否显示父子表
			columns : [{
				field : 'id',
				title : 'ID'
			}, {
				field : 'user_name',
				title : '操作人'
			}, {
				field : 'message',
				title : '操作'
			}, {
				field : 'log_level',
				title : '等级'
			},{
				field : 'create_time',
				title : '时间',
				formatter : function (value, row, index){
			    	return null!=value?new Date(value).format('yyyy-MM-dd hh:mm:ss'):null;
			    }
			}, {
				field : 'ip_address',
				title : 'ip地址'
			}]
		});
	};
	//得到查询的参数
	oTableInit.queryParams = function(params) {
	    
		var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				user_name: $("#user_name").val(),
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
					<li>首页</li><li>日志管理</li>
				</ol>
			</div>
			<!-- END RIBBON -->
			<!-- MAIN CONTENT -->
			<div id="content">
<!-- 				<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable no-padding"> -->
				
<!-- 							Widget ID (each widget will need unique ID) -->
<!-- 							<div class="jarviswidget jarviswidget-sortable" id="wid-id-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="border-top:1px solid #CCC!important;" > -->
							
<!-- 								widget div -->
<!-- 								<div role="content" style=" padding: 0; "> -->
				
				
<!-- 									widget content -->
<!-- 									<div class="widget-body no-padding"> -->
				
<!-- 										<form class="smart-form" id="smartForm"> -->
<!-- 											<header> -->
<!-- 												查询 -->
<!-- 											</header> -->
				
<!-- 											<fieldset class="padding-top-2"> -->
<!-- 											<div class="row"></div> -->
<!-- 											<div class="row"> -->
<!-- 													<section class="col col-1 text-right"><label class="text">操作人</label></section> -->
<!-- 													<section class="col col-3"><label class="input"><input type="text" placeholder="操作人" name="user_name" id="user_name"></label></section> -->
													
<!-- 													<section class="col col-1 text-right"><label class="text">时间</label></section> -->
<!-- 													<section class="col col-6"> -->
<!-- 														<section class="col col-5" style="padding: 0; margin: 0;"> -->
<!-- 															<label class="input"> -->
<!-- 																<i class="icon-append fa fa-calendar"></i> -->
<!-- 																<input type="text"name="create_time_from" id="create_time_from"> -->
<!-- 															</label> -->
<!-- 														</section> -->
<!-- 														<section class="col col-1" style="padding: 0; margin: 0; text-align: center;"> -->
<!-- 														<label>——</label> -->
<!-- 														</section> -->
<!-- 														<section class="col col-5" style="padding: 0; margin: 0;"> -->
<!-- 															<label class="input"> -->
<!-- 															<i class="icon-append fa fa-calendar"></i> -->
<!-- 															<input type="text" name="create_time_to" id="create_time_to"></label> -->
<!-- 														</section> -->
<!-- 													</section> -->
<!-- 												</div> -->
<!-- 											</fieldset> -->
				
										
				
<!-- 											<footer> -->
												
<!-- 												<button type="reset" class="btn btn-default"> -->
<!-- 													重置 -->
<!-- 												</button> -->
<!-- 												<button type="button" class="btn btn-primary" onclick="doSubmit()"> -->
<!-- 													查询 -->
<!-- 												</button> -->
<!-- 											</footer> -->
<!-- 										</form> -->
				
<!-- 									</div> -->
<!-- 									end widget content -->
				
<!-- 								</div> -->
<!-- 								end widget div -->
				
<!-- 							</div> -->
<!-- 							end widget -->
				
<!-- 						</article> -->
				<table id="task_list"></table>
			</div>
			<!-- END MAIN CONTENT -->
</body>
</html>