`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:36:42 10/22/2016
// Design Name:   Teclado
// Module Name:   C:/Users/Fabio/Desktop/Prueba/Teclado/Teclado_TB.v
// Project Name:  Teclado
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Teclado
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Teclado_TB;

	// Inputs
	//METER LUEGO EL new_data_pico
	reg new_data_pico;
	reg clk;
	reg reset;
	reg ps2d;
	reg ps2c;
	reg rx_en;

	// Outputs
	//wire rx_done_tick;
	//wire [7:0] dout;
	//wire llegoF;
	wire [7:0] letra;
	wire new_data;

	// Instantiate the Unit Under Test (UUT)
	Teclado uut (
		.new_data_pico(new_data_pico),
		.clk(clk), 
		.reset(reset), 
		.ps2d(ps2d), 
		.ps2c(ps2c), 
		.rx_en(rx_en), 
		//.rx_done_tick(rx_done_tick), 
		//.dout (dout),
		//.llegoF(llegoF),
		.new_data(new_data),
		.letra(letra)
	);
	
	
	integer i,j;
	//reg enable_ps2c;
	reg [10:0] mensaje_ps2 [0:15];
	reg [10:0] aux_ps2;
	reg fin_ps2;

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		new_data_pico = 0;
		ps2d = 1'b1;
		ps2c = 1'b1;
		rx_en = 1'b0;
		mensaje_ps2[0] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[1] = {2'b11,8'h2B,1'b0}; //F
		mensaje_ps2[2] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[3] = {2'b11,8'h33,1'b0}; //H
		mensaje_ps2[4] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[5] = {2'b11,8'h2C,1'b0}; //T
		mensaje_ps2[6] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[7] = {2'b11,8'h75,1'b0}; //flecha arrba
		mensaje_ps2[8] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[9] = {2'b11,8'h74,1'b0}; //Flecha derecha
		mensaje_ps2[10] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[11] = {2'b11,8'h6B,1'b0}; //flecha izquierda
		mensaje_ps2[12] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[13] = {2'b11,8'h72,1'b0}; //Flecha abajo
		mensaje_ps2[14] = {2'b11,8'hf0,1'b0}; //F0
		mensaje_ps2[15] = {2'b11,8'h76,1'b0}; //ESC
		aux_ps2 = 11'b0;
		repeat(10)@(posedge clk);
		reset = 0;
		fin_ps2 = 0;
	end

	initial begin //ir recorriendo cada uno de los mensajes
		@(negedge reset);
		for(j=0;j<16;j=j+1)
		begin
			aux_ps2=mensaje_ps2[j];
			repeat(5)@(posedge clk);
			rx_en =1'b1;
			for(i = 0; i<11; i=i+1) //recorre cada unos de los bit de cada dato
			begin
				ps2d = aux_ps2[i];//guardarlo en la variable ps2d, la cual va al dout del codigo del pong chu, que se usara para uardar el dato
				@(posedge ps2c);
			end
			ps2d = 1; 
			rx_en = 1'b0;
		end
		fin_ps2 = 1; //bandera usada para detener el funcionamiento del codigo el pong
		if ((letra==8'h2B)||(letra==8'h33)||(letra==8'h2C)||(letra==8'h75)||(letra==8'h74)||(letra==8'h6B)||(letra==8'h72)||(letra==8'h76))
			begin	
				#3000;
				new_data_pico = 1;
			end
		else
				new_data_pico = 0;
		#3000;
	$stop;
	end
      
	initial forever begin
		#5 clk = ~clk; //clock de la nexys 100MHz
	end

	initial begin
		@(posedge rx_en);
		while(rx_en)
			#500 ps2c = ~ps2c; //clock del teclado, se ajusto a una frecuencia mayor, para menos tiempo de simulación
	end
      
endmodule