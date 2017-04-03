<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加任务</title>
<%@ include file="../header.jsp"%>
<script src="${root }/resources/js/except.js"></script>	
<script type="text/javascript">
	$(document).ready(function(){
		doSubmit(1);
	});
	function doSubmit(pageNum){
		$("#pageNum").val(pageNum);
		$.post("query.do",$("#smartForm").serialize(),function(msg){
			sessionStorage.clear();
			pagefen(pageNum,msg);
			var htmlval=new StringBuffer();
			$.each(msg.list,function(index,val){
				htmlval.append('<tr class='+(index%2==0?"odd":"even")+' onclick="showschema('+val.id+')">'); 
				htmlval.append('<td class="sorting_1">'+(val.id!=undefined?val.id:"")+'</td>');
				htmlval.append('<td>'+(val.version!=undefined?val.version:"")+'</td>');
				htmlval.append('<td>'+(val.dbname!=undefined?val.dbname:"")+'</td>');
				htmlval.append('<td>'+(val.table_name!=undefined?val.table_name:"")+'</td>');
				htmlval.append('<td>'+(val.src_db!=undefined?val.src_db:"")+'</td>');
				htmlval.append('<td>'+(val.src_table!=undefined?val.src_table:"")+'</td>');
				htmlval.append('<td>'+(val.create_time!=undefined?new Date(val.create_time).toLocaleString():"")+'</td></tr>');
				sessionStorage.setItem("src_"+val.id, val.schema);
				sessionStorage.setItem("spark_"+val.id, val.spark_schema);
				
			})
			$("#dt_basic tbody").html(htmlval.toString());
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
	function showschema(id){
		var src_schema = sessionStorage.getItem("src_"+id);
		var src =eval('('+src_schema+')');
		var htmlval=new StringBuffer();
		$.each(src.schema,function(index,val){
			htmlval.append('<tr class='+(index%2==0?"odd":"even")+'>'); 
			htmlval.append('<td class="sorting_1">'+index+'</td>');
			htmlval.append('<td>'+(val.name!=undefined?val.name:"")+'</td>');
			htmlval.append('<td>'+(val.type!=undefined?val.type:"")+'</td>');
			htmlval.append('<td>'+(val.unique!=undefined?(val.unique==1?"是":"否"):"")+'</td>');
			htmlval.append('<td>'+(val.primary!=undefined?(val.primary==1?"是":"否"):"")+'</td></tr>');
		})
		$("#dt_src tbody").html(htmlval.toString());
		
		var sparkSchema = sessionStorage.getItem("spark_"+id);
		var spark = eval('('+sparkSchema+')');
		var  sparkvl = new StringBuffer();
		$.each(spark.schema,function(index,val){
			sparkvl.append('<tr class='+(index%2==0?"odd":"even")+'>'); 
			sparkvl.append('<td class="sorting_1">'+index+'</td>');
			sparkvl.append('<td>'+(val.name!=undefined?val.name:"")+'</td>');
			sparkvl.append('<td>'+(val.type!=undefined?val.type:"")+'</td>');
			sparkvl.append('<td>'+(val.unique!=undefined?(val.unique==1?"是":"否"):"")+'</td>');
			sparkvl.append('<td>'+(val.primary!=undefined?(val.primary==1?"是":"否"):"")+'</td></tr>');
		})
		$("#dt_spark tbody").html(sparkvl.toString());
	}

</script>
</head>
<body style='width: 99.5%'>
	<form action="" id="smartForm">
			<input id="table_id" type="hidden" name="table_id" value="${table_id }" />
			<input type="hidden" id="pageNum" name="pageNum" value="1">
			<input type="hidden" id="perNum" name="perNum" value="10">
		</form>
		<!-- MAIN PANEL -->
		<div id="main" role="main">

			<!-- RIBBON -->
			<!-- END RIBBON -->

			<!-- MAIN CONTENT -->
			<div id="content">

							<!-- widget grid -->
				<section id="widget-grid" class="">

					<!-- row -->
					<div class="row">
						<article class="col-sm-12">
							<!-- new widget -->
							<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
								
								<div class="widget-body no-padding bordertop">
									<!-- content -->
									
									<div id="dt_basic_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
									<table id="dt_basic" class="table table-striped table-bordered table-hover dataTable no-footer" width="100%" role="grid" aria-describedby="dt_basic_info" style="width: 100%;">
											<thead>			                
												<tr role="row">
													<th>ID</th>
													<th>版本名称</th>
													<th>库名</th>
													<th>表名</th>
													<th>源库名称</th>
													<th>源表名称</th>
													<th>创建时间</th>
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

											<section id="widget-grid" class="">

							<!-- row -->
							<div class="row">
								<article class="col-sm-6">
									
										<header>
												<h5>源表schema</h5>
											</header>
									<!-- new widget -->
									<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
							

										<div class="widget-body no-padding bordertop">
											<!-- content -->
											
											<div id="dt_basic_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
												<table id="dt_src" class="table table-striped table-bordered table-hover dataTable no-footer" width="100%" role="grid" aria-describedby="dt_basic_info" style="width: 100%;">
											<thead>			                
												<tr role="row">
													<th data-hide="phone " class="sorting_asc " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-sort="ascending " aria-label="ID: activate to sort column descending ">序号</th>
													<th data-class="expand " class="expand sorting " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-label=" Name: activate to sort column ascending ">ID</th>
													<th data-hide="phone " class="sorting " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-label=" Phone: activate to sort column ascending ">类型</th>
													<th class="sorting " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-label="Company: activate to sort column ascending ">是否唯一</th>
													<th data-hide="phone,tablet " class="sorting " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-label="City: activate to sort column ascending ">是否为主键</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>

									</div>
									
									
									<!-- end content -->
								</div>


						
								<!-- end widget div -->
							</div>
							<!-- end widget -->

						</article>
						<article class="col-sm-6 ">
							<header>
										<h5>SparkSQL Schema</h5>
									</header>
								
							<!-- new widget -->
							<div class="jarviswidget " id="wid-id-0 " data-widget-togglebutton="false " data-widget-editbutton="false " data-widget-fullscreenbutton="false " data-widget-colorbutton="false " data-widget-deletebutton="false ">
							
								<div class="widget-body no-padding bordertop ">
									<!-- content -->
									
									<div id="dt_basic_wrapper " class="dataTables_wrapper form-inline dt-bootstrap no-footer ">
									<table id="dt_spark" class="table table-striped table-bordered table-hover dataTable no-footer " width="100% " role="grid " aria-describedby="dt_basic_info " style="width: 100%; ">
											<thead>			                
												<tr role="row ">
													<th data-hide="phone " class="sorting_asc " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-sort="ascending " aria-label="ID: activate to sort column descending ">序号</th>
													<th data-class="expand " class="expand sorting " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-label=" Name: activate to sort column ascending ">ID</th>
													<th data-hide="phone " class="sorting " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-label=" Phone: activate to sort column ascending ">类型</th>
													<th class="sorting " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-label="Company: activate to sort column ascending ">是否唯一</th>
													<th data-hide="phone,tablet " class="sorting " tabindex="0 " aria-controls="dt_basic " rowspan="1 " colspan="1 " aria-label="City: activate to sort column ascending ">是否为主键</th>
												</tr>
											</thead>
											<tbody>
											</tbody>		
										</table>
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

				</section>
				<!-- end widget grid -->

				
				
			</div>
			<!-- END MAIN CONTENT -->

		</div>
		<!-- END MAIN PANEL -->
</body>
</html>