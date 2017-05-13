<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var dataStorage_option = {
	    series: [{
	        type: 'liquidFill',
	        data: [0.6, 0.5, 0.4, 0.3],
	        outline: {
	            show: false
	        }
	    }]
	};
var record_option = {   
	     title : {
	         text: '磁盘监控',
	         subtext: '纯属虚构',
	         x:'center'
	        },
	        tooltip : {
	         trigger: 'item',
	         formatter: "{a} <br/>{b} : {c} ({d}%)"
	        },
	        legend: {
	         orient : 'vertical',
	         x : 'left',
	         data:['碎片','使用','空闲']
	        },
	        toolbox: {
	         show : true,
	         feature : {
	          saveAsImage : {show: true}
	         }
	        },
	        calculable : false,   //拖拽
	        series : [
	         {
	          name:'访问来源',
	          type:'pie',     //这里指定类型
	          radius : '55%',
	          center: ['50%', '60%'],
	          data:[
	           {value:234, name:'碎片'},
	           {value:135, name:'使用'},
	           {value:1548, name:'空闲'}
	          ]
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
//FIRST===================================================
$(document).ready(function(){
	var dataStorage_Chart = echarts.init(document.getElementById('dataStoragefirst')); 
	dataStorage_Chart.setOption(dataStorage_option); 
	//---------------------
	var SystemPayload_Chart = echarts.init(document.getElementById('SystemPayloadfirst')); 
	 var x = (new Date()).getTime(); 
     var data_x=[];
     var i;
     for(i=-7;i<=0;i++){
     	data_x.push(new Date(x+i*1000).format('hh:mm:ss'));
     }      
     SystemPayload_option.xAxis.data =data_x;
	SystemPayload_Chart.hideLoading();
	SystemPayload_Chart.setOption(SystemPayload_option); 
     //----------
	var record_Chart = echarts.init(document.getElementById('recordfirst')); 
	record_Chart.setOption(record_option); 
	//-------------
	var data_JVM_Chart = echarts.init(document.getElementById('data_JVMfirst'));
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
//SECOND===================================================
$(document).ready(function(){
	var dataStorage_Chart = echarts.init(document.getElementById('dataStoragesecond')); 
	dataStorage_Chart.setOption(dataStorage_option); 
	//---------------------
	var SystemPayload_Chart = echarts.init(document.getElementById('SystemPayloadsecond')); 
	 var x = (new Date()).getTime(); 
     var data_x=[];
     var i;
     for(i=-7;i<=0;i++){
     	data_x.push(new Date(x+i*1000).format('hh:mm:ss'));
     }      
     SystemPayload_option.xAxis.data =data_x;
	SystemPayload_Chart.hideLoading();
	SystemPayload_Chart.setOption(SystemPayload_option); 
     //----------
	var record_Chart = echarts.init(document.getElementById('recordsecond')); 
	record_Chart.setOption(record_option); 
	//-------------
	var data_JVM_Chart = echarts.init(document.getElementById('data_JVMsecond'));
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
//THIRD===================================================
$(document).ready(function(){
	var dataStorage_Chart = echarts.init(document.getElementById('dataStoragethird')); 
	dataStorage_Chart.setOption(dataStorage_option); 
	//---------------------
	var SystemPayload_Chart = echarts.init(document.getElementById('SystemPayloadthird')); 
	 var x = (new Date()).getTime(); 
     var data_x=[];
     var i;
     for(i=-7;i<=0;i++){
     	data_x.push(new Date(x+i*1000).format('hh:mm:ss'));
     }      
     SystemPayload_option.xAxis.data =data_x;
	SystemPayload_Chart.hideLoading();
	SystemPayload_Chart.setOption(SystemPayload_option); 
     //----------
	var record_Chart = echarts.init(document.getElementById('recordthird')); 
	record_Chart.setOption(record_option); 
	//-------------
	var data_JVM_Chart = echarts.init(document.getElementById('data_JVMthird'));
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
//FOUR===================================================
$(document).ready(function(){
	var dataStorage_Chart = echarts.init(document.getElementById('dataStoragefour')); 
	dataStorage_Chart.setOption(dataStorage_option); 
	//---------------------
	var SystemPayload_Chart = echarts.init(document.getElementById('SystemPayloadfour')); 
	 var x = (new Date()).getTime(); 
     var data_x=[];
     var i;
     for(i=-7;i<=0;i++){
     	data_x.push(new Date(x+i*1000).format('hh:mm:ss'));
     }      
     SystemPayload_option.xAxis.data =data_x;
	SystemPayload_Chart.hideLoading();
	SystemPayload_Chart.setOption(SystemPayload_option); 
     //----------
	var record_Chart = echarts.init(document.getElementById('recordfour')); 
	record_Chart.setOption(record_option); 
	//-------------
	var data_JVM_Chart = echarts.init(document.getElementById('data_JVMfour'));
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
				
				<section>
					<!-- FIRST============================================================== -->
					
					<div class="row">
						<legend><font color="black" size="22"><b>节点1：</b></font></legend>
						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">

							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">
								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken	"></i> </span>
									<h2> CPU使用率 </h2>
								</header>
								
								<!-- widget div-->
								<div id="dataStoragefirst" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
								</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="fa fa-comments txt-color-dark	"></i> </span>
									<h2> JVM </h2>
								</header>
								
								
								
								<!-- widget div-->
								<div id="data_JVMfirst" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>

						</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2> 磁盘使用监控 </h2>
									
								</header>
								
								<!-- widget div-->
								<div id="recordfirst" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
								</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
		<!-- new widget -->
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">


								<header>
									<span class="widget-icon"> <i class="fa fa-map-marker"></i> </span>
									<h2>系统负载</h2>
								</header>

								<!-- widget div-->
								<div id="SystemPayloadfirst" style="height: 400px;">
								</div>
							<!-- end widget -->
							</div>
						</article>

					</div>
					<!--  SECOND==========================================================================-->
					<div class="row">
					<legend><font color="black" size="22"><b>节点2：</b></font></legend>
						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">

							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">
								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken	"></i> </span>
									<h2>CPU使用率 </h2>
								</header>
								
								<!-- widget div-->
								<div id="dataStoragesecond" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
								</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="fa fa-comments txt-color-dark	"></i> </span>
									<h2> JVM </h2>
								</header>
								
								
								
								<!-- widget div-->
								<div id="data_JVMsecond" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>

						</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2> 磁盘使用监控</h2>
									
								</header>
								
								<!-- widget div-->
								<div id="recordsecond" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
								</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
		<!-- new widget -->
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">


								<header>
									<span class="widget-icon"> <i class="fa fa-map-marker"></i> </span>
									<h2>系统负载</h2>
								</header>

								<!-- widget div-->
								<div id="SystemPayloadsecond" style="height: 400px;">
								</div>
							<!-- end widget -->
							</div>
						</article>

					</div>
					<!--  THIRD==========================================================================-->
					<div class="row">
						<legend><font color="black" size="22"><b>节点3：</b></font></legend>
						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">

							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">
								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken	"></i> </span>
									<h2> CPU使用率 </h2>
								</header>
								
								<!-- widget div-->
								<div id="dataStoragethird" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
								</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="fa fa-comments txt-color-dark	"></i> </span>
									<h2> JVM </h2>
								</header>
								
								
								
								<!-- widget div-->
								<div id="data_JVMthird" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>

						</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2> 磁盘使用监控 </h2>
									
								</header>
								
								<!-- widget div-->
								<div id="recordthird" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
								</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
		<!-- new widget -->
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">


								<header>
									<span class="widget-icon"> <i class="fa fa-map-marker"></i> </span>
									<h2>系统负载</h2>
								</header>

								<!-- widget div-->
								<div id="SystemPayloadthird" style="height: 400px;">
								</div>
							<!-- end widget -->
							</div>
						</article>

					</div>
					<!-- FOUR ==========================================================================-->
					<div class="row">
						<legend><font color="black" size="22"><b>节点4：</b></font></legend>
						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">

							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">
								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken	"></i> </span>
									<h2>CPU使用率</h2>
								</header>
								
								<!-- widget div-->
								<div id="dataStoragefour" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
								</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="fa fa-comments txt-color-dark	"></i> </span>
									<h2> JVM </h2>
								</header>
								
								
								
								<!-- widget div-->
								<div id="data_JVMfour" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>

						</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
							<!-- new widget -->
							
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">

								

								<header>
									<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
									<h2> 磁盘使用监控 </h2>
									
								</header>
								
								<!-- widget div-->
								<div id="recordfour" style="height: 400px;">
								</div>
								<!-- end widget div -->
							</div>
							<!-- end widget -->
								</article>

						<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
		<!-- new widget -->
							<div class="jarviswidget" id="wid-id-2" data-widget-colorbutton="false" data-widget-editbutton="false">


								<header>
									<span class="widget-icon"> <i class="fa fa-map-marker"></i> </span>
									<h2>系统负载</h2>
								</header>

								<!-- widget div-->
								<div id="SystemPayloadfour" style="height: 400px;">
								</div>
							<!-- end widget -->
							</div>
						</article>

					</div>
				</section>

			</div>
			<!-- END MAIN CONTENT -->
	
		
	
</body>
</html>