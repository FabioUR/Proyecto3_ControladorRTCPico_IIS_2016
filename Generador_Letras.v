`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Fabio Ureña Rojas, Camila Gómez Molina, Steven León Domínguez
// 
// Create Date:    16:45:40 10/17/2016 
// Design Name: 
// Module Name:    Generador_Letras e imágenes 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Generador_Letras(
    //ENTRADAS
	input wire CLK,
	//input wire RESET,
	input wire [7:0] digit_DD, digit_M, digit_AN, digit_HORA, digit_MIN, digit_SEG, digit_TimerHORA, digit_TimerMIN, digit_TimerSEG,
	input wire [8:0] bandera_cursor, //banderas para activar lo que se desea cambiar
	//input wire [2:0] switch_cursor,  //establecer si se cambia fecha, hora, timer
	input wire [9:0] pix_x, pix_y, // Coordenadas del escáner del VGA.
	input wire Alarma_on,
	
	//SALIDAS
	output reg [11:0] graph_rgb // Salida para controlar color en VGA.
   );
	
	// Declaración de señales, base. Para el momento de impresion
   wire [10:0] rom_addr;
   //wire [11:0] rom_addr;
	reg [6:0] char_addr;
	//reg [11:0] char_addr;
   reg [3:0] row_addr;
   reg [2:0] bit_addr;
	//wire [15:0] font_word;
   wire [7:0] font_word;
   wire font_bit;
	
	//Declaración de señales de variables a mostrar
	reg [6:0] char_addr_FECHA, char_addr_NumFECHA, char_addr_HORA, char_addr_NumHORA, char_addr_ForMili, char_addr_TIMER, char_addr_NumTIMER, char_addr_SIMBOLO;
	//reg [11:0] char_addr_FECHA, char_addr_NumFECHA, char_addr_HORA, char_addr_NumHORA, char_addr_ForMili, char_addr_TIMER, char_addr_NumTIMER, char_addr_SIMBOLO;

	wire [3:0] row_addr_FECHA, row_addr_NumFECHA, row_addr_HORA, row_addr_NumHORA, row_addr_ForMili, row_addr_TIMER, row_addr_NumTIMER, row_addr_SIMBOLO; //fila (y)
   wire [2:0] bit_addr_FECHA, bit_addr_NumFECHA, bit_addr_HORA, bit_addr_NumHORA, bit_addr_ForMili, bit_addr_TIMER, bit_addr_NumTIMER, bit_addr_SIMBOLO; //bit (x)
	wire FECHA_on, NumFECHA_on, HORA_on, NumHORA_on, ForMili_on, TIMER_on, NumTIMER_on, SIMBOLO_on; //establecera valor booleano como indicador que se pintara palabra FECHA
	reg [6:0] char_addr_FECHA_reg;
	//reg [15:0] char_addr_FECHA_reg;

	//Instanciar FONT ROM
	
	font_rom font_unit
      (.clk(CLK), .addr(rom_addr), .data(font_word));
	
	//VALORES DE LIMITES DE LOS CUADROS QUE ENCERRARAN LOS NUMEROS
		//Limites para caja de fecha
	localparam Caja_FECHA_XI = 59; //limite izquierdo de la caja
	localparam Caja_FECHA_XD = 324; //limite derecho de la caja
	localparam Caja_FECHA_YA = 60; //Limite superior de la caja
	localparam Caja_FECHA_YD = 131; //limite inferior de la caja 
	
	//Limites para caja de TIMER
	localparam Caja_TIMER_XI = 59; //limite izquierdo de la caja
	localparam Caja_TIMER_XD = 324; //limite derecho de la caja
	localparam Caja_TIMER_YA = 316; //Limite superior de la caja
	localparam Caja_TIMER_YD = 387; //limite inferior de la caja
	
	//Limites para caja de HORA
	localparam Caja_HORA_XI = 59; //limite izquierdo de la caja
	localparam Caja_HORA_XD = 324; //limite derecho de la caja
	localparam Caja_HORA_YA = 187; //Limite superior de la caja
	localparam Caja_HORA_YD = 260; //limite inferior de la caja
	
	
	//VARIABLES PARA CADA NUMERO QUE SE VAN A DIVIDIR DE UN NUMERO MAYOR
	wire [3:0] digitDec_DD, digitUni_DD, digitDec_M, digitUni_M, digitDec_AN, digitUni_AN,
	digitDec_HORA, digitUni_HORA, digitDec_MIN, digitUni_MIN, digitDec_SEG, digitUni_SEG,
	digitDec_TimerHORA, digitUni_TimerHORA, digitDec_TimerMIN, digitUni_TimerMIN, digitDec_TimerSEG, digitUni_TimerSEG;
	
	
	
	//PARA REALIZAR PRUEBA
	//HACER UN DIVISOR DE FRECUENCIA DE 25MHz A APROX
	reg [24:0] cont = 0;
	wire CLK1Hz;
	
	always @ (posedge CLK) begin
		if (cont == 25000000) begin
			cont <= 0;
		end
		else begin
			cont <= cont + 1'b1;
		end
	end
	assign CLK1Hz = cont[24];	
	
	//FECHA
	assign digitDec_DD = digit_DD[7:4];
	assign digitUni_DD = digit_DD[3:0];
	assign digitDec_M  = digit_M[7:4];
	assign digitUni_M  = digit_M[3:0];
	assign digitDec_AN = digit_AN[7:4];
	assign digitUni_AN = digit_AN[3:0];
	
	//HORA
	assign digitDec_HORA = digit_HORA[7:4];
	assign digitUni_HORA = digit_HORA[3:0];
	assign digitDec_MIN  = digit_MIN[7:4];
	assign digitUni_MIN  = digit_MIN[3:0];
	assign digitDec_SEG  = digit_SEG[7:4];
	assign digitUni_SEG  = digit_SEG[3:0];
	
	//TIMER
	assign digitDec_TimerHORA = digit_TimerHORA[7:4];
	assign digitUni_TimerHORA = digit_TimerHORA[3:0];
	assign digitDec_TimerMIN  = digit_TimerMIN[7:4];
	assign digitUni_TimerMIN  = digit_TimerMIN[3:0];
	assign digitDec_TimerSEG  = digit_TimerSEG[7:4];
	assign digitUni_TimerSEG  = digit_TimerSEG[3:0];
	
	//ESTABLECER LAS SEÑALES DE "ON" DE CADA CAJA
	//DECLARACIÓN DE LAS SEÑALES DE LA CAJA
	wire Caja_FECHA_on, Caja_TIMER_on, Caja_HORA_on;
	
	//ESTABLECIMIENTO CUANDO SE PINTARAN LOS CUADROS
	assign Caja_FECHA_on = (pix_x>=Caja_FECHA_XI)&&(pix_x<=Caja_FECHA_XD)&&(pix_y>=Caja_FECHA_YA)&&(pix_y<=Caja_FECHA_YD);
	assign Caja_TIMER_on = (pix_x>=Caja_TIMER_XI)&&(pix_x<=Caja_TIMER_XD)&&(pix_y>=Caja_TIMER_YA)&&(pix_y<=Caja_TIMER_YD);
	assign Caja_HORA_on = (pix_x>=Caja_HORA_XI)&&(pix_x<=Caja_HORA_XD)&&(pix_y>=Caja_HORA_YA)&&(pix_y<=Caja_HORA_YD);
	
	
	//Imagen Fecha
	localparam fecha_X = 129; 
	localparam fecha_Y = 29; 
	localparam fecha_size = 3741;// (129x29)
	
	//Imagen Hora
	localparam hora_X = 111; 
	localparam hora_Y = 29; 
	localparam hora_size = 3219;// (111x29)
	
	//Imagen Timer
	localparam timer_X = 136; 
	localparam timer_Y = 28; 
	localparam timer_size = 3808;// (136x28)
	 
	//Imagen 24H
	localparam H24_X = 93;
	localparam H24_Y = 29;
	localparam H24_size = 2697;//(93x29);
	

	//Imagen Flechas
	localparam flechas_X = 154;
	localparam flechas_Y = 103;
	localparam flechas_size = 15862; //(154x103)
	
	//Imagen Ring
	localparam ring_X = 55;
	localparam ring_Y = 50;
	localparam ring_size = 2750; //(55x50);
	
	//Imagen Programar Fecha
	localparam PFX = 183;
	localparam PFY = 24;
	localparam PF_size = 4392;
	
	//Imagen Programar Hora
	localparam PHX = 173;
	localparam PHY = 25;
	localparam PH_size = 4325;
	
	//Imagen Programar Timer
	localparam PTX = 188;
	localparam PTY = 24;
	localparam PT_size = 4512;
	
	//Imagen Activar Timer
	localparam ATX = 217;
	localparam ATY = 19;
	localparam AT_size = 4123;
	
	//Imagen Detener alarma
	localparam DTX = 285;
	localparam DTY = 19;
	localparam DT_size = 5415;
	
	
	
	//Declaración señales
	
	reg [11:0] COLOUR_DATA_f [0:fecha_size-1];
	reg [11:0] COLOUR_DATA_h [0:hora_size-1];
	reg [11:0] COLOUR_DATA_t [0:timer_size-1];
	reg [11:0] COLOUR_DATA_fl [0:flechas_size-1];
	reg [11:0] COLOUR_DATA_r [0:ring_size-1];
	reg [11:0] COLOUR_DATA_H24 [0:H24_size-1];
	reg [11:0] COLOUR_DATA_AT [0:AT_size-1];
	reg [11:0] COLOUR_DATA_DT [0:DT_size-1];
	reg [11:0] COLOUR_DATA_PF [0:PF_size-1];
	reg [11:0] COLOUR_DATA_PH [0:PH_size-1];
	reg [11:0] COLOUR_DATA_PT [0:PT_size-1];
	
	wire [19:0] STATE_f;
	wire [19:0] STATE_h;
	wire [19:0] STATE_t;
	wire [19:0] STATE_AT;
	wire [19:0] STATE_DT;
	wire [19:0] STATE_PF;
	wire [19:0] STATE_PH;
	wire [19:0] STATE_PT;
	wire [19:0] STATE_fl;
	wire [19:0] STATE_r;
	wire [19:0] STATE_H24;

	
	wire im_fecha;
	wire im_hora;
	wire im_timer;
	wire im_AT;
	wire im_DT;
	wire im_PF;
	wire im_PH;
	wire im_PT;
	wire im_flechas;
	wire im_ring;
	wire im_H24;
	
	reg  [11:0] graph_rgb_aux;
		
	
	//Coordenadas Imagen Fecha
	reg signed [10:0]X = 127;
	reg signed [9:0]Y = 30;

	
	//Coordenadas Imagen Hora
	reg signed [10:0]XH = 100;
	reg signed [9:0]YH = 155;
	
	//Coordenadas Imagen timer
	reg signed [10:0]XT = 123;
	reg signed [9:0]YT = 280;
	
	
	//Coordenadas Imagen Flechas
	reg signed [10:0]XF = 400;
	reg signed [9:0]YF = 185;
	
	//Coordenadas Imagen Ring
	reg signed [10:0]XR = 400;
	reg signed [9:0]YR = 318;
	
	//Coordenadas Imagen 24H
	reg signed [10:0]XH24 = 235;
	reg signed [9:0]YH24 = 155;
	
	//Coordenadas Imagen PF
	reg signed [10:0]XPF = 340;
	reg signed [9:0]YPF = 15;
	
	//Coordenadas Imagen PH
	reg signed [10:0]XPH = 340;
	reg signed [9:0]YPH = 44;

	//Coordenadas Imagen PT
	reg signed [10:0]XPT = 340;
	reg signed [9:0]YPT = 74;
	
	//Coordenadas Imagen AT
	reg signed [10:0]XAT = 340;
	reg signed [9:0]YAT = 103;
	
	//Coordenadas Imagen DT
	reg signed [10:0]XDT = 340;
	reg signed [9:0]YDT = 131;
	
	
	//Lectura de las imágenes
	
	initial
	$readmemh ("fecha.list", COLOUR_DATA_f);
	
	initial
	$readmemh ("hora1.list", COLOUR_DATA_h);
	
	initial
	$readmemh ("timer1.list", COLOUR_DATA_t);

	initial
	$readmemh ("flechas.list", COLOUR_DATA_fl);
	
	initial
	$readmemh ("ring1.list", COLOUR_DATA_r);
	
	initial
	$readmemh ("24h.list", COLOUR_DATA_H24);
	
	initial
	$readmemh ("PF.list", COLOUR_DATA_PF);
	
	initial
	$readmemh ("PH.list", COLOUR_DATA_PH);
	
	initial
	$readmemh ("PT.list", COLOUR_DATA_PT);
	
	initial
	$readmemh ("DT.list", COLOUR_DATA_DT);
	
	initial
	$readmemh ("AT1.list", COLOUR_DATA_AT);
	

	
	
	//Asignación STATE
	
	
	assign STATE_f = ((pix_x-X)*fecha_Y)+pix_y-Y;
	assign STATE_h = ((pix_x-XH)*hora_Y)+pix_y-YH;
	assign STATE_t = ((pix_x-XT)*timer_Y)+pix_y-YT;
	assign STATE_fl = ((pix_x-XF)*flechas_Y)+pix_y-YF;
	assign STATE_r = ((pix_x-XR)*ring_Y)+pix_y-YR;
	assign STATE_H24 = ((pix_x-XH24)*H24_Y)+pix_y-YH24;
	assign STATE_PH = ((pix_x-XPH)*PHY)+pix_y-YPH;
	assign STATE_PF = ((pix_x-XPF)*PFY)+pix_y-YPF;
	assign STATE_PT = ((pix_x-XPT)*PTY)+pix_y-YPT;
	assign STATE_AT = ((pix_x-XAT)*ATY)+pix_y-YAT;
	assign STATE_DT = ((pix_x-XDT)*DTY)+pix_y-YDT;
	

	
	//Verifica cuando se cumplen las coordenadas para pintar la imagen
		
		assign im_fecha = (pix_x>=X && pix_x<X+fecha_X && pix_y>=Y && pix_y<Y+fecha_Y);
		assign im_hora = (pix_x>=XH && pix_x<XH+hora_X && pix_y>=YH && pix_y<YH+hora_Y);
		assign im_timer = (pix_x>=XT && pix_x<XT+timer_X	&& pix_y>=YT && pix_y<YT+timer_Y);
		assign im_flechas = (pix_x>=XF && pix_x<XF+flechas_X && pix_y>=YF && pix_y<YF+flechas_Y);
		assign im_ring = (pix_x>=XR && pix_x<XR+ring_X && pix_y>=YR && pix_y<YR+ring_Y);
		assign im_H24= (pix_x>=XH24 && pix_x<XH24+H24_X && pix_y>=YH24 && pix_y<YH24+H24_Y);
		assign im_PH= (pix_x>=XPH && pix_x<XPH+PHX && pix_y>=YPH && pix_y<YPH+PHY);
		assign im_PF= (pix_x>=XPF && pix_x<XPF+PFX && pix_y>=YPF && pix_y<YPF+PFY);
		assign im_PT= (pix_x>=XPT && pix_x<XPT+PTX && pix_y>=YPT && pix_y<YPT+PTY);
		assign im_AT= (pix_x>=XAT && pix_x<XAT+ATX && pix_y>=YAT && pix_y<YAT+ATY);
		assign im_DT= (pix_x>=XDT && pix_x<XDT+DTX && pix_y>=YDT && pix_y<YDT+DTY);
		
	
	
	//Mostrar digitos de la fecha 64x32
	assign NumFECHA_on = (pix_y[9:5]<=3) && (pix_y[9:5]>=2) && (pix_x[9:6]>=1) && (pix_x[9:6]<=4); //coordenadas donde se pintara los digitos
	assign row_addr_NumFECHA = pix_y[5:2]; //tamaño de la letra 
	assign bit_addr_NumFECHA = pix_x[4:2]; //tamaño de la letra

	always@*
	begin
		case(pix_x[7:5]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumFECHA_on
			3'h2: char_addr_NumFECHA = {3'b011, digitDec_DD};//(decenas dia)  
			3'h3: char_addr_NumFECHA = {3'b011, digitUni_DD};//(unidades dia) 
			3'h4: char_addr_NumFECHA = 7'h2f;// /
			//3'h4: char_addr_NumFECHA = 16'h5e0;// /
			3'h5: char_addr_NumFECHA = {3'b011, digitDec_M};//(decenas Mes)
			3'h6: char_addr_NumFECHA = {3'b011, digitUni_M};//(unidades mes)
			3'h7: char_addr_NumFECHA = 7'h2f;// /
			//3'h7: char_addr_NumFECHA = 16'h5e0;// /
			3'h0: char_addr_NumFECHA = {3'b011, digitDec_AN};//(unidad de millar año)
			3'h1: char_addr_NumFECHA = {3'b011, digitUni_AN};//(Centenas año)
			//default: char_addr_NumFECHA = 16'h000;//Espacio en blanco
			default: char_addr_NumFECHA = 7'h00;//Espacio en blanco
		endcase	
	end
	
	// Mostrar digitos de la Hora
	assign NumHORA_on = (pix_y[9:5]>=6)&& (pix_y[9:5]<=7) && (pix_x[9:6]>=1) && (pix_x[9:6]<=4);
	assign row_addr_NumHORA = pix_y[5:2];
	assign bit_addr_NumHORA = pix_x[4:2];

	always@*
	begin
		case(pix_x[7:5]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumHORA_on
			3'h2: char_addr_NumHORA = {3'b011, digitDec_HORA};//(decenas dia)
			3'h3: char_addr_NumHORA = {3'b011, digitUni_HORA};//(unidades dia)
			3'h4: char_addr_NumHORA = 7'h3a;// :
			3'h5: char_addr_NumHORA = {3'b011, digitDec_MIN};//(decenas Mes)
			3'h6: char_addr_NumHORA = {3'b011, digitUni_MIN};//(unidades mes)
			3'h7: char_addr_NumHORA = 7'h3a;// :
			3'h0: char_addr_NumHORA = {3'b011, digitDec_SEG};//(unidad de millar año)
			3'h1: char_addr_NumHORA = {3'b011, digitUni_SEG};//(Centenas año)
			default: char_addr_NumHORA = 7'h00;//Espacio en blanco
		endcase	
	end

	// Mostrar digitos del Timer
	assign NumTIMER_on = (pix_y[9:5]>=10) && (pix_y[9:5]<=11) && (pix_x[9:6]>=1) && (pix_x[9:6]<=4);
	assign row_addr_NumTIMER = pix_y[5:2];
	assign bit_addr_NumTIMER = pix_x[4:2];

	always@*
	begin
		case(pix_x[7:5]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumTIMER_on
			3'h2: char_addr_NumTIMER = {3'b011, digitDec_TimerHORA};//(decenas dia)
			3'h3: char_addr_NumTIMER = {3'b011, digitUni_TimerHORA};//(unidades dia)
			3'h4: char_addr_NumTIMER = 7'h3a;// :
			3'h5: char_addr_NumTIMER = {3'b011, digitDec_TimerMIN};//(decenas Mes)
			3'h6: char_addr_NumTIMER = {3'b011, digitUni_TimerMIN};//(unidades mes)
			3'h7: char_addr_NumTIMER = 7'h3a;// :
			3'h0: char_addr_NumTIMER = {3'b011, digitDec_TimerSEG};//(decenas año)
			3'h1: char_addr_NumTIMER = {3'b011, digitUni_TimerSEG};//(unidades año)
			default: char_addr_NumTIMER = 7'h00;//Espacio en blanco
		endcase	
	end

	
	
	assign rom_addr = {char_addr, row_addr};
  	 assign font_bit = font_word[~bit_addr];
	
	//Mostrar en pantalla las letras con los colores definidos
	//Multiplexar las direcciones del font ROM con salida RBG
	always @(posedge CLK) begin
		
		graph_rgb = 12'h000;
		
		//Caso cuando se cumplen las coordenadas de una imagen
		
		if(im_hora) graph_rgb = COLOUR_DATA_h[{STATE_h}];
		else if (im_fecha) graph_rgb = COLOUR_DATA_f[{STATE_f}];
		else if (im_timer) graph_rgb = COLOUR_DATA_t[{STATE_t}];
		else if (im_flechas) graph_rgb = COLOUR_DATA_fl[{STATE_fl}];
		else if (im_ring) 
			begin
			if (Alarma_on == 1 && CLK1Hz==1)
					graph_rgb = COLOUR_DATA_r[{STATE_r}];
			else 
				graph_rgb = 12'h000;
			end
			
		else if (im_H24) graph_rgb = COLOUR_DATA_H24[{STATE_H24}];
		else if (im_PH) graph_rgb = COLOUR_DATA_PH[{STATE_PH}];
		else if (im_PF) graph_rgb = COLOUR_DATA_PF[{STATE_PF}];
		else if (im_PT) graph_rgb = COLOUR_DATA_PT[{STATE_PT}];
		else if (im_AT) graph_rgb = COLOUR_DATA_AT[{STATE_AT}];
		else if (im_DT) graph_rgb = COLOUR_DATA_DT[{STATE_DT}];
		
		
		else if(NumFECHA_on) //Digitos de la fecha
		begin
			char_addr = char_addr_NumFECHA;
			row_addr = row_addr_NumFECHA;
			bit_addr = bit_addr_NumFECHA;
			
				if (font_bit) begin //CAMBIAR COORDENADAS Y COLOR
					if ((pix_y[9:5]<=3) && (pix_y[9:5]>=2) &&(pix_x[9:6]>=1)&&(pix_x[9:6]<2)&&(bandera_cursor[8]==1)) //DIA 
						graph_rgb = 12'hFE0;//Hace un cursor AMARILLO
					else if ((pix_y[9:5]<=3) && (pix_y[9:5]>=2) &&(pix_x[9:5]>=5)&&(pix_x[9:5]<7)&&(bandera_cursor[7]==1))   //MES  
						graph_rgb = 12'hFE0;//Hace un cursor AMARILLO
					else if ((pix_y[9:5]<=3) && (pix_y[9:5]>=2) &&(pix_x[9:5]>=8)&&(pix_x[9:5]<10)&&(bandera_cursor[6]==1))  //AÑO  
						graph_rgb = 12'hFE0;//Hace un cursor AMARILLO
					else
						graph_rgb = 12'hFFF; //blanco
				end
		end
		
		
		else if (NumHORA_on)  //Digitos de la HORA
		begin
			char_addr = char_addr_NumHORA;
			row_addr = row_addr_NumHORA;
			bit_addr = bit_addr_NumHORA;
			
				if (font_bit) begin //CAMBIAR COORDENADAS Y COLOR
					if ((pix_y[9:5]>=6)&&(pix_y[9:5]<=7)&&(pix_x[9:6]>=1)&&(pix_x[9:6]<2)&&(bandera_cursor[5]==1)) //HORA QUITE UN = EN SEGUNDO X
						graph_rgb = 12'hFE0;//Hace un cursor AMARILLO
					else if ((pix_y[9:5]>=6)&&(pix_y[9:5]<=7)&&(pix_x[9:5]>=5)&&(pix_x[9:5]<7)&&(bandera_cursor[4]==1))   //MINUTO  QUITE UN = EN SEGUNDO X
						graph_rgb = 12'hFE0;//Hace un cursor AMARILLO
					else if ((pix_y[9:5]>=6)&&(pix_y[9:5]<=7)&&(pix_x[9:5]>=8)&&(pix_x[9:5]<10)&&(bandera_cursor[3]==1))  //SEGUNDO  QUITE UN = EN SEGUNDO X
						graph_rgb = 12'hFE0;//Hace un cursor AMARILLO
					else
						graph_rgb = 12'hFFF; //blanco
				end
		end
		
		
		else if (NumTIMER_on)  //Digitos del Timer
		begin
			char_addr = char_addr_NumTIMER;
			row_addr = row_addr_NumTIMER;
			bit_addr = bit_addr_NumTIMER;
			
				if (font_bit) begin //CAMBIAR COORDENADAS Y COLOR
					if ((pix_y[9:5]>=10)&&(pix_y[9:5]<=11)&&(pix_x[9:6]>=1)&&(pix_x[9:6]<2)&&(bandera_cursor[2]==1)) //HORA QUITE UN = EN SEGUNDO X
						graph_rgb = 12'hFE0;//Hace un cursor AMARILLO
					else if ((pix_y[9:5]>=10)&&(pix_y[9:5]<=11)&&(pix_x[9:5]>=5)&&(pix_x[9:5]<7)&&(bandera_cursor[1]==1))   //MINUTO  QUITE UN = EN SEGUNDO X
						graph_rgb = 12'hFE0;//Hace un cursor AMARILLO
					else if ((pix_y[9:5]>=10)&&(pix_y[9:5]<=11)&&(pix_x[9:5]>=8)&&(pix_x[9:5]<10)&&(bandera_cursor[0]==1))  //SEGUNDO  QUITE UN = EN SEGUNDO X
						graph_rgb = 12'hFE0;//Hace un cursor AMARILLO			
					else
						graph_rgb = 12'hFFF;
				end
		end
		
		
		//PARA IMPRIMIR LAS CAJAS
		else if (Caja_FECHA_on)
		begin
			graph_rgb = 12'hF7F;
		end
		
		else if (Caja_TIMER_on)
		begin
			graph_rgb = 12'h0FF;
		end
		
		else if (Caja_HORA_on)
		begin
			graph_rgb = 12'h5AF;
		end
		
		else begin
			graph_rgb = 12'h000; //negro
			
		end
	end
	
endmodule 
