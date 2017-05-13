<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加任务</title>
<%@ include file="../header.jsp"%>
<script type="text/javascript">
	function doValite(){
		var nameVal=$("#name").val();
		var snVal = $("#sn").val();
		var urlVal = $("#url").val();
		var idVal = $("#id").val();
		if(nameVal==null||nameVal.length==0){
			layer.msg("菜单名称不能为空！")
			return;
		}
		if(snVal==null||snVal.length==0){
			layer.msg("模块标识不能为空！")
			return;
		}
		if(urlVal==null||urlVal.length==0){
			layer.msg("菜单url不能为空！")
			return;
		}
		$.post("queryCountbySn",{sn:snVal,id:idVal},function(msg){
			if(msg>0){
				layer.msg("模块标识["+snVal+"]已存在，请重新输入！")
			}else{
				doSubmit();
			}
		})
	} 
	function doSubmit(){
		$.post("updateModule",$("#smartForm").serialize(),function(result){
			if (result == "error") {
			    layer.msg('修改失败！', {
				  icon: 2
				}) 
			}else{
			    layer.msg('修改成功！', {
				  icon: 1
				},function(){
					var index = parent.layer.getFrameIndex(window.name);
					parent.$('#task_list').bootstrapTable('refresh',{url:'module/queryListBypId?pid='+$("#parent_id").val()});
					parent.moduleTree();
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
				<input id="parent_id" name="parent_id" type="text" value="${module.parent_id }">
				<input id="id" name="id" type="text" value="${module.id }">
				<section class="col col-2 text-right">
					<label class="text">名称</label>
				</section>
				<section class="col col-4"> 
					<label class="input"><input type="text" placeholder="菜单名称" id="name" name="name" value="${module.name }">
					</label>
				</section>
				
				
				<section class="col col-2 text-right">
					<label class="text">模块标识</label>
				</section>
				<section class="col col-4">
					<label class="input"><input type="text" placeholder="模块标识" id="sn" name="sn" value="${module.sn }">
					</label>
				</section>
				
			</div>
			
			<div class="row">
					
					<section class="col col-2 text-right">
						<label class="text">url</label>
					</section>
					<section class="col col-4"> 
						<label class="input"><input type="text" placeholder="url" id="url" name="url" value="${module.url }">
						</label>
					</section>
					
					
					<section class="col col-2 text-right">
						<label class="text">描述信息</label>
					</section>
					<section class="col col-4">
						<label class="input"><input type="text" placeholder="描述信息" id="description" name="description" value="${module.description }">
						</label>
					</section>
					
			</div>
		</fieldset>
		<footer>
		<button type="button" class="btn btn-primary" onclick="doValite()">确定</button>
		<button type="reset" class="btn btn-default">重置</button>
		</footer>
	</form>
	</center>
</body>
</html>