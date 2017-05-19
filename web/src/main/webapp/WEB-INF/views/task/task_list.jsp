<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/vnd.graphviz" id="view_div">
digraph task{
    graph[color=red bgcolor="lightgrey" label="任务图表关系图",fontname="FangSong"]
    	rankdir=LR;//表示从左到右显示
	a1[shape=box label="表a1" fontname="FangSong"];
	b1[shape=box label="表b1" fontname="FangSong"];
	c1[shape=box label="表c1" fontname="FangSong"];
	d1[shape=box label="表d1" fontname="FangSong"];
	e1[shape=box label="表e1" fontname="FangSong"];
	C[label="任务C" fontname="FangSong"]
	A[label="任务A" fontname="FangSong" id="qq"]
	B[label="任务B" fontname="FangSong"]
	over[shape=Msquare]
	
	{a1 b1}->C[label="触发任务" fontname="FangSong"];
	C->c1[constraint=false label="生成" fontname="FangSong"];
	{d1 c1}->A[label="触发任务" fontname="FangSong"]
	A->e1[label="生成" fontname="FangSong"]
	e1->B[label="触发任务" fontname="FangSong"];
	B->over
	

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
						return '<a href="#" onclick="showInput('+row.id+')" data-toggle="modal" data-target="#myModal">查看</a>'
					}
					
				}, {
					field : 'export_tables',
					title : '输出',
					formatter: function(value,row,index){
						return '<a href="#" onclick="showExport('+row.id+')" data-toggle="modal" data-target="#myModal">查看</a>'
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
						return '<div class="btn-group" style="width: 100px;">'
						+	'<a class="btn btn-default" href="javascript:void(0);">操作</a>'
						+	'<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>'
						+	'<ul class="dropdown-menu">'
						+	'	<li><a href="javascript:void(0);onclick=show_file('+ row.id +')">查看代码</a></li>'
						+	'	<li><a href="javascript:void(0);onclick=upd_task('+ row.id +')">编辑</a></li>'
						+	'	<li><a href="javascript:void(0);onclick=del_task('+ row.id +')">删除</a></li>'
						+	'	<li><a href="javascript:void(0);onclick=del_task('+ row.id +')">手动运行</a></li>'
						+	'</ul></div>'
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
	$.post("mrTask/dowloadfile",{uri:res},function(msg){
		alert(msg);
// 		$("#id").load();
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
					var task_name =val.name
					var task_id =val.id
// 					alert(task_id+":"+task_name);
					strbuf.append(task_name+'[label="'+task_name+'" fontname="FangSong" id="task_'+task_id+'"]');
					if(input_tables!=null&&input_tables.length>0){
						var obj =eval('('+input_tables+')');
						$.each(obj,function(index_,val_){
							var node_input =val_.dbname+"_"+val_.table_name;
							var node_input_id =val_.id;
							strbuf.append(node_input+'[shape=box label="'+node_input+'" fontname="FangSong" id="input_'+node_input_id+'"];');
							strbuf.append(node_input+'->'+task_name);
						});
					}
				})
				strbuf.append('}');
				document.getElementById("profile_center").innerHTML=Viz(strbuf.toString(), "SVG");
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
				    	<center id="profile_center" style="width: 1000; height: 1000">
				    		
				    	</center>
				    	
				    </div>
				    <div role="tabpanel" class="tab-pane" id="messages">
				    	<center id="messages_center">
				    		
				    	</center>
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