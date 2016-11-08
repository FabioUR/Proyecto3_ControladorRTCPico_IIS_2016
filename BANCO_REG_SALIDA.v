`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:38:51 11/04/2016 
// Design Name: 
// Module Name:    BANCO_REG_SALIDA 
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
module BANCO_REG_SALIDA(
	input wire clk,
	input wire reset,
	input wire [7:0] entrada,
	input wire [5:0] enable,
	input wire w_s,
	
	output wire [7:0] sal_05, sal_06, sal_07, sal_08, sal_09, sal_0a, sal_0b, sal_0c, sal_0d, sal_0e, sal_0f,
		sal_10, sal_11, sal_12, sal_13, sal_14, sal_15, sal_16, sal_17, sal_18, sal_19, sal_1a, sal_1b, sal_1c, 
		sal_1d, sal_1e, sal_1f, sal_26, sal_27, sal_28, sal_29, sal_2a, sal_2b, sal_2c, sal_2d, sal_2e, sal_30,
	
	output wire [4:0] sal_31,
	output wire [2:0] sal_23, sal_24, sal_25,
	output wire sal_00, sal_01, sal_02, sal_03, sal_04, sal_20, sal_21, sal_22, sal_2f, sal_32
	
   );
	
	reg [50:0] en;
	wire [7:0] sal_31_p, sal_22_p, sal_23_p, sal_24_p, sal_25_p, sal_00_p, sal_01_p, sal_02_p, sal_03_p, sal_04_p, sal_20_p, sal_21_p, sal_2f_p, sal_32_p;
	
	assign sal_31 = sal_31_p[4:0];
	
	assign sal_23 = sal_23_p[2:0];
	assign sal_24 = sal_24_p[2:0];
	assign sal_25 = sal_25_p[2:0];
	
	assign sal_00 = sal_00_p[0];
	assign sal_01 = sal_01_p[0];
	assign sal_02 = sal_02_p[0];
	assign sal_03 = sal_03_p[0];
	assign sal_04 = sal_04_p[0];
	assign sal_20 = sal_20_p[0];
	assign sal_21 = sal_21_p[0];
	assign sal_22 = sal_22_p[0];
	assign sal_2f = sal_2f_p[0];
	assign sal_32 = sal_32_p[0];
	
	always @* begin
		if (~w_s) begin
			en = 51'h0000000000000;
		end else begin
			case(enable)
				6'h00: en = 51'h0000000000001;
				6'h01: en = 51'h0000000000002;
				6'h02: en = 51'h0000000000004;
				6'h03: en = 51'h0000000000008;
				6'h04: en = 51'h0000000000010;
				6'h05: en = 51'h0000000000020;
				6'h06: en = 51'h0000000000040;
				6'h07: en = 51'h0000000000080;
				6'h08: en = 51'h0000000000100;
				6'h09: en = 51'h0000000000200;
				6'h0a: en = 51'h0000000000400;
				6'h0b: en = 51'h0000000000800;
				6'h0c: en = 51'h0000000001000;
				6'h0d: en = 51'h0000000002000;
				6'h0e: en = 51'h0000000004000;
				6'h0f: en = 51'h0000000008000;
				6'h10: en = 51'h0000000010000;
				6'h11: en = 51'h0000000020000;
				6'h12: en = 51'h0000000040000;
				6'h13: en = 51'h0000000080000;
				6'h14: en = 51'h0000000100000;
				6'h15: en = 51'h0000000200000;
				6'h16: en = 51'h0000000400000;
				6'h17: en = 51'h0000000800000;
				6'h18: en = 51'h0000001000000;
				6'h19: en = 51'h0000002000000;
				6'h1a: en = 51'h0000004000000;
				6'h1b: en = 51'h0000008000000;
				6'h1c: en = 51'h0000010000000;
				6'h1d: en = 51'h0000020000000;
				6'h1e: en = 51'h0000040000000;
				6'h1f: en = 51'h0000080000000;
				6'h20: en = 51'h0000100000000;
				6'h21: en = 51'h0000200000000;
				6'h22: en = 51'h0000400000000;
				6'h23: en = 51'h0000800000000;
				6'h24: en = 51'h0001000000000;
				6'h25: en = 51'h0002000000000;
				6'h26: en = 51'h0004000000000;
				6'h27: en = 51'h0008000000000;
				6'h28: en = 51'h0010000000000;
				6'h29: en = 51'h0020000000000;
				6'h2a: en = 51'h0040000000000;
				6'h2b: en = 51'h0080000000000;
				6'h2c: en = 51'h0100000000000;
				6'h2d: en = 51'h0200000000000;
				6'h2e: en = 51'h0400000000000;
				6'h2f: en = 51'h0800000000000;
				6'h30: en = 51'h1000000000000;
				6'h31: en = 51'h2000000000000;
				6'h32: en = 51'h4000000000000;
				default: en = 51'hxxxxxxxxxxx;
			endcase
		end
	end
	
	REGISTRO Reg00(
		.clk(clk),
		.reset(reset),
		.enable(en[0]),
		.data_in(entrada),
		.data_out(sal_00_p)
	);
	
	REGISTRO Reg01(
		.clk(clk),
		.reset(reset),
		.enable(en[1]),
		.data_in(entrada),
		.data_out(sal_01_p)
	);
	
	REGISTRO Reg02(
		.clk(clk),
		.reset(reset),
		.enable(en[2]),
		.data_in(entrada),
		.data_out(sal_02_p)
	);
	
	REGISTRO Reg03(
		.clk(clk),
		.reset(reset),
		.enable(en[3]),
		.data_in(entrada),
		.data_out(sal_03_p)
	);
	
	REGISTRO Reg04(
		.clk(clk),
		.reset(reset),
		.enable(en[4]),
		.data_in(entrada),
		.data_out(sal_04_p)
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
		.data_in(entrada),
		.data_out(sal_0b)
	);
	
	REGISTRO Reg0c(
		.clk(clk),
		.reset(reset),
		.enable(en[12]),
		.data_in(entrada),
		.data_out(sal_0c)
	);
	
	REGISTRO Reg0d(
		.clk(clk),
		.reset(reset),
		.enable(en[13]),
		.data_in(entrada),
		.data_out(sal_0d)
	);
	
	REGISTRO Reg0e(
		.clk(clk),
		.reset(reset),
		.enable(en[14]),
		.data_in(entrada),
		.data_out(sal_0e)
	);
	
	REGISTRO Reg0f(
		.clk(clk),
		.reset(reset),
		.enable(en[15]),
		.data_in(entrada),
		.data_out(sal_0f)
	);
	
	REGISTRO Reg10(
		.clk(clk),
		.reset(reset),
		.enable(en[16]),
		.data_in(entrada),
		.data_out(sal_10)
	);
	
	REGISTRO Reg11(
		.clk(clk),
		.reset(reset),
		.enable(en[17]),
		.data_in(entrada),
		.data_out(sal_11)
	);
	
	REGISTRO Reg12(
		.clk(clk),
		.reset(reset),
		.enable(en[18]),
		.data_in(entrada),
		.data_out(sal_12)
	);
	
	REGISTRO Reg13(
		.clk(clk),
		.reset(reset),
		.enable(en[19]),
		.data_in(entrada),
		.data_out(sal_13)
	);
	
	REGISTRO Reg14(
		.clk(clk),
		.reset(reset),
		.enable(en[20]),
		.data_in(entrada),
		.data_out(sal_14)
	);
	
	REGISTRO Reg15(
		.clk(clk),
		.reset(reset),
		.enable(en[21]),
		.data_in(entrada),
		.data_out(sal_15)
	);
	
	REGISTRO Reg16(
		.clk(clk),
		.reset(reset),
		.enable(en[22]),
		.data_in(entrada),
		.data_out(sal_16)
	);
	
	REGISTRO Reg17(
		.clk(clk),
		.reset(reset),
		.enable(en[23]),
		.data_in(entrada),
		.data_out(sal_17)
	);
	
	REGISTRO Reg18(
		.clk(clk),
		.reset(reset),
		.enable(en[24]),
		.data_in(entrada),
		.data_out(sal_18)
	);
	
	REGISTRO Reg19(
		.clk(clk),
		.reset(reset),
		.enable(en[25]),
		.data_in(entrada),
		.data_out(sal_19)
	);
	
	REGISTRO Reg1a(
		.clk(clk),
		.reset(reset),
		.enable(en[26]),
		.data_in(entrada),
		.data_out(sal_1a)
	);
	
	REGISTRO Reg1b(
		.clk(clk),
		.reset(reset),
		.enable(en[27]),
		.data_in(entrada),
		.data_out(sal_1b)
	);
	
	REGISTRO Reg1c(
		.clk(clk),
		.reset(reset),
		.enable(en[28]),
		.data_in(entrada),
		.data_out(sal_1c)
	);
	REGISTRO Reg1d(
		.clk(clk),
		.reset(reset),
		.enable(en[29]),
		.data_in(entrada),
		.data_out(sal_1d)
	);
	
	REGISTRO Reg1e(
		.clk(clk),
		.reset(reset),
		.enable(en[30]),
		.data_in(entrada),
		.data_out(sal_1e)
	);
	
	REGISTRO Reg1f(
		.clk(clk),
		.reset(reset),
		.enable(en[31]),
		.data_in(entrada),
		.data_out(sal_1f)
	);
	
	REGISTRO Reg20(
		.clk(clk),
		.reset(reset),
		.enable(en[32]),
		.data_in(entrada),
		.data_out(sal_20_p)
	);
	
	REGISTRO Reg21(
		.clk(clk),
		.reset(reset),
		.enable(en[33]),
		.data_in(entrada),
		.data_out(sal_21_p)
	);
	
	REGISTRO Reg22(
		.clk(clk),
		.reset(reset),
		.enable(en[34]),
		.data_in(entrada),
		.data_out(sal_22_p)
	);
	
	REGISTRO Reg23(
		.clk(clk),
		.reset(reset),
		.enable(en[35]),
		.data_in(entrada),
		.data_out(sal_23_p)
	);
	
	REGISTRO Reg24(
		.clk(clk),
		.reset(reset),
		.enable(en[36]),
		.data_in(entrada),
		.data_out(sal_24_p)
	);
	
	REGISTRO Reg25(
		.clk(clk),
		.reset(reset),
		.enable(en[37]),
		.data_in(entrada),
		.data_out(sal_25_p)
	);
	
	REGISTRO Reg26(
		.clk(clk),
		.reset(reset),
		.enable(en[38]),
		.data_in(entrada),
		.data_out(sal_26)
	);
	
	REGISTRO Reg27(
		.clk(clk),
		.reset(reset),
		.enable(en[39]),
		.data_in(entrada),
		.data_out(sal_27)
	);
	
	REGISTRO Reg28(
		.clk(clk),
		.reset(reset),
		.enable(en[40]),
		.data_in(entrada),
		.data_out(sal_28)
	);
	
	REGISTRO Reg29(
		.clk(clk),
		.reset(reset),
		.enable(en[41]),
		.data_in(entrada),
		.data_out(sal_29)
	);
	
	REGISTRO Reg2a(
		.clk(clk),
		.reset(reset),
		.enable(en[42]),
		.data_in(entrada),
		.data_out(sal_2a)
	);
	
	REGISTRO Reg2b(
		.clk(clk),
		.reset(reset),
		.enable(en[43]),
		.data_in(entrada),
		.data_out(sal_2b)
	);
	
	REGISTRO Reg2c(
		.clk(clk),
		.reset(reset),
		.enable(en[44]),
		.data_in(entrada),
		.data_out(sal_2c)
	);
	
	REGISTRO Reg2d(
		.clk(clk),
		.reset(reset),
		.enable(en[45]),
		.data_in(entrada),
		.data_out(sal_2d)
	);
	
	REGISTRO Reg2e(
		.clk(clk),
		.reset(reset),
		.enable(en[46]),
		.data_in(entrada),
		.data_out(sal_2e)
	);
	
	REGISTRO Reg2f(
		.clk(clk),
		.reset(reset),
		.enable(en[47]),
		.data_in(entrada),
		.data_out(sal_2f_p)
	);
	
	REGISTRO Reg30(
		.clk(clk),
		.reset(reset),
		.enable(en[48]),
		.data_in(entrada),
		.data_out(sal_30)
	);
	
	REGISTRO Reg31(
		.clk(clk),
		.reset(reset),
		.enable(en[49]),
		.data_in(entrada),
		.data_out(sal_31_p)
	);
	
	REGISTRO Reg32(
		.clk(clk),
		.reset(reset),
		.enable(en[50]),
		.data_in(entrada),
		.data_out(sal_32_p)
	);
	
endmodule

