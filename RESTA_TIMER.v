`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:40:22 11/04/2016 
// Design Name: 
// Module Name:    RESTA_TIMER 
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
module RESTA_TIMER(
	input [7:0] hora_in,
	input [7:0] minuto_in,
	input [7:0] segundo_in,

	output wire [7:0] hora_out,
	output wire [7:0] minuto_out,
	output wire [7:0] segundo_out
    );

	
	wire [6:0] hora;
	wire [6:0] minuto;
	wire [6:0] segundo;
	
	reg [6:0] hora_s;
	reg [6:0] minuto_s;
	reg [6:0] segundo_s;

	CONV_BCD_BIN BCDBinario1 (
		.dato_bcd (hora_in),
		.dato_bin (hora)
	);
	
	CONV_BCD_BIN BCDBinario2 (
		.dato_bcd (minuto_in),
		.dato_bin (minuto)
	);
	
	CONV_BCD_BIN BCDBinario3 (
		.dato_bcd (segundo_in),
		.dato_bin (segundo)
	);
	
	always @*
	begin
		hora_s = 7'b0010111 - hora;
		minuto_s = 7'b0111011 - minuto;
		segundo_s = 7'b0111011 - segundo;
	end
		
	
	CONV_BIN_BCD BinarioBCD1 (
		.dato_bin (hora_s),
		.dato_bcd (hora_out)
	);
	
	CONV_BIN_BCD BinarioBCD2 (
		.dato_bin (minuto_s),
		.dato_bcd (minuto_out)
	);
	
	CONV_BIN_BCD BinarioBCD3 (
		.dato_bin (segundo_s),
		.dato_bcd (segundo_out)
	);
	
endmodule

