`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:35:44 11/04/2016 
// Design Name: 
// Module Name:    ESC_LECT_RTC 
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
module ESC_LECT_RTC(
	input wire clk, reset,
	
	input wire leer,
	input wire esc_hora,
	input wire esc_fecha,
	input wire esc_timer,
	input wire stop_ring,
	input wire inic,
	//input wire stop_timer
	
	output wire a_d, cs, rd, wr, // Señales de ctrl RTC.
	
	output wire dir_com_cyt,
	output wire dir_com_c,
	output wire dir_com_t,
		
	output wire dir_st0,
	output wire dir_st1,
	output wire dir_st2,
	
	output wire dir_seg,
	output wire dir_min,
	output wire dir_hora,
	output wire dir_dia,
	output wire dir_mes,
	output wire dir_anio,
	output wire dir_tseg,
	output wire dir_tmin,
	output wire dir_thora,
	
	output wire seg_in,
	output wire min_in,
	output wire hora_in,
	output wire dia_in,
	output wire mes_in,
	output wire anio_in,
	output wire tseg_in,
	output wire tmin_in,
	output wire thora_in,
	
	output wire st0_out,
	output wire st1_out,
	output wire st2_out,
	
	output wire seg_out,
	output wire min_out,
	output wire hora_out,
	output wire dia_out,
	output wire mes_out,
	output wire anio_out,
	output wire tseg_out,
	output wire tmin_out,
	output wire thora_out,
	
	output wire buf_act,
	
	output wire ready
   );
	
	wire a_d_e, cs_e, rd_e, wr_e,
		dir_seg_e, dir_min_e, dir_hora_e, dir_dia_e, dir_mes_e, dir_anio_e, dir_tseg_e, dir_tmin_e, dir_thora_e,
		ready_e;
	wire buffer_activo_e;
	wire estado_esc;
	
	ESC_RTC Escrituras(
		.clk(clk),
		.reset(reset),
		.esc_hora(esc_hora),
		.esc_fecha(esc_fecha),
		.esc_timer(esc_timer),
		.stop_ring(stop_ring),
		.inic(inic),
		//.stop_timer(stop_timer),
		.a_d(a_d_e),
		.cs(cs_e),
		.rd(rd_e),
		.wr(wr_e),
		.dir_com_c(dir_com_c),
		.dir_com_t(dir_com_t),
		.dir_st0(dir_st0),
		.dir_st1(dir_st1),
		.dir_st2(dir_st2),	
		.dir_seg(dir_seg_e),
		.dir_min(dir_min_e),
		.dir_hora(dir_hora_e),
		.dir_dia(dir_dia_e),
		.dir_mes(dir_mes_e),
		.dir_anio(dir_anio_e),
		.dir_tseg(dir_tseg_e),
		.dir_tmin(dir_tmin_e),
		.dir_thora(dir_thora_e),
		
		.seg_out(seg_out),
		.min_out(min_out),
		.hora_out(hora_out),
		.dia_out(dia_out),
		.mes_out(mes_out),
		.anio_out(anio_out),
		.tseg_out(tseg_out),
		.tmin_out(tmin_out),
		.thora_out(thora_out),
		.st0_out(st0_out),
		.st1_out(st1_out),
		.st2_out(st2_out),
		
		.ready(ready_e),
		.buffer_activo(buffer_activo_e),
		.estado_esc(estado_esc)
   );
	
	wire a_d_l, cs_l, rd_l, wr_l,
		dir_seg_l, dir_min_l, dir_hora_l, dir_dia_l, dir_mes_l, dir_anio_l, dir_tseg_l, dir_tmin_l, dir_thora_l,
		ready_l;
	wire buffer_activo_l;
	
	LECT_RTC Lectura(
		.clk(clk),
		.reset(reset),
		.leer(leer),
		.a_d(a_d_l),
		.cs(cs_l),
		.rd(rd_l),
		.wr(wr_l),
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
		.dir_seg(dir_seg_l),
		.dir_min(dir_min_l),
		.dir_hora(dir_hora_l),
		.dir_dia(dir_dia_l),
		.dir_mes(dir_mes_l),
		.dir_anio(dir_anio_l),
		.dir_tseg(dir_tseg_l),
		.dir_tmin(dir_tmin_l),
		.dir_thora(dir_thora_l),
		.buffer_activo(buffer_activo_l),
		.ready(ready_l)
	);

	assign a_d = (estado_esc) ? a_d_e : a_d_l;
	assign cs = (estado_esc) ? cs_e : cs_l;
	assign rd = (estado_esc) ? rd_e : rd_l;
	assign wr = (estado_esc) ? wr_e : wr_l;
	
	assign dir_seg = (estado_esc) ? dir_seg_e : dir_seg_l;
	assign dir_min = (estado_esc) ? dir_min_e : dir_min_l;
	assign dir_hora = (estado_esc) ? dir_hora_e : dir_hora_l;
	assign dir_dia = (estado_esc) ? dir_dia_e : dir_dia_l;
	assign dir_mes = (estado_esc) ? dir_mes_e : dir_mes_l;
	assign dir_anio = (estado_esc) ? dir_anio_e : dir_anio_l;
	assign dir_tseg = (estado_esc) ? dir_tseg_e : dir_tseg_l;
	assign dir_tmin = (estado_esc) ? dir_tmin_e : dir_tmin_l;
	assign dir_thora = (estado_esc) ? dir_thora_e : dir_thora_l;
	
	assign buf_act = (estado_esc) ? buffer_activo_e : buffer_activo_l;
	assign ready = (estado_esc) ? ready_e : ready_l;

endmodule

