`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:37:20 11/04/2016 
// Design Name: 
// Module Name:    ESC_RTC 
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
module ESC_RTC(
   input wire clk, reset,
	
	input wire esc_hora,
	input wire esc_fecha,
	input wire esc_timer,
	input wire stop_ring,
	input wire inic,
	//input wire stop_timer,
	
	output wire a_d, cs, rd, wr, // Señales de ctrl RTC.

	output reg dir_com_c,
	output reg dir_com_t,
	
	output reg dir_st0,
	output reg dir_st1,
	output reg dir_st2,	
	
	output reg dir_seg,
	output reg dir_min,
	output reg dir_hora,
	output reg dir_dia,
	output reg dir_mes,
	output reg dir_anio,
	output reg dir_tseg,
	output reg dir_tmin,
	output reg dir_thora,
	
	output reg seg_out,
	output reg min_out,
	output reg hora_out,
	output reg dia_out,
	output reg mes_out,
	output reg anio_out,
	output reg tseg_out,
	output reg tmin_out,
	output reg thora_out,
	
	output reg st0_out,
	output reg st1_out,
	output reg st2_out,
	
	output reg ready,
	
	output wire buffer_activo,
	
	output wire estado_esc
   );
	
	reg w_r;
	reg do_it;
	wire read_data;  // Bandera que indica que puede leer el dato.
	wire send_data; // Bandera que indica enviar el dato.
	wire send_add;	// Bandera que indica enviar dirección.
	
	W_R ParaEscribir(
		.clk(clk),
		.reset(reset),
		.w_r(w_r),
		.do_it(do_it),
		.a_d(a_d),
		.cs(cs),
		.rd(rd),
		.wr(wr),
		.read_data(read_data),
		.send_data(send_data),
		.send_add(send_add)
	);
	
	
	/* Estados. */
	localparam [1:0] est0 = 2'b00, est1 = 2'b01, est2 = 2'b10;
	
	reg [1:0] est_sig;
	reg [1:0] est_act;
	reg [8:0] contador;
	
	/* Lógica Secuencial */
	
	always @(posedge clk, posedge reset) begin
		if (reset)	begin
			contador <= 9'b000000000;
		end else if (est_act == est0) begin
			contador <= 9'b000000000;
		end else	begin
			contador <= contador + 9'b000000001;
		end
	end
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			est_act <= est0;
		end else if (contador == 259) begin
			est_act <= est2;
		end else if (contador == 289) begin
			est_act <= est0;
		end else begin
			est_act <= est_sig;
		end
	end
	
	/* Lógica Combinacional */
	
	always @* begin
		est_sig = est0;
		case(est_act)
			est0: begin
				if (esc_fecha || esc_hora || esc_timer || inic || stop_ring/* | stop_timer*/) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin
				est_sig = est1;
			end
			est2: begin
				est_sig = est2;
			end
			default: est_sig = est0;
		endcase
	end
	
	/* Salidas */
	
	always @* begin
		if (est_act == est0) begin
			w_r = 1;
			do_it = 0;
			
			dir_com_c = 0;
			dir_com_t = 0;
			
			dir_st0 = 0;
			dir_st1 = 0;
			dir_st2 = 0;
			
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_tseg = 0;
			dir_tmin = 0;
			dir_thora = 0;
			
			st0_out = 0;
			st1_out = 0;
			st2_out = 0;
			
			seg_out = 0;
			min_out = 0;
			hora_out = 0;
			dia_out = 0;
			mes_out = 0;
			anio_out = 0;
			tseg_out = 0;
			tmin_out = 0;
			thora_out = 0;
			
			ready = 0;
		end else if (est_act == est1) begin
			w_r = 1;
			do_it = 1;
			
			ready = 0;
			if (send_add && (~send_data) && (~read_data)) begin
				st0_out = 0;
				st1_out = 0;
				st2_out = 0;
				
				seg_out = 0;
				min_out = 0;
				hora_out = 0;
				dia_out = 0;
				mes_out = 0;
				anio_out = 0;
				tseg_out = 0;
				tmin_out = 0;
				thora_out = 0;
				if (contador > 215) begin
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
					if (esc_hora) begin
						dir_com_c = 1;
						dir_com_t = 0;
						dir_st0 = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_fecha) begin
						dir_com_c = 1;
						dir_com_t = 0;
						dir_st0 = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_timer) begin
						dir_com_c = 0;
						dir_com_t = 0;
						dir_st0 = 1;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (stop_ring) begin
						dir_com_c = 0;
						dir_com_t = 0;
						dir_st0 = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else if (inic) begin
						dir_com_c = 0;
						dir_com_t = 0;
						dir_st0 = 0;
						dir_st1 = 0;
						dir_st2 = 1;
					end else begin
						dir_com_c = 0;
						dir_com_t = 0;
						dir_st0 = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end
				end else if (contador > 172) begin
					dir_st0 = 0;
					
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
					if (esc_hora) begin
						dir_com_c = 1;
						dir_com_t = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_fecha) begin
						dir_com_c = 1;
						dir_com_t = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_timer) begin
						dir_com_c = 0;
						dir_com_t = 1;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (stop_ring) begin
						dir_com_c = 0;
						dir_com_t = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else if (inic) begin
						dir_com_c = 0;
						dir_com_t = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else begin
						dir_com_c = 0;
						dir_com_t = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end
				end else if (contador > 129) begin
					dir_com_t = 0;
					
					dir_st0 = 0;
					
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
					if (esc_hora) begin
						dir_com_c = 1;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_fecha) begin
						dir_com_c = 1;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_timer) begin
						dir_com_c = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else if (stop_ring) begin
						dir_com_c = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else if (inic) begin
						dir_com_c = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else begin
						dir_com_c = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end
				end else if (contador > 86) begin
					dir_com_c = 0;
					dir_com_t = 0;
					
					dir_st0 = 0;
					if (esc_hora) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 1;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_fecha) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 1;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_timer) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 1;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (stop_ring) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else if (inic) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end
				end else if (contador > 43) begin
					dir_com_c = 0;
					dir_com_t = 0;
					
					dir_st0 = 0;
					if (esc_hora) begin
						dir_seg = 0;
						dir_min = 1;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_fecha) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 1;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_timer) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 1;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (stop_ring) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else if (inic) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end
				end else begin
					dir_com_c = 0;
					dir_com_t = 0;
					
					dir_st0 = 0;
					if (esc_hora) begin
						dir_seg = 1;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_fecha) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 1;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (esc_timer) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 1;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end else if (stop_ring) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else if (inic) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 1;
						dir_st2 = 0;
					end else begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_tseg = 0;
						dir_tmin = 0;
						dir_thora = 0;
						dir_st1 = 0;
						dir_st2 = 0;
					end
				end
			end else if (send_data && (~send_add) && (~read_data)) begin
				dir_st0 = 0;
				dir_st1 = 0;
				dir_st2 = 0;
				
				dir_seg = 0;
				dir_min = 0;
				dir_hora = 0;
				dir_dia = 0;
				dir_mes = 0;
				dir_anio = 0;
				dir_thora = 0;
				dir_tmin = 0;
				dir_tseg = 0;
				if (contador > 215) begin
					seg_out = 0;
					min_out = 0;
					hora_out = 0;
					dia_out = 0;
					mes_out = 0;
					anio_out = 0;
					tseg_out = 0;
					tmin_out = 0;
					thora_out = 0;
					if (esc_hora) begin
						dir_com_c = 1;
						dir_com_t = 0;
						st0_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_fecha) begin
						dir_com_c = 1;
						dir_com_t = 0;
						st0_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_timer) begin
						dir_com_c = 0;
						dir_com_t = 0;
						st0_out = 1;
						st1_out = 0;
						st2_out = 0;
					end else if (stop_ring) begin
						dir_com_c = 0;
						dir_com_t = 0;
						st0_out = 0;
						st1_out = 1;
						st2_out = 0;
					end else if (inic) begin
						dir_com_c = 0;
						dir_com_t = 0;
						st0_out = 0;
						st1_out = 0;
						st2_out = 1;
					end else begin
						dir_com_c = 0;
						dir_com_t = 0;
						st0_out = 0;
						st1_out = 0;
						st2_out = 0;
					end
				end else if (contador > 172) begin
					st0_out = 0;
					
					seg_out = 0;
					min_out = 0;
					hora_out = 0;
					dia_out = 0;
					mes_out = 0;
					anio_out = 0;
					tseg_out = 0;
					tmin_out = 0;
					thora_out = 0;
					if (esc_hora) begin
						dir_com_t = 0;
						dir_com_c = 1;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_fecha) begin
						dir_com_t = 0;
						dir_com_c = 1;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_timer) begin
						dir_com_t = 1;
						dir_com_c = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (stop_ring) begin
						dir_com_t = 0;
						dir_com_c = 0;
						st1_out = 1;
						st2_out = 0;
					end else if (inic) begin
						dir_com_t = 0;
						dir_com_c = 0;
						st1_out = 0;
						st2_out = 1;
					end else begin
						dir_com_t = 0;
						dir_com_c = 0;
						st1_out = 0;
						st2_out = 0;
					end
				end else if (contador > 129) begin
					st0_out = 0;
					
					seg_out = 0;
					min_out = 0;
					hora_out = 0;
					dia_out = 0;
					mes_out = 0;
					anio_out = 0;
					tseg_out = 0;
					tmin_out = 0;
					thora_out = 0;
					if (esc_hora) begin
						dir_com_c = 1;
						dir_com_t = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_fecha) begin
						dir_com_c = 1;
						dir_com_t = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_timer) begin
						dir_com_c = 0;
						dir_com_t = 0;
						st1_out = 1;
						st2_out = 0;						
					end else if (stop_ring) begin
						dir_com_c = 0;
						dir_com_t = 0;
						st1_out = 1;
						st2_out = 0;
					end else if (inic) begin
						dir_com_c = 0;
						dir_com_t = 0;
						st1_out = 0;
						st2_out = 1;
					end else begin
						dir_com_c = 0;
						dir_com_t = 0;
						st1_out = 0;
						st2_out = 0;
					end
				end else if (contador > 86) begin
					dir_com_c = 0;
					dir_com_t = 0;
					
					st0_out = 0;
					if (esc_hora) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 1;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_fecha) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 1;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_timer) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 1;
						st1_out = 0;
						st2_out = 0;
					end else if (stop_ring) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 1;
						st2_out = 0;
					end else if (inic) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 1;
					end else begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end
				end else if (contador > 43) begin
					dir_com_c = 0;
					dir_com_t = 0;
					
					st0_out = 0;
					if (esc_hora) begin
						seg_out = 0;
						min_out = 1;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_fecha) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 1;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_timer) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 1;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (stop_ring) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 1;
						st2_out = 0;
					end else if (inic) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 1;
					end else begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end
				end else begin
					dir_com_c = 0;
					dir_com_t = 0;
					
					st0_out = 0;
					if (esc_hora) begin
						seg_out = 1;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_fecha) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 1;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (esc_timer) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 1;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end else if (stop_ring) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 1;
						st2_out = 0;
					end else if (inic) begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 1;
					end else begin
						seg_out = 0;
						min_out = 0;
						hora_out = 0;
						dia_out = 0;
						mes_out = 0;
						anio_out = 0;
						tseg_out = 0;
						tmin_out = 0;
						thora_out = 0;
						st1_out = 0;
						st2_out = 0;
					end
				end
			end else begin
				dir_com_c = 0;
				dir_com_t = 0;
				
				dir_st0 = 0;
				dir_st1 = 0;
				dir_st2 = 0;
				
				dir_seg = 0;
				dir_min = 0;
				dir_hora = 0;
				dir_dia = 0;
				dir_mes = 0;
				dir_anio = 0;
				dir_tseg = 0;
				dir_tmin = 0;
				dir_thora = 0;
				
				st0_out = 0;
				st1_out = 0;
				st2_out = 0;
				
				seg_out = 0;
				min_out = 0;
				hora_out = 0;
				dia_out = 0;
				mes_out = 0;
				anio_out = 0;
				tseg_out = 0;
				tmin_out = 0;
				thora_out = 0;
			end
		end else if (est_act == est2) begin
			w_r = 1;
			do_it = 0;
			
			dir_com_c = 0;
			dir_com_t = 0;
			
			dir_st0 = 0;
			dir_st1 = 0;
			dir_st2 = 0;
			
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_tseg = 0;
			dir_tmin = 0;
			dir_thora = 0;
			
			st0_out = 0;
			st1_out = 0;
			st2_out = 0;
			
			seg_out = 0;
			min_out = 0;
			hora_out = 0;
			dia_out = 0;
			mes_out = 0;
			anio_out = 0;
			tseg_out = 0;
			tmin_out = 0;
			thora_out = 0;
			
			ready = 1;
		end else begin
			w_r = 1;
			do_it = 0;
			
			dir_com_c = 0;
			dir_com_t = 0;
			
			dir_st0 = 0;
			dir_st1 = 0;
			dir_st2 = 0;
			
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_tseg = 0;
			dir_tmin = 0;
			dir_thora = 0;
			
			st0_out = 0;
			st1_out = 0;
			st2_out = 0;
			
			seg_out = 0;
			min_out = 0;
			hora_out = 0;
			dia_out = 0;
			mes_out = 0;
			anio_out = 0;
			tseg_out = 0;
			tmin_out = 0;
			thora_out = 0;	
			
			ready = 0;
		end
	end
	
	assign buffer_activo = send_data || send_add;
	assign estado_esc = (est_act == est1) ? 1'b1 : ((est_act == est2) ? 1'b1 : 1'b0);
	
endmodule

