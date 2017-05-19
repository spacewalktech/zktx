<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.svg-container { 
    display: inline-block;
    position: relative;
    width: 100%;
    padding-bottom: 100%; 
    vertical-align: middle; 
    overflow: hidden; 
}
        </style>
<script type="text/vnd.graphviz" id="view_div">
digraph task{
	
	 graph[label="任务图表关系图" fontsize="20" fontname="FangSong"]
	rankdir=LR;
	a1[shape=box label="l1prpcinsured_etn_d" fontname="FangSong"]
	a2[shape=box label="l1prpcitem_car_etn_d" fontname="FangSong"]
	a3[shape=box label="l1prpcmain_etn_d" fontname="FangSong"]
	a4[shape=box label="l1prpcopyitemkind_etn_d" fontname="FangSong"]
	a5[shape=box label="l1prpcopymain_etn_d" fontname="FangSong"]
	a6[shape=box label="l1prpcopyprofitdetail_etn_d" fontname="FangSong"]
	a7[shape=box label="l1prpdagent_etn_d" fontname="FangSong"]

	b1[shape=box label="l2prpcmain_d" fontname="FangSong"]
	b2[shape=box label="l2prpcopymain_d" fontname="FangSong"]
	b3[shape=box label="l2prpdagent_d" fontname="FangSong"]
	b4[shape=box label="l2prpdcompany_d" fontname="FangSong"]
	b5[shape=box label="l2prpdagent_d" fontname="FangSong"]
	b6[shape=box label="l2utiisales_d" fontname="FangSong"]
	b7[shape=box label="l2utiisales_d" fontname="FangSong"]

	c1[shape=box label="dim_com_branch" fontname="FangSong"]
	c2[shape=box label="dim_com_county" fontname="FangSong"]
	c3[shape=box label="dim_com_city" fontname="FangSong"]
	c4[shape=box label="dim_com_province" fontname="FangSong"]
	c5[shape=box label="dim_com_staff" fontname="FangSong"]

	d1[shape=box label="l1utiisales_etn_d" fontname="FangSong"]
	d2[shape=box label="l1sffdocdetail_etn_d" fontname="FangSong"]

	e1[shape=box label="l1prpphead_etn_d" fontname="FangSong"]

	over[shape=doublecircle fillcolor="black"]
	
	R1[style=filled fillcolor="lightgrey" label="l2prpcinsured_p" fontname="FangSong"]
	R2[style=filled fillcolor="lightgrey" label="l2prpcitem_car_p" fontname="FangSong"]
	R3[style=filled fillcolor="lightgrey" label="l2prpcmain_p" fontname="FangSong"]
	R4[style=filled fillcolor="lightgrey" label="l2prpcopyitemkind_p" fontname="FangSong"]
	R5[style=filled fillcolor="lightgrey" label="l2prpcopymain_p" fontname="FangSong"]
	R6[style=filled fillcolor="lightgrey" label="l2prpcopyprofitdetail_p" fontname="FangSong"]
	R7[style=filled fillcolor="lightgrey" label="l2prpdagent_p" fontname="FangSong"]

	P1[style=filled fillcolor="lightgrey" label="l2prpdcompany_p" fontname="FangSong"]
	P2[style=filled fillcolor="lightgrey" label="l2prplcompensate_p" fontname="FangSong"]
	P3[style=filled fillcolor="lightgrey" label="l2prplprepay_p" fontname="FangSong"]
	P4[style=filled fillcolor="lightgrey" label="l2prpmainsub_p" fontname="FangSong"]
	P5[style=filled fillcolor="lightgrey" label="l2prppfee_p" fontname="FangSong"]
	
	M1[style=filled fillcolor="lightgrey" label="l2prpphead_p" fontname="FangSong"]
	M2[style=filled fillcolor="lightgrey" label="l2sffdocdetail_p" fontname="FangSong"]
	
	N1[style=filled fillcolor="lightgrey" label="l2utiisales_p" fontname="FangSong"]


	a1->R1->b1
	a2->R2->b2	
	a3->R3->b3
	a4->R4->b4
	a5->R5->b5
	a6->R6->b6
	a7->R7->b7
	
	
	{b1 b2}->P1->c1
	{b1 b3}->P2->c2
	{b3 b5}->P3->c3
	{b4 b5 b6}->P4->c4
	b7->P5->c5
	c4->M1->d1
	c4->M2->d2
	b6->N1->e1
	{e1 d1 d2}->over;
	
}
</script>
<script type="text/javascript">
//==========================================
	//主页

