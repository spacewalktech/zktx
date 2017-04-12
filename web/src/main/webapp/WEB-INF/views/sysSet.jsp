<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
			<div id="ribbon">
				<!-- breadcrumb -->
				<ol class="breadcrumb">
					<li>首页</li><li>系统配置</li>
				</ol>
			</div>
	<!-- MAIN CONTENT -->
			<div id="content">
				<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable no-padding">
				
							<!-- Widget ID (each widget will need unique ID)-->
							<div class="jarviswidget jarviswidget-sortable" id="wid-id-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="border-top:1px solid #CCC!important;" >
							
								<!-- widget div-->
								<div role="content" style=" padding: 0; ">
									<div class="widget-body no-padding">
				
										<form class="smart-form">
											<header>
												配置参数
											</header>
				
											<fieldset class="padding-top-0">
												　
												<div class="row">
													<section class="col col-2 text-right"><label class="text">最大连接数</label></section>
													<section class="col col-4">
														<label class="input">
														<input type="text" list="list">
														</label>
													</section>
													
													
													<section class="col col-2 text-right"><label class="text">存储节点预留空间百分比</label></section>
													<section class="col col-4">
														<label class="input"><input type="text" placeholder=""></label>
														
													</section>
											</div>
											<div class="row">
													<section class="col col-2 text-right"><label class="text">网络超时时间</label></section>
													<section class="col col-4"><label class="input"><input type="text" placeholder=""></label></section>
													
													<section class="col col-2 text-right"><label class="text">存储服务的线程个数</label></section>
													<section class="col col-4">
														<label class="input"><input type="text" placeholder=""></label>
													</section>
											</div>
											<div class="row">
													<section class="col col-2 text-right"><label class="text">日志文件保留时间</label></section>
													<section class="col col-4"><label class="input"><input type="text" placeholder=""></label></section>
													
													<!--<section class="col col-1 text-right"><label class="text">存储服务的线程个数</label></section>
													<section class="col col-5">
														<label class="input"><input type="text" placeholder=""></label>
													</section>-->
											</div>
												
											</fieldset>
				
										</form>
				
									</div>
								</div>
								<!-- end widget div -->
				
							</div>
							<!-- end widget -->
				
				</article>
				<article class="col-sm-12 col-md-12 col-lg-12 sortable-grid ui-sortable no-padding">
				
							<!-- Widget ID (each widget will need unique ID)-->
							<div class="jarviswidget jarviswidget-sortable" id="wid-id-0" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="border-top:1px solid #CCC!important;" >
							
								<!-- widget div-->
								<div role="content" style=" padding: 0; ">
				
									
				
									<!-- widget content -->
									<div class="widget-body no-padding">
				
										<form class="smart-form">
											<header>
												存储管理
											</header>
				
											<fieldset class="padding-top-0">
												　
												<div class="row">
													<section class="col col-1 text-right"><label class="text">存储根目录：</label></section>
													<section class="col col-6">
														<label class="input">
														<input type="text" list="list">
														<datalist id="list">
															<option value="Alexandra">/images/</option>
															<option value="Alice">/images/<</option>
															<option value="Anastasia">/images/<</option>
															
														</datalist> </label>
													</section>
												</div>	
												<div class="row">	
													<section class="col col-1 text-right"></section>
													<section class="col col-6">
														<section class="col col-1" ><label class="input"><input type="text" placeholder=""></label></section>
														<section class="col col-3"><label class="text">自动清理早于</label></section>
														<section class="col col-2"><label class="input"><input type="text" placeholder=""></label></section>
														<section class="col col-3"><label class="text">天的外部文件</label></section>
													</section>
											</div>
											<!--<div class="row">
													<section class="col col-1 text-right"><label class="text">表名</label></section>
													<section class="col col-5"><label class="input"><input type="text" placeholder="表名"></label></section>
													
													<section class="col col-1 text-right"><label class="text">创建时间</label></section>
													<section class="col col-5">
														<section class="col col-5" style="padding: 0; margin: 0;">
															<label class="input"><input type="text" placeholder=""></label>
														</section>
														<section class="col col-1" style="padding: 0; margin: 0;">
														<label>－</label>
														</section>
														<section class="col col-6" style="padding: 0; margin: 0;">
															<label class="input"><input type="text" placeholder=""></label>
														</section>
													</section>
												</div>-->
												
												
											</fieldset>
				
										
				
											<footer>
												
												<button type="button" class="btn btn-default" onclick="window.history.back();">
													重置
												</button>
												<button type="submit" class="btn btn-primary">
													查询
												</button>
											</footer>
										</form>
				
									</div>
									<!-- end widget content -->
									
								</div>
								<!-- end widget div -->
				
							</div>
							<!-- end widget -->
				
						</article>

					

			</div>
			<!-- END MAIN CONTENT -->
	
</body>
</html>