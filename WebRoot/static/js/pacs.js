/*
省市联动
	new PCAS("Province","City")
	new PCAS("Province","City","吉林省")
	new PCAS("Province","City","吉林省","吉林市")
省市地区联动
	new PCAS("Province","City","Area")
	new PCAS("Province","City","Area","吉林省")
	new PCAS("Province","City","Area","吉林省","松原市")
	new PCAS("Province","City","Area","吉林省","松原市","宁江区")

注：省、市、地区提示信息选项的值为""(空字符串)
*/
SPT="--省份--";
SCT="--城市--";
SAT="--地区--";
function PCAS(){
    this.SelP = document.getElementById(arguments[0]);
    this.SelC = document.getElementById(arguments[1]);
    this.SelA = document.getElementById(arguments[2]);
    this.DefP = this.SelA ? arguments[3] : arguments[2];
    this.DefC = this.SelA ? arguments[4] : arguments[3];
    this.DefA = this.SelA ? arguments[5] : arguments[4];
    this.SelP.PCA = this;
    this.SelC.PCA = this;
    //this.SelA.PCA = this;
    this.SelP.onchange=function(){
        PCAS.SetC(this.PCA)
    };
    if (this.SelA) this.SelC.onchange=function(){
        PCAS.SetA(this.PCA)
    };
    PCAS.SetP(this)
};
PCAS.SetP=function(PCA){
	PCA.SelP.options.add(new Option(SPT,""));
		var list = pcasJson.result.list;
		for (i = 0; i < list.length; i++) {
			var option = list[i];
			PCA.SelP.options.add(new Option(option.name, option.id));
			if (PCA.DefP == option.id)
				PCA.SelP[i+1].selected = true
		}
	PCAS.SetC(PCA)
};
PCAS.SetC=function(PCA){
	var pid =$(PCA.SelP).val();
    PCA.SelC.length = 0;
    PCA.SelC.options.add(new Option(SCT, ""));
    if(pid){
    	RcmsAjax.ajaxNoMsg(jsUtil.getRootPath()+"/common/pcas/getChildren.docomp",function(result){
    	var list = result.result.list;
		for (i = 0; i < list.length; i++) {
			var option = list[i];
			PCA.SelC.options.add(new Option(option.name, option.id));
			if (PCA.DefC == option.id)
				PCA.SelC[i+1].selected = true
			}
    	},null,'pid='+pid);
    }
    if (PCA.SelA)
		PCAS.SetA(PCA)
};
PCAS.SetA=function(PCA){
	var pid =$(PCA.SelC).val();
    PCA.SelA.length = 0;
    PCA.SelA.options.add(new Option(SAT, ""));
	if(pid){
		RcmsAjax.ajaxNoMsg(jsUtil.getRootPath()+"/common/pcas/getChildren.docomp",function(result){
		var list = result.result.list;
			for (i = 0; i < list.length; i++) {
				var option = list[i];
				PCA.SelA.options.add(new Option(option.name, option.id));
				if (PCA.DefA == option.id)
					PCA.SelA[i + 1].selected = true
			}
   		},null,'pid='+pid);
	}
    
}