// 修改 
function upd_task(id){
    layer.open({
	  type: 2,
	  title: '修改任务',
	  shadeClose: true,
	  shade: 0.2,
	  area: ['65%', '60%'],
	  content: 'mrTask/updatePage?id='+id
	}); 
}

// 删除
function del_task(id){
    layer.confirm('确认删除?', {
	  btn: ['删除','取消'], //按钮
	  icon: 3
	}, function(){
	    $.ajax({
			type : 'post',
			url : 'mrTask/deleteByid',
			data : {
			    id : id
			},
	    	success : function(result){
	    	    if(result == true){
	    			layer.msg('删除成功', {icon: 1});
	    			$('#task_list').bootstrapTable('refresh');
	    	    }else{
	    			layer.msg('删除失败', {icon: 5});
	    	    }
	    	}
	    })
	});
}



var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#task_list').bootstrapTable({
				url : 'mrTask/query', //请求后台的URL（*）
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
				search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch : true,
				smartDisplay:false,
				showColumns : false, //是否显示所有的列
				showRefresh : false, //是否显示刷新按钮
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				// height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				uniqueId : "ID", //每一行的唯一标识，一般为主键列
				showToggle : false, //是否显示详细视图和列表视图的切换按钮
				cardView : false, //是否显示详细视图
				detailView : false, //是否显示父子表
				columns : [{
					field : 'id',
					title : 'ID'
				}, {
					field : 'name',
					title : '流程名称'
				},  {
					field : 'task_type',
					title : '类型'
				}, {
					field : 'option_mode',
					title : '调度模式',
					formatter : function (value, row, index){
						if(value==0){
							return '手动'
						}else if(value==1){
							return '触发'
						}else if(value==2){
							return '定时'
						}
				    }
				}, {
					field : 'input_tables',
					title : '输入',
					formatter: function(value,row,index){
						return '<a href="#" onclick="showInput('+row.id+')" data-toggle="modal" data-target="#myModal">查看库名/表名？</a>'
					}
					
				}, {
					field : 'export_tables',
					title : '输出',
					formatter: function(value,row,index){
						return '<a href="#" onclick="showExport('+row.id+')" data-toggle="modal" data-target="#myModal">查看库名/表名？</a>'
					}
				}, {
					field : 'active',
					title : '是否激活',
					formatter : function (value, row, index){
				    	return value == true ? '激活' : '未激活';
				    }
				},  {
					field : 'create_user',
					title : '创建人',
					formatter : function (value, row, index){
						return value!=null?value.name:""
				    }
				},{
					field : 'create_time',
					title : '创建时间',
					formatter : function (value, row, index){
				    	return value == null ? null : new Date(value).format('yyyy-MM-dd hh:mm:ss');
				    }
				}, {
					field : 'information',
					title : '描述'
				},{
				    title : '操作',
				    formatter : function(value,row,index){
				    	var val ="";
				    	val+= '<div class="btn-group" style="width: 100px;">'
						val+='<a class="btn btn-default" href="javascript:void(0);">操作</a>'
						val+=	'<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>'
						val+=	'<ul class="dropdown-menu">'
						val+=	'	<li><a href="javascript:void(0);onclick=show_file('+ row.id +')">查看代码</a></li>'
						val+='	<li><a href="javascript:void(0);onclick=upd_task('+ row.id +')">编辑</a></li>'
						val+='	<li><a href="javascript:void(0);onclick=del_task('+ row.id +')">删除</a></li>'
						if(row.option_mode==0){
							val+='	<li><a href="javascript:void(0);onclick=del_task('+ row.id +')">手动运行</a></li>'
						}
						val+='</ul></div>'
						return val;
				    }
				}],
				onLoadSuccess:function(data){
					sessionStorage.clear();
					$.each(data,function(index,val){
					sessionStorage.setItem("input_"+val.id, val.input_tables);
					sessionStorage.setItem("export_"+val.id, val.export_tables);
					sessionStorage.setItem("uri_"+val.id, val.bin_file_uri);
					});
				}
			});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
		    
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				search_name : $("#search_name").val(),
				search_type : $("#search_type").val(),
				search_triggle_tables : $("#search_triggle_tables").val(),
				search_active : $("#search_active").val(),
				search_create_time_begin : $("#search_create_time_begin").val(),
				search_create_time_end : $("#search_create_time_end").val()
			};
			return temp;
		};
		return oTableInit;
	};
	
	function queryTable(){
	    $('#task_list').bootstrapTable("refresh")
	}
