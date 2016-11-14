`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:53:35 11/07/2016
// Design Name:   MODIF_DATOS
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/Proyecto 3 Lab. Digitales/MODIF_DATOS/MODIF_DATOS_TB.v
// Project Name:  MODIF_DATOS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MODIF_DATOS
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MODIF_DATOS_TB;

	// Inputs
	reg [7:0] dato_e;
	reg [4:0] tipo;
	reg s_r;

	// Outputs
	wire [7:0] dato_s;
	
	// Instantiate the Unit Under Test (UUT)
	MODIF_DATOS uut (
		.dato_e(dato_e), 
		.tipo(tipo), 
		.s_r(s_r), 
		.dato_s(dato_s)
	);
	
	initial begin
		// Initialize Inputs
		dato_e = 8'h12;
		tipo = 5'b00001;
		s_r = 1;
		#100;
		dato_e = 8'h00;
		s_r = 0;
		#200;
	
		dato_e = 8'h23;
		tipo = 5'b00010;
		s_r = 1;
		#100;
		dato_e = 8'h00;
		s_r = 0;
		#200;
		
		dato_e = 8'h31;
		tipo = 5'b00100;
		s_r = 1;
		#100;
		dato_e = 8'h00;
		s_r = 0;
		#200;
		
		dato_e = 8'h59;
		tipo = 5'b01000;
		s_r = 1;
		#100;
		dato_e = 8'h00;
		s_r = 0;
		#200;
		
		dato_e = 8'h99;
		tipo = 5'b10000;
		s_r = 1;
		#100;
		dato_e = 8'h00;
		s_r = 0;
		#200;
		
		dato_e = 8'h77;
		tipo = 5'b10000;
		s_r = 1;
		#100;
		dato_e = 8'h99;
		s_r = 0;
		#200;
		
		$stop;
	end
      
endmodule

