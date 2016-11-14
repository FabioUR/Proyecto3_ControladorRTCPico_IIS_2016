`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:53:55 11/09/2016 
// Design Name: 
// Module Name:    SONIDO 
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
module SONIDO(
	input wire clk, reset,
	input wire alarma_on,
	
	output wire ampPWM,
	output wire ampSD

   );
	
	reg ampSD_temp;
	reg [25:0] cont;
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			cont <= 0;
			ampSD_temp <= 0;
		end else if (cont == 49999999) begin
				ampSD_temp <= ~ampSD_temp;
				cont <= 0;
		end else begin
			cont <= cont + 26'h0000001;
		end
	end
	
	assign ampSD = ampSD_temp && alarma_on;
	
	DIV_FREC Div_Frec(
		.clk(clk),
		.reset(reset),
		.clk_k(ampPWM)
	);
	
endmodule
