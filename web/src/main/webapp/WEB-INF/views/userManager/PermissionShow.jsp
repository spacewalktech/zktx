<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE>
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
			url : 'role/queryList', //请求后台的URL（*）
			method : 'get', //请求方式（*）
			toolbar : '#toolbar', //工具按钮用哪个容器
			striped : true, //是否显示行间隔色
			cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			sortable : false, //是否启用排序
			sortOrder : "asc", //排序方式
			search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			strictSearch : true,
			smartDisplay:false,
			showColumns : true, //是否显示所有的列
			showRefresh : true, //是否显示刷新按钮
			minimumCountColumns : 2, //最少允许的列数
			clickToSelect : true, //是否启用点击选中行
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
				title : '角色'
			}, {
				field : 'info',
				title : '信息'
			}],
			onClickRow:function(row){
				roleToPermission(row.id);
			}
		});
	};
	return oTableInit;
};

function roleToPermission(id){
	moduleTree(function(){
		$.post("permission/querylistByroleId",{roleid:id},function(msg){
			$.each(msg,function(index,val){
				$("#"+val.module.grade+"_"+val.id).prop('checked',true);
				checkboxBut(val.module.grade+"_"+val.id,true);
			});
		});
	});
	$("#roleId").val(id);
}

function checkboxBut(id,checkVal){
	var resId=id;
	$('input[id^="'+resId+'"]').prop("checked",checkVal);
	parentcheckboxBut(resId);
}
function parentcheckboxBut(resId){
	var msgId =resId;
	if(resId.indexOf('_')>0){
		msgId=resId.substring(0,resId.indexOf('_'));
	}else{
		msgId=resId.substring(0,resId.length-2);
	}
	for(var i=2;i<=msgId.length;i+=2){
		var maneId=msgId.substring(0,i);
		$("#"+maneId).prop("checked",true);
	}
	parentUnCheckBut(msgId);
}
//--------------start
function parentUnCheckBut(resId){
	var falg =true;
	var checkS =$('input[id^="'+resId+'"]');
	$.each(checkS,function(index,val){
		if(val.checked&&val.id!=resId){
			falg=false;
			return true;
		}
	})
	if(falg){
		$("#"+resId).prop("checked",false);
		if(resId.length>2){
			var msgid =resId.substring(0,resId.length-2);
			parentUnCheckBut(msgid);
		}
	}
}
//--------------------end

function addCss() {
	$('.tree li:has(ul)').addClass('parent_li').find(' > span').attr(
			'title', 'Collapse this branch');
	
	$('.tree li.parent_li > span').on(
			'click',
			function(e) {
				var children = $(this).parent('li.parent_li').find(
						' > ul > li');
				if (children.is(":hidden")) {
					children.show('fast');
					$(this).attr('title', 'Collapse this branch').find(
							' > i').addClass('icon-minus-sign')
							.removeClass('icon-plus-sign');
				} else {
					children.hide('fast');
					$(this).attr('title', 'Expand this branch')
							.find(' > i').addClass('icon-plus-sign')
							.removeClass('icon-minus-sign');
				}
				e.stopPropagation();
			});
	//---------------------------start----
	$('.tree li.parent_li > :checkbox').click(
		function(e){
			checkboxBut(this.id,this.checked);
			e.stopPropagation();
		}
	);
	//------------------------------end
};
//-------------------------------------start--

//--------------------------------end
function moduleTree(func){
	$.post("module/getTree",function(msg){
		var stringbuffer = new StringBuffer();
		createTree(stringbuffer,msg);
		$("#treeDiv").html(stringbuffer.toString());
		addCss();
		if(typeof func=='function'){
			func();
		}
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
			stringbuffer.append('<li><input id="'+val.grade+'" name="module" type="checkbox" value="'+val.id+'"><span><i class="'+classType+'"></i> '+val.name+'</span>');
			$.each(val.permissions,function(indexOne,valOne){
				stringbuffer.append('<input type="checkbox" name="permission" id="'+val.grade+"_"+valOne.id+'" value="'+valOne.id+'">'+valOne.name);
			});
			createTree(stringbuffer,val.children);
			stringbuffer.append('</li>');
		});
	stringbuffer.append('</ul>');
}

function doTreeSubmit(){
	var checkVal =$('input[name="permission"]:checked');
	var strArray = new Array();
	$.each(checkVal,function(index,val){
		strArray.push(val.value);
	})
	var params =strArray.join(",");
	var roleId =$("#roleId").val();
	$.post("permission/permissionAssign",{params:params,roleId:roleId},function(result){
		if (result == "error") {
		    layer.msg('权限分配失败！', {
			  icon: 2
			}) 
		}else{
		    layer.msg('权限分配成功！', {
			  icon: 1
			},function(){
				roleToPermission(roleId);
			})
		}
	})
}
$(document).ready(function(){
	roleToPermission(1);
	var oTable = new TableInit();
	oTable.Init();
	$("#add_table").click(function(){
		var rows =$('#task_list').bootstrapTable('getSelections');
		alert(rows.length);
	});
	$("#update_table").click(function(){
		var rows =$('#task_list').bootstrapTable('getSelections');
		if(rows.length==0){
			layer.msg("请选择角色项！")
		}else if(rows.length>1){
			layer.msg("只能选择一项")
		}else{
			
			
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
			<li>权限分配</li>
		</ol>
	</div>
			<!-- END RIBBON -->
			<!-- MAIN CONTENT -->
			<div id="content">
				<article class="col-sm-12 col-md-12 col-lg-5 sortable-grid">
				<div class="panel panel-default">
					<div class="panel-heading">角色列表</div>
					<div class="panel-body">
						<div id="toolbar" class="btn-group">
							<button id="add_table" class="btn btn-primary glyphicon glyphicon-plus">
										新增
							</button>
							<button id="update_table" class="btn btn-primary glyphicon glyphicon-pencil">
										修改
							</button>
							<button id="update_table"  class="btn btn-primary glyphicon glyphicon-minus">
										删除
							</button>
							<button id="update_table"  class="btn btn-primary glyphicon glyphicon-indent-left">
										分配权限
							</button>
						</div>				
						<table id="task_list"></table>
					</div>
				</div>
			</article>
			<article class="col-sm-12 col-md-12 col-lg-7 sortable-grid">
				<div class="panel panel-default">
					<div class="panel-heading">权限列表<button type="button" class="btn btn-primary" style="float: right;" onclick="doTreeSubmit()">确定</button></div>
					<div class="panel-body">
						<form action="" id="treeSubmit" name="treeSubmit">
							
							<div class="tree well" id="treeDiv"></div>
							<input type="hidden" value="" name="roleId" id="roleId">
						</form>
					</div>
				</div>
			</article>
			</div>
			
</body>
</html>