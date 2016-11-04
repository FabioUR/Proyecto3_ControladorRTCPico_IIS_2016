`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:46:08 11/04/2016 
// Design Name: 
// Module Name:    ROM_INST 
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
module ROM_INST(
	input wire clk, en,
	input wire [11:0] add,
	output reg [17:0]	inst,
	output wire rdl
	);

	parameter ROM_WIDTH = 18;
	parameter ROM_ADDR_BITS = 12;

	reg [(ROM_WIDTH-1):0] mem_inst [((2**ROM_ADDR_BITS)-1):0];

	initial
		$readmemh("instrucciones.hex", mem_inst, 12'h000, 12'hfff);

	always @(posedge clk) begin
		if (en) begin
			inst = mem_inst[add];
		end
	end
	
	assign rdl = 1'b0;

endmodule

