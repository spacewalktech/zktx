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
	function deleteByid(){
		document.getElementById("deleteByid").submit();
	}
	function mrTaskupdate(){
		document.getElementById("mrTaskupdate").submit();
	}
	function mrTaskinsertSelective(){
		document.getElementById("mrTaskinsertSelective").submit();
	}
	function mrTaskfindByProper(){
		document.getElementById("mrTaskfindByProper").submit();
	}
	function mrTasktaskAction(){
		document.getElementById("mrTasktaskAction").submit();
	}
</script>
</head>

<body>这是首页
	<form action="importTables/query.do" id="perForm">
		导入表查询：：<input id="Submit" type="button"  value="导入表查询" onclick="perSubmit()"/>
	</form>
	<form action="importTables/insert.do" id="perinsert">
		导入表插入：<input id="insert" type="button"  value="导入表/插入" onclick="perinsert()"/>
	</form>
	<form action="importTables/update.do" id="perupdate">
		导入表更新：<input id="update" type="button"  value="导入表更新" onclick="perupdate()"/>
	</form>
	------
	<form action="importTables/delete.do" id="perdelete">
		<input id="id" name="id" value="3">
		导入表删除：<input id="delete" type="button"  value="导入表删除" onclick="perdelete()"/>
	</form>
	
	--------------------------------------------------
	<form action="mrTask/query.do" id="mrTaskquery">
		任务列表查询：<input id="mrTaskquery1" type="button"  value="任务列表查询" onclick="mrTaskquery()"/>
	</form>
	<form action="mrTask/deleteByid.do" id="deleteByid">
		<input id="id3" name="id" value="3">
		任务列表查询：<input id="deleteByid1" type="button"  value="任务删除" onclick="deleteByid()"/>
	</form>
	<form action="mrTask/update.do" id="mrTaskupdate">
		任务列更新：<input id="mrTaskupdate1" type="button"  value="任务更新" onclick="mrTaskupdate()"/>
	</form>
	<form action="mrTask/insertSelective.do" id="mrTaskinsertSelective">
		任务列插入：<input id="insertSelective" type="button"  value="任务插入" onclick="mrTaskinsertSelective()"/>
	</form>
	<form action="mrTask/findTaskToRun.do" id="mrTaskfindTaskToRun">
		待运行任务列表：<input id="mrTaskfindTaskToRun1" type="button"  value="待运行任务列表" onclick="mrTaskfindTaskToRun()"/>
	</form>
	<form action="mrTask/findByProper.do" id="mrTaskfindByProper">
		任务预警：<input id="mrTaskfindByProper2" type="button"  value="任务预警" onclick="mrTaskfindByProper()"/>
	</form>
	<form action="mrTask/taskAction.do" id="mrTasktaskAction">
		<input id="id1" name="id" value="3">
		任务预警：<input id="mrTasktaskAction1" type="button"  value="任务激活" onclick="mrTasktaskAction()"/>
	</form>
	
	--------------------------------------------------
	<form action="stage/queryStageOri.do" id="queryStageOri">
		导入表预警：<input id="queryStageOri1" type="button"  value="导入表预警" onclick="queryStageOri()"/>
	</form>
	
	-----------------------------------------------------
	<form action="tableSchema/query.do" id="tableSchemaquery">
		导入表：<input id="tableSchemaquery1" type="button"  value="schema" onclick="tableSchemaquery()"/>
	</form>
</body>
</html>