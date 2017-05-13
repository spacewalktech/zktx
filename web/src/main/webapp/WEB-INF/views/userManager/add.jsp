<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加任务</title>
<%@ include file="../header.jsp"%>
<script type="text/javascript">
	
	function doSubmit(){
		$.post("add.do",$("#smartForm").serialize(),function(result){
			if (result == "error") {
			    layer.msg('添加失败！', {
				  icon: 2
				}) 
			}else{
			    layer.msg('添加成功！', {
				  icon: 1
				},function(){
					var index = parent.layer.getFrameIndex(window.name);
					parent.$('#task_list').bootstrapTable('refresh');
					parent.layer.close(index);
				})
			}
		});
	}
	
</script>
</head>
<body style='width: 99.5%'>

	<form class="smart-form" id="smartForm">
		<fieldset>
			<div class="row">
				
				<section class="col col-2 text-right">
					<label class="text">用户名</label>
				</section>
				<section class="col col-4"> 
					<label class="input"><input type="text" placeholder="用户名" id="name" name="name">
					</label>
				</section>
				
				
				<section class="col col-2 text-right">
					<label class="text">密码</label>
				</section>
				<section class="col col-4">
					<label class="input"><input type="text" placeholder="密码" id="pwd" name="pwd">
					</label>
				</section>
				
			</div>
			
		
		</fieldset>
		<footer>
		<button type="button" class="btn btn-primary" onclick="doSubmit()">确定</button>
		<button type="reset" class="btn btn-default">重置</button>
		</footer>
	</form>
	</center>
</body>
</html>