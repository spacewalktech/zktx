<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var dataStorage_option = {
	    title : {
	        text: '数据存储情况',
	        subtext: '数据表',
	        x:'center'
	    },
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        left: 'left',
	        data: ['ico','tif','gif','jpg','结构化数据']
	    },
	    series : [
	        {
	            name: '访问来源',
	            type: 'pie',
	            radius : '55%',
	            center: ['50%', '60%'],
	            data:[
	                {value:335, name:'ico'},
	                {value:310, name:'tif'},
	                {value:234, name:'jpg'},
	                {value:135, name:'gif'},
	                {value:1548, name:'结构化数据'}
	            ],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        }
	    ]
	};
var record_option = {
	    title: {
	        text: '折线图堆叠'
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['增','删','改']
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    toolbox: {
	        feature: {
	            saveAsImage: {}
	        }
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: ['周一','周二','周三','周四','周五','周六','周日']
	    },
	    yAxis: {
	        type: 'value'
	    },
	    series: [
	        {
	            name:'增',
	            type:'line',
	            stack: '总量',
	            data:[120, 132, 101, 134, 90, 230, 210]
	        },
	        {
	            name:'删',
	            type:'line',
	            stack: '总量',
	            data:[220, 182, 191, 234, 290, 330, 310]
	        },
	        {
	            name:'改',
	            type:'line',
	            stack: '总量',
	            data:[150, 232, 201, 154, 190, 330, 410]
	        }
	    ]
	};
var data_JVM_option = {
	    title: {
	        text: '内存占用率'
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['内存']
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    toolbox: {
	        feature: {
	            saveAsImage: {}
	        }
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	    	data:[]
	    },
	    yAxis: {
	        type: 'value'
	    },
	    series: [
	        {
	            name:'增',
	            type:'line',
	            stack: '总量',
	            smooth:true,//true为平滑，
	            data:[120, 132, 101, 134, 90, 230, 210]
	        }
	    ]
	};
var SystemPayload_option = {
	    title: {
	        text: '系统负载'
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['线程']
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    toolbox: {
	        feature: {
	            saveAsImage: {}
	        }
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: []
	    },
	    yAxis: {
	        type: 'value'
	    },
	    series: [
	        {
	            name:'线程',
	            type:'line',
	            stack: '总量',
	            smooth:true,//true为平滑，
	            data:[120, 132, 101, 134, 90, 230, 210]
	        }
	    ]
	};
$(document).ready(function(){
	var dataStorage_Chart = echarts.init(document.getElementById('dataStorage')); 
	dataStorage_Chart.setOption(dataStorage_option); 
	var SystemPayload_Chart = echarts.init(document.getElementById('SystemPayload')); 
	 var x = (new Date()).getTime(); 
     var data_x=[];
     var i;
     for(i=-7;i<=0;i++){
     	data_x.push(new Date(x+i*1000).format('hh:mm:ss'));
     }      
     SystemPayload_option.xAxis.data =data_x;
	SystemPayload_Chart.hideLoading();
	SystemPayload_Chart.setOption(SystemPayload_option); 
     
	var record_Chart = echarts.init(document.getElementById('record')); 
	record_Chart.setOption(record_option); 
	var data_JVM_Chart = echarts.init(document.getElementById('data_JVM'));
	var data_x = [];
    var data_y = [];
	setInterval(function () {
        var x = (new Date()).getTime(); // current time
        //将返回的category和series对象赋值给options对象内的category和series
        //因为xAxis是一个数组 这里需要是xAxis[i]的形式
        var data_y=[];
        var data_x=[];
        var i;
        for(i=-7;i<=0;i++){
        	data_y.push(Math.random());
        	data_x.push(new Date(x+i*1000).format('hh:mm:ss'));
        }      
        data_JVM_option.xAxis.data =data_x;
        data_JVM_option.series[0].data =data_y ;
        data_JVM_Chart.hideLoading();
        data_JVM_Chart.setOption(data_JVM_option); 
    }, 2000);
});
</script>
</head>
<body>
			<div id="content">
				<section  id="widget-grid">
					<div class="row">
						<div class="col-md-3 sortable-grid ui-sortable indoxnum">
							<div class="jarviswidget">
								<div class="numcon">
									<i class="fa fa-lg fa-fw fa-database" id="ico" style="color: #2196F3!important;"></i>
									<span class="fontsize"><i>结构化数据</i><br />表记录数:39867<br />占用空间:1.2T</span>
								</div>
							</div>
						</div>
						<div class="col-md-3 sortable-grid ui-sortable indoxnum">
							<div class="jarviswidget">
								<div class="numcon">
									<i class="fa fa-lg fa-fw fa-signal" id="ico" style="color: #43A047!important; "></i>
									<span class="fontsize"><i>非结构化数据</i><br />表记录数:8745<br />占用空间:3.1T</span>
								</div>
							</div>
						</div>
						<div class="col-md-3 sortable-grid ui-sortable indoxnum">
							<div class="jarviswidget">
								<div class="numcon">
									<i class="fa fa-lg fa-fw fa-pencil" id="ico" style="color: #E65100!important;"></i>
									<span class="fontsize"><i>导入次数：2947</i><br />表：27346<br />图像：3875</span>
								</div>
							</div>
						</div>
						<div class="col-md-3 sortable-grid ui-sortable indoxnum">
							<div class="jarviswidget">
								<div  class="numcon">
									<i class="fa fa-lg fa-fw fa-shield"  id="ico" style="color:#1565C0!important;"></i>
									<span class="fontsize"><i>可用容量：3.5T</i><br />CPU：2.31%/320核<br />内存：12.99%/1280G</span>
								</div>
							</div>
						</div>
					</div>
				</section>
				<section>
					<div class="row">

						<article class="col-sm-12 col-md-12 col-lg-6 sortable-grid">

							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">
								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken	"></i> </span>
									<h2> 数据存储 </h2>
								</header>
								
								<!-- widget div-->
								<div id="dataStorage" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
							
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="fa fa-comments txt-color-dark	"></i> </span>
									<h2> JVM </h2>
								</header>
								
								
								
								<!-- widget div-->
								<div id="data_JVM" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>

						</article>

						<article class="col-sm-12 col-md-12 col-lg-6 sortable-grid">
							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2> 增／删／改记录数 </h2>
									
								</header>
								
								<!-- widget div-->
								<div id="record" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
		<!-- new widget -->
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">


								<header>
									<span class="widget-icon"> <i class="fa fa-map-marker"></i> </span>
									<h2>系统负载</h2>
								</header>

								<!-- widget div-->
								<div id="SystemPayload" style="height: 400px;">
								</div>
							<!-- end widget -->
							
						</article>

					</div>
				</section>

			</div>
			<!-- END MAIN CONTENT -->
	
		
	
</body>
</html>