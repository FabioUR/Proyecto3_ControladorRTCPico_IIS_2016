`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:45:04 11/07/2016 
// Design Name: 
// Module Name:    SUMA_RESTA 
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
module SUMA_RESTA(
	input wire [6:0] dato_ent,
	input wire [6:0] max,
	input wire s_r,
	output reg [6:0] dato_sal
   );
	
	always @* begin
		if (s_r) begin // s_r en alto = suma.
			if (dato_ent == max) begin
				dato_sal = 7'b0000000;
			end else begin
				dato_sal = dato_ent + 7'b0000001;
			end
		end else begin // s_r en bajo = resta.
			if (dato_ent == 7'b0000000) begin
				dato_sal = max;
			end else begin
				dato_sal = dato_ent - 7'b0000001;
			end
		end
	end

endmodule
