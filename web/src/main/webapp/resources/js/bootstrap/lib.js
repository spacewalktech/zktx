function bsStep(a) {
    
    $(".step > li").each(function(){
	$(this).removeClass("active")
    })
    
    $(".step").each(function() {
	var b, c = $(this);
	if (a > c.find("li").length) {
	    console.log("您输入数值已超过步骤最大数量" + c.find("li").length + "！！！");
	    return false
	} else {
	    if (a == undefined) {
		a = 1
	    }
	}
	a != undefined || null ? b = a : b = $(this).data("step");
	$(this).find("li:lt(" + b + ")").addClass("active")
    })
};