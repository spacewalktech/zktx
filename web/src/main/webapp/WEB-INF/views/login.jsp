<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us" id="extr-page">
<head>
<meta charset="utf-8">
<title>登录</title>
<%@ include file="./header.jsp"%>
</head>
<body class="animated fadeInDown">
	<div id="main" role="main">
		<!-- MAIN CONTENT -->
		<div id="content" class="container">
			<div class="row" style="padding-top: 20%">
				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-4"></div>
				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-4">
					<div class="well no-padding">
						<form action="" method="post" id="login-form" class="smart-form client-form">
							<header> 登录 </header>
							<fieldset>
								<section> <label class="label">用户名</label> <label class="input">
									<i class="icon-append fa fa-user"></i>
									<input type="username" name="username">
									<input type="hidden" name="redirectUrl" value="${redirectUrl }">
									<b class="tooltip tooltip-top-right">
										<i class="fa fa-user txt-color-teal"></i>
										请输入登录名
									</b>
								</label> </section>
								<section> <label class="label">密码</label> <label class="input">
									<i class="icon-append fa fa-lock"></i>
									<input type="password" name="password">
									<b class="tooltip tooltip-top-right">
										<i class="fa fa-lock txt-color-teal"></i>
										请输入密码
									</b>
								</label> </section>
								<c:if test="${msg != null }">
									<section> <label class="label">
										<font color="red">${msg}</font>
									</label> </section>
								</c:if>
							</fieldset>
							<footer>
							<button type="submit" class="btn btn-primary">登录</button>
							</footer>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(function() {
	    // Validation
	    $("#login-form").validate({
		// Rules for form validation
		rules : {
		    email : {
			required : true,
			email : false
		    },
		    password : {
			required : true,
			minlength : 3,
			maxlength : 20
		    }
		},

		// Messages for form validation
		messages : {
		    email : {
			required : '请输入邮箱',
			email : '请输入正确的邮箱'
		    },
		    password : {
			required : '请输入密码'
		    }
		},

		// Do not change code below
		errorPlacement : function(error, element) {
		    error.insertAfter(element.parent());
		}
	    });
	});
    </script>
</body>
</html>
