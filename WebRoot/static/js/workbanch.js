window.workbanch = window.workbanch||{};
workbanch.modules={
	lead:{},
	customer:{},
	contact:{},
	supplier:{
			titles:['供应商','法人','电话','手机','传真'],
			fields:['name','corporation','phone','mobile','fax']	
		}
};
workbanch.getModule=function(module){
	switch(module){
		case "lead":
			return workbanch.modules.lead;
		case "customer":
			return workbanch.modules.customer;
		case "supplier":
			return workbanch.modules.supplier;
		default:
			return null;
	}
};
workbanch.result2Html=function(result,module){
	var module = workbanch.getModule(module);
	var title = module.titles;
	var fields = module.fields;
	var table = new Array();
	table.push("<table style='width:100%;'>");
	table.push("<tr>");
	for(var i=0;i<title.length;i++){
		table.push("<th>",title[i],"</th>");
	}
	table.push("</tr>");
	var list = result.result.result;
	for(var i=0;i<list.length;i++){
		table.push("<tr>");
		for(var j=0;j<fields.length;j++){
			var value= list[i][fields[j]];
			table.push("<td>");
			table.push(value);
			table.push("</td>");
		}
		table.push("</tr>");
	}
	table.push("");
	table.push("</table>");
	return table.join("");
};