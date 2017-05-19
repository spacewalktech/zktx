<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>修改任务</title>
<%@ include file="../header.jsp"%>

<script>
	var n = 0
	var m = 0
	var father_select
	
	  var task_type
	    var bin_file_uri 
	    var priority
	    var export_tables
	    var option_mode
	    var triggle_tables
	    var task_schedule
	    var has_derivative_table
	
	$(function(){
			//将所有的table表放入到session中,为了后边通过id取值
		  var tableList = ${tableList};
		   sessionStorage.clear();
		   $.each(tableList,function(index,val){
			   sessionStorage.setItem("db_"+val.id,val.dbname);
			   sessionStorage.setItem("tab_"+val.id,val.table_name);
		   });
		   //取出数据库（去重复）
	   var srcdbs = ${srcdbs};
	   $.each(srcdbs,function(index,val){
		   father_select+= '<option value="'+val+'">'+val+'</option>';
	   });
	   //返回触发条件的:
	   var triggle_tables_src = '${task.triggle_tables}';
	   update_triger(triggle_tables_src);
	   //返回输出表的值：
	   var  export_tables_src = '${task.export_tables}'
	   update_export(export_tables_src);
	   
	    $("#file").fileupload({
		    url: '${root}' + "/mrTask/upload",
		    done:function(e,result){
				var file_name = result.result
		        $("#file_lable").html("<input type='hidden' name='bin_file_uri' id='bin_file_uri' value='" + file_name + "' />" + file_name)
		    }
		})
		 option_mode = '${task.option_mode}';
		 optionMode(option_mode);
			
			$("input[name='option_mode']").bind('change',function(){
				var val =this.value
				optionMode(val);
			});
			has_derivative_table = '${task.has_derivative_table}';
			derivative(has_derivative_table);
			$("input[name='has_derivative_table']").bind('change',function(){
				var val = this.value
				derivative(val);
			});
    })
		function optionMode(val){
		if(val==2){
			$("#task_schedule_div").show();
			$("div[name='trigger_div']").hide();
		}else if(val==1){
			$("#task_schedule_div").hide();
			$("div[name='trigger_div']").show();
		}else{
			$("#task_schedule_div").hide();
			$("div[name='trigger_div']").hide();
		}
	}
		function derivative(val){
			if(val==0){
				$("div[name='export_div']").hide();
			}else if(val==1){
				$("div[name='export_div']").show();
			}
		}
	
	
	    function subimtForm(){
	    	var name = $("#name").val()
			
			if(null == name || name.length == 0){
			    layer.msg("任务名称不能为空！")
			    return
			}
			
			
			var information = $("#information").val()
			
			if (null == information || information.length == 0){
			    layer.msg("任务描述不能为空！")
			    return
			}
			
			
			var active = $("input[name='active']:checked").val();
		
	    	task_type =$("input[name='task_type']:checked").val();
	   	 bin_file_uri = $("#bin_file_uri").val()
	   		
	   		if (null == bin_file_uri){
	   		    layer.msg("您还没上传需要执行的文件！")
	   		    return
	   		}
	    	option_mode = $("input[name='option_mode']:checked").val();
	    	if(option_mode==0){
	    		task_schedule="";
	    		triggle_tables="";
	    	}else if(option_mode==2){
	    		triggle_tables="";
	    		task_schedule = $("#task_schedule").val();
	    		if(null==task_schedule||task_schedule.length==0){
	    			 layer.msg("定时表达式不能为空！")
	    	 		    return
	    		}
	    	}else if(option_mode==1){
	    		task_schedule="";
	    		var trigger_db_arry = document.getElementsByName("trigger_db")
	    		var trigger_table_arry = document.getElementsByName("trigger_table")
	    		var trigger_type_arry = document.getElementsByName("trigger_type")
	    		
	    		var arry = new Array() 
	    		
	    		for( var i=0 ; i < trigger_db_arry.length ; i++){
	    		    
	    		    arry.push('{"'+ $(trigger_table_arry[i]).val() +'":'+ $(trigger_type_arry[i]).val() +'}')
	    		    
	    		}
	    		
	    		triggle_tables = "[" + arry.join(",") + "]"
	    	}
	    	
	    	 priority = $("#priority").val()
	 		if(null == priority || priority.length == 0){
	 		    layer.msg("优先级不能为空！")
	 		    return
	 		}
	    	 
	    	has_derivative_table =$("input[name='has_derivative_table']:checked").val();
	    	if(has_derivative_table==1){
	    		var export_table_arry = document.getElementsByName("export_table")
	     		var arry = new Array() 
// 	    		var arry_vo = new Array() 
	     		for(var i=0;i<export_table_arry.length;i++){
	     			var res = $(export_table_arry[i]).val();
	    			var msgs =res.split("*");
	     		    arry.push(msgs[1]+"."+msgs[2])
// 	     		    arry_vo.push('{"id":'+ msgs[0] +',"dbname":"'+msgs[1]+'","table_name":"'+msgs[2]+'"}')
	     		}
	     		export_tables = arry.join(",")
	    	}else if(has_derivative_table==0){
	    		export_tables="";
	    	}
		
	    	var pk = $("#id").val();
		$.ajax({
		    url : '${root}/mrTask/update',
		    type : 'post',
		    data : {
				id: pk,
				name: name,
				task_type: task_type,
				bin_file_uri: bin_file_uri,
				information: information,
				priority: priority,
				task_schedule: task_schedule,
				triggle_tables: triggle_tables,
				option_mode: option_mode,
				export_tables: export_tables,
				active: active,
				has_derivative_table: has_derivative_table,
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
	
	  function onchange_select(id,index_) {
			var val = $("#trigger_db_" + id).val()
			$.ajax({
				    url : '${root}' + '/mrTask/getTableByDB',
				    type : 'post',
				    data : {
						dbname : val
				    },
				    success : function(result) {
					var str = ''
					for ( var i in result) {
					    var tb_id = result[i].id
					    var table_name = result[i].table_name
					    str += '<option value="'+tb_id+'">' + table_name + '</option>'
					}
					
					$("#trigger_table" + id).html(str)
					$("#trigger_table"+id).val(index_);
					
			    }
			})
	    }
	  function onchange_select_export(id,sv) {
			var val = $("#export_db_" + id).val()
			$.ajax({
				    url : '${root}' + '/mrTask/getTableByDB',
				    type : 'post',
				    data : {
						dbname : val
				    },
				    success : function(result) {
					
				    	var str = ''
							for ( var i in result) {
							    var tb_id = result[i].id
							    var table_name = result[i].table_name
							    var db_name = result[i].dbname
							    str += '<option value="'+tb_id+'*'+db_name+'*'+table_name+'">'+table_name+'</option>'
							}
						$("#export_table_" + id).html(str)
						$("#export_table_"+id).val(sv);
			    	}
			})
	    }
	 function delete_row(id) {
		$("#row_" + id).remove()
    }

    function add_triger() {
    	n = n + 1;

		var str = '<div class="form-group" id="row_'+ n +'" name="trigger_div">'
			+ '<label for="disabledSelect" class="col-sm-2 control-label text-right"></label>'
			+ '<div class="col-sm-3">'
			+ '<select name="trigger_db" id="trigger_db_'+ n + '" onchange="onchange_select('+ n + ',0)" class="form-control" >'
			+ father_select
			+ '</select>'
			+ '</div>'
			+ '<div class="col-sm-3">'
			+ '<select id="trigger_table'+n+'" name="trigger_table" class="form-control">'
			+ '</select>'
			+ '</div>'
			+ '<div class="col-sm-3">'
			+'<select name="trigger_type" class="form-control"><option value="0">全量</option><option value="1">增量</option></select></div>'
			+ '<div class="col-sm-1">'
			+ '<span style="display:block;padding-top:7px">'
			+ '<a style="cursor:pointer;color:blue" onclick="delete_row('
			+ n
			+ ')">删除</a>'
			+ '</span>'
			+ '</div>' + '</div>'
	
			$("#trigger_db_div").after(str);
			onchange_select(n,0);
		
    }
// 	  [{"45":1},{"52":0},{"53":1},{"56":0}]
	function update_triger(triggle_tables_src){
		if(null!=triggle_tables_src&&triggle_tables_src.length>0){
			var src =eval('('+triggle_tables_src+')');
			$.each(src,function(index,val){
				$.each(val,function(index_,val_){
					n=index;
					var str = '<div class="form-group" id="row_'+ n +'" name="trigger_div">'
						+ '<label for="disabledSelect" class="col-sm-2 control-label text-right"></label>'
						+ '<div class="col-sm-3">'
						+ '<select name="trigger_db" id="trigger_db_'+ n + '" onchange="onchange_select('+ n + ',0)" class="form-control" >'
						+ father_select
						+ '</select>'
						+ '</div>'
						+ '<div class="col-sm-3">'
						+ '<select id="trigger_table'+n+'" name="trigger_table" class="form-control">'
						+ '</select>'
						+ '</div>'
						+ '<div class="col-sm-3">'
						+'<select id="trigger_type'+n+'" name="trigger_type" class="form-control"><option value="0">全量</option><option value="1">增量</option></select></div>'
						+ '<div class="col-sm-1">'
						+'<span style="display:block;padding-top:7px">'
						+ '<a style="cursor:pointer;color:blue" onclick="delete_row('
						+ n
						+ ')">删除</a>'
						+ '</span>'
						+ '</div>' + '</div>'
						
						
					$("#trigger_db_div").after(str);
					$("#trigger_db_"+n).val(sessionStorage.getItem("db_"+index_));
					onchange_select(n,index_);
					$("#trigger_type"+n).val(val_);
// 					console.log($("#trigger_table"+n).find("option[value='"+index_+"']"));
// 					//$("#trigger_table"+n).find("option[value='"+index_+"']").prop("selected","selected");
// 					console.log(index_)
// 					console.log(n)
// 					console.log($("#trigger_table"+n).html())
					
				});
				
			});
		}
		
	}
	
	 function delete_row_export(id) {
			$("#row_export_" + id).remove()
	    }
	
    function add_export() {
    	m = m + 1
		var str = '<div class="form-group" id="row_export_'+ m +'" name="export_div">'
			+ '<label for="disabledSelect" class="col-sm-2 control-label text-right"></label>'
			+ '<div class="col-sm-3">'
			+ '<select name="export_db" id="export_db_'+ m + '" onchange="onchange_select_export('+ m + ',0)" class="form-control" >'
			+ father_select
			+ '</select>'
			+ '</div>'
			+ '<div class="col-sm-3">'
			+ '<select id="export_table_'+m+'" name="export_table" class="form-control">'
			+ '</select>'
			+ '</div>'
			+ '<div class="col-sm-4">'
			+ '<span style="display:block;padding-top:7px">'
			+ '<a style="cursor:pointer;color:blue" onclick="delete_row_export('
			+ m
			+ ')">删除</a>'
			+ '</span>'
			+ '</div>' + '</div>'
	
			$("#export_db_div").after(str);
    		onchange_select_export(m,"");
		
    }
    function update_export(export_tables_src){
		if(null!=export_tables_src&&export_tables_src.length>0){
			var src =export_tables_src.split(",");
			$.each(src,function(index,val){
				m=index;
				var srcVal =val.split(".");
				var str = '<div class="form-group" id="row_export_'+ m +'" name="export_div">'
				+ '<label for="disabledSelect" class="col-sm-2 control-label text-right"></label>'
				+ '<div class="col-sm-3">'
				+ '<select name="export_db" id="export_db_'+ m + '" onchange="onchange_select_export('+ m + ',0)" class="form-control" >'
				+ father_select
				+ '</select>'
				+ '</div>'
				+ '<div class="col-sm-3">'
				+ '<select id="export_table_'+m+'" name="export_table" class="form-control">'
				+ '</select>'
				+ '</div>'
				+ '<div class="col-sm-4">'
				+ '<span style="display:block;padding-top:7px">'
				+ '<a style="cursor:pointer;color:blue" onclick="delete_row_export('
				+ m
				+ ')">删除</a>'
				+ '</span>'
				+ '</div>' + '</div>'
				
				$("#export_db_div").after(str);
				$("#export_db_"+m).val(srcVal[0]);
				var sv =srcVal[0]+"*"+srcVal[1];
				onchange_select_export(m,sv);
			})
		}
	}

</script>

</head>
<body style='width: 99.5%'>
	<div id="content">
			<form class="form-horizontal" action="mrTask/insertSelective">
		<fieldset id="firstDiv">
		       <legend>流程类型</legend>

                      <div class="form-group">
                      		<input type='hidden' id='id' name='id' value='${task.id}'>
								<label for="disabledSelect"  class="col-sm-2 control-label text-right">流程类型：</label>
								<section class="col col-4">
				
								<div class="col-sm-10">
										<div class="checkbox-inline">
									        <label>
									            <input type="radio" name="task_type" value="sql" <c:if test='${task.task_type == "sql" }'>checked</c:if>> SQL
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="task_type" value="scala" <c:if test='${task.task_type == "scala" }'>checked</c:if>> SCALA
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="task_type" value="python" <c:if test='${task.task_type == "python" }'>checked</c:if>>PYTHON
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="task_type" value="java" <c:if test='${task.task_type == "java" }'>checked</c:if>>JAVA
									        </label>
									    </div>
									</div>
								</section>
						   </div>
						    <div class="form-group">
								<label for="disabledSelect"  class="col-sm-2 control-label text-right">流程代码：</label>
						    	<section class="col col-8">
									<label class="file">
										<input type="file" placeholder="选择文件" id="file" name="file">
										<div class="input input-file" id="file_lable">
											${task.bin_file_uri }
											<input type="hidden" placeholder="选择文件" id="bin_file_uri" name="bin_file_uri" value="${task.bin_file_uri }">
										</div>
									</label> 
								</section>
						    </div>
						 
		</fieldset>
		<fieldset id="secondDiv">
			<legend>调度类型</legend>
			 <div class="form-group">
				<label for="disabledSelect"  class="col-sm-2 control-label text-right">类型：</label>
								<section class="col col-4">
				
								<div class="col-sm-10">
										<div class="checkbox-inline">
									        <label>
									            <input type="radio" name="option_mode" value="0" <c:if test='${task.option_mode == 0 }'>checked</c:if>>手动
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="option_mode" value="1" <c:if test='${task.option_mode == 1 }'>checked</c:if>>触发
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="option_mode" value="2" <c:if test='${task.option_mode == 2 }'>checked</c:if>>定时
									        </label>
									    </div>
									</div>
			 </div>
			 <div class="form-group" id="task_schedule_div">
			 	<label for="disabledSelect"  class="col-sm-2 control-label text-right">定时运行表达式：</label>
					<div class="col-sm-6">
						<input class="form-control" type="text" placeholder="定时表达式" id="task_schedule" name="task_schedule" value="${task.task_schedule }">
                    </div>
                    <div class="col-sm-4 control-label text-left">
										<font color="red"><b>*</b></font>
									</div>
			 </div>
			 <div id="trigger_db_div" class="form-group" name="trigger_div"> 
			 	<label for="disabledSelect"  class="col-sm-2 control-label text-right">触发条件：</label>
                    <div class="col-sm-8 control-label text-left">
						<a style="cursor: pointer; color: blue" onclick="add_triger()">点击添加触发条件</a>
					</div>
			 </div>

				<div class="form-group">
					<label for="disabledSelect"  class="col-sm-2 control-label text-right">是否创建输出表：</label>
								<section class="col col-4">
				
								<div class="col-sm-10">
										<div class="checkbox-inline">
									        <label>
									            <input type="radio" name="has_derivative_table" value="0" <c:if test='${task.has_derivative_table == 0 }'>checked</c:if>>否
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="has_derivative_table" value="1" <c:if test='${task.has_derivative_table == 1 }'>checked</c:if>>是
									        </label>
									    </div>
									</div>
			 	</div>
			 	<div id="export_db_div" class="form-group" name="export_div"> 
			 		<label for="disabledSelect"  class="col-sm-2 control-label text-right">输出表：</label>
                    <div class="col-sm-8 control-label text-left">
						<a style="cursor: pointer; color: blue" onclick="add_export()">点击添加输出表</a>
					</div>
			 	</div>
               <div class="form-group">
			 	<label for="disabledSelect"  class="col-sm-2 control-label text-right">优先级：</label>
					<div class="col-sm-6">
						<input class="form-control" type="text" placeholder="优先级" id="priority" name="priority" value="${task.priority }">
                    </div>
                    <div class="col-sm-4 control-label text-left">
										<font color="red"><b>*</b></font>
									</div>
			 </div>
		</fieldset>
		<fieldset id="threeDiv">
			<legend>任务基本信息</legend>
			 <div class="form-group">
			 	<label for="disabledSelect"  class="col-sm-2 control-label text-right">任务名称：</label>
					<div class="col-sm-5">
						<input type="text" placeholder="任务名称" id="name" name="name" class="form-control" value="${task.name }">
                    </div>
                    <div class="col-sm-5 control-label text-left">
										<font color="red"><b>*</b></font>
									</div>
			 	</div>
			 	<div class="form-group">
                           <label for="disabledSelect"  class="col-sm-2 control-label text-right">描述信息：</label>
                           <div class="col-sm-8">
								<textarea class="form-control" rows="3" id="information" name="information">
									${task.information }	
								</textarea> 
                           </div>
                           <div class="col-sm-5 control-label text-left">
										<font color="red"><b></b></font>
									</div>
                </div>
               <div class="form-group">
				<label for="disabledSelect"  class="col-sm-2 control-label text-right">是否激活：</label>
								<section class="col col-4">
				
								<div class="col-sm-10">
										<div class="checkbox-inline">
									        <label>
									            <input type="radio" name="active" value="0"  <c:if test='${task.active == false }'>checked</c:if> >否
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="active" value="1"  <c:if test='${task.active == true }'>checked</c:if> >是
									        </label>
									    </div>
									</div>
			 </div>
			 <select id="testSe">
			 	 <option value="1" >1</option>
			 	 <option value="2" >2</option>
			 	 <option value="3" >3</option>
			 </select>
			 <div class="text-center">
				<button type="button" class="btn btn-default" onclick=""  >上一步</button>
				<button type="button" class="btn btn-primary" onclick="subimtForm()">提交</button>
			</div>
		</fieldset>
    </form>
	</div>
</body>
</html>