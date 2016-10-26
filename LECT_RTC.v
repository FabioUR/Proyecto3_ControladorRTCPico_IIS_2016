`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:37:44 10/25/2016 
// Design Name: 
// Module Name:    LECT_RTC 
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
module LECT_RTC(
	input wire clk, reset,
	input wire leer,
	
	output wire a_d, cs, rd, wr, // Señales de ctrl RTC.
			
	output reg seg_in,
	output reg min_in,
	output reg hora_in,
	output reg dia_in,
	output reg mes_in,
	output reg anio_in,
	output reg tseg_in,
	output reg tmin_in,
	output reg thora_in,
	
	output reg dir_com_cyt,
	
	output reg dir_seg,
	output reg dir_min,
	output reg dir_hora,
	output reg dir_dia,
	output reg dir_mes,
	output reg dir_anio,
	output reg dir_tseg,
	output reg dir_tmin,
	output reg dir_thora,
	
	output reg ready
	);
	
	reg w_r;
	reg do_it;
	wire read_data;  // Bandera que indica que puede leer el dato.
	wire send_data; // Bandera que indica enviar el dato.
	wire send_add;	// Bandera que indica enviar dirección.
	
	W_R ParaLeer(
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
	localparam [1:0] est0 = 1'b00, est1 = 1'b01, est2 = 2'b10;
	
	reg [1:0] est_sig;
	reg [1:0] est_act;
	reg [8:0] contador;
	
	/* Lógica Secuencial */
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
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
		end else if (contador == 431) begin
			est_act <= est2;
		end else if (contador == 441) begin
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
				if (leer) begin
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
			w_r = 0;
			do_it = 0;
			
			dir_com_cyt = 0;
			
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_tseg = 0;
			dir_tmin = 0;
			dir_thora = 0;
			
			seg_in = 0;
			min_in = 0;
			hora_in = 0;
			dia_in = 0;
			mes_in = 0;			
			anio_in = 0;
			tseg_in = 0;
			tmin_in = 0;
			thora_in = 0;
			
			ready = 0;
		end else if (est_act == est1) begin
			w_r = 0;
			do_it = 1;
			
			ready = 0;
			if (send_add && (~send_data) && (~read_data)) begin
				seg_in = 0;
				min_in = 0;
				hora_in = 0;
				dia_in = 0;
				mes_in = 0;
				anio_in = 0;
				tseg_in = 0;
				tmin_in = 0;
				thora_in = 0;
				if (contador > 387) begin
					dir_com_cyt = 0;
					dir_seg = 1;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
				end else	if (contador > 344) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 1;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
				end else	if (contador > 301) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 1;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
				end else if (contador > 258) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 1;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
				end else if (contador > 215) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 1;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
				end else if (contador > 172) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 1;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
				end else if (contador > 129) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 1;
					dir_tmin = 0;
					dir_thora = 0;
				end else if (contador > 86) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 1;
					dir_thora = 0;
				end else if (contador > 43) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 1;
				end else begin
					dir_com_cyt = 1;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_tseg = 0;
					dir_tmin = 0;
					dir_thora = 0;
				end
			end else if (read_data && (~send_add) && (~send_data)) begin
				dir_seg = 0;
				dir_min = 0;
				dir_hora = 0;
				dir_dia = 0;
				dir_mes = 0;
				dir_anio = 0;
				dir_tseg = 0;
				dir_tmin = 0;
				dir_thora = 0;
				dir_com_cyt = 0;
				if (contador > 387) begin
					seg_in = 1;
					min_in = 0;
					hora_in = 0;
					dia_in = 0;
					mes_in = 0;
					anio_in = 0;
					tseg_in = 0;
					tmin_in = 0;
					thora_in = 0;
				end else if (contador > 344) begin
					seg_in = 0;
					min_in = 1;
					hora_in = 0;
					dia_in = 0;
					mes_in = 0;
					anio_in = 0;
					tseg_in = 0;
					tmin_in = 0;
					thora_in = 0;
				end else if(contador > 301) begin
					seg_in = 0;
					min_in = 0;
					hora_in = 1;
					dia_in = 0;
					mes_in = 0;
					anio_in = 0;
					tseg_in = 0;
					tmin_in = 0;
					thora_in = 0;
				end else if (contador > 258) begin
					seg_in = 0;
					min_in = 0;
					hora_in = 0;
					dia_in = 1;
					mes_in = 0;
					anio_in = 0;
					tseg_in = 0;
					tmin_in = 0;
					thora_in = 0;
				end else if (contador > 215) begin
					seg_in = 0;
					min_in = 0;
					hora_in = 0;
					dia_in = 0;
					mes_in = 1;
					anio_in = 0;
					tseg_in = 0;
					tmin_in = 0;
					thora_in = 0;
				end else if (contador > 172) begin
					seg_in = 0;
					min_in = 0;
					hora_in = 0;
					dia_in = 0;
					mes_in = 0;
					anio_in = 1;
					tseg_in = 0;
					tmin_in = 0;
					thora_in = 0;
				end else if (contador > 129) begin
					seg_in = 0;
					min_in = 0;
					hora_in = 0;
					dia_in = 0;
					mes_in = 0;
					anio_in = 0;
					tseg_in = 1;
					tmin_in = 0;
					thora_in = 0;
				end else if (contador > 86) begin
					seg_in = 0;
					min_in = 0;
					hora_in = 0;
					dia_in = 0;
					mes_in = 0;
					anio_in = 0;
					tseg_in = 0;
					tmin_in = 1;
					thora_in = 0;
				end else if (contador > 43) begin
					seg_in = 0;
					min_in = 0;
					hora_in = 0;
					dia_in = 0;
					mes_in = 0;
					anio_in = 0;
					tseg_in = 0;
					tmin_in = 0;
					thora_in = 1;
				end else begin
					seg_in = 0;
					min_in = 0;
					hora_in = 0;
					dia_in = 0;
					mes_in = 0;
					anio_in = 0;
					tseg_in = 0;
					tmin_in = 0;
					thora_in = 0;
				end
			end else begin
				dir_com_cyt = 0;
				
				dir_seg = 0;
				dir_min = 0;
				dir_hora = 0;
				dir_dia = 0;
				dir_mes = 0;
				dir_anio = 0;
				dir_tseg = 0;
				dir_tmin = 0;
				dir_thora = 0;
				
				seg_in = 0;
				min_in = 0;
				hora_in = 0;
				dia_in = 0;
				mes_in = 0;			
				anio_in = 0;
				tseg_in = 0;
				tmin_in = 0;
				thora_in = 0;
			end
		end else if (est_act == est2) begin
			w_r = 0;
			do_it = 0;
			
			dir_com_cyt = 0;
			
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_tseg = 0;
			dir_tmin = 0;
			dir_thora = 0;
			
			seg_in = 0;
			min_in = 0;
			hora_in = 0;
			dia_in = 0;
			mes_in = 0;			
			anio_in = 0;
			tseg_in = 0;
			tmin_in = 0;
			thora_in = 0;
			
			ready = 1;
		end else begin
			w_r = 0;
			do_it = 0;

			dir_com_cyt = 0;
				
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_tseg = 0;
			dir_tmin = 0;
			dir_thora = 0;
			
			seg_in = 0;
			min_in = 0;
			hora_in = 0;
			dia_in = 0;
			mes_in = 0;			
			anio_in = 0;
			tseg_in = 0;
			tmin_in = 0;
			thora_in = 0;
			
			ready = 0;
		end
	end
endmodule
