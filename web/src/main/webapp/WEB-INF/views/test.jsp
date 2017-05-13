<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var Strbuffer = function(){
		this.str = new Array();
	}
	Strbuffer.prototype.append=function(str){
		return this.str.push(str);
	}
	Strbuffer.prototype.toString=function(){
		return this.str.join("");
	}
	
	///////////////////////////////////////////
	var CallbackFun = function(){
		this.name ='ddd';
		this.method =function(callback){
			if(typeof callback==="function"){
				callback(this.name);
			}
		}
		
	}
	
	$(function(){
		var call = new CallbackFun();
		call.method(function(name){
			alert(name);
		});
	})
</script>
</head>
<body>
	<div id="content"></div>
</body>
</html>