`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:33:22 11/04/2016 
// Design Name: 
// Module Name:    PICOBLAZE 
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
module PICOBLAZE(
	input wire clk,
	input wire rst,
	/* RTC */
	input wire irq, // No sé si se irá a ocupar.
	inout wire [7:0] AD,
	output wire a_d, cs, rd, wr,
	
	//input wire leido2,
	//////////////////////
	/*output wire esc_fecha, esc_hora, esc_timer, stop_ring, stop_timer, leer, inic, ready,
	
	output wire write_strobe, read_strobe,
	
	output wire [26:0] en_sal,
	output wire [12:0] en_ent,*/
	/////////////////////
	/* Teclado */
	input wire PS2data,
	input wire PS2clk,
	
	/* VGA */
	output wire h_sync, v_sync,
	output wire [11:0] graph_rgb,
	
	/* Audio */
	output wire ampPWM,
	output wire ampSD
	);
	
	wire reset;
	assign reset = !rst;
	
	wire buf_act; // Para buffer triestado.
	
	wire ready; // Para el Pico.
	
	wire esc_fecha, esc_hora, esc_timer, stop_ring, inic, act_timer, leer; // Para máquinas.
	
	/* Banderas de máquinas */
	wire dir_com_cyt, dir_com_c, dir_com_t, dir_st0, sir_st1, dir_st2, dir_seg, dir_min, dir_hora, dir_dia, dir_mes,
		dir_anio, dir_tseg, dir_tmin, dir_thora,
		seg_in, min_in, hora_in, dia_in, mes_in, anio_in, tseg_in, tmin_in, thora_in,
		st0_out, st1_out, st2_out, seg_out, min_out, hora_out, dia_out, mes_out, anio_out, tseg_out, tmin_out, thora_out;
	
	ESC_LECT_RTC Maquinas(
		.clk(clk),
		.reset(reset),
		.leer(leer),
		.esc_hora(esc_hora),
		.esc_fecha(esc_fecha),
		.esc_timer(esc_timer),
		.stop_ring(stop_ring),
		.inic(inic),
		.act_timer(act_timer),
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
		
		.buf_act(buf_act),
		.ready(ready)
	);
	
	wire rx_en = 1'b1;
	wire leido;
	wire [7:0] data;// = 8'h77; // PROVISIONAL.
	wire new_data;// = 1'b0; // PROVISIONAL.
	
	Teclado PS2(
		.clk(clk),
		.reset(reset),
		.rx_en(rx_en),
		.ps2d(PS2data),
		.ps2c(PS2clk),
		.new_data_pico(leido),
		.letra(data),
		.new_data(new_data)
	);
	
	/* Enable para mux de selección del dato que va al RTC */
	wire [26:0] en_sal = {dir_st0, dir_st1, dir_st2, dir_seg, dir_min, dir_hora, dir_dia, dir_mes, dir_anio, dir_tseg,
		dir_tmin, dir_thora, dir_com_cyt, dir_com_c, dir_com_t,
		st0_out, st1_out, st2_out, seg_out, min_out, hora_out, dia_out, mes_out, anio_out, tseg_out, tmin_out, thora_out};
	
	/* Datos para VGA y RTC */
	wire [7:0] vga_seg_sal, vga_min_sal, vga_hora_sal, vga_dia_sal, vga_mes_sal, vga_anio_sal, vga_tseg_sal,
		vga_tmin_sal, vga_thora_sal,
		dir_st0_sal, dir_st1_sal, dir_st2_sal, dir_seg_sal, dir_min_sal, dir_hora_sal, dir_dia_sal, dir_mes_sal,
		dir_anio_sal, dir_tseg_sal, dir_tmin_sal, dir_thora_sal, dir_com_cyt_sal, dir_com_c_sal, dir_com_t_sal,
		st0_sal, st1_sal, st2_sal, seg_sal, min_sal, hora_sal, dia_sal, mes_sal, anio_sal, tseg_s, tmin_s, thora_s;
	
	/* Datos para Modif_Datos */
	wire [7:0] dato_a_modif;
	wire [4:0] tipo;
	wire s_r;
	
	wire [2:0] cursor_tim, cursor_hora, cursor_fecha;
	
	wire alarma_on;
	
	/* Desde el Pico */
	wire	[7:0]		out_port;
	wire	[7:0]		port_id;
	wire			write_strobe;
	
	BANCO_REG_SALIDA Registros_Salida(
		.clk(clk),
		.reset(reset),
		.entrada(out_port),
		.enable(port_id[5:0]),
		.w_s(write_strobe),
		.sal_05(thora_s),
		.sal_06(tmin_s),
		.sal_07(tseg_s),
		.sal_08(anio_sal),
		.sal_09(mes_sal),
		.sal_0a(dia_sal),
		.sal_0b(hora_sal),
		.sal_0c(min_sal),
		.sal_0d(seg_sal),
		.sal_0e(st2_sal),
		.sal_0f(st1_sal),
		.sal_10(st0_sal),
		.sal_11(dir_com_t_sal),
		.sal_12(dir_com_c_sal),
		.sal_13(dir_com_cyt_sal),
		.sal_14(dir_thora_sal),
		.sal_15(dir_tmin_sal),
		.sal_16(dir_tseg_sal), 
		.sal_17(dir_anio_sal),
		.sal_18(dir_mes_sal),
		.sal_19(dir_dia_sal),
		.sal_1a(dir_hora_sal),
		.sal_1b(dir_min_sal),
		.sal_1c(dir_seg_sal),
		.sal_1d(dir_st2_sal),
		.sal_1e(dir_st1_sal),
		.sal_1f(dir_st0_sal),
		
		.sal_26(vga_thora_sal),
		.sal_27(vga_tmin_sal),
		.sal_28(vga_tseg_sal),
		.sal_29(vga_anio_sal),
		.sal_2a(vga_mes_sal),
		.sal_2b(vga_dia_sal),
		.sal_2c(vga_hora_sal),
		.sal_2d(vga_min_sal),
		.sal_2e(vga_seg_sal),
		.sal_30(dato_a_modif),
		
		.sal_31(tipo),
		
		.sal_23(cursor_fecha),
		.sal_24(cursor_hora),
		.sal_25(cursor_tim),
		
		.sal_00(stop_ring),
		.sal_01(esc_timer),
		.sal_02(esc_hora),
		.sal_03(esc_fecha),
		.sal_04(leer), 
		.sal_20(act_timer),
		.sal_21(inic),
		.sal_22(alarma_on),
		.sal_2f(leido),
		.sal_32(s_r)
		
	);
	
	/*wire [7:0] vga_tseg_sal, vga_tmin_sal, vga_thora_sal;
	
	RESTA_TIMER Resta_VGA(
		.hora_in(vga_thora_s),
		.minuto_in(vga_tmin_s),
		.segundo_in(vga_tseg_s),
		.hora_out(vga_thora_sal),
		.minuto_out(vga_tmin_sal),
		.segundo_out(vga_tseg_sal)
	);*/
	
	wire [7:0] tseg_sal, tmin_sal, thora_sal; // Datos del timer restados.
	
	RESTA_TIMER Resta_Escritura(
		.hora_in(thora_s),
		.minuto_in(tmin_s),
		.segundo_in(tseg_s),
		.hora_out(thora_sal),
		.minuto_out(tmin_sal),
		.segundo_out(tseg_sal)
	);
	
	wire [7:0] dato_ent_rtc, dato_sal_rtc; // Los datos que van al buffer.
	
	MUX_ESC MuxEscritura(
		.sel(en_sal),
		.ch0(thora_sal),
		.ch1(tmin_sal),
		.ch2(tseg_sal),
		.ch3(anio_sal),
		.ch4(mes_sal),
		.ch5(dia_sal),
		.ch6(hora_sal),
		.ch7(min_sal),
		.ch8(seg_sal),
		.ch9(st2_sal),
		.ch10(st1_sal),
		.ch11(st0_sal),
		.ch12(dir_com_t_sal),
		.ch13(dir_com_c_sal),
		.ch14(dir_com_cyt_sal),
		.ch15(dir_thora_sal),
		.ch16(dir_tmin_sal),
		.ch17(dir_tseg_sal),
		.ch18(dir_anio_sal),
		.ch19(dir_mes_sal),
		.ch20(dir_dia_sal),
		.ch21(dir_hora_sal),
		.ch22(dir_min_sal),
		.ch23(dir_seg_sal),
		.ch24(dir_st2_sal),
		.ch25(dir_st1_sal),
		.ch26(dir_st0_sal),
		.sal(dato_ent_rtc)
	);
	
	BUFFER_TRIESTADO Buffer(
		.AD(AD),
		.sig_out(dato_ent_rtc),
		.sig_in(dato_sal_rtc),
		.buffer_activo(buf_act)
	);
	
	wire [7:0] dato_modificado;
	
	MODIF_DATOS Mod_Datos(
		.dato_e(dato_a_modif),
		.tipo(tipo),
		.s_r(s_r),
		.dato_s(dato_modificado)
	);
		
	/* Enable para banco de registros de entrada para el Pico */
	wire [13:0] en_ent = {1'b1, 1'b1, 1'b1, seg_in, min_in, hora_in, dia_in, mes_in,
		anio_in, tseg_in, tmin_in, thora_in, 1'b1, 1'b1};
	
	/* Datos para el mux hacia el Pico */
	wire [7:0] dato_mod_ent, new_data_ent, data_ent, seg_ent, min_ent, hora_ent, dia_ent, mes_ent,
		anio_ent, tseg_e, tmin_e, thora_e, ready_ent, irq_ent;
	
	BANCO_REG_ENTRADA Registros_Entrada(
		.clk(clk),
		.reset(reset),
		.entrada(/*dato_ent_rtc*/dato_sal_rtc),
		.irq(irq),
		.ready(ready),
		.new_data(new_data),
		.data_teclado(data),
		.dato_cambio(dato_modificado),
		.en(en_ent),
		.sal_00(irq_ent),
		.sal_01(ready_ent),
		.sal_02(thora_e),
		.sal_03(tmin_e),
		.sal_04(tseg_e),
		.sal_05(anio_ent),
		.sal_06(mes_ent),
		.sal_07(dia_ent),
		.sal_08(hora_ent),
		.sal_09(min_ent),
		.sal_0a(seg_ent),
		.sal_0b(data_ent),
		.sal_0c(new_data_ent),
		.sal_0d(dato_mod_ent)
	);
	
	wire [7:0] tseg_ent, tmin_ent, thora_ent; // Datos del timer restados.
	
	RESTA_TIMER Resta_Lectura(
		.hora_in(thora_e),
		.minuto_in(tmin_e),
		.segundo_in(tseg_e),
		.hora_out(thora_ent),
		.minuto_out(tmin_ent),
		.segundo_out(tseg_ent)
	);
	
	wire	[7:0]		in_port; // Hacia el Pico.
	
	wire			read_strobe;
	
	MUX_ENT MuxEntradas(
		.sel(port_id[3:0]),
		.r_s(read_strobe),
		.ch0(irq_ent),
		.ch1(ready_ent),
		.ch2(thora_ent),
		.ch3(tmin_ent),
		.ch4(tseg_ent),
		.ch5(anio_ent),
		.ch6(mes_ent),
		.ch7(dia_ent),
		.ch8(hora_ent),
		.ch9(min_ent),
		.ch10(seg_ent),
		.ch11(data_ent),
		.ch12(new_data_ent),
		.ch13(dato_mod_ent),
		.sal(in_port)
	);
	
	/* PICOBLAZE Y ROM INSTRUCCIONES */

	wire	[11:0]	address;
	wire	[17:0]	instruction;
	wire			bram_enable;

	wire			k_write_strobe;
	
	wire			interrupt;            //See note above
	wire			interrupt_ack;
	wire			kcpsm6_sleep;         //See note above
	wire			kcpsm6_reset;         //See note above

	//wire			cpu_reset;
	wire			rdl;
	
	wire			int_request;

  kcpsm6 #(
	.interrupt_vector	(12'h3FF),
	.scratch_pad_memory_size(64),
	.hwbuild		(8'h00))
  processor (
	.address 		(address),
	.instruction 	(instruction),
	.bram_enable 	(bram_enable),
	.port_id 		(port_id),
	.write_strobe 	(write_strobe),
	.k_write_strobe 	(k_write_strobe),
	.out_port 		(out_port),
	.read_strobe 	(read_strobe),
	.in_port 		(in_port),
	.interrupt 		(interrupt),
	.interrupt_ack 	(interrupt_ack),
	.reset 		(kcpsm6_reset),
	.sleep		(kcpsm6_sleep),
	.clk 			(clk)); 

  assign kcpsm6_sleep = 1'b0;
  assign interrupt = 1'b0;

  ROM_INST /*#(
	.C_FAMILY		   ("V6"),   	//Family 'S6' or 'V6'
	.C_RAM_SIZE_KWORDS	(2),     	//Program size '1', '2' or '4'
	.C_JTAG_LOADER_ENABLE	(1))     	//Include JTAG Loader when set to 1'b1 
  */program_rom (    		       	//Name to match your PSM file
 	.rdl 			(rdl),
	.en 		(bram_enable),
	.add 		(address),
	.inst 	(instruction),
	.clk 			(clk));
	
  assign kcpsm6_reset = reset | rdl;

	/* VGA */
	
	wire [9:0] X, Y;
	wire clk_gen;
	
	wire [8:0] cursor = {cursor_fecha, cursor_hora, cursor_tim};
		
	Sincronizador_P3_RTCPico Sinc(
		.CLK(clk),
		.RESET(reset),
		.sincro_horiz(h_sync),
		.sincro_vert(v_sync),
		.p_tick(clk_gen),
		.pixel_X(X),
		.pixel_Y(Y)
	);
	
	Generador_Letras Gen(
		.CLK(clk_gen),
		.pix_x(X),
		.pix_y(Y),
		.Alarma_on(alarma_on),
		.graph_rgb(graph_rgb),
		.bandera_cursor(cursor),
		.digit_DD(vga_dia_sal),
		.digit_M(vga_mes_sal),
		.digit_AN(vga_anio_sal),
		.digit_HORA(vga_hora_sal),
		.digit_MIN(vga_min_sal),
		.digit_SEG(vga_seg_sal),
		.digit_TimerSEG(vga_tseg_sal),
		.digit_TimerMIN(vga_tmin_sal),
		.digit_TimerHORA(vga_thora_sal)
	);
	
	/* SONIDO */
	
	SONIDO Beep(
		.clk(clk),
		.reset(reset),
		.alarma_on(alarma_on),
		.ampPWM(ampPWM),
		.ampSD(ampSD)
	);
	
endmodule
