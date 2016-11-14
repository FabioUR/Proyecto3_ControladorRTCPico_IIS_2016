`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:55:39 08/21/2016
// Design Name:   C
// Module Name:   C:/Users/Fabio/Desktop/Prueba/ControladorVGA_FINAL/ControladorVGA_TB.v
// Project Name:  ControladorVGA_FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: C
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module C_TB;

	// Inputs
	//reg [2:0] ctrl_rgb;
	reg RESET;
	reg CLK;

	// Outputs
	wire [11:0] graph_rgb;
	wire h_sync;
	wire v_sync;
	wire [9:0]X;
	wire [9:0]Y;
	wire video_on;

	// Instantiate the Unit Under Test (UUT)
	C uut (
		//.ctrl_rgb(ctrl_rgb), 
		.RESET(RESET), 
		.CLK(CLK), 
		.graph_rgb(graph_rgb), 
		.h_sync(h_sync), 
		.v_sync(v_sync),
		.X(X),
		.Y(Y),
		.video_on(video_on)
	);

	always #10 CLK=!CLK;
	integer i;
	integer j;
	
	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 0;

		// Wait 100 ns for global reset to finish
		#100
		RESET=1;
		#10
		RESET=0;
		#10
		RESET = 1;
		j=0;
		
		    #50
		RESET = 0;
		

		    //archivo txt para observar los bits, simulando una pantalla

		    i = $fopen("FabioVGA.txt","w");
		    for(j=0;j<383520;j=j+1) begin
		      #40
		      if(video_on) begin
		        $fwrite(i,"%h",graph_rgb);
		      end
		      else if(X==641)
		        $fwrite(i,"\n");
		    end


		    #16800000


		    RESET=0;
		    $fclose(i);
		    $stop;
		end

endmodule

