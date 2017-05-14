<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>资源管理</title>
<script type="text/javascript">

	var data_obj = {};

    function init(key, nodes){
		var data = nodes[key];
		resource_use_echarts(key, data)
    }

    var resource_use_option = {
	    tooltip: {
	        trigger: 'axis',
	        axisPointer: {
	            animation: false
	        },
	        formatter: function(params) {
	            params_cpu = params[0];
	            params_mem = params[1];
	            return params_cpu.seriesName + " : " + params_cpu.value + "%" + params_mem.seriesName + " : " + params_mem.value + "%";
	        }
	    },
	    grid: {
	        left: '2%',
	        right: '2%',
	        bottom: '2%',
	        top: '3%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: []
	    },
	    yAxis: {
	        type: 'value',
	        data: [0, 20, 40, 60, 80, 100]
	    },
	    series: [{
	        name: 'cpu',
	        type: 'line',
	        data: [0, 0, 0, 0, 0, 0, 0, 0]
	    },
	    {
	        name: 'mem',
	        type: 'line',
	        data: [0, 0, 0, 0, 0, 0, 0, 0]
	    }]
	}
    
    
    var search_requests_option = {
	    tooltip: {
	        trigger: 'axis',
	        formatter: function(params) {
	            params_cpu = params[0];
	            params_mem = params[1];
	            return params_cpu.seriesName + " : " + params_cpu.value + " " + params_mem.seriesName + " : " + params_mem.value;
	        }
	    },
	    grid: {
	        left: '2%',
	        right: '2%',
	        bottom: '2%',
	        top: '3%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: []
	    },
	    yAxis: {
	        type: 'value',
	        data: [0, 20, 40, 60, 80, 100]
	    },
	    series: [{
	        name: 'Query',
	        type: 'line',
	        data: [0, 0, 0, 0, 0, 0, 0, 0]
	    },
	    {
	        name: 'Fetch',
	        type: 'line',
	        data: [0, 0, 0, 0, 0, 0, 0, 0]
	    }]
	}
    
    
    var search_time_option = {
	    tooltip: {
	        trigger: 'axis',
	        formatter: function(params) {
	            params_cpu = params[0];
	            params_mem = params[1];
	            return params_cpu.seriesName + " : " + params_cpu.value + "ms  " + params_mem.seriesName + " : " + params_mem.value + "ms";
	        }
	    },
	    grid: {
	        left: '2%',
	        right: '2%',
	        bottom: '2%',
	        top: '3%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: []
	    },
	    yAxis: {
	        type: 'value',
	        data: [0, 20, 40, 60, 80, 100]
	    },
	    series: [{
	        name: 'Query',
	        type: 'line',
	        data: [0, 0, 0, 0, 0, 0, 0, 0]
	    },
	    {
	        name: 'Fetch',
	        type: 'line',
	        data: [0, 0, 0, 0, 0, 0, 0, 0]
	    }]
	}
    
    var indexing_time_option = {
	    tooltip: {
	        trigger: 'axis',
	        formatter: function(params) {
	            params_cpu = params[0];
	            params_mem = params[1];
	            return params_cpu.seriesName + " : " + params_cpu.value + "ms  " + params_mem.seriesName + " : " + params_mem.value + "ms";
	        }
	    },
	    grid: {
	        left: '2%',
	        right: '2%',
	        bottom: '2%',
	        top: '3%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: []
	    },
	    yAxis: {
	        type: 'value',
	        data: [0, 20, 40, 60, 80, 100]
	    },
	    series: [{
	        name: 'Delete',
	        type: 'line',
	        data: [0, 0, 0, 0, 0, 0, 0, 0]
	    },
	    {
	        name: 'Index',
	        type: 'line',
	        data: [0, 0, 0, 0, 0, 0, 0, 0]
	    }]
	}
    
    function resource_use_echarts(id, data){
	
		// 声明需要的echart
		var data_JVM_Chart = echarts.init(document.getElementById('resource_use_'+id));
		var search_requests_Chart = echarts.init(document.getElementById('search_requests_'+id));
		var search_time_Chart = echarts.init(document.getElementById('search_time_'+id));
		var indexing_time_Chart = echarts.init(document.getElementById('indexing_time_'+id));
				
		
		// 获取各自的属性
		var data_y = data_obj[id].resource_use_data_y;
		var data_z = data_obj[id].resource_use_data_z;
		
		var search_requests_y = data_obj[id].search_requests_y;
		var search_requests_z = data_obj[id].search_requests_z;
		
		var search_time_y = data_obj[id].search_time_y;
		var search_time_z = data_obj[id].search_time_z;
		
		var indexing_time_y = data_obj[id].indexing_time_y;
		var indexing_time_z = data_obj[id].indexing_time_z;
		
		// X轴都是时间
		var x = (new Date()).getTime();
	    var i;
	    var data_x = [];
	    
	    // 各个图的数据
	    var data_y_1 = [];
	    var data_z_1 = [];
	    
	    var search_requests_y_1 = [];
	    var search_requests_z_1 = [];
	    
	    var search_time_y_1 = [];
	    var search_time_z_1 = [];
	    
	    var indexing_time_y_1 = [];
	    var indexing_time_z_1 = [];
	    
	    // 将历史数据去掉第一个，加上最新的
	    for (i = 1; i <= 7; i++) {
	        data_y_1.push(data_y[i]);
	        data_z_1.push(data_z[i]);
	        search_requests_y_1.push(search_requests_y[i])
	        search_requests_z_1.push(search_requests_z[i])
	        search_time_y_1.push(search_time_y[i])
	        search_time_z_1.push(search_time_z[i])
	        indexing_time_y_1.push(indexing_time_y[i])
	        indexing_time_z_1.push(indexing_time_z[i])
	    }
	    
	    
	    // X轴
	    for (i = -7; i <= 0; i++) {
        	data_x.push(new Date(x + i * 1000).format('hh:mm:ss'));
        }
	    
		// 需要展示的数据	    
	    var cpu_percent = data.os.cpu.percent
	    var used_percent = data.os.mem.used_percent
        data_y_1.push(cpu_percent);
        data_z_1.push(used_percent);
        
        var query_total = data.indices.search.query_total
        var fetch_total = data.indices.search.fetch_total
        search_requests_y_1.push(query_total)
        search_requests_z_1.push(fetch_total)
        
        var query_time = data.indices.search.query_time
        var fetch_time = data.indices.search.fetch_time
        search_time_y_1.push(query_time.replace("ms",""))
        search_time_z_1.push(fetch_time.replace("ms",""))
        
        var delete_time = data.indices.indexing.delete_time
        var index_time = data.indices.indexing.index_time
        indexing_time_y_1.push(delete_time.replace("ms",""))
        indexing_time_z_1.push(index_time.replace("ms",""))
        
        resource_use_option.xAxis.data = data_x;
        search_requests_option.xAxis.data = data_x;
        search_time_option.xAxis.data = data_x;
        indexing_time_option.xAxis.data = data_x;
        
        // 设置属性和加载到图上
        resource_use_option.series[0].data = data_y_1;
        resource_use_option.series[1].data = data_z_1;
        data_JVM_Chart.setOption(resource_use_option, true);
        
        search_requests_option.series[0].data = search_requests_y_1;
        search_requests_option.series[1].data = search_requests_z_1;
        search_requests_Chart.setOption(search_requests_option);
        
        search_time_option.series[0].data = search_time_y_1;
        search_time_option.series[1].data = search_time_z_1;
        search_time_Chart.setOption(search_time_option);
        
        indexing_time_option.series[0].data = indexing_time_y_1;
        indexing_time_option.series[1].data = indexing_time_z_1;
        indexing_time_Chart.setOption(indexing_time_option)
        
        // 将值写回到源数据上
        data_obj[id].resource_use_data_y = data_y_1;
        data_obj[id].resource_use_data_z = data_z_1;
        data_obj[id].search_requests_y = search_requests_y_1;
        data_obj[id].search_requests_z = search_requests_z_1;
        data_obj[id].search_time_y = search_time_y_1;
        data_obj[id].search_time_z = search_time_z_1;
        data_obj[id].indexing_time_y = indexing_time_y_1;
        data_obj[id].indexing_time_z = indexing_time_z_1;
        
    }
    
    function init_data(keys){
		var len = keys.length
		for(var i = 0; i < len; i++){
		    var k = keys[i]
		    var obj = {};
		    // resource_use
		    obj.resource_use_data_y = [0, 0, 0, 0, 0, 0, 0, 0];
		    obj.resource_use_data_z = [0, 0, 0, 0, 0, 0, 0, 0];
		    obj.search_requests_y = [0, 0, 0, 0, 0, 0, 0, 0];
		    obj.search_requests_z = [0, 0, 0, 0, 0, 0, 0, 0];
		    obj.search_time_y = [0, 0, 0, 0, 0, 0, 0, 0];
		    obj.search_time_z = [0, 0, 0, 0, 0, 0, 0, 0];
		    obj.indexing_time_y = [0, 0, 0, 0, 0, 0, 0, 0];
		    obj.indexing_time_z = [0, 0, 0, 0, 0, 0, 0, 0];
		    data_obj[k] = obj
		    var data_JVM_Chart = echarts.init(document.getElementById('resource_use_'+k));
			var search_requests_Chart = echarts.init(document.getElementById('search_requests_'+k));
			var search_time_Chart = echarts.init(document.getElementById('search_time_'+k));
			var indexing_time_Chart = echarts.init(document.getElementById('indexing_time_'+k));
			data_JVM_Chart.setOption(resource_use_option);
			search_requests_Chart.setOption(search_requests_option);
			search_time_Chart.setOption(search_time_option);
			indexing_time_Chart.setOption(indexing_time_option)
		}
		
		
	}
    
    $(function() {
		
		var len = '${size}'
		
		var keys = '${keys}'
		
		init_data(keys.split(","))
	
		setInterval(function() {
		    $.ajax({
				url : 'http://hadoop01:9200/_nodes/stats?human=true',
				type : 'get',
				success : function(re) {
				    keys = Object.keys(re.nodes)
				    for(var key in keys){
						var k = keys[key]
						init(k, re.nodes)
				    }
				}
		    })
		}, 3000)
	})
    
