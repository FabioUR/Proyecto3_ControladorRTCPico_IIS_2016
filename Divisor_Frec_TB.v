`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:32:55 11/07/2016
// Design Name:   DivisorFrec_100M_1k
// Module Name:   C:/Users/Fabio/Desktop/Prueba/DivisorFrec_100M-1k/Divisor_Frec_TB.v
// Project Name:  DivisorFrec_100M-1k
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DivisorFrec_100M_1k
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Divisor_Frec_TB;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire clk_k;

	// Instantiate the Unit Under Test (UUT)
	DivisorFrec_100M_1k uut (
		.clk(clk), 
		.reset(reset), 
		.clk_k(clk_k)
	);

	always #5 clk=~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
       
		reset = 0;
		// Add stimulus here
		#100000;
		$stop;
	end
      
endmodule

