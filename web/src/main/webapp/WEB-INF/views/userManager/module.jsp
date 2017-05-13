<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

</script>
<script type="text/javascript">
var TableInit = function() {
// 	var oTableInit = new Object();
	//初始化Table
	this.Init = function() {
		$('#task_list').bootstrapTable({
			url : 'module/queryListBypId?pid=1', //请求后台的URL（*）
			method : 'get', //请求方式（*）
			toolbar : '#toolbar', //工具按钮用哪个容器
			striped : true, //是否显示行间隔色
// 			queryParams：eval('({pid:1})'),
			cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			clickToSelect : true, //是否启用点击选中行
			sortable : false, //是否启用排序
			sortOrder : "asc", //排序方式
			search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			strictSearch : true,
			smartDisplay:false,
			showColumns : true, //是否显示所有的列
			showRefresh : true, //是否显示刷新按钮
			minimumCountColumns : 2, //最少允许的列数
			// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId : "id", //每一行的唯一标识，一般为主键列
			showToggle : true, //是否显示详细视图和列表视图的切换按钮
			cardView : false, //是否显示详细视图
			detailView : false, //是否显示父子表
			columns : [{
				checkbox:true
			},{
				field : 'id',
				title : 'ID'
			}, {
				field : 'name',
				title : '名称'
			},  {
				field : 'sn',
				title : '模块标识'
			}, {
				field : 'url',
				title : 'url'
			}, {
				field : 'description',
				title : '描述信息'
			}]
		});
	};
};
function doTable(id){
	
	$("#parent_id").val(id);
	$('#task_list').bootstrapTable('refresh',{url:'module/queryListBypId?pid='+id});
}
function addCss() {
	$('.tree li:has(ul)').addClass('parent_li').find(' > span').attr(
			'title', 'Collapse this branch');
	$('.tree li.parent_li > span').on(
			'click',
			function(e) {
				var children = $(this).parent('li.parent_li').find(
						' > ul > li');
				if (children.is(":visible")) {
					children.hide('fast');
					$(this).attr('title', 'Expand this branch')
							.find(' > i').addClass('icon-plus-sign')
							.removeClass('icon-minus-sign');
				} else {
					children.show('fast');
					$(this).attr('title', 'Collapse this branch').find(
							' > i').addClass('icon-minus-sign')
							.removeClass('icon-plus-sign');
				}
				e.stopPropagation();
			});
};
function selectCheck(){
	
}
function moduleTree(){
	$.post("module/getTree",function(msg){
		var stringbuffer = new StringBuffer();
		createTree(stringbuffer,msg);
		$("#treeDiv").html(stringbuffer.toString());
		addCss();
	});
}
function createTree(stringbuffer,msg){
	stringbuffer.append('<ul>');
		$.each(msg,function(index,val){
			var classType="";
			if(null==val.parent_id){
				classType = "glyphicon glyphicon-duplicate";
				}else if(val.children!=null&&val.children.length>0){
					classType = "glyphicon glyphicon-console";
				}else {
					classType ="glyphicon glyphicon-leaf";
				}
			stringbuffer.append('<li><span><i class="'+classType+'"></i> '+val.name+'</span><a href="javascript:void(0);" onclick="doTable('+val.id+')">管理子模块</a>');
			createTree(stringbuffer,val.children);
			stringbuffer.append('</li>');
		});
	stringbuffer.append('</ul>');
}
$(document).ready(function () {
	moduleTree();
	var oTable = new TableInit();
	oTable.Init();
	
	$("#add_table").bind("click",function(){
		layer.open({
			  type: 2,
			  title: '新增菜单',
			  shadeClose: true,
			  shade: 0.3,
			  area: ['60%', '70%'],
			  content: "module/toAddModule?parent_id="+$("#parent_id").val()
			}); 
	});
	$("#delete_table").bind("click",function(){
		var rows =$('#task_list').bootstrapTable('getSelections');
		if(rows.length==0){
			layer.msg("请选择要删除的菜单项！")
		}else{
			var ids ="";
			$.each(rows,function(index,val){
				ids+=val.id+",";
			})
			if(ids.length>0){
				ids = ids.substr(0,ids.length-1);
			}
			layer.confirm('确认删除?', {
				  btn: ['删除','取消'], //按钮
				  icon: 3
				}, function(){
				    $.ajax({
						type : 'post',
						url : 'module/deleteModuleByIds',
						data : {
						    ids : ids
						},
				    	success : function(result){
				    	    if(result == 'success'){
				    			layer.msg('删除成功', {icon: 1});
				    			$('#task_list').bootstrapTable('refresh');
				    			moduleTree();
				    	    }else{
				    			layer.msg('删除失败', {icon: 5});
				    	    }
				    	}
				    })
				});
		}
		    
	});
	$("#update_table").bind("click",function(){
		var rows =$('#task_list').bootstrapTable('getSelections');
		if(rows.length==0){
			layer.msg("请选择要修改的菜单项！")
		}else if(rows.length>1){
			layer.msg("只能选择一项")
		}else{
			layer.open({
				  type: 2,
				  title: '修改菜单',
				  shadeClose: true,
				  shade: 0.3,
				  area: ['60%', '70%'],
				  content: "module/toUpdateModule?id="+rows[0].id
				}); 
		}
	});
});
</script>
</head>
<body>
	<div id="ribbon">
		<ol class="breadcrumb">
			<li>首页</li>
			<li>权限管理</li>
			<li>菜单管理</li>
		</ol>
	</div>
	<div id="content">
	<input id="parent_id" name="parent_id" type="hidden" value="1">
	<div class="panel panel-default">
				<div class="panel-heading">菜单列表</div>
				<div class="panel-body">
	<article class="col-sm-12 col-md-12 col-lg-5 sortable-grid">
		
					<div class="tree well" id="treeDiv">
					</div>
		
	</article>
	<article class="col-sm-12 col-md-12 col-lg-5 sortable-grid">
		<div id="toolbar" class="btn-group">
			<button id="add_table" class="btn btn-primary glyphicon glyphicon-plus">
				新增
			</button>
			<button id="update_table" class="btn btn-primary glyphicon glyphicon-pencil">
				修改
			</button>
			<button id="delete_table"  class="btn btn-primary glyphicon glyphicon-minus">
				删除
			</button>
		</div>	
		<table id="task_list"></table>
	</article>
			</div>
		</div>
	</div>
</body>
</html>