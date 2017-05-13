<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加任务</title>
</head>
<script>
    var n = 0
    var m=0
    var father_select
    var son_select
    var father_select_export
    var son_select_export
    
    var task_type
    var bin_file_uri 
    var priority
    var export_tables
    var option_mode
    var triggle_tables
    var task_schedule
    var has_derivative_table
    
    
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
		var create_userid = $("#create_userid").val();
		
		shield();
		$.post("mrTask/insertSelective",{
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
			create_userid: create_userid
	    },function(result){
			if (result == "error") {
			    layer.msg('添加失败！', {
				  icon: 2
				}) 
			}else{
			    layer.msg('添加成功！', {
				  icon: 1
				})
			}
			cancel_shield();
			$("#content_").load('mrTask/index');
	    });
		
    }

    function delete_row(id) {
		$("#row_" + id).remove()
		n = n - 1
    }
    function delete_row_export(id) {
		$("#row_export_" + id).remove()
		m = m - 1
    }

    function add_triger() {
	
		if (n == 10) {
	    	layer.msg('您添加的表太多啦！', {icon : 5});
		    return;
		}

		var str = '<div class="form-group" id="row_'+ n +'" name="trigger_div">'
			+ '<label for="disabledSelect" class="col-sm-2 control-label text-right"></label>'
			+ '<div class="col-sm-3">'
			+ '<select name="trigger_db" id="trigger_db_'+ n + '" onchange="onchange_select('+ n + ')" class="form-control" >'
			+ father_select
			+ '</select>'
			+ '</div>'
			+ '<div class="col-sm-3">'
			+ '<select id="trigger_table_'+n+'" name="trigger_table" class="form-control">'
			+ son_select
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
	
		n = n + 1
    }
    function add_export() {
	
		if (m == 10) {
	    	layer.msg('您添加的表太多啦！', {icon : 5});
		    return;
		}

		var str = '<div class="form-group" id="row_export_'+ m +'" name="export_div">'
			+ '<label for="disabledSelect" class="col-sm-2 control-label text-right"></label>'
			+ '<div class="col-sm-3">'
			+ '<select name="export_db" id="export_db_'+ m + '" onchange="onchange_export_select('+ m + ')" class="form-control" >'
			+ father_select_export
			+ '</select>'
			+ '</div>'
			+ '<div class="col-sm-3">'
			+ '<select id="export_table_'+m+'" name="export_table" class="form-control">'
			+ son_select_export
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
	
		m = m + 1
    }

    $(function() {
    	$("#secondDiv").hide();
    	$("#threeDiv").hide();
		$("#task_schedule_div").hide();
		$("div[name='trigger_div']").hide();
		$("div[name='export_div']").hide();
		get_first_select()
		get_first_export_select()

		father_select = $("#trigger_db_999").html()
		father_select_export = $("#export_db_999").html()
		
		$("#file").fileupload({
		    url: '${root}' + "/mrTask/upload",
		    done:function(e,result){
				var file_name = result.result
		        $("#file_lable").html("<input type='hidden' name='bin_file_uri' id='bin_file_uri' value='" + file_name + "' />" + file_name)
		    }
		})
		
		$("input[name='option_mode']").bind('change',function(){
			var val =this.value
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
		});
		
		$("input[name='has_derivative_table']").bind('change',function(){
			var val = this.value
			if(val==0){
				$("div[name='export_div']").hide();
			}else if(val==1){
				$("div[name='export_div']").show();
			}
		});

    })

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
				    var table_name = result[i].table_name
				    str += '<option value="'+tb_id+'">' + table_name + '</option>'
				}
				$("#trigger_table_" + id).html(str)
		    }
		})
    }
    function onchange_export_select(id) {
		var val = $("#export_db_" + id).val()
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
				    var table_name = result[i].table_name
				    var dbname =result[i].dbname
				    str += '<option value="'+id+'*'+dbname+'*'+table_name+'">' + table_name + '</option>'
				}
				$("#export_table_" + id).html(str)
		    }
		})
    }

    function get_first_select() {

		var val = $("#trigger_db_999").val()
		
		$.ajax({
		    url : '${root}' + '/mrTask/getTableByDB',
		    type : 'post',
		    data : {
				dbname : val
		    },
		    success : function(result) {
				var str = ""
				for ( var i in result) {
				    var id = result[i].id
				    var table_name = result[i].table_name
				    str += '<option value="'+id+'">'+table_name+'</option>'
				}
				$("#trigger_table_999").html(str)
				son_select = str
			}
		})
    }
    function get_first_export_select() {

		var val = $("#export_db_999").val()
		
		$.ajax({
		    url : '${root}' + '/mrTask/getTableByDB',
		    type : 'post',
		    data : {
				dbname : val
		    },
		    success : function(result) {
				var str = ""
				for ( var i in result) {
				    var id = result[i].id
				    var table_name = result[i].table_name
				    var dbname =result[i].dbname
				    str += '<option value="'+id+'*'+dbname+'*'+table_name+'">'+table_name+'</option>'
				}
				$("#export_table_999").html(str)
				son_select_export = str
			}
		})
    }
    
