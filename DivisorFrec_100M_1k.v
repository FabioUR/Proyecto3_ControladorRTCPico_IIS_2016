`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:17:40 11/07/2016 
// Design Name: 
// Module Name:    DivisorFrec_100M_1k 
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
module DivisorFrec_100M_1k(
	input wire clk,
	input wire reset,
	output wire clk_k
    );

	reg [15:0] contador=0;
	reg clk_temp;
	
	always @(posedge clk, posedge reset)
	
		if(reset)
		begin
			contador<=0;
			clk_temp<=0;
		end
		else
		begin
			if (contador==16'b1100001101001111) //1100001101001111 (binario de 49999)
			begin
				clk_temp<=~clk_temp;
				contador<=0;
			end
			else
				contador<=contador+1'b1;
		end
	
	assign clk_k=clk_temp;
	
endmodule
