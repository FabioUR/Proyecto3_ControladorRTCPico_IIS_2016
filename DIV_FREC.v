`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:55:07 11/09/2016 
// Design Name: 
// Module Name:    DIV_FREC 
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
module DIV_FREC(
	input wire clk,
	input wire reset,
	output wire clk_k
   );

	reg [14:0] contador;
	reg clk_temp;
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			contador <= 0;
			clk_temp <= 0;
		end else begin
			if (contador == 24999) begin
				clk_temp <= ~clk_temp;
				contador <= 0;
			end else begin
				contador <= contador + 15'h0001;
			end
		end
	end
	
	assign clk_k = clk_temp;
	
endmodule

