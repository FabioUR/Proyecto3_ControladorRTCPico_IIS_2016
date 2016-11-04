`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:42:36 11/04/2016 
// Design Name: 
// Module Name:    MUX_ESC 
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
module MUX_ESC(
	input wire [26:0] sel,
	input wire [7:0] ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15, ch16, ch17,
		ch18, ch19, ch20, ch21, ch22, ch23, ch24, ch25, ch26,
	output reg [7:0] sal
   );
	
	always @* begin
		case(sel)
			27'h0000001: sal = ch0;
			27'h0000002: sal = ch1;
			27'h0000004: sal = ch2;
			27'h0000008: sal = ch3;
			27'h0000010: sal = ch4;
			27'h0000020: sal = ch5;
			27'h0000040: sal = ch6;
			27'h0000080: sal = ch7;
			27'h0000100: sal = ch8;
			27'h0000200: sal = ch9;
			27'h0000400: sal = ch10;
			27'h0000800: sal = ch11;
			27'h0001000: sal = ch12;
			27'h0002000: sal = ch13;
			27'h0004000: sal = ch14;
			27'h0008000: sal = ch15;
			27'h0010000: sal = ch16;
			27'h0020000: sal = ch17;
			27'h0040000: sal = ch18;
			27'h0080000: sal = ch19;
			27'h0100000: sal = ch20;
			27'h0200000: sal = ch21;
			27'h0400000: sal = ch22;
			27'h0800000: sal = ch23;
			27'h1000000: sal = ch24;
			27'h2000000: sal = ch25;
			27'h4000000: sal = ch26;
			default: sal = 8'hxx;
		endcase 
	end


endmodule


