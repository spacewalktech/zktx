<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加任务</title>
<%@ include file="../header.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
		var flag =${bloBs.export_to_es_index_warehouse};
		$("#index_div").css('display',(flag?'block':'none'));
		$("[name='export_to_es_index_warehouse']").bind('change',function(){
			var val =this.value;
			changeDiv(val);
		});
	});
	function changeDiv(val){
		
		$("#index_div").css('display',(val==0?'none':'block'));
	}
	function doSubmit(){
		var src_keys =$("#src_keys").val();
		if(null == src_keys || src_keys.length == 0){
		    layer.msg("源表的unique键不能为空！")
		    return
		}
		var  src_db_version =$("#src_db_version").val();
		if(null == src_db_version || src_db_version.length == 0){
		    layer.msg("源库版本不能为空！")
		    return
		}
		var v =$("input[name='export_to_es_index_warehouse']:checked").val();
		var es_index_schema =$("#es_index_schema").val();
		if(v==1&&(null==es_index_schema||es_index_schema.length==0)){
			layer.msg("es索引设置json格式不能为空！")
		    return
		}
		var data ={id:$("#id").val(),table_name:$("#table_name").val(),dbname:$("#dbname").val()};
		$.post("queryCountTable",data,function(msg){
			if(msg>0){
				layer.msg("表名重复，请重新输入", {
					  icon: 2
					}) 
			}else if(msg<0){
				layer.msg('表名或库名不能为空', {
					  icon: 2
					}) 
			}else{
				doSubmit_ready();
			}
		});
	}
	function doSubmit_ready(){
		$.post("update",$("#smartForm").serialize(),function(result){
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
		});
		
	}
</script>
</head>
<body style='width: 99.5%'>
	<form class="smart-form" id="smartForm">
		<input id="id" name="id" type="hidden" value="${bloBs.id }">
		<fieldset>
			<div class="row">
				<section class="col col-2 text-right">
					<label class="text">源库</label>
				</section>
				<section class="col col-4"> 
					<label class="input">
						<input type="text" list="list_src_db"  id="src_db" name="src_db" value="${bloBs.src_db }"/> 
						<datalist id="list_src_db">
							<c:forEach var="i" items="${src_dbList}">
								<option value="${i}">${i }</option>
							</c:forEach>
						</datalist>
						<i></i>
					</label>
				</section>
				
				<section class="col col-2 text-right">
					<label class="text">源表</label>
				</section>
				<section class="col col-4"> 
					<label class="input"><input type="text" placeholder="表名" id="src_table" name="src_table" value="${bloBs.src_table }">
					</label>
				</section>
				
				<section class="col col-2 text-right">
					<label class="text">库名</label>
				</section>
				<section class="col col-4">
					<label class="input">
						<input type="text" list="list_dbname"  id="dbname" name="dbname" value="${bloBs.dbname }"/> 
						<datalist id="list_dbname">
							<c:forEach var="i" items="${dbList}">
								<option value="${i}">${i }</option>
							</c:forEach>
						</datalist>
						<i></i>
					</label>
				</section>
				
				<section class="col col-2 text-right">
				<label class="text">表名</label></section>
				<section class="col col-4">
				<label class="input"><input type="text" placeholder="表名" id="table_name" name="table_name" value="${bloBs.table_name }"/></label>
				</section>
				
				<section class="col col-2 text-right">
				<label class="text">源库类型</label></section>
				<section class="col col-4"> 
					<label class="select">
						<select id="src_db_type" name="src_db_type">
							<option value="Oracle" selected="${bloBs.src_db_type==Oracle}">Oracle</option>
							<option value="Spark SQL" selected="${bloBs.src_db_type=='Spark SQL'}">Spark SQL</option>
							<option value="DB2" selected="${bloBs.src_db_type==DB2}">DB2</option>
							<option value="Sybase" selected="${bloBs.src_db_type==Sybase}">Sybase</option>
							<option value="Hive" selected="${bloBs.src_db_type==Hive}">Hive</option>
							<option value="SQL Server" selected="${bloBs.src_db_type=='SQL Server'}">SQL Server</option>
							<option value="Informix" selected="${bloBs.src_db_type==Informix}">Informix</option>
							<option value="MySQL" selected="${bloBs.src_db_type==MySQL}">MySQL</option>
						</select> 
					</label> 
				</section>
				<section class="col col-2 text-right">
				<label class="text">源表的unique键</label></section>
				<section class="col col-4">
				<label class="input"><input type="text" placeholder="源表的unique键，可能多个   key1;key2;" id="src_keys" name="src_keys" value="${bloBs.src_keys }"></label></section>
			
			</div>
			<div class="row">
				<section class="col col-2 text-right">
				<label class="text">源库版本</label></section>
				<section class="col col-4">
				<label class="input"><input type="text" placeholder="源库版本"	id="src_db_version" name="src_db_version" value="${bloBs.src_db_version }"></label></section>
				
				<section class="col col-2 text-right">
				<label class="text">是否同步到数据仓库</label></section>
				<section class="col col-4">
					<div class="inline-group">
						<label class="radio">
							<input type="radio" name="export_to_sql_warehouse" value="0" <c:if test='${bloBs.export_to_sql_warehouse == false }'>checked</c:if> >
							<i></i>
							不同步
						</label>
						<label class="radio">
							<input type="radio" name="export_to_sql_warehouse" value="1" <c:if test='${bloBs.export_to_sql_warehouse == true }'>checked</c:if> >
							<i></i>
							同步
						</label>
					</div>
				</section>
			</div>
			<div class="row">
				<section class="col col-2 text-right">
				<label class="text">是否同步到ES索引</label></section>
				<section class="col col-4">
					<div class="inline-group">
						<label class="radio">
							<input type="radio" name="export_to_es_index_warehouse" value="0" <c:if test='${bloBs.export_to_es_index_warehouse == false }'>checked</c:if>>
							<i></i>
							不同步
						</label>
						<label class="radio">
							<input type="radio" name="export_to_es_index_warehouse" value="1" <c:if test='${bloBs.export_to_es_index_warehouse == true }'>checked</c:if> >
							<i></i>
							同步
						</label>
					</div>
				</section>
				<section class="col col-2 text-right">
				<label class="text">是否激活</label></section>
				<section class="col col-4">
				
				<div class="inline-group">
						<label class="radio">
							<input type="radio" name="active" value="0" <c:if test='${bloBs.active == false }'>checked</c:if> >
							<i></i>
							是
						</label>
						<label class="radio">
							<input type="radio" name="active" value="1" <c:if test='${bloBs.active == true }'>checked</c:if> >
							<i></i>
							否
						</label>
					</div>
				</section>
			</div>
			<div class="row">
				<div id="index_div">
					<section class="col col-2 text-right">
				<label class="text">es索引设置json格式</label></section>
				<section class="col col-10">
				<label class="input"><input type="text" placeholder="es索引设置json格式" id="es_index_schema" name="es_index_schema" value="${bloBs.es_index_schema }"></label></section>
			
				</div>
			</div>
		</fieldset>
		<footer>
		<button type="button" class="btn btn-primary" onclick="doSubmit()">确定</button>
		<button type="reset" class="btn btn-default">重置</button>
		</footer>
	</form>
	<script type="text/javascript">
	
	</script>
	
</body>
</html>