	var escalam = 0.05;
	var escalaf = 0.80;

function DibujarUso(pCanvas = "mycanvas"){
	var canvas = document.getElementById(pCanvas);

	var s = getComputedStyle(canvas);
	var w = s.width
	var h = s.height;
	
	var W = canvas.width = w.split('px')[0];
	var H = canvas.height = h.split('px')[0];

	var ctx = canvas.getContext("2d");
	
	ctx.font='18px Arial';
	ctx.textAlign = "right";
	ctx.setTransform(1, 0, 0, 1, 0, 0);
	ctx.clearRect(0,0,canvas.width, canvas.height);

	var celdas = "";

	ctx.setTransform(1, 0, 0, 1, 0, 30);
	
	ctx.strokeStyle="#777777";
	for (var i = 1 ; i<16; i++){
		ctx.beginPath();
		ctx.moveTo(32,i * 1000 * escalam);	
		ctx.lineTo(580,i * 1000 * escalam);
		ctx.stroke();  // lineas

		ctx.fillText(i + 'k'  ,30, i * 1000 * escalam ); // metros k
	}
	
	ctx.textAlign = "center";
	ctx.setTransform(1, 0, 0, 1, 80, 30);
	corrugado(ctx);



	ctx.setTransform(1, 0, 0, 1, 220, 30);
	abc('A',ctx);

	ctx.setTransform(1, 0, 0, 1, 360, 30);
	abc('B',ctx);
	ctx.setTransform(1, 0, 0, 1, 500, 30);
	abc('C',ctx);

}

function corrugado(pContext){
	var id="";
	var formato="";
	var metros="";
	var calidad="";
	var stat= 0;
	var ini = 0;
	var fin = 0;
	var m= 0;
	var tableA = document.getElementById('CORRUGADO').getElementsByTagName('tr');

    var ancho = 70;
	pContext.strokeStyle="#000000";
    
    pContext.fillStyle = '#000000';	
    pContext.fillText('Orden' ,0, -10);

    if (tableA.length < 2) {
    	return ;
    }

	for (var i = 2; i < tableA.length; i++)
	{
		celdas =  tableA[i].getElementsByTagName('td');

		id =  celdas[0].innerHTML;
		formato =  celdas[1].innerHTML.replace(".","");
		metros =  celdas[2].innerHTML.replace(".","");
		calidad =  celdas[3].innerHTML;	
		stat =  celdas[4].innerHTML;	
		ini =  celdas[5].innerHTML;	
		fin =  celdas[6].innerHTML;	
		 
		 ancho = formato * .5;
		switch (calidad.substr(0,1)){
			case "3":
				pContext.fillStyle = '#ece2c6';	
				break;
			case "5":
				pContext.fillStyle = '#f7e9a0';	
				break;
			case "L":
				pContext.fillStyle = '#f9c27d';	
				break;
			case "M":
				pContext.fillStyle = '#c38974';	
				break;
			case "B":
				pContext.fillStyle = '#f5fbf7';	
				break;
			default:
				pContext.fillStyle = '#ff3';	
		}
		
		pContext.globalAlpha = 0.3;  
			pContext.fillRect(ancho/2,m,500-ancho/2, metros * escalam ); // dibujo sombra

		switch (stat) {
		case "1":			
			pContext.globalAlpha = 1;
			pContext.strokeStyle="#000000";
				break;   
		case "-1":
			pContext.globalAlpha = 0.5;
			pContext.strokeStyle="#777777";
				break;	
		case "0":
			pContext.globalAlpha = 0.9;
			pContext.strokeStyle="#0000ff";
				break;
		}	
				
		pContext.fillRect(-ancho/2,m,ancho, metros * escalam ); //dibujo barra corrugado
		pContext.beginPath();
		pContext.rect(-ancho/2,m,ancho,metros * escalam ); //dibujo borde
		pContext.stroke();
		
		
		switch (stat) {
		case "1":			
			pContext.strokeStyle="#000000";
		    pContext.fillStyle = '#000000';
				break;   
		case "-1":
			pContext.strokeStyle="#777777";
			pContext.fillStyle = '#000000';
				break;	
		case "0":
			pContext.strokeStyle="#0000ff";
			pContext.fillStyle = '#0000ff';
				break;
		}			
		
    	pContext.globalAlpha = 1;
		pContext.fillText(id,0, m + 15 ); // nro de orden
		m = m + metros * escalam;	
	}
}

function abc(pLugar,pContext){
	var bobina="";
	var formato="";
	var metros="";
	var tipo="";

	var m= 0;
	var tableA = document.getElementById('TABLE_'+pLugar).getElementsByTagName('tr');

	pContext.strokeStyle="#000000";
    
    pContext.fillStyle = '#000000';	
    pContext.fillText(pLugar ,0, -10); // letra lugar

    if (tableA.length < 2) {
    	return ;
    }

	for (var i = 2; i < tableA.length; i++)
	{
		celdas =  tableA[i].getElementsByTagName('td');

		bobina =  celdas[0].innerHTML;
		tipo =  celdas[1].innerHTML;
		formato =  celdas[2].innerHTML.replace(".","");
		metros =  celdas[3].innerHTML.replace(".","");
		switch (tipo){
			case "C":
				pContext.fillStyle = '#ece2c6';	
				break;
			case "O":
				pContext.fillStyle = '#f7e9a0';	
				break;
			case "L":
				pContext.fillStyle = '#f9c27d';	
				break;
			case "M":
				pContext.fillStyle = '#c38974';	
				break;
			case "B":
				pContext.fillStyle = '#f5fbf7';	
				break;
		}
		pContext.globalAlpha = .8;
		pContext.fillRect(formato*escalaf/-2,m, formato*escalaf,metros * escalam );
		
		pContext.globalAlpha = 1;
		pContext.fillStyle = '#000000';	
		pContext.beginPath();
		pContext.rect(formato*escalaf/-2,m , formato*escalaf,metros * escalam);
		pContext.stroke();
		pContext.fillText(bobina ,0, m + 15);
		m = m + metros * escalam;	
	}
}




