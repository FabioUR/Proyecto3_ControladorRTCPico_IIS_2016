`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:44:57 11/04/2016 
// Design Name: 
// Module Name:    MUX_ENT 
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
module MUX_ENT(
	input wire [3:0] sel,
	input wire [7:0] ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, ch10, ch11, ch12,
	output reg [7:0] sal
   );
	
	always @* begin
		case(sel)
			4'h0: sal = ch0;
			4'h1: sal = ch1;
			4'h2: sal = ch2;
			4'h3: sal = ch3;
			4'h4: sal = ch4;
			4'h5: sal = ch5;
			4'h6: sal = ch6;
			4'h7: sal = ch7;
			4'h8: sal = ch8;
			4'h9: sal = ch9;
			4'ha: sal = ch10;
			4'hb: sal = ch11;
			4'hc: sal = ch12;
			default: sal = 8'hxx;
		endcase 
	end

endmodule
