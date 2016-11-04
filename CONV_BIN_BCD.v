`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:41:39 11/04/2016 
// Design Name: 
// Module Name:    CONV_BIN_BCD 
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
module CONV_BIN_BCD(
	input wire [6:0] dato_bin,
	output reg [7:0] dato_bcd
   );
	
	always @ (dato_bin) begin
		if (dato_bin == 7'b0000000) begin
			dato_bcd = 8'h00;
		end
		else if (dato_bin == 7'b0000001) begin
			dato_bcd = 8'h01;
		end
		else if (dato_bin == 7'b0000010) begin
			dato_bcd = 8'h02;
		end
		else if (dato_bin == 7'b0000011) begin
			dato_bcd = 8'h03;
		end
		else if (dato_bin == 7'b0000100) begin
			dato_bcd = 8'h04;
		end
		else if (dato_bin == 7'b0000101) begin
			dato_bcd = 8'h05;
		end
		else if (dato_bin == 7'b0000110) begin
			dato_bcd = 8'h06;
		end
		else if (dato_bin == 7'b0000111) begin
			dato_bcd = 8'h07;
		end
		else if (dato_bin == 7'b0001000) begin
			dato_bcd = 8'h08;
		end
		else if (dato_bin == 7'b0001001) begin
			dato_bcd = 8'h09;
		end
		else if (dato_bin == 7'b0001010) begin
			dato_bcd = 8'h10;
		end
		else if (dato_bin == 7'b0001011) begin
			dato_bcd = 8'h11;
		end
		else if (dato_bin == 7'b0001100) begin
			dato_bcd = 8'h12;
		end
		else if (dato_bin == 7'b0001101) begin
			dato_bcd = 8'h13;
		end
		else if (dato_bin == 7'b0001110) begin
			dato_bcd = 8'h14;
		end
		else if (dato_bin == 7'b0001111) begin
			dato_bcd = 8'h15;
		end
		else if (dato_bin == 7'b0010000) begin
			dato_bcd = 8'h16;
		end
		else if (dato_bin == 7'b0010001) begin
			dato_bcd = 8'h17;
		end
		else if (dato_bin == 7'b0010010) begin
			dato_bcd = 8'h18;
		end
		else if (dato_bin == 7'b0010011) begin
			dato_bcd = 8'h19;
		end
		else if (dato_bin == 7'b0010100) begin
			dato_bcd = 8'h20;
		end
		else if (dato_bin == 7'b0010101) begin
			dato_bcd = 8'h21;
		end
		else if (dato_bin == 7'b0010110) begin
			dato_bcd = 8'h22;
		end
		else if (dato_bin == 7'b0010111) begin
			dato_bcd = 8'h23;
		end		
		else if (dato_bin == 7'b0011000) begin
			dato_bcd = 8'h24;
		end		
		else if (dato_bin == 7'b0011001) begin
			dato_bcd = 8'h25;
		end		
		else if (dato_bin == 7'b0011010) begin
			dato_bcd = 8'h26;
		end		
		else if (dato_bin == 7'b0011011) begin
			dato_bcd = 8'h27;
		end		
		else if (dato_bin == 7'b0011100) begin
			dato_bcd = 8'h28;
		end		
		else if (dato_bin == 7'b0011101) begin
			dato_bcd = 8'h29;
		end		
		else if (dato_bin == 7'b0011110) begin
			dato_bcd = 8'h30;
		end		
		else if (dato_bin == 7'b0011111) begin
			dato_bcd = 8'h31;
		end		
		else if (dato_bin == 7'b0100000) begin
			dato_bcd = 8'h32;
		end
		else if (dato_bin == 7'b0100001) begin
			dato_bcd = 8'h33;
		end
		else if (dato_bin == 7'b0100010) begin
			dato_bcd = 8'h34;
		end
		else if (dato_bin == 7'b0100011) begin
			dato_bcd = 8'h35;
		end
		else if (dato_bin == 7'b0100100) begin
			dato_bcd = 8'h36;
		end
		else if (dato_bin == 7'b0100101) begin
			dato_bcd = 8'h37;
		end
		else if (dato_bin == 7'b0100110) begin
			dato_bcd = 8'h38;
		end
		else if (dato_bin == 7'b0100111) begin
			dato_bcd = 8'h39;
		end
		else if (dato_bin == 7'b0101000) begin
			dato_bcd = 8'h40;
		end
		else if (dato_bin == 7'b0101001) begin
			dato_bcd = 8'h41;
		end
		else if (dato_bin == 7'b0101010) begin
			dato_bcd = 8'h42;
		end
		else if (dato_bin == 7'b0101011) begin
			dato_bcd = 8'h43;
		end
		else if (dato_bin == 7'b0101100) begin
			dato_bcd = 8'h44;
		end
		else if (dato_bin == 7'b0101101) begin
			dato_bcd = 8'h45;
		end
		else if (dato_bin == 7'b0101110) begin
			dato_bcd = 8'h46;
		end
		else if (dato_bin == 7'b0101111) begin
			dato_bcd = 8'h47;
		end
		else if (dato_bin == 7'b0110000) begin
			dato_bcd = 8'h48;
		end
		else if (dato_bin == 7'b0110001) begin
			dato_bcd = 8'h49;
		end
		else if (dato_bin == 7'b0110010) begin
			dato_bcd = 8'h50;
		end
		else if (dato_bin == 7'b0110011) begin
			dato_bcd = 8'h51;
		end
		else if (dato_bin == 7'b0110100) begin
			dato_bcd = 8'h52;
		end
		else if (dato_bin == 7'b0110101) begin
			dato_bcd = 8'h53;
		end
		else if (dato_bin == 7'b0110110) begin
			dato_bcd = 8'h54;
		end
		else if (dato_bin == 7'b0110111) begin
			dato_bcd = 8'h55;
		end
		else if (dato_bin == 7'b0111000) begin
			dato_bcd = 8'h56;
		end
		else if (dato_bin == 7'b0111001) begin
			dato_bcd = 8'h57;
		end
		else if (dato_bin == 7'b0111010) begin
			dato_bcd = 8'h58;
		end
		else if (dato_bin == 7'b0111011) begin
			dato_bcd = 8'h59;
		end
		else if (dato_bin == 7'b0111100) begin
			dato_bcd = 8'h60;
		end
		else if (dato_bin == 7'b0111101) begin
			dato_bcd = 8'h61;
		end
		else if (dato_bin == 7'b0111110) begin
			dato_bcd = 8'h62;
		end
		else if (dato_bin == 7'b0111111) begin
			dato_bcd = 8'h63;
		end
		else if (dato_bin == 7'b1000000) begin
			dato_bcd = 8'h64;
		end
		else if (dato_bin == 7'b1000001) begin
			dato_bcd = 8'h65;
		end
		else if (dato_bin == 7'b1000010) begin
			dato_bcd = 8'h66;
		end
		else if (dato_bin == 7'b1000011) begin
			dato_bcd = 8'h67;
		end
		else if (dato_bin == 7'b1000100) begin
			dato_bcd = 8'h68;
		end
		else if (dato_bin == 7'b1000101) begin
			dato_bcd = 8'h69;
		end
		else if (dato_bin == 7'b1000110) begin
			dato_bcd = 8'h70;
		end
		else if (dato_bin == 7'b1000111) begin
			dato_bcd = 8'h71;
		end
		else if (dato_bin == 7'b1001000) begin
			dato_bcd = 8'h72;
		end
		else if (dato_bin == 7'b1001001) begin
			dato_bcd = 8'h73;
		end
		else if (dato_bin == 7'b1001010) begin
			dato_bcd = 8'h74;
		end
		else if (dato_bin == 7'b1001011) begin
			dato_bcd = 8'h75;
		end
		else if (dato_bin == 7'b1001100) begin
			dato_bcd = 8'h76;
		end
		else if (dato_bin == 7'b1001101) begin
			dato_bcd = 8'h77;
		end
		else if (dato_bin == 7'b1001110) begin
			dato_bcd = 8'h78;
		end
		else if (dato_bin == 7'b1001111) begin
			dato_bcd = 8'h79;
		end
		else if (dato_bin == 7'b1010000) begin
			dato_bcd = 8'h80;
		end
		else if (dato_bin == 7'b1010001) begin
			dato_bcd = 8'h81;
		end
		else if (dato_bin == 7'b1010010) begin
			dato_bcd = 8'h82;
		end
		else if (dato_bin == 7'b1010011) begin
			dato_bcd = 8'h83;
		end
		else if (dato_bin == 7'b1010100) begin
			dato_bcd = 8'h84;
		end
		else if (dato_bin == 7'b1010101) begin
			dato_bcd = 8'h85;
		end
		else if (dato_bin == 7'b1010110) begin
			dato_bcd = 8'h86;
		end
		else if (dato_bin == 7'b1010111) begin
			dato_bcd = 8'h87;
		end
		else if (dato_bin == 7'b1011000) begin
			dato_bcd = 8'h88;
		end
		else if (dato_bin == 7'b1011001) begin
			dato_bcd = 8'h89;
		end
		else if (dato_bin == 7'b1011010) begin
			dato_bcd = 8'h90;
		end
		else if (dato_bin == 7'b1011011) begin
			dato_bcd = 8'h91;
		end
		else if (dato_bin == 7'b1011100) begin
			dato_bcd = 8'h92;
		end
		else if (dato_bin == 7'b1011101) begin
			dato_bcd = 8'h93;
		end
		else if (dato_bin == 7'b1011110) begin
			dato_bcd = 8'h94;
		end
		else if (dato_bin == 7'b1011111) begin
			dato_bcd = 8'h95;
		end
		else if (dato_bin == 7'b1100000) begin
			dato_bcd = 8'h96;
		end
		else if (dato_bin == 7'b1100001) begin
			dato_bcd = 8'h97;
		end
		else if (dato_bin == 7'b1100010) begin
			dato_bcd = 8'h98;
		end
		else if (dato_bin == 7'b1100011) begin
			dato_bcd = 8'h99;
		end
		else begin
			dato_bcd = 8'hff;
		end
	end

endmodule


