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
			url : 'annotation/queryList', //请求后台的URL（*）
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
				title : 'guid'
			}, {
				field : 'upload_id',
				title : '上传人'
			}, {
				field : 'image_uri',
				title : 'uri地址'
			},{
				field : 'create_time',
				title : '识别时间',
				formatter : function (value, row, index){
			    	return null!=value?new Date(value).format('yyyy-MM-dd hh:mm:ss'):null;
			    }
			},{
				 title : '操作',
				    formatter : function(value,row,index){
				    	 var str ="";
				    	str+='<button id="img_button" onclick="showImg(\''+row.image_uri+'\')" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModal">查看</button>  ';
				    	str+='<button id="img_button" onclick="showJson('+row.id+')" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModal">查看Json</button> ';
						str+='<button type="submit"  class="btn btn-primary btn-xs">删除</button>  ';
						return str;
				    }
			}],
			onLoadSuccess:function(data){
				sessionStorage.clear();
				$.each(data,function(index,val){
				sessionStorage.setItem(val.id, val.res_json);
				});
			}
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
function showJson(id){
	$('#myModal').on('show.bs.modal', function () {
		  $("#show_div").html(sessionStorage.getItem(id));
		})
}

function showImg(url){
	$('#myModal').on('show.bs.modal', function () {
		  $("#show_div").html('<img id="showIMG" alt="" src="'+url+'">');
		})
}
$(document).ready(function(){

	var oTable = new TableInit();
	oTable.Init();
	
	
	
});
</script>
</head>
<body>
		<!-- RIBBON -->
			<div id="ribbon">
				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>首页</li><li>运行监控</li><li>搜索监控</li>
				</ol>
			</div>
			<!-- END RIBBON -->
			<!-- MAIN CONTENT -->
			<div id="content">
				<table id="task_list"></table>
			</div>
			<!-- END MAIN CONTENT -->
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
				<img id="showIMG" alt="" src="">
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