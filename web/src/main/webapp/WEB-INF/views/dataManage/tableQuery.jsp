<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

		<title> SmartAdmin </title>
		<meta name="description" content="">
		<meta name="author" content="">
			
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-skins.min.css">

		<!-- SmartAdmin RTL Support -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/smartadmin-rtl.min.css"> 

		<!-- We recommend you use "your_style.css" to override SmartAdmin
		     specific styles this will also ensure you retrain your customization with each SmartAdmin update.
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/your_style.css"> -->

		<!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
		<link rel="stylesheet" type="text/css" media="screen" href="${root}/resources/css/demo.min.css">

		<!-- FAVICONS -->
		<link rel="shortcut icon" href="${root}/resources/img/favicon/favicon.ico" type="image/x-icon">
		<link rel="icon" href="${root}/resources/img/favicon/favicon.ico" type="image/x-icon">

		<!-- GOOGLE FONT -->
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

		<!-- Specifying a Webpage Icon for Web Clip 
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
		<link rel="apple-touch-icon" href="${root}/resources/img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="${root}/resources/img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="${root}/resources/img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="${root}/resources/img/splash/touch-icon-ipad-retina.png">
		
		<!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		
		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="${root}/resources/img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="${root}/resources/img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="${root}/resources/img/splash/iphone.png" media="screen and (max-device-width: 320px)">
		<script src="${root }/resources/js/jquery.min.js"></script>	
		<script src="${root }/resources/js/except.js"></script>	
		<script type="text/javascript">
			$(document).ready(function(){
				doSubmit(1);
			});
			function doSubmit(pageNum){
				$("#pageNum").val(pageNum);
				$.post("stage/queryTable.do",$("#smartForm").serialize(),function(msg){
					pagefen(pageNum,msg);
					var htmlval=new StringBuffer();
					$.each(msg.list,function(index,val){
						htmlval.append('<tr role="row" class='+(index%2==0?"odd":"even")+' aria-selected="false">'); 
						htmlval.append('<td class="sorting_1">'+(val.stage_id!=undefined?val.stage_id:"")+'</td>');
						htmlval.append('<td>'+(val.inserted_num!=undefined?val.inserted_num:"")+'</td>');
						htmlval.append('<td>'+(val.updated_num!=undefined?val.updated_num:"")+'</td>');
						htmlval.append('<td>'+(val.deleted_num!=undefined?val.deleted_num:"")+'</td>');
						htmlval.append('<td>'+(val.record_num!=undefined?val.record_num:"")+'</td>');
						htmlval.append('<td>'+(val.begin_time!=undefined?new Date(val.begin_time).toLocaleString():"")+'</td>');
						htmlval.append('<td>'+(val.end_time!=undefined?new Date(val.end_time).toLocaleString():"")+'</td>');
						htmlval.append('<td>'+(val.status!=undefined&&val.status?"失败":"成功")+'</td>');
						htmlval.append('<td>'+(val.import_type!=undefined&&val.import_type?"增量":"全量")+'</td></tr>');
					})
					$("table tbody").html(htmlval.toString());
				});
			}
			function pagefen(pageNum,msg){
				
				var perNum = $("#perNum").val();
				var count = msg.countRows;//总行数
				var perCount =msg.list.length;//一次返回的行数
				var pageCount = parseInt(count/perNum)+1;//总页数
				$("#rowCount").html(count);
				$("#fromRowid").html(perNum*(pageNum-1)+(count==0?0:1));
				$("#toRowid").html(perNum*(pageNum-1)+perCount);
				var pageval=new StringBuffer();
				pageval.append('<li class="paginate_button previous" id="dt_basic_previous"><a href="#" aria-controls="dt_basic" data-dt-idx="0" tabindex="0" onclick="PreviousQuery('+(pageNum-1)+','+pageCount+')">Previous</a></li>');
				pageval.append('<li class="paginate_button previous" id="dt_basic_previous"><a href="#" aria-controls="dt_basic" data-dt-idx="1" tabindex="0" onclick="PreviousQuery(1,'+pageCount+')">first</a></li>');
				if(pageNum<=3){
					for(var i=1;i<=(Math.min(pageCount,6));i++){
						pageval.append('<li class='+((pageNum==i)?"paginate_button active":"paginate_button")+'><a href="#" aria-controls="dt_basic" data-dt-idx="'+i+'" tabindex="0" onclick="PreviousQuery('+i+','+pageCount+')">'+i+'</a></li>');
					}
					if(pageCount>=6){
						pageval.append('<li class="paginate_button disabled" id="dt_basic_ellipsis"><a href="#" aria-controls="dt_basic" data-dt-idx="'+pageCount+'" tabindex="0">…</a></li>');
					}
				}else if(pageNum>(pageCount-3)){
					if(pageCount>=6){
						pageval.append('<li class="paginate_button disabled" id="dt_basic_ellipsis"><a href="#" aria-controls="dt_basic" data-dt-idx="0" tabindex="0">…</a></li>');
					}
					for(var i=(pageCount-4);i<=pageCount;i++){
						pageval.append('<li class='+((pageNum==i)?"paginate_button active":"paginate_button")+'><a href="#" aria-controls="dt_basic" data-dt-idx="'+i+'" tabindex="0" onclick="PreviousQuery('+i+','+pageCount+')">'+i+'</a></li>');
					}
				}else{
					pageval.append('<li class="paginate_button disabled" id="dt_basic_ellipsis"><a href="#" aria-controls="dt_basic" data-dt-idx="0" tabindex="0">…</a></li>');
					for(var i=(pageNum-2);i<=(pageNum+2);i++){
						pageval.append('<li class="paginate_button"><a href="#" aria-controls="dt_basic" data-dt-idx="'+i+'" tabindex="0" onclick="PreviousQuery('+i+','+pageCount+')">'+i+'</a></li>');
					}
					pageval.append('<li class="paginate_button disabled" id="dt_basic_ellipsis"><a href="#" aria-controls="dt_basic" data-dt-idx="'+pageCount+'" tabindex="0">…</a></li>');
				}
				pageval.append('<li class="paginate_button previous" id="dt_basic_previous"><a href="#" aria-controls="dt_basic" data-dt-idx="1" tabindex="0" onclick="PreviousQuery('+pageCount+','+pageCount+')">last</a></li>');
				pageval.append('<li class="paginate_button next" id="dt_basic_next"><a href="#" aria-controls="dt_basic" data-dt-idx="'+(pageCount+1)+'" tabindex="0" onclick="PreviousQuery('+(pageNum+1)+','+pageCount+')">Next</a></li>');
				$("#dt_basic_paginate ul").html(pageval.toString());
			}
			function PreviousQuery(pageNum,pageCount){
				if(pageNum==0){
					alert("已经是第一页");
				}else if(pageNum>pageCount){
					alert("已是最后一页");
				}else{
					doSubmit(pageNum);
				}
			}
			
		</script>
	</head>
	<body class="">
		<form action="" id="smartForm">
			<input id="table_id" type="hidden" name="table_id" value="${table_id }" />
			<input type="hidden" id="pageNum" name="pageNum" value="1">
			<input type="hidden" id="perNum" name="perNum" value="10" />
		</form>
				

				<!-- 由主表滑出的表 -->
				<section id="widget-grid" class="">

					<!-- row -->
					<div class="row">
						<article class="col-sm-12">
							<!-- new widget -->
							<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
	
								<div class="widget-body no-padding  no-margin">
									<!-- content -->
									<div id="dt_basic_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer" style="border-top: 1px solid #ccc!important; ">
									<table id="dt_basic" class="table table-striped table-bordered table-hover  no-footer margin-top-0" width="100%" role="grid" aria-describedby="dt_basic_info" style="width: 100%;">
											<thead>			                
												<tr role="row">
													<th data-hide="phone" class="sorting_asc" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-sort="ascending" aria-label="ID: activate to sort column descending">STAGE_ID</th>
													<th data-class="expand" class="expand sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Name: activate to sort column ascending">新增记录数</th>
													<th data-class="expand" class="expand sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Name: activate to sort column ascending">修改记录数</th>
													<th data-hide="phone" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Phone: activate to sort column ascending">删除记录数</th>
													<th data-hide="phone" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Phone: activate to sort column ascending">总记录数</th>
													<th class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="Company: activate to sort column ascending">开始时间</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">结束时间</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label=" Date: activate to sort column ascending">状态</th>
													<th data-hide="phone,tablet" class="sorting" tabindex="0" aria-controls="dt_basic" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending">更新类型</th>
												</tr>
											</thead>
											<tbody>
										
											</tbody>

									</table>
										<div class="dt-toolbar-footer">
											<div class="col-sm-5 col-xs-12 hidden-xs">
												<div class="dataTables_info" id="dt_basic_info" role="status" aria-live="polite">Showing <span id="fromRowid"></span> to <span id="toRowid"></span> of <span id="rowCount"></span> entries</div>
											</div>
											<div class="col-xs-12 col-sm-7">
												<div class="dataTables_paginate paging_simple_numbers" id="dt_basic_paginate">
													<ul class="pagination">
													</ul>
												</div>
											</div>
										</div>
									</div>
									
									
									<!-- end content -->
								</div>

						
								<!-- end widget div -->
							</div>
							<!-- end widget -->

						</article>
					</div>

					<!-- end row -->

					

				</section>
				<!-- 由主表滑出的表 -->
	</body>

</html>