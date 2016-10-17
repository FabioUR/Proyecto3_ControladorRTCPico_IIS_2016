`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Fabio Ureña Rojas
// 
// Create Date:    17:06:54 10/17/2016 
// Design Name: 
// Module Name:    Sincronizador_P3_RTCPico 
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
module Sincronizador_P3_RTCPico(
   input wire CLK, RESET,
	output wire sincro_horiz, sincro_vert, p_tick,
	output wire [9:0] pixel_X, pixel_Y
    );
	
	//declaración de constantes
	//parametros de sincronización del controlador VGA 640x480
	//dichos valores o parametros salen de las graficas
	
	//dimensiones horizontales
	localparam HM = 640   ; //area de muestro horizontal
	localparam H_izq = 48 ; //borde izquierdo horizontal
	localparam H_der = 16 ; //borde derecho horizontal
	localparam H_retraz=96; //retrazo horizontal
	
	//dimensiones verticales
	localparam VM = 480   ; //area de muestro vertical
	localparam V_sup = 10 ; //borde superior vertical
	localparam V_inf = 33 ; //borde inferior vertical
	localparam V_retraz=2 ; //retrazo vertical
	
	//modulo 1 contador, divisor de frecuencia
	reg [1:0] cont = 2'b00;
	
	//contadores sincronos
	reg [9:0] cont_horiz_regist, cont_horiz_siguiente; //cont=contador
	reg [9:0] cont_vert_regist, cont_vert_siguiente;   //cont=contador
	
	//salida del buffer 
	reg sincr_vert_reg, sincr_horiz_reg; //registro vertical sincronizador, registro horizontal soncronizador
	wire sincr_vert_siguiente, sincr_horiz_siguiente; // sincronización vertical siguiente, sincronización horizontal siguiente
	
	//Estado de señal
	wire horiz_fin, vert_fin, pixel_tick; // finalización horizontal, final vertical,
	
	//Cuerpo/Registros
	
	always @ (posedge CLK, posedge RESET) begin
		if (RESET) begin //caracteristicas del reinicio de pantalla
			cont_vert_regist <= 10'b0000000000;
			cont_horiz_regist <= 10'b0000000000;
			sincr_vert_reg <= 1'b0;
			sincr_horiz_reg <=1'b0;
		end else begin
			cont_vert_regist <= cont_vert_siguiente;
			cont_horiz_regist <= cont_horiz_siguiente;
			sincr_vert_reg <= sincr_vert_siguiente;
			sincr_horiz_reg <= sincr_horiz_siguiente;
		end
	end
	
	//Divisor de frecuencia, obteniendo 25MHz del CLK de la Nexys de 100MHz
	always @ (posedge CLK) begin
		if (cont == 2'b11) begin
			cont <= 2'b00;
		end else begin
			cont <= cont + 2'b01;
		end
	end
	
	assign pixel_tick = cont[1];

	//Estados de señal
	//FIN indicador Contador horizontal 0-799
	assign horiz_fin = (cont_horiz_regist == (HM + H_izq + H_der + H_retraz - 1));
	//FIN indicador contador vertical 0-524
	assign vert_fin = (cont_vert_regist == (VM + V_sup + V_inf + V_retraz - 1));
	
	//etapa de contador sincronico horizontal 800
	always @* begin
		if (pixel_tick) begin //25MHz pulso
			if (horiz_fin & cont[1] & cont[0]) begin
				cont_horiz_siguiente = 10'b0000000000;
			end else begin
				if (cont == 2'b11) begin
					cont_horiz_siguiente = cont_horiz_regist + 10'b0000000001;
				end
				else begin
					cont_horiz_siguiente = cont_horiz_regist + 10'b0000000000;
				end
			end
		end else begin
			cont_horiz_siguiente = cont_horiz_regist;
		end
	end
	
	//etapa contador sincrono vertical 525
	always @* begin
		if (pixel_tick & horiz_fin) begin
			if (vert_fin) begin
				cont_vert_siguiente = 10'b0000000000;
			end else begin
				if (cont == 2'b11) begin
					cont_vert_siguiente = cont_vert_regist + 10'b0000000001;
				end
				else begin
					cont_vert_siguiente = cont_vert_regist + 10'b0000000000;
				end
			end
		end else begin
			cont_vert_siguiente = cont_vert_regist;
		end
	end
	
//	Se toma en cuenta la parte de retrazo, de 656-751 en horizontal
// Asignando un valor booleano a sincr_horiz_siguiente
	
	assign sincr_horiz_siguiente = ((cont_horiz_regist >= (HM + H_der)) && (cont_horiz_regist <= (HM + H_der + H_retraz - 1)));
	
// Se toma en cuenta la parte de retrazo, de 490 a 491
// Asignando un valor booleano a sincr_vert_siguiente
	assign sincr_vert_siguiente = ((cont_vert_regist >= (VM + V_sup)) && (cont_vert_regist <= (VM + V_sup + V_retraz - 1)));
	
//Señales de salida, las cuales van al generador de pixeles
	assign sincro_horiz = ~sincr_horiz_reg;
	assign sincro_vert = ~sincr_vert_reg;
	assign pixel_X = cont_horiz_regist;
	assign pixel_Y = cont_vert_regist;
	assign p_tick = pixel_tick;
	
endmodule