//     function doNextPage(pageId){
//     	$("form.form-horizontal fieldset").hide();
//     	$("#"+pageId).show();
//     }
    function dofirstPage(){
    	task_type =$("input[name='task_type']:checked").val();
	 bin_file_uri = $("#bin_file_uri").val()
		
		if (null == bin_file_uri){
		    layer.msg("您还没上传需要执行的文件！")
		    return
		}
    	$("#firstDiv").hide();
    	$("#secondDiv").show();
    	$("#threeDiv").hide();
    }
    function dosecondupPage(){
    	
    	$("#threeDiv").hide();
    	$("#firstDiv").show();
    	$("#secondDiv").hide();
    }
    function doseconddownPage(){
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
     		var arry_vo = new Array() 
     		for(var i=0;i<export_table_arry.length;i++){
     			var res = $(export_table_arry[i]).val();
    			var msgs =res.split("*");
//     			arry_vo.push('{"id":'+ msgs[0] +',"dbname":"'+msgs[1]+'","table_name":"'+msgs[2]+'"}')
     		    arry.push(msgs[1]+"."+msgs[2])
     		}
     		export_tables = arry.join(",")
    	}else if(has_derivative_table==0){
    		export_tables="";
    	}
 		
    	
    	$("#firstDiv").hide();
    	$("#threeDiv").show();
    	$("#secondDiv").hide();
    }
    function dothreePage(){
    	$("#firstDiv").hide();
    	$("#secondDiv").show();
    	$("#threeDiv").hide();
    }
    
