`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:34:53 10/25/2016
// Design Name:   ESC_LECT_RTC
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/Proyecto 3 Lab. Digitales/ESC_LECT_RTC/ESC_LECT_RTC_TB.v
// Project Name:  ESC_LECT_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ESC_LECT_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ESC_LECT_RTC_TB;

	// Inputs
	reg clk;
	reg reset;
	reg leer;
	reg esc_hora;
	reg esc_fecha;
	reg esc_timer;
	reg stop_ring;
	reg inic;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire dir_com_cyt;
	wire dir_com_c;
	wire dir_com_t;
	wire dir_st0;
	wire dir_st1;
	wire dir_st2;
	wire dir_seg;
	wire dir_min;
	wire dir_hora;
	wire dir_dia;
	wire dir_mes;
	wire dir_anio;
	wire dir_tseg;
	wire dir_tmin;
	wire dir_thora;
	wire seg_in;
	wire min_in;
	wire hora_in;
	wire dia_in;
	wire mes_in;
	wire anio_in;
	wire tseg_in;
	wire tmin_in;
	wire thora_in;
	wire st0_out;
	wire st1_out;
	wire st2_out;
	wire seg_out;
	wire min_out;
	wire hora_out;
	wire dia_out;
	wire mes_out;
	wire anio_out;
	wire tseg_out;
	wire tmin_out;
	wire thora_out;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	ESC_LECT_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.leer(leer), 
		.esc_hora(esc_hora), 
		.esc_fecha(esc_fecha), 
		.esc_timer(esc_timer), 
		.stop_ring(stop_ring), 
		.inic(inic), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.dir_com_cyt(dir_com_cyt), 
		.dir_com_c(dir_com_c), 
		.dir_com_t(dir_com_t), 
		.dir_st0(dir_st0), 
		.dir_st1(dir_st1), 
		.dir_st2(dir_st2), 
		.dir_seg(dir_seg), 
		.dir_min(dir_min), 
		.dir_hora(dir_hora), 
		.dir_dia(dir_dia), 
		.dir_mes(dir_mes), 
		.dir_anio(dir_anio), 
		.dir_tseg(dir_tseg), 
		.dir_tmin(dir_tmin), 
		.dir_thora(dir_thora), 
		.seg_in(seg_in), 
		.min_in(min_in), 
		.hora_in(hora_in), 
		.dia_in(dia_in), 
		.mes_in(mes_in), 
		.anio_in(anio_in), 
		.tseg_in(tseg_in), 
		.tmin_in(tmin_in), 
		.thora_in(thora_in), 
		.st0_out(st0_out), 
		.st1_out(st1_out), 
		.st2_out(st2_out), 
		.seg_out(seg_out), 
		.min_out(min_out), 
		.hora_out(hora_out), 
		.dia_out(dia_out), 
		.mes_out(mes_out), 
		.anio_out(anio_out), 
		.tseg_out(tseg_out), 
		.tmin_out(tmin_out), 
		.thora_out(thora_out), 
		.ready(ready)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		
		leer = 0;
		esc_hora = 0;
		esc_fecha = 0;
		esc_timer = 0;
		stop_ring = 0;
		inic = 1;
		
		#100;
		reset = 0;
		#2640;
		inic = 0;
		#360;
		reset = 1;
		
		#100;
		leer = 1;
		reset = 0;
		#4360;
		leer = 0;
		#140;
		reset = 1;
		
		#100;
		esc_fecha = 1;
		reset = 0;
		#2640;
		esc_fecha = 0;
		#360;
		reset = 1;
		
		#100;
		esc_hora = 1;
		reset = 0;
		#2640;
		esc_hora = 0;
		#360;
		reset = 1;
		
		#100;
		esc_timer = 1;
		reset = 0;
		#2640;
		esc_timer = 0;
		#360;
		reset = 1;

		#100;
		stop_ring = 1;
		reset = 0;
		#2640;
		stop_ring = 0;
		#360;
		//reset = 1;
		
		/*#100;
		stop_timer = 1;
      reset = 0;
		#2640;
		stop_timer = 0;
		#360;*/

		$stop;
	end
      
endmodule

