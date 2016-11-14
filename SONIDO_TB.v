`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:09:03 11/14/2016
// Design Name:   SONIDO
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/Proyecto 3 Lab. Digitales/SONIDO/SONIDO_TB.v
// Project Name:  SONIDO
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SONIDO
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SONIDO_TB;

	// Inputs
	reg clk;
	reg reset;
	reg alarma_on;

	// Outputs
	wire ampPWM;
	wire ampSD;

	// Instantiate the Unit Under Test (UUT)
	SONIDO uut (
		.clk(clk), 
		.reset(reset), 
		.alarma_on(alarma_on), 
		.ampPWM(ampPWM), 
		.ampSD(ampSD)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		alarma_on = 0;

		// Wait 100 ns for global reset to finish
		#100;
       
		reset = 0;
		// Add stimulus here
		#1500000;
		$stop;
	end
      
endmodule

