<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>添加任务</title>
<%@ include file="../header.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
		var oTable = new TableInit();
		oTable.Init();
		Date.prototype.format =function(format){
			var o = {
				"M+" : this.getMonth()+1, //month
				"d+" : this.getDate(), //day
				"h+" : this.getHours(), //hour
				"m+" : this.getMinutes(), //minute
				"s+" : this.getSeconds(), //second
				"q+" : Math.floor((this.getMonth()+3)/3), //quarter
				"S" : this.getMilliseconds() //millisecond
			}
			if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
			(this.getFullYear()+"").substr(4- RegExp.$1.length));
			for(var k in o)if(new RegExp("("+ k +")").test(format))
			format = format.replace(RegExp.$1,
			RegExp.$1.length==1? o[k] :
			("00"+ o[k]).substr((""+ o[k]).length));
			return format;
		}
	});
	
	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#dt_basic').bootstrapTable({
				url : 'query.do', //请求后台的URL（*）
				method : 'get', //请求方式（*）
				toolbar : '#toolbar', //工具按钮用哪个容器
				striped : true, //是否显示行间隔色
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination : true, //是否显示分页（*）
				sortable : false, //是否启用排序
				sortOrder : "asc", //排序方式
				queryParams : oTableInit.queryParams,//传递参数（*）
				sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, //初始化加载第一页，默认第一页
				pageSize : 10, //每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
				search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch : true,
				showColumns : true, //是否显示所有的列
				showRefresh : true, //是否显示刷新按钮
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				uniqueId : "ID", //每一行的唯一标识，一般为主键列
				onClickRow:function(row){
					querySchema(row.schema,row.spark_schema);
				},
				showToggle : true, //是否显示详细视图和列表视图的切换按钮
				cardView : false, //是否显示详细视图
				detailView : false, //是否显示父子表
				columns : [{
					field : 'id',
					title : 'ID'
				},{
					field : 'version',
					title : '版本名称'
				}, {
					field : 'dbname',
					title : '库名'
				}, {
					field : 'table_name',
					title : '表名'
				}, {
					field : 'src_db',
					title : '源库名称'
				},{
					field : 'src_table',
					title : '源表名称'
				},{
					field : 'create_time',
					title : '创建时间',
					formatter : function (value, row, index){
				    	return new Date(value).format('yyyy-MM-dd hh:mm:ss');
				    }
				}]
			});
		};
		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
					limit : params.limit, //页面大小
					offset : params.offset, //页码
					table_id : $("#table_id").val()
			};
			return temp;
		};
		return oTableInit;
	};
	
	function querySchema(src_schema,sparkSchema){
		if(null!=src_schema&&src_schema.length>0){
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
			
		}
		if(null!=sparkSchema&&sparkSchema.length>0){
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
		
	}

</script>
</head>
<body style='width: 99.5%'>
			<input id="table_id" type="hidden" name="table_id" value="${table_id }" />

			<!-- MAIN CONTENT -->
			<div id="content">

							<!-- widget grid -->
				<section id="widget-grid" class="">

					<!-- row -->
					<div class="row">
									<div id="content">
									<table id="dt_basic">

									</table>
									</div>
									
							<!-- end widget -->

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
</body>
</html>