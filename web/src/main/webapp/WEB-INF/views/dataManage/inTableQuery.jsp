<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	 function formSubmit() {
		 $.ajax({
			   type: "POST",
			   url: "importTables/query.do?fromRowId=0&num=10",
			   data: "table_type=false",
			   success: function(msg){
			     alert( "Data Saved: " + msg );
			   }
			});
		};
		
</script>
</head>
<body>
		<!-- Widget ID (each widget will need unique ID)-->
		<div class="jarviswidget jarviswidget-sortable" id="wid-id-0" data-widget-colorbutton="false" 
		data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="border-top: 1px solid #CCC !important;">

			<!-- widget div-->
			<div role="content" style="padding: 0;">
				<!-- widget content -->
				<div class="widget-body no-padding">

					<form class="smart-form" id="smartForm">
						<header> 查询 </header>

						<fieldset class="padding-top-0">

							<div class="row">
								<section class="col col-1 text-right">
								<label class="text">源表</label>
								</section>
								<section class="col col-3"> 
								<label class="input">
									<input type="text" list="list" id="src_table"> 
									<datalist id="list">
										<option value="Alexandra">库名一</option>
										<option value="Alice">库名二</option>
										<option value="Anastasia">库名三</option>

									</datalist>
								</label> 
								</section>

								<section class="col col-1 text-right">
									<label class="text">源库</label>
								</section>
								<section class="col col-3"> 
									<label class="input">
										<input type="text" list="list" id="src_db">
										<datalist id="list">
											<option value="Alexandra">库名一</option>
											<option value="Alice">库名二</option>
											<option value="Anastasia">库名三</option>
										</datalist>
									</label> 
								</section>
								
								<section class="col col-1 text-right">
									<label class="text">源库类型</label>
								</section>
								<section class="col col-3"> 
									<label class="select">
										<select id="src_db_type">
											<option value="0">Oracle</option>
											<option value="1">DB2</option>
											<option value="2">Sybase</option>
											<option value="3">SQL</option>
											<option value="4">Server</option>
											<option value="5">Informax</option>
											<option value="6">MySQL</option>
										</select> 
										<i></i>
									</label> 
								</section>
							</div>
							<div class="row">
								<section class="col col-1 text-right">
									<label class="text">表名</label>
								</section>
								<section class="col col-3">
									<label class="input">
										<input type="text" placeholder="表名" id="table_name">
									</label>
								</section>
								<section class="col col-1 text-right">
									<label class="text">库名</label>
								</section>
								<section class="col col-3">
									<label class="input">
										<input type="text" placeholder="库名" id="dbname">
									</label>
								</section>
								<section class="col col-1 text-right">
									<label class="text">创建时间</label>
								</section>
								<section class="col col-3">
									<section class="col col-5" style="padding: 0; margin: 0;">
										<label class="input">
											<inputtype="text" placeholder="">
										</label> 
									</section> 
									<section class="col col-1" style="padding: 0; margin: 0;">
										<label>－</label> 
									</section> 
									<section class="col col-6" style="padding: 0; margin: 0;">
										<label class="input">
											<input type="text" placeholder="">
										</label>
									</section> 
								</section>
							</div>
						</fieldset>
						<footer>
							<button type="button" class="btn btn-default"
								onclick="window.history.back();">重置</button>
							<button type="button" class="btn btn-primary" onclick="formSubmit()">查询</button>
						</footer>
					</form>

				</div>
				<!-- end widget content -->

			</div>
			<!-- end widget div -->

		</div>
	<div class="widget-body no-padding bordertop">
		<!-- content -->

		<div id="dt_basic_wrapper"
			class="dataTables_wrapper form-inline dt-bootstrap no-footer">
			<table id="dt_basic"
				class="table table-striped table-bordered table-hover dataTable no-footer"
				width="100%" role="grid" aria-describedby="dt_basic_info"
				style="width: 100%;">
				<thead>
					<tr role="row">
						<th data-hide="phone" class="sorting_asc" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-sort="ascending"
							aria-label="ID: activate to sort column descending">序号</th>
						<th data-class="expand" class="expand sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label=" Name: activate to sort column ascending">数据库名称</th>
						<th data-class="expand" class="expand sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label=" Name: activate to sort column ascending">表名称</th>
						<th data-hide="phone" class="sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label=" Phone: activate to sort column ascending">源库类型</th>
						<th class="sorting" tabindex="0" aria-controls="dt_basic"
							rowspan="1" colspan="1"
							aria-label="Company: activate to sort column ascending">源库名称</th>
						<th data-hide="phone,tablet" class="sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label="City: activate to sort column ascending">源表名称</th>
						<th data-hide="phone,tablet" class="sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label=" Date: activate to sort column ascending">创建时间</th>
						<th data-hide="phone,tablet" class="sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label="City: activate to sort column ascending">更新时间</th>
						<th data-hide="phone,tablet" class="sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label="City: activate to sort column ascending">创建人</th>
						<th data-hide="phone,tablet" class="sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label="City: activate to sort column ascending">状态</th>
						<th data-hide="phone,tablet" class="sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label="City: activate to sort column ascending">文件大小</th>
						<th data-hide="phone,tablet" class="sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label="City: activate to sort column ascending">总记录数</th>
						<th data-hide="phone,tablet" class="sorting" tabindex="0"
							aria-controls="dt_basic" rowspan="1" colspan="1"
							aria-label="City: activate to sort column ascending">操作</th>
					</tr>
				</thead>
				<tbody>

					<tr role="row" class="odd" aria-selected="false">
						<td class="sorting_1">1</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>copymain</td>
						<td>informix</td>
						<td>car3g</td>
						<td>prpcopymain</td>
						<td>2017-03-01 10:00:00</td>
						<td>2017-03-01 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>200MB</td>
						<td>2999776</td>
						<td>
							<div class="btn-group" style="width: 100px;">
								<a class="btn btn-default" href="javascript:void(0);">操作</a> <a
									class="btn btn-default dropdown-toggle" data-toggle="dropdown"
									href="javascript:void(0);"><span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="javascript:void(0);">查看表</a></li>
									<li><a href="javascript:void(0);">查看表定义</a></li>
									<li><a href="javascript:void(0);">编辑</a></li>
									<li><a href="javascript:void(0);">删除表</a></li>

									<li><a href="javascript:void(0);">删除外部文件</a></li>
								</ul>
							</div>
							<button type="submit" class="btn btn-primary btn-lg"
								onclick="window.open ('数据管理查看表.html','newwindow','height=500,width=900,top=100,left=200,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') "
								style="margin-bottom: 20px;">查看表</button>
							<button type="submit" class="btn btn-primary btn-lg"
								onclick="window.open ('数据管理查看表定义.html','newwindow') "
								style="margin-bottom: 20px;">查看表定义</button>

						</td>
					</tr>
					<tr role="row" class="even">
						<td class="sorting_1">2</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>third_car</td>
						<td>infromix</td>
						<td>lp3g</td>
						<td>prplthird_car</td>
						<td>2017-03-05 10:00:00</td>
						<td>2017-03-05 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>500MB</td>
						<td>5999776</td>
						<td></td>
					</tr>
					<tr role="row" class="odd" aria-selected="false">
						<td class="sorting_1">3</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>copyitemkind</td>
						<td>informix</td>
						<td>car3g</td>
						<td>prpcopyitemkind</td>
						<td>2017-03-01 10:00:00</td>
						<td>2017-03-01 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>2000MB</td>
						<td>30999776</td>
						<td></td>
					</tr>
					<tr role="row" class="even">
						<td class="sorting_1">4</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>copyitem_car</td>
						<td>infromix</td>
						<td>car3g</td>
						<td>prpcopyitem_car</td>
						<td>2017-03-05 10:00:00</td>
						<td>2017-03-05 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>500MB</td>
						<td>5999776</td>
						<td></td>
					</tr>
					<tr role="row" class="odd" aria-selected="false">
						<td class="sorting_1">5</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>copyinsured</td>
						<td>informix</td>
						<td>car3g</td>
						<td>prpcopyinsured</td>
						<td>2017-03-01 10:00:00</td>
						<td>2017-03-01 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>50MB</td>
						<td>9770</td>
						<td></td>
					</tr>
					<tr role="row" class="even">
						<td class="sorting_1">6</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>copyitem_car</td>
						<td>infromix</td>
						<td>car3g</td>
						<td>prpcopyitem_car</td>
						<td>2017-03-05 10:00:00</td>
						<td>2017-03-05 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>500MB</td>
						<td>5999776</td>
						<td></td>
					</tr>
					<tr role="row" class="odd" aria-selected="false">
						<td class="sorting_1">7</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>copycoins</td>
						<td>informix</td>
						<td>car3g</td>
						<td>prpcopycoins</td>
						<td>2017-03-01 10:00:00</td>
						<td>2017-03-01 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>200MB</td>
						<td>2999776</td>
						<td></td>
					</tr>
					<tr role="row" class="even">
						<td class="sorting_1">8</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>dcompany</td>
						<td>infromix</td>
						<td>car3g</td>
						<td>prpdcompany</td>
						<td>2017-03-05 10:00:00</td>
						<td>2017-03-05 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>50MB</td>
						<td>99776</td>
						<td></td>
					</tr>
					<tr role="row" class="odd" aria-selected="false">
						<td class="sorting_1">9</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>deflossmain</td>
						<td>informix</td>
						<td>car3g</td>
						<td>prpdeflossmain</td>
						<td>2017-03-01 10:00:00</td>
						<td>2017-03-01 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>2000MB</td>
						<td>29997760</td>
						<td></td>
					</tr>
					<tr role="row" class="even">
						<td class="sorting_1">10</td>
						<td class=" expand"><span class="responsiveExpander"></span>car_insurance</td>
						<td>compensate</td>
						<td>infromix</td>
						<td>car3g</td>
						<td>prplcompensate</td>
						<td>2017-03-05 10:00:00</td>
						<td>2017-03-05 10:00:00</td>
						<td>张三</td>
						<td>激活</td>
						<td>500MB</td>
						<td>5999776</td>
						<td></td>
					</tr>
			</table>

			<div class="dt-toolbar-footer">
				<div class="col-sm-6 col-xs-12 hidden-xs">
					<div class="dataTables_info" id="dt_basic_info" role="status"
						aria-live="polite">Showing 1 to 10 of 100 entries</div>
				</div>
				<div class="col-xs-12 col-sm-6">
					<div class="dataTables_paginate paging_simple_numbers"
						id="dt_basic_paginate">
						<ul class="pagination">
							<li class="paginate_button previous disabled"
								id="dt_basic_previous"><a href="#" aria-controls="dt_basic"
								data-dt-idx="0" tabindex="0">Previous</a></li>
							<li class="paginate_button active"><a href="#"
								aria-controls="dt_basic" data-dt-idx="1" tabindex="0">1</a></li>
							<li class="paginate_button "><a href="#"
								aria-controls="dt_basic" data-dt-idx="2" tabindex="0">2</a></li>
							<li class="paginate_button "><a href="#"
								aria-controls="dt_basic" data-dt-idx="3" tabindex="0">3</a></li>
							<li class="paginate_button "><a href="#"
								aria-controls="dt_basic" data-dt-idx="4" tabindex="0">4</a></li>
							<li class="paginate_button "><a href="#"
								aria-controls="dt_basic" data-dt-idx="5" tabindex="0">5</a></li>
							<li class="paginate_button disabled" id="dt_basic_ellipsis"><a
								href="#" aria-controls="dt_basic" data-dt-idx="6" tabindex="0">…</a></li>
							<li class="paginate_button "><a href="#"
								aria-controls="dt_basic" data-dt-idx="7" tabindex="0">10</a></li>
							<li class="paginate_button next" id="dt_basic_next"><a
								href="#" aria-controls="dt_basic" data-dt-idx="8" tabindex="0">Next</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>


		<!-- end content -->
	</div>


</body>
</html>