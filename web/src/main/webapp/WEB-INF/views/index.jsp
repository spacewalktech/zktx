<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">

	function perSubmit(){
		 document.getElementById("perForm").submit();
	}
	function perinsert(){
		document.getElementById("perinsert").submit();
	}
	function perupdate(){
		document.getElementById("perupdate").submit();
	}
	function perdelete(){
		document.getElementById("perdelete").submit();
	}
	function mrTaskquery(){
		document.getElementById("mrTaskquery").submit();
	}
	function mrTaskfindTaskToRun(){
		document.getElementById("mrTaskfindTaskToRun").submit();
	}
	function queryStageOri(){
		document.getElementById("queryStageOri").submit();
	}
	function tableSchemaquery(){
		document.getElementById("tableSchemaquery").submit();
	}
</script>
</head>

<body>这是首页
	<form action="importTables/query.do" id="perForm">
		导入表查询：<input id="Submit" type="button"  value="导入表查询" onclick="perSubmit()"/>
	</form>
	<form action="importTables/insert.do" id="perinsert">
		导入表：<input id="insert" type="button"  value="导入表/插入" onclick="perinsert()"/>
	</form>
	<form action="importTables/update.do" id="perupdate">
		导入表：<input id="update" type="button"  value="导入表更新" onclick="perupdate()"/>
	</form>
	------
	<form action="importTables/delete.do" id="perdelete">
		<input id="id" name="id" value="3">
		导入表：<input id="delete" type="button"  value="导入表更新" onclick="perdelete()"/>
	</form>
	
	--------------------------------------------------
	<form action="mrTask/query.do" id="mrTaskquery">
		导入表：<input id="mrTaskquery1" type="button"  value="派生表查询" onclick="mrTaskquery()"/>
	</form>
	<form action="mrTask/findTaskToRun.do" id="mrTaskfindTaskToRun">
		导入表：<input id="mrTaskfindTaskToRun1" type="button"  value="未处理任务" onclick="mrTaskfindTaskToRun()"/>
	</form>
	--------------------------------------------------
	<form action="stage/queryStageOri.do" id="queryStageOri">
		导入表：<input id="queryStageOri1" type="button"  value="派导入预警" onclick="queryStageOri()"/>
	</form>
	
	-----------------------------------------------------
	<form action="tableSchema/query.do" id="tableSchemaquery">
		导入表：<input id="tableSchemaquery1" type="button"  value="schema" onclick="tableSchemaquery()"/>
	</form>
</body>
</html>