$(document).ready(function(){
  	//1.初始化Table
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
	
	
	$("#search_create_time_begin").datetimepicker({
	    format: 'YYYY-MM-DD HH:mm:ss',
	    locale:  'zh-cn'
	});
	
	$("#search_create_time_end").datetimepicker({
	    format: 'YYYY-MM-DD HH:mm:ss',
	    locale:  'zh-cn'
	});
	
	
});
function showInput(id){
		var res =sessionStorage.getItem("input_"+id);
		var msg =''
			msg+='<table id="dt_src" class="table table-striped table-bordered table-hover dataTable no-footer" width="100%" role="grid" aria-describedby="dt_basic_info" style="width: 100%;">';
			msg+='<tr><td>库名</td><td>表名</td></tr>'
		if(res!=null&&res!='null'&&res.length>0){
			$.each(eval(res),function(index,val){
				msg+='<tr class='+(index%2==0?"odd":"even")+'><td>'+val.dbname+'</td><td>'+val.table_name+'</td></tr>'
			});
		}else{
			msg+="<tr><td colspan=2>null</td></tr>"
		}
		msg+='</table>'
		$('#myModal').on('show.bs.modal', function () {
			
			$("#show_div").html(msg);
		})
}
function showExport(id){
		var res =sessionStorage.getItem("export_"+id);
		var msg =''
			msg+='<table id="dt_src" class="table table-striped table-bordered table-hover dataTable no-footer" width="100%" role="grid" aria-describedby="dt_basic_info" style="width: 100%;">';
			msg+='<tr><td>库名</td><td>表名</td></tr>'
		if(res!=null&&res!='null'&&res.length>0){
			var strList = res.split(",");
			$.each(strList,function(index,val){
				var strVal=val.split(".");
				msg+='<tr class='+(index%2==0?"odd":"even")+'><td>'+strVal[0]+'</td><td>'+strVal[1]+'</td></tr>'
				
			});
		}else{
			msg+="<tr><td colspan=2>null</td></tr>"
		}
		msg+='</table>'
		$('#myModal').on('show.bs.modal', function () {
			
			$("#show_div").html(msg);
		})
}

