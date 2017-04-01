<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>修改任务</title>
<%@ include file="../header.jsp"%>
</head>
<body style='width: 99.5%'>
	<form class="smart-form">
		<fieldset>
			<div class="row">
				<section class="col col-2 text-right"> <label class="text">任务名称</label> </section>
				<section class="col col-3"> <label class="input">
					<input type="text" placeholder="任务名称" disabled="true" name="name" value='${task.name }'>
				</label> </section>
				<section class="col col-2 text-right"> <label class="text">运行文件</label> </section>
				<section class="col col-3"> <label class="input">
					<div class="input input-file">
						<span class="button">
							<input type="file" id="file" name="file" onchange="this.parentNode.nextSibling.value = this.value">
							浏览...
						</span>
						<input type="text" placeholder="选择文件" readonly="" name="bin_file_uri" value="${task.bin_file_uri }">
					</div>
				</label> </section>
			</div>

			<div class="row">
				<section class="col col-2 text-right"> <label class="text">任务描述</label> </section>
				<section class="col col-9"> <label class="input">
					<input type="text" placeholder="任务描述" disabled="true" name="information" value="${task.information }">
				</label> </section>
			</div>

			<div class="row">
				<section class="col col-2 text-right"> <label class="text">触发条件</label> </section>
				<section class="col col-3 text-right"> <label class="input">
					<input type="text" placeholder="选择库" disabled="true">
				</label> </section>
				<section class="col col-3 text-right"> <label class="input">
					<input type="text" placeholder="选择表" disabled="true">
				</label> </section>
				<section class="col col-3 text-right"> <label class="select">
					<select>
						<option value="0">全量</option>
						<option value="1">增量</option>
					</select>
					<i></i>
				</label> </section>
			</div>

			<div class="row">
				<section class="col col-2 text-right"> <label class="text">是否创建逻辑表</label> </section>
				<section class="col col-3 text-right">
				<div class="inline-group">
					<label class="radio">
						<input type="radio" name="radio" checked="checked">
						<i></i>
						是
					</label>
					<label class="radio">
						<input type="radio" name="radio">
						<i></i>
						否
					</label>
				</div>
				</section>
				<section class="col col-2 text-right"> <label class="text">优先级</label> </section>
				<section class="col col-3 text-right"> <label class="input">
					<input type="text" placeholder="任务描述" disabled="true">
				</label> </section>
			</div>

			<div class="row">
				<section class="col col-2 text-right"> <label class="text">是否激活</label> </section>
				<section class="col col-3 text-right">
				<div class="inline-group">
					<label class="radio">
						<input type="radio" name="radio" checked="checked">
						<i></i>
						是
					</label>
					<label class="radio">
						<input type="radio" name="radio">
						<i></i>
						否
					</label>
				</div>
				</section>
				<section class="col col-2 text-right"> <label class="text">定时运行表达式</label> </section>
				<section class="col col-3 text-right"> <label class="input">
					<input type="text" placeholder="corn表达式" disabled="true" name="task_schedule" value="${task.task_schedule }">
				</label> </section>
			</div>
		</fieldset>
		<footer>
		<button type="submit" class="btn btn-primary">确定</button>
		<button type="reset" class="btn btn-default">重置</button>
		</footer>
	</form>
</body>
</html>