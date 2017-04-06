<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>修改任务</title>
<%@ include file="../header.jsp"%>

<script>
	var n = 0
	var father_select
	var son_select
	
	$(function(){
		  var tableList = ${tableList};
		   sessionStorage.clear();
		   $.each(tableList,function(index,val){
			   sessionStorage.setItem("db_"+val.id,val.src_db);
			   sessionStorage.setItem("tab_"+val.id,val.src_table);
		   });
		   
	   var srcdbs = ${srcdbs};
	   $.each(srcdbs,function(index,val){
		   father_select+= '<option value="'+val+'">'+val+'</option>';
	   });
	 
	    $("#file").fileupload({
		    url: '${root}' + "/mrTask/upload",
		    done:function(e,result){
				var file_name = result.result
		        $("#file_lable").html("<input type='hidden' name='bin_file_uri' id='bin_file_uri' value='" + file_name + "' />" + file_name)
		    }
		})
		
	})
	
	
	    function subimtForm(){
		
 		var name = $("#name").val()
		
		if(null == name || name.length == 0){
		    layer.msg("任务名称不能为空！")
		    return
		}
		
		var bin_file_uri = $("#bin_file_uri").val()
		
		if (null == bin_file_uri){
		    layer.msg("您还没上传需要执行的文件！")
		    return
		}
		
		var information = $("#information").val()
		
		if (null == information || information.length == 0){
		    layer.msg("任务描述不能为空！")
		    return
		}
		
		var priority = $("#priority").val()
		
		if(null == priority || priority.length == 0){
		    layer.msg("优先级不能为空！")
		    return
		}
		
		 var task_schedule = $("#task_schedule").val()
		
		var trigger_db_arry = document.getElementsByName("trigger_db")
		var trigger_table_arry = document.getElementsByName("trigger_table")
		var trigger_type_arry = document.getElementsByName("trigger_type")
		
		var arry = new Array() 
		
		for( var i=0 ; i < trigger_db_arry.length ; i++){
		    
			arry.push('{"'+ $(trigger_table_arry[i]).val() +'":'+ $(trigger_type_arry[i]).val() +'}')
		    
		}
		
		var triggle_tables = "[" + arry.join(",") + "]" 
		
// 		var triggle_tables = $("#triggle_tables").val()
		
		var active = $("input[name='active']:checked").val();
		
		var type = $("input[name='type']:checked").val();
		
		var pk = $("#id").val()
		
		$.ajax({
		    url : '${root}/mrTask/update.do',
		    type : 'post',
		    data : {
				id: pk,
				name: name,
				bin_file_uri: bin_file_uri,
				information: information,
				priority: priority,
				task_schedule: task_schedule,
				triggle_tables: triggle_tables,
				active: active,
				type: type
		    },
		    success : function(result){
				if (result == "error") {
				    layer.msg('修改失败！', {
					  icon: 2
					}) 
				}else{
				    layer.msg('修改成功！', {
					  icon: 1
					},function(){
						var index = parent.layer.getFrameIndex(window.name);
						parent.$('#task_list').bootstrapTable('refresh')
						parent.layer.close(index);
					})
				}
		    }
		})
    }
	
	  function onchange_select(id) {
			var val = $("#trigger_db_" + id).val()
			$.ajax({
				    url : '${root}' + '/mrTask/getTableByDB',
				    type : 'post',
				    data : {
						dbname : val
				    },
				    success : function(result) {
					str = ''
					for ( var i in result) {
					    var tb_id = result[i].id
					    var src_table = result[i].src_table
					    str += '<option value="'+tb_id+'">' + src_table + '</option>'
					}
					$("#trigger_table_" + id).html(str)
			    }
			})
	    }
	  function delete_row(id) {
			$("#row_" + id).remove()
			n = n - 1
	    }
	   function add_triger() {
		   	n = n + 1
			if (n == 10) {
		    	layer.msg('您添加的表太多啦！', {icon : 5});
			    return;
			}
			
			var str = '<div class="row" id="row_'+ n +'">' + '<section class="col col-2 text-right">'
				+ '<label class="text"></label>' + '</section>' + '<section class="col col-3">'
				+ '<label class="select">' + '<select name="trigger_db" id="trigger_db_'
				+ n
				+ '" onchange="onchange_select('
				+ n
				+ ')"  >'
				+ father_select
				+ '</select>'
				+ '<i></i>'
				+ '</label>'
				+ '</section>'
				+ '<section class="col col-3">'
				+ '<label class="select">'
				+ '<select id="trigger_table_'+n+'" name="trigger_table">'
				+ son_select
				+ '</select>'
				+ '<i></i>'
				+ '</label>'
				+ '</section>'
				+ '<section class="col col-3"><label class="select"><select id="trigger_type'+n+'" name="trigger_type"><option value="0">全量</option><option value="1">增量</option></select></label></section>'
				+ '<section class="col col-1">'
				+ '<span style="display:block;padding-top:7px">'
				+ '<a style="cursor:pointer;color:blue" onclick="delete_row('
				+ n
				+ ')">删除</a>'
				+ '</span>'
				+ '</section>' + '</div>'
		
				$("#div_row_trigger_parent").append(str)
				onchange_select(n);
			
	    }
	   
	function update_triger(){
		vartriggleTables = $("#triggle_tables").val();
		var src =eval('('+vartriggleTables+')');
		$.each(src,function(index,val){
			$.each(val,function(index_,val_){
				n=index;
				var str = '<div class="row" id="row_'+ n +'">' + '<section class="col col-2 text-right">'
				+ '<label class="text"></label>' + '</section>' + '<section class="col col-3">'
				+ '<label class="select">' + '<select name="trigger_db" id="trigger_db_'
				+ n
				+ '" onchange="onchange_select('
				+ n
				+ ')"  >'
				+ father_select
				+ '</select>'
				+ '<i></i>'
				+ '</label>'
				+ '</section>'
				+ '<section class="col col-3">'
				+ '<label class="select">'
				+ '<select id="trigger_table_'+n+'" name="trigger_table">'
				+ son_select
				+ '</select>'
				+ '<i></i>'
				+ '</label>'
				+ '</section>'
				+ '<section class="col col-3"><label class="select"><select id="trigger_type'+n+'" name="trigger_type"><option value="0" >全量</option><option value="1">增量</option></select></label></section>';
				if(index==0){
					str+= '<section class="col col-1">'
					+ '<span style="display:block;padding-top:7px">'
					+ '<a style="cursor:pointer;color:blue" onclick="add_triger()">添加</a>'
					+ '</span>'
					+ '</section>' + '</div>';
				}else{
					str+= '<section class="col col-1">'
					+ '<span style="display:block;padding-top:7px">'
					+ '<a style="cursor:pointer;color:blue" onclick="delete_row('
					+ n
					+ ')">删除</a>'
					+ '</span>'
					+ '</section>' + '</div>';
				}
				
				$("#div_row_trigger_parent").append(str);
				$("#trigger_db_"+n).val(sessionStorage.getItem("db_"+index_));
				$("#trigger_type"+n).val(val_);
				onchange_select(n);
			});
			
		});
	}