function show_file(id){
	var res =sessionStorage.getItem("uri_"+id);
	layer.open({
		  type: 2,
		  title: '代码展示',
		  shadeClose: true,
		  shade: 0.3,
		  area: ['60%', '80%'],
		  content: 'mrTask/dowloadfile?uri='+res
		}); 
}

	
	//====================================================================
		$(function(){
			
			$.post("mrTask/taskViewViz",function(res){
				var strbuf =new StringBuffer();
				strbuf.append('digraph task{ graph[color=red bgcolor="lightgrey" label="任务图表关系图",fontname="FangSong"];');
				strbuf.append('rankdir=LR;');
				$.each(res,function(index,val){
					var input_tables =val.input_tables;
					var export_tables=val.export_tables;
					if((input_tables==null||input_tables=="null"||input_tables.length==0)&&(export_tables=="null"||export_tables==null||export_tables.length==0)){
						return  true;
					}
					//任务：
					var task_name =val.name
					var task_id =val.id
					strbuf.append(task_name+'[label="'+task_name+'" fontname="FangSong" id="task_'+task_id+'"];');
					//任务对应的输入表
					
					if(input_tables!=null&&input_tables.length>0){
						var obj =eval('('+input_tables+')');
						$.each(obj,function(index_,val_){
							var node_input =val_.dbname+"_"+val_.table_name;
							var node_input_id =val_.id;
							strbuf.append(node_input+'[shape="box" label="'+node_input+'" fontname="FangSong"];');
							strbuf.append(node_input+'->'+task_name+";");
						});
					}
					//任务对应的输出 表：
					
					if(export_tables!=null&&export_tables.length>0){
						var exports = export_tables.split(",");
						$.each(exports,function(index,val){
							var valstr=val.split(".");
							var exp_dbname = valstr[0];
							var exp_tablename=valstr[1];
							var label_name=val[0]+"_"+val[1];
							strbuf.append(label_name+'[shape="box" label="'+label_name+'" fontname="FangSong"];');
							strbuf.append(task_name+"->"+label_name+";");
						})
					}
					
					
				})
				strbuf.append('}');
				document.getElementById("messages_center").innerHTML=Viz(strbuf.toString(), "SVG");
			})
			
			
// 			var strbuf =new StringBuffer();
// 	        strbuf.append('digraph G{size = "4, 4"; main[shape=box];');
// 	        strbuf.append('main->parse;');
// 	        strbuf.append('parse->execute;');
// 	        strbuf.append('main->init[style = dotted];');
// 	        strbuf.append('main->cleanup;');
// 	        strbuf.append('execute->{make_string; printf};');
// 	        strbuf.append('init->make_string;');
// 	        strbuf.append('edge[color = red];');
// 	        strbuf.append('main->printf[style=bold, label="100 times"];');
// 	        strbuf.append('make_string[label = "make a\nstring"];');
// 	        strbuf.append('node[shape = box, style = filled, color = ".7.3 1.0"];');
// 	        strbuf.append('execute->compare;}');
	        
			
// 			$("svg g #node1").click(function(){
// 				alert("这是动态的");
// 				$(this).attr("color","red");
// 			});
			
		})
	//==========================================================================
		$(function(){
			document.getElementById("profile_center").innerHTML=Viz(document.getElementById("view_div").innerHTML, "SVG");
		})
</script>
</head>
<body>
		<div id="ribbon">
			<ol class="breadcrumb">
				<li>首页</li>
				<li>流程管理</li>
				<li>流程管理</li>
			</ol>
		</div>
		<div id="content">
				  <!-- Nav tabs -->
				  <ul class="nav nav-tabs" role="tablist">
				    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">主页</a></li>
				    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">可视化</a></li>
				    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">帮助</a></li>
				  </ul>
				
				  <!-- Tab panes -->
				  <div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="home">
				    
				    		<!-- 任务管理主表 -->
							<div class="panel">
								<div>
									<div id="toolbar" class="btn-group">
										
									</div>
								</div>
							</div>
							
							<table id="task_list"></table>
				    
				    </div>
				    <div role="tabpanel" class="tab-pane" id="profile">
				    	<div id="profile_center" class="svg-container">
				    		
				    	</div>
				    	
				    </div>
				    <div role="tabpanel" class="tab-pane" id="messages">
				    	<div id="messages_center" >
				    		
				    	</div>
				    </div>
				  </div>
			
			</div>	
			
			
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" 
										aria-hidden="true">×
								</button>
								<h4 class="modal-title" id="myModalLabel">
									数据展示
								</h4>
							</div>
							<div class="modal-body" id="show_div">
								...
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" 
										data-dismiss="modal">关闭
								</button>
							</div>
						</div><!-- /.modal-content -->
					</div><!-- /.modal-dialog -->
				</div>

</body>
</html>