</script>
</head>
<body>
	<div id="ribbon">
		<ol class="breadcrumb">
			<li>首页</li>
			<li>运行监控</li>
			<li>资源监控</li>
		</ol>
	</div>
	<div id="content">
		<c:forEach var="i" items="${nodesInfo}">
			<div class="row">
				<legend style="padding-left: 13px"> ${i.name} (${i.transport_address }) </legend>
				<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
					<div class="jarviswidget" data-widget-colorbutton="false" data-widget-editbutton="false">
						<header>
							<span class="widget-icon">
								<i class="glyphicon glyphicon-stats txt-color-darken	"></i>
							</span>
							<h2>Resouce Used (%)</h2>
						</header>
						<div id="resource_use_${i.id}" style="height: 200px;"></div>
					</div>
				</article>
				<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
					<div class="jarviswidget" data-widget-colorbutton="false" data-widget-editbutton="false">
						<header>
							<span class="widget-icon">
								<i class="glyphicon glyphicon-stats txt-color-darken	"></i>
							</span>
							<h2>Search requests per second</h2>
						</header>
						<div id="search_requests_${i.id}" style="height: 200px;"></div>
					</div>
				</article>
				<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
					<div class="jarviswidget" data-widget-colorbutton="false" data-widget-editbutton="false">
						<header>
							<span class="widget-icon">
								<i class="glyphicon glyphicon-stats txt-color-darken	"></i>
							</span>
							<h2>Search time per second</h2>
						</header>
						<div id="search_time_${i.id}" style="height: 200px;"></div>
					</div>
				</article>
				<article class="col-sm-12 col-md-12 col-lg-3 sortable-grid">
					<div class="jarviswidget" data-widget-colorbutton="false" data-widget-editbutton="false">
						<header>
							<span class="widget-icon">
								<i class="glyphicon glyphicon-stats txt-color-darken	"></i>
							</span>
							<h2>Indexing time per second</h2>
						</header>
						<div id="indexing_time_${i.id}" style="height: 200px;"></div>
					</div>
				</article>
			</div>
		</c:forEach>
	</div>
</body>
</html>