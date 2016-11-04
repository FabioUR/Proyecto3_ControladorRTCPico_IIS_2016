`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:43:53 11/04/2016 
// Design Name: 
// Module Name:    BANCO_REG_ENTRADA 
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
module BANCO_REG_ENTRADA(
	input wire clk,
	input wire reset,
	input wire [7:0] entrada,
	input wire irq, ready, new_data,
	input wire [7:0] data_teclado,
	input wire [12:0] en,
	
	output wire [7:0] sal_00, sal_01, sal_02, sal_03, sal_04, sal_05, sal_06, sal_07, sal_08, sal_09, sal_0a, sal_0b, sal_0c
   );
	
	wire [7:0] irq_byte, ready_byte, new_data_byte;
	assign irq_byte = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, irq};
	assign ready_byte = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, ready};
	assign new_data_byte = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, new_data};
	
	REGISTRO Reg00(
		.clk(clk),
		.reset(reset),
		.enable(en[0]),
		.data_in(irq_byte),
		.data_out(sal_00)
	);
	
	REGISTRO Reg01(
		.clk(clk),
		.reset(reset),
		.enable(en[1]),
		.data_in(ready_byte),
		.data_out(sal_01)
	);
	
	REGISTRO Reg02(
		.clk(clk),
		.reset(reset),
		.enable(en[2]),
		.data_in(entrada),
		.data_out(sal_02)
	);
	
	REGISTRO Reg03(
		.clk(clk),
		.reset(reset),
		.enable(en[3]),
		.data_in(entrada),
		.data_out(sal_03)
	);
	
	REGISTRO Reg04(
		.clk(clk),
		.reset(reset),
		.enable(en[4]),
		.data_in(entrada),
		.data_out(sal_04)
	);
	
	REGISTRO Reg05(
		.clk(clk),
		.reset(reset),
		.enable(en[5]),
		.data_in(entrada),
		.data_out(sal_05)
	);
	
	REGISTRO Reg06(
		.clk(clk),
		.reset(reset),
		.enable(en[6]),
		.data_in(entrada),
		.data_out(sal_06)
	);
	
	REGISTRO Reg07(
		.clk(clk),
		.reset(reset),
		.enable(en[7]),
		.data_in(entrada),
		.data_out(sal_07)
	);
	
	REGISTRO Reg08(
		.clk(clk),
		.reset(reset),
		.enable(en[8]),
		.data_in(entrada),
		.data_out(sal_08)
	);
	
	REGISTRO Reg09(
		.clk(clk),
		.reset(reset),
		.enable(en[9]),
		.data_in(entrada),
		.data_out(sal_09)
	);

	REGISTRO Reg0a(
		.clk(clk),
		.reset(reset),
		.enable(en[10]),
		.data_in(entrada),
		.data_out(sal_0a)
	);
	
	REGISTRO Reg0b(
		.clk(clk),
		.reset(reset),
		.enable(en[11]),
		.data_in(data_teclado),
		.data_out(sal_0b)
	);
	
	REGISTRO Reg0c(
		.clk(clk),
		.reset(reset),
		.enable(en[12]),
		.data_in(new_data_byte),
		.data_out(sal_0c)
	);

endmodule
