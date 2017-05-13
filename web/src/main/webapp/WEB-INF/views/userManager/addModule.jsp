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
		$.post("queryCountbySn",{sn:snVal},function(msg){
			if(msg>0){
				layer.msg("模块标识["+snVal+"]已存在，请重新输入！")
			}else{
				doSubmit();
			}
		})
	} 
	 
	function doSubmit(){
		$.post("addModule",$("#smartForm").serialize(),function(result){
			if (result == "error") {
			    layer.msg('添加失败！', {
				  icon: 2
				}) 
			}else{
			    layer.msg('添加成功！', {
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
	function addPermissions(){
		var maxId =0;
		var $divRow = $("#divRow");
		var $newPermissonInput = $("#newPermissonInput");
		maxId =parseInt($("input:last",$divRow).attr("rel"))+1;
		var _name =$("input[name='_name']",$newPermissonInput).val();
		var _sn =$("input[name='_sn']",$newPermissonInput).val();
		var _description =$("input[name='_description']",$newPermissonInput).val();
		
		if(_name==null||_name.length==0){
			layer.msg("菜单名称不能为空！")
			return;
		}
		if(_sn==null||_sn.length==0){
			layer.msg("模块标识不能为空！")
			return;
		}
		
		var substr = new StringBuffer();
		substr.append('<section class="col"><label class="checkbox"><input type="checkbox" name="permissions['+maxId+'].sn" value="'+_sn+'" checked="checked" rel="'+maxId+'">'+_name+'('+_sn+')<input type="hidden" name="permissions['+maxId+'].name" value="'+_name+'" rel="'+maxId+'"/><i></i></label></section>');
		$divRow.append(substr.toString());
	}
</script>
</head>
<body style='width: 99.5%'>

	<form class="smart-form" id="smartForm">
		<fieldset>
			<div class="row">
				<input id="parent_id" name="parent_id" type="hidden" value="${parent_id }">
				<input id="grade" name="grade" type="hidden" value="${grade }">
				<section class="col col-2 text-right">
					<label class="text">名称</label>
				</section>
				<section class="col col-4"> 
					<label class="input"><input type="text" placeholder="菜单名称" id="name" name="name">
					</label>
				</section>
				
				
				<section class="col col-2 text-right">
					<label class="text">模块标识</label>
				</section>
				<section class="col col-4">
					<label class="input"><input type="text" placeholder="模块标识" id="sn" name="sn">
					</label>
				</section>
				
			</div>
			
			<div class="row">
					
					<section class="col col-2 text-right">
						<label class="text">url</label>
					</section>
					<section class="col col-4"> 
						<label class="input"><input type="text" placeholder="url" id="url" name="url">
						</label>
					</section>
					
					
					<section class="col col-2 text-right">
						<label class="text">描述信息</label>
					</section>
					<section class="col col-4">
						<label class="input"><input type="text" placeholder="描述信息" id="description" name="description">
						</label>
					</section>
					
			</div>
			
		</fieldset>
			<legend>自定义授权</legend>
		<fieldset>
			<div class="row" id="divRow">
				<section class="col">
					<label class="checkbox">
						<input type="checkbox" name="permissions[0].sn" value="show" checked="checked" rel="0">看(show)
						<input type="hidden" name="permissions[0].name" value="看" rel="0"/>	
						<i></i>
					</label>
				</section>
				<section class="col">
					<label class="checkbox">
						<input type="checkbox" name="permissions[1].sn" value="save" checked="checked" rel="1">增(save)
						<input type="hidden" name="permissions[1].name" value="增" rel="1"/>	
						<i></i>
					</label>
				</section>
				<section class="col">
					<label class="checkbox">
						<input type="checkbox" name="permissions[2].sn" value="delete" checked="checked" rel="2">删(delete)
						<input type="hidden" name="permissions[2].name" value="删" rel="2"/>	
						<i></i>
					</label>
				</section>
				<section class="col">
					<label class="checkbox">
						<input type="checkbox" name="permissions[3].sn" value="view" checked="checked" rel="3">看(view)
						<input type="hidden" name="permissions[3].name" value="查" rel="3"/>	
						<i></i>
					</label>
				</section>
				<section class="col">
					<label class="checkbox">
						<input type="checkbox" name="permissions[4].sn" value="edit" checked="checked" rel="4">改(edit)
						<input type="hidden" name="permissions[4].name" value="改" rel="4"/>	
						<i></i>
					</label>
				</section>
			</div>
		</fieldset>
		<legend>动态新增</legend>
		<fieldset id="newPermissonInput">
			<div class="row">
					
					<section class="col col-1 text-right">
						<label class="text">名称：</label>
					</section>
					<section class="col col-2"> 
						<label class="input"><input type="text" name="_name" class="input-medium validate[required,maxSize[64]] required" maxlength="64"/>
						</label>
					</section>
					
					
					<section class="col col-1 text-right">
						<label class="text">标识：</label>
					</section>
					<section class="col col-2">
						<label class="input"><input type="text" name="_sn" class="input-medium validate[required,maxSize[32]] required" maxlength="32"/>
						</label>
					</section>
					
					<section class="col col-1 text-right">
						<label class="text">描述：</label>
					</section>
					<section class="col col-2">
						<label class="input"><input type="text" name="_description" class="input-medium" maxlength="256"/>
						</label>
					</section>
					
					<button type="button" onclick="addPermissions()" class="btn btn-default">新增</button>
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