</script>
<body style='width: 99.5%'>
		<div id="ribbon">
			<ol class="breadcrumb">
				<li>首页</li>
				<li>流程管理</li>
				<li>流程注册</li>
			</ol>
		</div>
	
	<div id="content">
		
	
	<form class="form-horizontal" action="mrTask/insertSelective">
	<fieldset id="firstDiv">
		       <legend>流程类型</legend>
		       		<input type="hidden" name="create_userid" id="create_userid" value="${sessionScope.user.id }">
                      <div class="form-group">
								<label for="disabledSelect"  class="col-sm-2 control-label text-right">流程类型：</label>
								<section class="col col-4">
				
								<div class="col-sm-10">
										<div class="checkbox-inline">
									        <label>
									            <input type="radio" name="task_type" value="sql" checked> SQL
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="task_type" value="scala"> SCALA
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="task_type" value="python">PYTHON
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="task_type" value="java">JAVA
									        </label>
									    </div>
									</div>
								</section>
						   </div>
						    <div class="form-group">
								<label for="disabledSelect"  class="col-sm-2 control-label text-right">流程代码：</label>
						    	<section class="col col-8">
									<label class="file" id="file_lable">
										<input type="file" name="file" id="file"  />
									</label>
								</section>
						    </div>
						    <div class="text-center">
							<button type="button" class="btn btn-default" onclick="dofirstPage()"  >下一步</button>
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
									            <input type="radio" name="option_mode" value="0" checked>手动
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="option_mode" value="1">触发
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="option_mode" value="2">定时
									        </label>
									    </div>
									</div>
			 </div>
			 <div class="form-group" id="task_schedule_div">
			 	<label for="disabledSelect"  class="col-sm-2 control-label text-right">定时运行表达式：</label>
					<div class="col-sm-6">
						<input class="form-control" type="text" placeholder="定时表达式" id="task_schedule" name="task_schedule">
                    </div>
                    <div class="col-sm-4 control-label text-left">
										<font color="red"><b>*</b></font>
									</div>
			 </div>
			  <div class="form-group" id="trigger_db_div" name="trigger_div">
							<label for="disabledSelect"  class="col-sm-2 control-label text-right">触发条件：</label>
							<div class="col-sm-3">
                             	<select id="trigger_db_999" name="trigger_db" onchange="onchange_select(999)" class="form-control">
										<c:forEach var="i" items="${srcdbs}">
											<option value="${i}">${i }</option>
										</c:forEach>
									</select>
                           </div>
							<div class="col-sm-3">
                             	<select id="trigger_table_999" name="trigger_table" class="form-control"> 

								</select>
                           </div>
							<div class="col-sm-3">
                             	<select name="trigger_type" class="form-control">
									<option value="0">全量</option>
									<option value="1">增量</option>
								</select>
                           </div>
							<div class="col-sm-1">
                             	<span style="display: block; padding-top: 7px">
									<a style="cursor: pointer; color: blue" onclick="add_triger()">添加</a>
								</span> 
                           </div>
               </div>
               

				<div class="form-group">
				<label for="disabledSelect"  class="col-sm-2 control-label text-right">是否创建输出：</label>
								<section class="col col-4">
				
								<div class="col-sm-10">
										<div class="checkbox-inline">
									        <label>
									            <input type="radio" name="has_derivative_table" value="0" checked>否
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="has_derivative_table" value="1">是
									        </label>
									    </div>
									</div>
			 	</div>
               <div class="form-group" id="export_db_div" name="export_div">
							<label for="disabledSelect"  class="col-sm-2 control-label text-right">输出表：</label>
							<div class="col-sm-3">
                             	<select id="export_db_999" name="export_db" onchange="onchange_export_select(999)" class="form-control">
										<c:forEach var="i" items="${srcdbs}">
											<option value="${i}">${i }</option>
										</c:forEach>
									</select>
                           </div>
							<div class="col-sm-3">
                             	<select id="export_table_999" name="export_table" class="form-control"> 

								</select>
                           </div>
							<div class="col-sm-4">
                             	<span style="display: block; padding-top: 7px">
									<a style="cursor: pointer; color: blue" onclick="add_export()">添加</a>
								</span> 
                           </div>
               </div>
               <div class="form-group">
			 	<label for="disabledSelect"  class="col-sm-2 control-label text-right">优先级：</label>
					<div class="col-sm-6">
						<input class="form-control" type="text" placeholder="优先级" id="priority" name="priority">
                    </div>
                    <div class="col-sm-4 control-label text-left">
										<font color="red"><b>*</b></font>
									</div>
			 </div>
			 <div class="text-center">
				<button type="button" class="btn btn-default" onclick="dosecondupPage()"  >上一步</button>
				<button type="button" class="btn btn-default" onclick="doseconddownPage()"  >下一步</button>
			</div>
		</fieldset>
		<fieldset id="threeDiv">
			<legend>任务基本信息</legend>
			 <div class="form-group">
			 	<label for="disabledSelect"  class="col-sm-2 control-label text-right">任务名称：</label>
					<div class="col-sm-5">
						<input type="text" placeholder="任务名称" id="name" name="name" class="form-control">
                    </div>
                    <div class="col-sm-5 control-label text-left">
										<font color="red"><b>*</b></font>
									</div>
			 	</div>
			 	<div class="form-group">
                           <label for="disabledSelect"  class="col-sm-2 control-label text-right">描述信息：</label>
                           <div class="col-sm-8">
								<textarea class="form-control" rows="3" id="information" name="information"></textarea> 
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
									            <input type="radio" name="active" value="0" checked>否
									        </label>
									    </div>
									    <div class="checkbox-inline">
									        <label>
									            <input type="radio" name="active" value="1">是
									        </label>
									    </div>
									</div>
			 </div>
			 <div class="text-center">
				<button type="button" class="btn btn-default" onclick="dothreePage('secondDiv')"  >上一步</button>
				<button type="button" class="btn btn-primary" onclick="subimtForm()">提交</button>
			</div>
		</fieldset>
    </form>
    </div>
</body>
</html>