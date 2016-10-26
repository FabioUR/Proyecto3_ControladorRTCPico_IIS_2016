`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:36:42 10/22/2016
// Design Name:   Teclado
// Module Name:   C:/Users/Fabio/Desktop/Prueba/Teclado/Teclado_TB.v
// Project Name:  Teclado
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Teclado
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Teclado_TB;

	// Inputs
	reg clk;
	reg reset;
	reg ps2d;
	reg ps2c;
	reg rx_en;

	// Outputs
	wire rx_done_tick;
	wire [7:0] dout;
	wire [7:0] detec;
	wire [7:0] letra;

	// Instantiate the Unit Under Test (UUT)
	Teclado uut (
		.clk(clk), 
		.reset(reset), 
		.ps2d(ps2d), 
		.ps2c(ps2c), 
		.rx_en(rx_en), 
		.rx_done_tick(rx_done_tick), 
		.dout (dout),
		.detec(detec),
		.letra(letra)
	);


	always #5 clk=~clk; //100MHz
	always #50000 ps2c=~ps2c; //10kHz
	
	reg [7:0] data; 
	reg [3:0] cont;
	
	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 1;
		ps2d = 0;
		ps2c = 1;
		rx_en = 0; 

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		rx_en = 1;
		cont = 0;
		data = 8'b00101011; //la F en el teclado, dato 2B
		
		//meto F0
		//@(posedge ps2c)
		//ps2d=0; //start bit
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=0;//parity
		
		@(posedge ps2c)
		ps2d=1; //stop
		
		@(posedge ps2c)
		ps2d=0;//extra
		
		//METO 2B
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;//parity
		
		@(posedge ps2c)
		ps2d=1; //stop
		
		@(posedge ps2c)
		ps2d=0;//extra
		
		//meto F0
		//@(posedge ps2c)
		//ps2d=0; //start bit
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=0;//parity
		
		@(posedge ps2c)
		ps2d=1; //stop
		
		@(posedge ps2c)
		ps2d=0;//extra
		
		//meto F0
		//@(posedge ps2c)
		//ps2d=0; //start bit
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=0;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=1;
		
		@(posedge ps2c)
		ps2d=0;//parity
		
		@(posedge ps2c)
		ps2d=1; //stop
		
		@(posedge ps2c)
		ps2d=0;//extra
		$stop;
		
	end
      
endmodule

/*forever @(posedge ps2c) begin
		
			if (cont==0) begin
				ps2d = 0;
				cont = cont+1'b1;
			end
			else if (cont==1) begin
				ps2d = 0;
				cont = cont+1'b1;
			end
			else if (cont==2) begin
				ps2d = 0;
				cont = cont+1'b1;
			end
			else if (cont==3) begin
				ps2d = 1;	
				cont = cont+1'b1;
			end
			else if (cont==4) begin
				ps2d = 0;
				cont = cont+1'b1;
			end
			else if (cont==5) begin
				ps2d = 1;
				cont = cont+1'b1;
			end
			else if (cont==6) begin
				ps2d = 0;
				cont = cont+1'b1;
			end
			else if (cont==7) begin
				ps2d = 1;
				cont = cont+1'b1;
			end
			else if (cont==8) begin
				ps2d = 1;
				cont = cont+1'b1;
				
			end
			else if (cont==9) begin //parity
				ps2d = 0;
				cont = cont+1'b1;
			end
			else if(cont==10) begin //stop
				ps2d = 1;
				cont = 0;
				$stop;
			end		
		end*/
