`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Fabio Ureña Rojas
// 
// Create Date:    16:45:40 10/17/2016 
// Design Name: 
// Module Name:    Generador_Letras 
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
	output reg [2:0] graph_rgb // Salida para controlar color en VGA.
   );
	
	// Declaración de señales, base. Para el momento de impresion
   wire [10:0] rom_addr;
   reg [6:0] char_addr;
   reg [3:0] row_addr;
   reg [2:0] bit_addr;
   wire [7:0] font_word;
   wire font_bit;
	
	//Declaración de señales de variables a mostrar
	reg [6:0] char_addr_FECHA, char_addr_NumFECHA, char_addr_HORA, char_addr_NumHORA, char_addr_ForMili, char_addr_TIMER, char_addr_NumTIMER, char_addr_SIMBOLO;
	wire [3:0] row_addr_FECHA, row_addr_NumFECHA, row_addr_HORA, row_addr_NumHORA, row_addr_ForMili, row_addr_TIMER, row_addr_NumTIMER, row_addr_SIMBOLO; //fila (y)
   wire [2:0] bit_addr_FECHA, bit_addr_NumFECHA, bit_addr_HORA, bit_addr_NumHORA, bit_addr_ForMili, bit_addr_TIMER, bit_addr_NumTIMER, bit_addr_SIMBOLO; //bit (x)
	wire FECHA_on, NumFECHA_on, HORA_on, NumHORA_on, ForMili_on, TIMER_on, NumTIMER_on, SIMBOLO_on; //establecera valor booleano como indicador que se pintara palabra FECHA
	reg [6:0] char_addr_FECHA_reg;
	//Instanciar FONT ROM
	font_rom font_unit
      (.clk(CLK), .addr(rom_addr), .data(font_word));
	
	//VALORES DE LIMITES DE LOS CUADROS QUE ENCERRARAN LOS NUMEROS
		//Limites para caja de fecha
	localparam Caja_FECHA_XI = 187; //limite izquierdo de la caja
	localparam Caja_FECHA_XD = 452; //limite derecho de la caja
	localparam Caja_FECHA_YA = 60; //Limite superior de la caja
	localparam Caja_FECHA_YD = 131; //limite inferior de la caja 
	
	//Limites para caja de TIMER
	localparam Caja_TIMER_XI = 124; //limite izquierdo de la caja
	localparam Caja_TIMER_XD = 259; //limite derecho de la caja
	localparam Caja_TIMER_YA = 348; //Limite superior de la caja
	localparam Caja_TIMER_YD = 387; //limite inferior de la caja
	
	//Limites para caja de HORA
	localparam Caja_HORA_XI = 124; //limite izquierdo de la caja
	localparam Caja_HORA_XD = 259; //limite derecho de la caja
	localparam Caja_HORA_YA = 220; //Limite superior de la caja
	localparam Caja_HORA_YD = 259; //limite inferior de la caja
	
	
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


///// BORRAR
/////	BORRAR
/*	reg [7:0] TIMERHORA=0;
	
	reg [5:0] contadora = 0;
	always @(posedge CLK1Hz)
	begin
		if (contadora==59)
		begin
			TIMERHORA=4'b0000;
			contadora=0;
		end
		else
		begin
			TIMERHORA=TIMERHORA+1;
			contadora=contadora+1;
		end
	end
	assign digit_TimerHORA = TIMERHORA;*/
	
	
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
	
	//1. Definir el espacio y las letras correspondientes a la palabra FECHA 16x32
	assign FECHA_on = ((pix_y>=28) && (pix_y<=59) && (pix_x[9:4]>=18) && (pix_x[9:4]<=22));
	assign row_addr_FECHA = pix_y[4:1]; //me define el tamaño de la letra
	assign bit_addr_FECHA = pix_x[3:1]; //me define el tamaño de la letra
	
	
	always @* 
		case(pix_x[6:4]) //para este caso cada 2^4 bits se pinta nueva letra
							  //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en FECHA_on
			4'h2: char_addr_FECHA = 7'h46; //F
			4'h3: char_addr_FECHA = 7'h45; //E
			4'h4: char_addr_FECHA = 7'h43; //C
			4'h5: char_addr_FECHA = 7'h48; //H
			4'h6: char_addr_FECHA = 7'h41; //A
			default: char_addr_FECHA = 7'h20;//Espacio en blanco
		endcase

	//2. Mostrar digitos de la fecha 64x32
	assign NumFECHA_on = (pix_y[9:5]<=3) && (pix_y[9:5]>=2) && (pix_x[9:6]>=3) && (pix_x[9:6]<=6); //coordenadas donde se pintara los digitos
	assign row_addr_NumFECHA = pix_y[5:2]; //tamaño de la letra 
	assign bit_addr_NumFECHA = pix_x[4:2]; //tamaño de la letra

	always@*
	begin
		case(pix_x[7:5]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumFECHA_on
			3'h6: char_addr_NumFECHA = {3'b011, digitDec_DD};//(decenas dia)  
			3'h7: char_addr_NumFECHA = {3'b011, digitUni_DD};//(unidades dia) 
			3'h0: char_addr_NumFECHA = 7'h2f;// /
			3'h1: char_addr_NumFECHA = {3'b011, digitDec_M};//(decenas Mes)
			3'h2: char_addr_NumFECHA = {3'b011, digitUni_M};//(unidades mes)
			3'h3: char_addr_NumFECHA = 7'h2f;// /
			3'h4: char_addr_NumFECHA = {3'b011, digitDec_AN};//(unidad de millar año)
			3'h5: char_addr_NumFECHA = {3'b011, digitUni_AN};//(Centenas año)
			default: char_addr_NumFECHA = 7'h00;//Espacio en blanco
		endcase	
	end
	
	//3. Mostrar Palabra HORA
	assign HORA_on = ((pix_y>=192) && (pix_y<=219) && (pix_x[9:5]>=2) && (pix_x[9:5]<=3)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_HORA = pix_y[4:1]; //pix_y[5:1] //me define el tamaño de la letra
	assign bit_addr_HORA = pix_x[3:1]; //pix_x[4:1]//me define el tamaño de la letra
	
	always @* 
	begin
		case(pix_x[5:4]) //para este caso cada 2^4 bits se pinta nueva letra
							  //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en HORA_on
			2'h0: char_addr_HORA = 7'h48; //H
			2'h1: char_addr_HORA = 7'h4f; //O
			2'h2: char_addr_HORA = 7'h52; //R
			2'h3: char_addr_HORA = 7'h41; //A
			default: char_addr_HORA = 7'h00;//Espacio en blanco
			
		endcase
	end
	
	//4. Mostrar Palabra 24 H
	assign ForMili_on = ((pix_y[9:5]==7) && (pix_x[9:5]>=9) && (pix_x[9:5]<=10)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_ForMili = pix_y[4:1]; // pix_y[5:1]//me define el tamaño de la letra
	assign bit_addr_ForMili = pix_x[3:1]; // pix_x[4:1]//me define el tamaño de la letra
	
	always @* 
	begin
		case(pix_x[5:4]) //para este caso cada 2^4 bits se pinta nueva letra
							  
			2'h2: char_addr_ForMili = 7'h32; //2
			2'h3: char_addr_ForMili = 7'h34; //4 
			2'h0: char_addr_ForMili = 7'h00; //espacio en blanco
			2'h1: char_addr_ForMili = 7'h48; //H
			
			
		endcase
	end

	//5. Mostrar digitos de la Hora
	assign NumHORA_on = (pix_y[9:5]==7) && (pix_x[9:5]>=4) && (pix_x[9:5]<=7);
	assign row_addr_NumHORA = pix_y[4:1];
	assign bit_addr_NumHORA = pix_x[3:1];

	always@*
	begin
		case(pix_x[6:4]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumHORA_on
			3'h0: char_addr_NumHORA = {3'b011, digitDec_HORA};//(decenas dia)
			3'h1: char_addr_NumHORA = {3'b011, digitUni_HORA};//(unidades dia)
			3'h2: char_addr_NumHORA = 7'h3a;// /
			3'h3: char_addr_NumHORA = {3'b011, digitDec_MIN};//(decenas Mes)
			3'h4: char_addr_NumHORA = {3'b011, digitUni_MIN};//(unidades mes)
			3'h5: char_addr_NumHORA = 7'h3a;// /
			3'h6: char_addr_NumHORA = {3'b011, digitDec_SEG};//(unidad de millar año)
			3'h7: char_addr_NumHORA = {3'b011, digitUni_SEG};//(Centenas año)
			default: char_addr_NumHORA = 7'h00;//Espacio en blanco
		endcase	
	end
	
	//6. Mostrar Palabra TIMER
	assign TIMER_on = ((pix_y>=320) && (pix_y<=347) && (pix_x[9:5]>=2) && (pix_x[9:5]<=4)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_TIMER = pix_y[4:1]; //pix_y[5:1]//me define el tamaño de la letra
	assign bit_addr_TIMER = pix_x[3:1]; //pix_x[4:1]//me define el tamaño de la letra
	
	always @* 
	begin
		case(pix_x[6:4]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en TIMER_on
			3'h4: char_addr_TIMER = 7'h54; //T
			3'h5: char_addr_TIMER = 7'h49; //I
			3'h6: char_addr_TIMER = 7'h4d; //M
			3'h7: char_addr_TIMER = 7'h45; //E
			3'h0: char_addr_TIMER = 7'h52; //R
			default: char_addr_TIMER = 7'h00;//Espacio en blanco
			
		endcase
	end
	
	//7. Mostrar digitos del Timer
	assign NumTIMER_on = (pix_y[9:5]==11) && (pix_x[9:5]>=4) && (pix_x[9:5]<=7);
	assign row_addr_NumTIMER = pix_y[4:1];
	assign bit_addr_NumTIMER = pix_x[3:1];

	always@*
	begin
		case(pix_x[6:4]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumTIMER_on
			3'h0: char_addr_NumTIMER = {3'b011, digitDec_TimerHORA};//(decenas dia)
			3'h1: char_addr_NumTIMER = {3'b011, digitUni_TimerHORA};//(unidades dia)
			3'h2: char_addr_NumTIMER = 7'h3a;// /
			3'h3: char_addr_NumTIMER = {3'b011, digitDec_TimerMIN};//(decenas Mes)
			3'h4: char_addr_NumTIMER = {3'b011, digitUni_TimerMIN};//(unidades mes)
			3'h5: char_addr_NumTIMER = 7'h3a;// /
			3'h6: char_addr_NumTIMER = {3'b011, digitDec_TimerSEG};//(decenas año)
			3'h7: char_addr_NumTIMER = {3'b011, digitUni_TimerSEG};//(unidades año)
			default: char_addr_NumTIMER = 7'h00;//Espacio en blanco
		endcase	
	end

	//8. Mostrar Simbolo para la alarma
	assign SIMBOLO_on = (pix_y[9:5]==9) && (pix_x[9:5]==16);
	assign row_addr_SIMBOLO = pix_y[4:1]; //pix_y[5:1]
	assign bit_addr_SIMBOLO = pix_x[3:1]; //pix_x[4:1]

	always@*
	begin
		case(pix_x[9:5]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en SIMBOLO_on
			5'd16: char_addr_SIMBOLO = 7'h06; //simbolo de espadas
			default: char_addr_SIMBOLO = 7'h00;//Espacio en blanco
		endcase	
	end
	
	assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];
	
	//Mostrar en pantalla las letras con los colores definidos
	//Multiplexar las direcciones del font ROM con salida RBG
	always @(posedge CLK) begin
		
		graph_rgb = 3'b000;
		if (FECHA_on) //palabra FECHA
		begin
			char_addr = char_addr_FECHA;
			row_addr = row_addr_FECHA;
			bit_addr = bit_addr_FECHA;
				if (font_bit) begin
					graph_rgb = 3'b010; //verde
				end
		end
		
		else if(NumFECHA_on) //Digitos de la fecha
		begin
			char_addr = char_addr_NumFECHA;
			row_addr = row_addr_NumFECHA;
			bit_addr = bit_addr_NumFECHA;
			
				if (font_bit) begin
					if ((pix_y[9:5]<=3) && (pix_y[9:5]>=2) &&(pix_x[9:5]>=6)&&(pix_x[9:5]<8)&&(bandera_cursor[8]==1)) //DIA 
						graph_rgb = 3'b001;//Hace un cursor AZUL
					else if ((pix_y[9:5]<=3) && (pix_y[9:5]>=2) &&(pix_x[9:5]>=9)&&(pix_x[9:5]<11)&&(bandera_cursor[7]==1))   //MES  
						graph_rgb = 3'b001;//Hace un cursor AZUL
					else if ((pix_y[9:5]<=3) && (pix_y[9:5]>=2) &&(pix_x[9:5]>=12)&&(pix_x[9:5]<14)&&(bandera_cursor[6]==1))  //AÑO  
						graph_rgb = 3'b001;//Hace un cursor AZUL
					else
						graph_rgb = 3'b111; //blanco
				end
		end
		
		else if (HORA_on)  //Palabra HORA
		begin
			char_addr = char_addr_HORA;
			row_addr = row_addr_HORA;
			bit_addr = bit_addr_HORA;
				if (font_bit) begin
					graph_rgb = 3'b010; //verde
				end
		end
		
		else if (NumHORA_on)  //Digitos de la HORA
		begin
			char_addr = char_addr_NumHORA;
			row_addr = row_addr_NumHORA;
			bit_addr = bit_addr_NumHORA;
			
				if (font_bit) begin
					if ((pix_y[9:5]==7)&&(pix_x[9:4]>=8)&&(pix_x[9:4]<10)&&(bandera_cursor[5]==1)) //HORA QUITE UN = EN SEGUNDO X
						graph_rgb = 3'b001;//Hace un cursor AZUL
					else if ((pix_y[9:5]==7)&&(pix_x[9:4]>=11)&&(pix_x[9:4]<13)&&(bandera_cursor[4]==1))   //MINUTO  QUITE UN = EN SEGUNDO X
						graph_rgb = 3'b001;//Hace un cursor AZUL
					else if ((pix_y[9:5]==7)&&(pix_x[9:4]>=14)&&(pix_x[9:4]<16)&&(bandera_cursor[3]==1))  //SEGUNDO  QUITE UN = EN SEGUNDO X
						graph_rgb = 3'b001;//Hace un cursor AZUL
					else
						graph_rgb = 3'b111; //blanco
				end
		end
		
		else if (ForMili_on) //Palabra 24H. Posteriormente se hará cambio
		begin
			char_addr = char_addr_ForMili;
			row_addr = row_addr_ForMili;
			bit_addr = bit_addr_ForMili;
				if (font_bit) begin
					graph_rgb = 3'b111; //blanco
				end
		end
		
		else if (TIMER_on) //Palabra TIMER
		begin
			char_addr = char_addr_TIMER;
			row_addr = row_addr_TIMER;
			bit_addr = bit_addr_TIMER;
				if (font_bit) begin
					graph_rgb = 3'b010; //verde
				end
		end
		
		else if (NumTIMER_on)  //Digitos del Timer
		begin
			char_addr = char_addr_NumTIMER;
			row_addr = row_addr_NumTIMER;
			bit_addr = bit_addr_NumTIMER;
			//Evalúa que se está configurando (0: modo normal, 1: config.hora, 2: config.fecha, 4: config.timer)
				if (font_bit) begin
					if ((pix_y[9:5]==11)&&(pix_x[9:4]>=8 )&&(pix_x[9:4]<10)&&(bandera_cursor[2]==1)) //HORA QUITE UN = EN SEGUNDO X
						graph_rgb = 3'b001;//Hace un cursor AZUL
					else if ((pix_y[9:5]==11)&&(pix_x[9:4]>=11)&&(pix_x[9:4]<13)&&(bandera_cursor[1]==1))   //MINUTO  QUITE UN = EN SEGUNDO X
						graph_rgb = 3'b001;//Hace un cursor AZUL
					else if ((pix_y[9:5]==11)&&(pix_x[9:4]>=14)&&(pix_x[9:4]<16)&&(bandera_cursor[0]==1))  //SEGUNDO  QUITE UN = EN SEGUNDO X
						graph_rgb = 3'b001;//Hace un cursor AZUL				
					else
						graph_rgb = 3'b111;
				end
		end
		
		else if (SIMBOLO_on) //Impresion del Simbolo
									//FALTA AGREGAR LA CONDICION CUANDO PARPADEA LA ALARMA, 
		begin
			char_addr = char_addr_SIMBOLO;
			row_addr = row_addr_SIMBOLO;
			bit_addr = bit_addr_SIMBOLO;
				if (font_bit) begin
					if (Alarma_on==1 && CLK1Hz==1)
						graph_rgb = 3'b001; //azul
					else
					graph_rgb = 3'b111;   //blanco
				end
		end
		
		//PARA IMPRIMIR LAS CAJAS
		else if (Caja_FECHA_on)
		begin
			graph_rgb = 3'b001;
		end
		
		else if (Caja_TIMER_on)
		begin
			graph_rgb = 3'b001;
		end
		
		else if (Caja_HORA_on)
		begin
			graph_rgb = 3'b001;
		end
		
		else begin
			graph_rgb = 3'b000; //negro
		end
	end
	
endmodule