</script>

</head>
<body style='width: 99.5%'>
	<form class="smart-form">
		<fieldset id="div_row_trigger_parent">
			<div class="row">
				<section class="col col-2 text-right"> 
					<label class="text">任务名称</label> 
				</section>
				<section class="col col-3"> 
					<label class="input">
						<input type="text" placeholder="任务名称" id="name" name="name" value='${task.name }'>
					</label> 
				</section>
				
				<section class="col col-2 text-right"> 
					<label class="text">运行文件</label> 
				</section>
				<section class="col col-3"> 
					<label class="input">
						<div class="input input-file" id="file_lable">
							${task.bin_file_uri }
							<input type="file" placeholder="选择文件" id="file" name="file">
							<input type="hidden" placeholder="选择文件" id="bin_file_uri" name="bin_file_uri" value="${task.bin_file_uri }">
						</div>
					</label> 
				</section>
			</div>

			<div class="row">
				<section class="col col-2 text-right"> 
					<label class="text">任务描述</label> 
				</section>
				<section class="col col-9"> 
					<label class="input">
						<input type="text" placeholder="任务描述" id="information" name="information" value="${task.information }">
					</label> 
				</section>
			</div>


			<div class="row">
				<section class="col col-2 text-right"> 
					<label class="text">是否创建逻辑表</label> 
				</section>
				<section class="col col-3 text-right">
					<div class="inline-group">
						<label class="radio">
							<input type="radio" name="type" value="1" <c:if test="${task.type == true }">checked</c:if>>
							<i></i>
							是
						</label>
						<label class="radio">
							<input type="radio" name="type" value="0" <c:if test='${task.type == false }'>checked</c:if> >
							<i></i>
							否
						</label>
					</div>
				</section>
				
				<section class="col col-2 text-right"> 
					<label class="text">优先级</label> 
				</section>
				<section class="col col-3 text-right"> 
					<label class="input">
						<input type="text" placeholder="优先级" id="priority" value="${task.priority}">
					</label> 
				</section>
			</div>

			<div class="row">
				<section class="col col-2 text-right"> 
					<label class="text">是否激活</label> 
				</section>
				<section class="col col-3 text-right">
					<div class="inline-group">
						<label class="radio">
							<input type="radio" name="active" value="1" <c:if test='${task.active == true }'>checked</c:if> >
							<i></i>
							是
						</label>
						<label class="radio">
							<input type="radio" name="active" value="0" <c:if test='${task.active == false }'>checked</c:if> >
							<i></i>
							否
						</label>
					</div>
				</section>
				
				<section class="col col-2 text-right"> 
					<label class="text">定时运行表达式</label> 
				</section>
				<section class="col col-3 text-right"> 
					<label class="input">
						<input type="text" placeholder="corn表达式"  id="task_schedule" name="task_schedule" value="${task.task_schedule }">
						<input type='hidden' id='id' name='id' value='${task.id}'>
					</label> 
				</section>
			</div>
			
			<div class="row">
				<section class="col col-2 text-right"> 
					<label class="text">
						<a style="cursor: pointer; color: blue" onclick="update_triger()">点击查看触发条件</a>
					</label> 
				</section>
				<section class="col col-9 text-right"> <label class="input">
					<input type="hidden" placeholder="触发条件" id="triggle_tables" value='${task.triggle_tables}'>
				</label> </section>
			</div>
		</fieldset>
		<footer>
		<button type="button" class="btn btn-primary" onclick="subimtForm()">确定</button>
		<button type="reset" class="btn btn-default">重置</button>
		</footer>
	</form>
</body>
</html>