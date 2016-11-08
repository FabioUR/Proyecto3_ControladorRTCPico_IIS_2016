`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:31:12 11/07/2016 
// Design Name: 
// Module Name:    MODIF_DATOS 
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
module MODIF_DATOS(
	input wire [7:0] dato_e,
	input wire [4:0] tipo,
	input wire s_r,
	output wire [7:0] dato_s
   );
	
	wire [6:0] dato_e_bin;
	wire [6:0] dato_s_bin;
	
	CONV_BCD_BIN bcd_bin(
		.dato_bcd(dato_e),
		.dato_bin(dato_e_bin)
	);
	
	reg [6:0] max;
	
	always @* begin
		case(tipo)
			5'b00001: max = 7'b0001100; // 12;
			5'b00010: max = 7'b0010111; // 23;
			5'b00100: max = 7'b0011111; // 31;
			5'b01000: max = 7'b0111011; //59;
			5'b10000: max = 7'b1100011; // 99;
			default: max = 7'b0001100; // 12;
		endcase
	end
	
	SUMA_RESTA sum_res(
		.dato_ent(dato_e_bin),
		.max(max),
		.s_r(s_r),
		.dato_sal(dato_s_bin)
	);
	
	CONV_BIN_BCD bin_bcd(
		.dato_bin(dato_s_bin),
		.dato_bcd(dato_s)
	);

endmodule
