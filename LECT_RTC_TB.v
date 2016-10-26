`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:51:59 10/26/2016
// Design Name:   LECT_RTC
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/Proyecto 3 Lab. Digitales/LECT_RTC/LECT_RTC_TB.v
// Project Name:  LECT_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LECT_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LECT_RTC_TB;

	// Inputs
	reg clk;
	reg reset;
	reg leer;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire seg_in;
	wire min_in;
	wire hora_in;
	wire dia_in;
	wire mes_in;
	wire anio_in;
	wire tseg_in;
	wire tmin_in;
	wire thora_in;
	wire dir_com_cyt;
	wire dir_seg;
	wire dir_min;
	wire dir_hora;
	wire dir_dia;
	wire dir_mes;
	wire dir_anio;
	wire dir_tseg;
	wire dir_tmin;
	wire dir_thora;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	LECT_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.leer(leer), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.seg_in(seg_in), 
		.min_in(min_in), 
		.hora_in(hora_in), 
		.dia_in(dia_in), 
		.mes_in(mes_in), 
		.anio_in(anio_in), 
		.tseg_in(tseg_in), 
		.tmin_in(tmin_in), 
		.thora_in(thora_in), 
		.dir_com_cyt(dir_com_cyt), 
		.dir_seg(dir_seg), 
		.dir_min(dir_min), 
		.dir_hora(dir_hora), 
		.dir_dia(dir_dia), 
		.dir_mes(dir_mes), 
		.dir_anio(dir_anio), 
		.dir_tseg(dir_tseg), 
		.dir_tmin(dir_tmin), 
		.dir_thora(dir_thora), 
		.ready(ready)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		leer = 1;

		#100;
      reset = 0;
		#4360;
		leer = 0;
		#140;
		$stop;
	end
      
endmodule

