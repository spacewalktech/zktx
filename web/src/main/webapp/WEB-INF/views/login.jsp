<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-us" id="extr-page">
	<head>
		<meta charset="utf-8">
		<title>健康医疗保险大数据</title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="shortcut icon" href="${root }/resources/img/logo_title.ico" type="image/x-icon">
		<link rel="icon" href="${root }/resources/img/logo_title.ico" type="image/x-icon">
		<%@ include file="./header.jsp"%>
		<script type="text/javascript">
				
				
		</script>
	</head>
	<style type="text/css">
		.backgroundimg{ background:url(${root }/resources/img/login_bg.jpg) no-repeat top left;}
		.bgno{ background: none;}
		.padding-30{ padding: 30px;}
	</style>
	<body class="animated fadeInDown">

		<header id="header">

			<div id="logo-group">
				<span id="titlogo">健康医疗保险大数据</span>
			</div>

		</header>

		<div id="main" role="main">

			<!-- MAIN CONTENT -->
			<div id="content" class="container">

				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-7 col-lg-8 hidden-xs hidden-sm padding-30 backgroundimg">
						<h1 class="txt-color-red login-header-big">大数据分析管理平台</h1>
						<div class="hero bgno">

							<div class="pull-left login-desc-box-l">
								<h4 class="paragraph-header">It's Okay to be Smart. Experience the simplicity of SmartAdmin, everywhere you go!</h4>
							</div>
							
							<img src="${root }/resources/img/demo/iphoneview.png" class="pull-right display-image" alt="" style="width:210px">

						</div>

						<div class="row">
							<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
								<h5 class="about-heading">关于平台 </h5>
								<p>
									Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa.
								</p>
							</div>
							<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
								<h5 class="about-heading">大数据分析管理平台!</h5>
								<p>
									Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi voluptatem accusantium!
								</p>
							</div>
						</div>

					</div>
					<div class="col-xs-12 col-sm-12 col-md-5 col-lg-4">
						<div class="well no-padding">
							<form action="index.do" method="post" id="login-form" class="smart-form client-form">
								<header>
									登录
								</header>

								<fieldset>
									
									<section>
										<label class="label">用户名</label>
										<label class="input"> <i class="icon-append fa fa-user"></i>
											<input type="email" name="username">
											<b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> 请输入邮箱地址或用户名</b></label>
									</section>

									<section>
										<label class="label">密码</label>
										<label class="input"> <i class="icon-append fa fa-lock"></i>
											<input type="password" name="password">
											<b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> 请输入密码</b> </label>
									</section>

								</fieldset>
								<footer>
									<button type="submit" class="btn btn-primary">
										登录
									</button>
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
							required : '请输入你的邮箱',
							email : '请输入有效的邮件地址'
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