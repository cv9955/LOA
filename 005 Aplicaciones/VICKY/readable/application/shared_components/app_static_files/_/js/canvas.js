
//var myescala = 0.5;
var escala_ref_largo = 600;
var escala_ref_ancho = 280;
//var borde = 10;


function dibujar_canvas(pCanvas,escala)
{
	var canvas = document.getElementById(pCanvas);
	var ctx = canvas.getContext("2d");
    
    var c_w = canvas.width;
    var c_h = canvas.height;
    
    var c_w2 = canvas.width / 2 ;
 

    var px = 'P' + $v('pFlowStepId')+'_'; // Generalizo Nro de PAGINA

	var tipo = $x(px+'ART_TIPO_ID').value;
	var plargo =$x(px+'PLARGO').value;
	var pancho =$x(px+'PANCHO').value;
	var strazados = $x(px+'TRAZADOS').value;
    var trazados = strazados.split(":");

   	var sslotter = $x(px+'SLOTTER').value;
	var slotter = sslotter.split(":");



// borrar canvas    
    ctx.save();
    ctx.setTransform(1, 0, 0, 1, 0, 0);
    //  ctx.clearRect(0,0,c_w, c_h);
      ctx.fillStyle = '#fffefe';	
      ctx.fillRect(0, 0,c_w, c_h); 
    ctx.stroke();
    ctx.restore();

	if (escala == 1)    { // para copiar y pegar a escala 
        ctx.setTransform(1, 0, 0, 1,c_w2, 100);
    }    else    {
        escala = Math.min(escala_ref_largo/plargo,escala_ref_ancho/pancho) ;
        ctx.setTransform(escala,0,0,escala,canvas.clientWidth/2 ,50);	
    }

// grosor de lineas y tamaño de texto
    ctx.strokeStyle="#000000";
    ctx.lineWidth = 2;
    ctx.font='25px Arial';

//  ctx.fillText( ctx.font ,c_w2,0); // escribe el valor de la escala en la posicion 0 0

/*  // solo para pruebas
	ctx.strokeStyle="#777777";
	ctx.lineWidth = 1;
	ctx.beginPath();
	ctx.rect(0,0,100,100);
	ctx.stroke(); */


// dibuja plancha 
    var guia = plargo /2;
    ctx.save();
    ctx.translate(-guia,0);
    ctx.beginPath();
    ctx.rect(0,0,plargo,pancho);
    ctx.stroke();
    ctx.restore();

// dibujar trazados slitter
   	if (tipo == "1" || tipo > "3"){
   		ctx.save();
		ctx.translate(-guia,0);   
	    var t = 0;
		for (i = 0; i < trazados.length -1 ; i++){
            t += (trazados[i] * 1 ) ;
            ctx.beginPath();
            ctx.moveTo(0,t);	
            ctx.lineTo(plargo,t);
            ctx.stroke();
        }
//dibuja cotas
		t = 0; 
		var cota = 0;
	    var ycota = 0;
		ctx.translate(plargo ,0);
		ctx.textAlign = "left";
	    for (i = 0; i < trazados.length ; i++){
            t += (trazados[i] * 1 ) ;
            ycota = t/2  + cota/ 2 ;
            if (trazados[i] < 30) { 
                ctx.font='25px Arial';
            }else{	
                ctx.font='50px Arial';                
            }
            ctx.fillText(Math.round(trazados[i]) ,10,ycota);
            cota = t;
		};
		ctx.restore();	
	}

 // trazados de slotter
	if (tipo >= "3" || tipo == "1") {
	    var t = 0;
   		ctx.save();
		ctx.translate(-guia,0);   

		for (i = 0; i < slotter.length ; i++){
				t += (slotter[i] * 1 ) ;

				ctx.beginPath();
				ctx.moveTo(t,0);	
				ctx.lineTo(t,pancho);
				ctx.stroke();
			}
		
		//dibuja cotas
		t = 0; 
		var cota = 0;
	    var xcota = 0;
		ctx.textAlign = "center";
	    for (i = 0; i < slotter.length ; i++){
	     		t += (slotter[i] * 1 ) ;
	     		xcota = t/2  + cota/ 2 ;
				if (slotter[i] < 100)
				{	ctx.font='25px Arial'; }
				else
				{	ctx.font='50px Arial'; }	
	            ctx.fillText(slotter[i] ,xcota,-10);
				cota = t;
		};

		ctx.restore();

	}



// dibujar cortes trazadora x largo
	if (tipo == "0" || tipo =="1"){
    	var mult_x = Number(document.getElementById('P30_MULT_X').value);  
    	if (mult_x > 1){
    		ctx.save();
			ctx.translate(-guia,0);
			var l = Number(document.getElementById('P30_LARGO').value);  
			for (var i = 1; i < mult_x; i++) {
				ctx.beginPath();
				ctx.moveTo(l * i,0);	
				ctx.lineTo(l * i,pancho);
				ctx.stroke();
			}
			ctx.restore();
   		} 
	}
// dibujar cortes trazadora x Onda
   	if (tipo == "0"){
   		var mult_y = Number(document.getElementById('P30_MULT_Y').value);
    	if (mult_y > 1){
    		ctx.save();
			ctx.translate(-guia,0);    		
			var a = Number(document.getElementById('P30_ANCHO').value);  
			for (var i = 1; i < mult_y; i++) {
				ctx.beginPath();
				ctx.moveTo(0,a * i);	
				ctx.lineTo(plargo,a * i);
				ctx.stroke();
			}
			ctx.restore();
   		} 	
	}
	



}




