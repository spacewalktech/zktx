<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加任务</title>
<%@ include file="../header.jsp"%>

<script type="text/javascript">
	function doSubmit(){
		$.post("update.do",$("#smartForm").serialize(),function(result){
			if (result == "error") {
			    layer.msg('添加失败！', {
				  icon: 2
				}) 
			}else{
			    layer.msg('添加成功！', {
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
				<section class="col col-1 text-right">
					<label class="text">源库</label>
				</section>
				<section class="col col-5"> 
					<label class="input">
						<input type="text" list="list" id="src_db" name="src_db" value="${bloBs.src_db }"/> 
						<datalist id="list">
						<option value="Alexandra">库名一</option>
						<option value="Alice">库名二</option>
						<option value="Anastasia">库名三</option>
						</datalist>
					</label> 
				</section>

				<section class="col col-1 text-right">
				<label class="text">库名</label></section>
				<section class="col col-5">
				<label class="input"><input type="text" placeholder="库名" id="dbname" name="dbname" value="${bloBs.dbname }"></label></section>
				<section class="col col-1 text-right">
				<label class="text">源表</label></section>
				<section class="col col-5"> <label class="input">
					<input type="text" list="list" id="src_table" name="src_table" value="${bloBs.src_table }"/> 
					<datalist id="list">
						<option value="Alexandra">库名一</option>
						<option value="Alice">库名二</option>
						<option value="Anastasia">库名三</option>

					</datalist>
				</label> </section>
				<section class="col col-1 text-right">
				<label class="text">表名</label></section>
				<section class="col col-5">
				<label class="input"><input type="text" placeholder="表名" id="table_name" name="table_name" value="${bloBs.table_name }"/></label></section>
				<section class="col col-1 text-right">
				<label class="text">源库类型</label></section>
				<section class="col col-5"> 
					<label class="select">
						<select id="src_db_type" name="src_db_type">
							<option value="Oracle" selected="${bloBs.src_db_type==Oracle}">Oracle</option>
							<option value="DB2" selected="${bloBs.src_db_type==DB2}">DB2</option>
							<option value="Sybase" selected="${bloBs.src_db_type==Sybase}">Sybase</option>
							<option value="SQL" selected="${bloBs.src_db_type==SQL}">SQL</option>
							<option value="Server" selected="${bloBs.src_db_type==Server}">Server</option>
							<option value="Informax" selected="${bloBs.src_db_type==Informax}">Informax</option>
							<option value="MySQL" selected="${bloBs.src_db_type==MySQL}">MySQL</option>
						</select> 
					</label> 
				</section>
				<section class="col col-1 text-right">
				<label class="text">是否激活</label></section>
				<section class="col col-5">
					
				<div class="inline-group">
					<label class="radio"> <input type="radio" name="active"  checked="${bloBs.active==false?"'checked'":''}"/> 
						<i></i>激活
					</label> 
					<label class="radio"> <input type="radio" name="active" checked="${bloBs.active==true?"'checked'":''}"/>
						<i></i>不激活
					</label>
				</div>
				</section>
			</div>
			<div class="row">
				<section class="col col-1 text-right">
				<label class="text">源库版本</label></section>
				<section class="col col-5">
				<label class="input"><input type="text" placeholder="源库版本"	id="src_db_version" name="src_db_version" value="${bloBs.src_db_version }"></label></section>

			</div>
		</fieldset>
		<footer>
		<button type="button" class="btn btn-primary" onclick="doSubmit()">确定</button>
		<button type="reset" class="btn btn-default">重置</button>
		</footer>
	</form>
</body>
</html>