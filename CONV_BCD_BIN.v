`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:40:55 11/04/2016 
// Design Name: 
// Module Name:    CONV_BCD_BIN 
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
module CONV_BCD_BIN(
   input wire [7:0] dato_bcd,
	output reg [6:0] dato_bin
   );
	
	always @ (dato_bcd) begin
		if (dato_bcd == 8'h00) begin
			dato_bin = 7'b0000000;
		end
		else if (dato_bcd == 8'h01) begin
			dato_bin = 7'b0000001;
		end
		else if (dato_bcd == 8'h02) begin
			dato_bin = 7'b0000010;
		end
		else if (dato_bcd == 8'h03) begin
			dato_bin = 7'b0000011;
		end
		else if (dato_bcd == 8'h04) begin
			dato_bin = 7'b0000100;
		end
		else if (dato_bcd == 8'h05) begin
			dato_bin = 7'b0000101;
		end
		else if (dato_bcd == 8'h06) begin
			dato_bin = 7'b0000110;
		end
		else if (dato_bcd == 8'h07) begin
			dato_bin = 7'b0000111;
		end
		else if (dato_bcd == 8'h08) begin
			dato_bin = 7'b0001000;
		end
		else if (dato_bcd == 8'h09) begin
			dato_bin = 7'b0001001;
		end
		else if (dato_bcd == 8'h10) begin
			dato_bin = 7'b0001010;
		end
		else if (dato_bcd == 8'h11) begin
			dato_bin = 7'b0001011;
		end
		else if (dato_bcd == 8'h12) begin
			dato_bin = 7'b0001100;
		end
		else if (dato_bcd == 8'h13) begin
			dato_bin = 7'b0001101;
		end
		else if (dato_bcd == 8'h14) begin
			dato_bin = 7'b0001110;
		end
		else if (dato_bcd == 8'h15) begin
			dato_bin = 7'b0001111;
		end
		else if (dato_bcd == 8'h16) begin
			dato_bin = 7'b0010000;
		end
		else if (dato_bcd == 8'h17) begin
			dato_bin = 7'b0010001;
		end
		else if (dato_bcd == 8'h18) begin
			dato_bin = 7'b0010010;
		end
		else if (dato_bcd == 8'h19) begin
			dato_bin = 7'b0010011;
		end
		else if (dato_bcd == 8'h20) begin
			dato_bin = 7'b0010100;
		end
		else if (dato_bcd == 8'h21) begin
			dato_bin = 7'b0010101;
		end
		else if (dato_bcd == 8'h22) begin
			dato_bin = 7'b0010110;
		end
		else if (dato_bcd == 8'h23)begin
			dato_bin = 7'b0010111;
		end		
		else if (dato_bcd == 8'h24) begin
			dato_bin = 7'b0011000;
		end		
		else if (dato_bcd == 8'h25) begin
			dato_bin = 7'b0011001;
		end		
		else if (dato_bcd == 8'h26) begin
			dato_bin = 7'b0011010;
		end		
		else if (dato_bcd == 8'h27) begin
			dato_bin = 7'b0011011;
		end		
		else if (dato_bcd == 8'h28) begin
			dato_bin = 7'b0011100;
		end		
		else if (dato_bcd == 8'h29) begin
			dato_bin = 7'b0011101;
		end		
		else if (dato_bcd == 8'h30) begin
			dato_bin = 7'b0011110;
		end		
		else if (dato_bcd == 8'h31) begin
			dato_bin = 7'b0011111;
		end		
		else if (dato_bcd == 8'h32) begin
			dato_bin = 7'b0100000;
		end
		else if (dato_bcd == 8'h33) begin
			dato_bin = 7'b0100001;
		end
		else if (dato_bcd == 8'h34) begin
			dato_bin = 7'b0100010;
		end
		else if (dato_bcd == 8'h35) begin
			dato_bin = 7'b0100011;
		end
		else if (dato_bcd == 8'h36) begin
			dato_bin = 7'b0100100;
		end
		else if (dato_bcd == 8'h37) begin
			dato_bin = 7'b0100101;
		end
		else if (dato_bcd == 8'h38) begin
			dato_bin = 7'b0100110;
		end
		else if (dato_bcd == 8'h39) begin
			dato_bin = 7'b0100111;
		end
		else if (dato_bcd == 8'h40) begin
			dato_bin = 7'b0101000;
		end
		else if (dato_bcd == 8'h41) begin
			dato_bin = 7'b0101001;
		end
		else if (dato_bcd == 8'h42) begin
			dato_bin = 7'b0101010;
		end
		else if (dato_bcd == 8'h43) begin
			dato_bin = 7'b0101011;
		end
		else if (dato_bcd == 8'h44) begin
			dato_bin = 7'b0101100;
		end
		else if (dato_bcd == 8'h45) begin
			dato_bin = 7'b0101101;
		end
		else if (dato_bcd == 8'h46) begin
			dato_bin = 7'b0101110;
		end
		else if (dato_bcd == 8'h47) begin
			dato_bin = 7'b0101111;
		end
		else if (dato_bcd == 8'h48) begin
			dato_bin = 7'b0110000;
		end
		else if (dato_bcd == 8'h49) begin
			dato_bin = 7'b0110001;
		end
		else if (dato_bcd == 8'h50) begin
			dato_bin = 7'b0110010;
		end
		else if (dato_bcd == 8'h51) begin
			dato_bin = 7'b0110011;
		end
		else if (dato_bcd == 8'h52) begin
			dato_bin = 7'b0110100;
		end
		else if (dato_bcd == 8'h53) begin
			dato_bin = 7'b0110101;
		end
		else if (dato_bcd == 8'h54) begin
			dato_bin = 7'b0110110;
		end
		else if (dato_bcd == 8'h55) begin
			dato_bin = 7'b0110111;
		end
		else if (dato_bcd == 8'h56) begin
			dato_bin = 7'b0111000;
		end
		else if (dato_bcd == 8'h57) begin
			dato_bin = 7'b0111001;
		end
		else if (dato_bcd == 8'h58) begin
			dato_bin = 7'b0111010;
		end
		else if (dato_bcd == 8'h59) begin
			dato_bin = 7'b0111011;
		end
		else if (dato_bcd == 8'h60) begin
			dato_bin = 7'b0111100;
		end
		else if (dato_bcd == 8'h61) begin
			dato_bin = 7'b0111101;
		end
		else if (dato_bcd == 8'h62) begin
			dato_bin = 7'b0111110;
		end
		else if (dato_bcd == 8'h63) begin
			dato_bin = 7'b0111111;
		end
		else if (dato_bcd == 8'h64) begin
			dato_bin = 7'b1000000;
		end
		else if (dato_bcd == 8'h65) begin
			dato_bin = 7'b1000001;
		end
		else if (dato_bcd == 8'h66) begin
			dato_bin = 7'b1000010;
		end
		else if (dato_bcd == 8'h67) begin
			dato_bin = 7'b1000011;
		end
		else if (dato_bcd == 8'h68) begin
			dato_bin = 7'b1000100;
		end
		else if (dato_bcd == 8'h69) begin
			dato_bin = 7'b1000101;
		end
		else if (dato_bcd == 8'h70) begin
			dato_bin = 7'b1000110;
		end
		else if (dato_bcd == 8'h71) begin
			dato_bin = 7'b1000111;
		end
		else if (dato_bcd == 8'h72) begin
			dato_bin = 7'b1001000;
		end
		else if (dato_bcd == 8'h73) begin
			dato_bin = 7'b1001001;
		end
		else if (dato_bcd == 8'h74) begin
			dato_bin = 7'b1001010;
		end
		else if (dato_bcd == 8'h75) begin
			dato_bin = 7'b1001011;
		end
		else if (dato_bcd == 8'h76) begin
			dato_bin = 7'b1001100;
		end
		else if (dato_bcd == 8'h77) begin
			dato_bin = 7'b1001101;
		end
		else if (dato_bcd == 8'h78) begin
			dato_bin = 7'b1001110;
		end
		else if (dato_bcd == 8'h79) begin
			dato_bin = 7'b1001111;
		end
		else if (dato_bcd == 8'h80) begin
			dato_bin = 7'b1010000;
		end
		else if (dato_bcd == 8'h81) begin
			dato_bin = 7'b1010001;
		end
		else if (dato_bcd == 8'h82) begin
			dato_bin = 7'b1010010;
		end
		else if (dato_bcd == 8'h83) begin
			dato_bin = 7'b1010011;
		end
		else if (dato_bcd == 8'h84) begin
			dato_bin = 7'b1010100;
		end
		else if (dato_bcd == 8'h85) begin
			dato_bin = 7'b1010101;
		end
		else if (dato_bcd == 8'h86) begin
			dato_bin = 7'b1010110;
		end
		else if (dato_bcd == 8'h87) begin
			dato_bin = 7'b1010111;
		end
		else if (dato_bcd == 8'h88) begin
			dato_bin = 7'b1011000;
		end
		else if (dato_bcd == 8'h89) begin
			dato_bin = 7'b1011001;
		end
		else if (dato_bcd == 8'h90) begin
			dato_bin = 7'b1011010;
		end
		else if (dato_bcd == 8'h91) begin
			dato_bin = 7'b1011011;
		end
		else if (dato_bcd == 8'h92) begin
			dato_bin = 7'b1011100;
		end
		else if (dato_bcd == 8'h93) begin
			dato_bin = 7'b1011101;
		end
		else if (dato_bcd == 8'h94) begin
			dato_bin = 7'b1011110;
		end
		else if (dato_bcd == 8'h95) begin
			dato_bin = 7'b1011111;
		end
		else if (dato_bcd == 8'h96) begin
			dato_bin = 7'b1100000;
		end
		else if (dato_bcd == 8'h97) begin
			dato_bin = 7'b1100001;
		end
		else if (dato_bcd == 8'h98) begin
			dato_bin = 7'b1100010;
		end
		else if (dato_bcd == 8'h99) begin
			dato_bin = 7'b1100011;
		end
		else begin
			dato_bin = 7'b1111111;
		end
	end

endmodule

