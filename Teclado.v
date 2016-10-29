`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:36:01 10/22/2016 
// Design Name: 
// Module Name:    Teclado 
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
module Teclado(
    input wire clk, reset,
    input wire ps2d, ps2c, rx_en,
    output reg rx_done_tick,
    output wire [7:0] dout,
	 output wire [7:0] letra,
	 output reg llegoF
   );

   // symbolic state declaration
   localparam [1:0]
      idle = 2'b00,
      dps  = 2'b01,
      load = 2'b10;
	
	//VARIABLE PARA ALMACENAR EN SALIDA
	//wire [7:0] dout;
	
	//DECLARACIÓN DE SEÑALES
	reg [1:0] Est_act, Est_sig;
	reg [3:0] cont = 0;
	reg [7:0] letra1;

   // signal declaration
   reg [1:0] state_reg, state_next;
   reg [7:0] filter_reg;
   wire [7:0] filter_next;
   reg f_ps2c_reg;
   wire f_ps2c_next;
   reg [3:0] n_reg, n_next;
   reg [10:0] b_reg, b_next;
   wire fall_edge;

   // body
   //=================================================
   // filter and falling-edge tick generation for ps2c
   //=================================================
   always @(posedge clk, posedge reset)
   if (reset)
      begin
         filter_reg <= 0;
         f_ps2c_reg <= 0;
      end
   else
      begin
         filter_reg <= filter_next;
         f_ps2c_reg <= f_ps2c_next;
      end

   assign filter_next = {ps2c, filter_reg[7:1]};
   assign f_ps2c_next = (filter_reg==8'b11111111) ? 1'b1 :
                        (filter_reg==8'b00000000) ? 1'b0 :
                         f_ps2c_reg;
   assign fall_edge = f_ps2c_reg & ~f_ps2c_next;

   //=================================================
   // FSMD
   //=================================================
   // FSMD state & data registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= idle;
            n_reg <= 0;
            b_reg <= 0;
         end
      else
         begin
            state_reg <= state_next;
            n_reg <= n_next;
            b_reg <= b_next;
         end
   // FSMD next-state logic
   always @*
   begin
      state_next = state_reg;
      rx_done_tick = 1'b0;
      n_next = n_reg;
      b_next = b_reg;
      case (state_reg)
			idle:
				if (fall_edge & rx_en)
               begin
                  // shift in start bit
                  b_next = {ps2d, b_reg[10:1]};
                  n_next = 4'b1001;
                  state_next = dps;
               end
         dps: // 8 data + 1 parity + 1 stop
            if (fall_edge)
               begin
                  b_next = {ps2d, b_reg[10:1]};
                  if (n_reg==0)
                     state_next = load;
                  else
                     n_next = n_reg - 4'b0001;
               end
         load: // 1 extra clock to complete the last shift
            begin
               state_next = idle;
               rx_done_tick = 1'b1;
            end
      endcase
   end
   // output
   assign dout = b_reg[8:1]; // data bits
	






//registro llegoF0
//	reg llegoF; //registro llego F0 ponerlo luego aqui, primero colocar como salida, para ver su comportamiento

	always @(posedge clk, posedge reset)  
		if(reset)
			llegoF <= 0;
		else
			if(~llegoF)
				llegoF <= (~rx_done_tick) ? 0:
							(dout==8'hF0) ? 1'b1:0;
			else
				llegoF <= ~rx_done_tick ? 1'b1:0;
	

	always @*
	begin 
	letra1=0;
		if (llegoF==1) begin
			//letra1=dout;
			case (dout)
				8'h2B:
					letra1=dout; //letra F
				8'h33:
					letra1=dout; //letra H
				8'h2C:
					letra1=dout; //letra T
				8'h75:
					letra1=dout; //flecha arriba
				8'h74:
					letra1=dout; //flecha derecha
				8'h6B:
					letra1=dout; //flecha izquierda
				8'h72:
					letra1=dout; //flecha abajo
				8'h76: 
					letra1=dout; //tecla ESC
				//default:
				//	letra1=0;
			endcase
		end
		else
			//letra1=letra1;
			cont=4'b0001;
	end
	
	//Establecer comparación cuando detec==0 y letra==(a la letra a usar), 
	//para mandar como salida en otra variable a dicha letra
	
	assign letra = letra1; //letra es tipo wire [7:0]
	
endmodule


// CODIGO 1
/*always @ (posedge clk, posedge reset)
	begin
	if (reset) begin
		detec1<=0;
		letra1<=0;
	end
	else 
		if (rx_done_tick==1) begin
			if (dout==8'hF0) begin
				detec1 <= dout;
			end
			else begin
				if (detec==8'hF0) begin
					//letra1=dout;
					case (dout)
						8'h2B:
							letra1<=dout; //letra F
						8'h33:
							letra1<=dout; //letra H
						8'h2C:
							letra1<=dout; //letra T
						8'h75:
							letra1<=dout; //flecha arriba
						8'h74:
							letra1<=dout; //flecha derecha
						8'h6B:
							letra1<=dout; //flecha izquierda
						8'h72:
							letra1<=dout; //flecha abajo
						8'h76:
							letra1<=dout; //tecla ESC
						default:
							begin
							letra1<=0;
							detec1<=0;
							end
					endcase
					detec1<=0;
				end
				else
					//letra1=0;
					cont<=0;
			end
		end
		else begin
				detec1 <= detec;
				letra1 <= letra1;
				//letra1=0; //se reinicia el valor de letra, si el tiempo de envio de dato es de 10ns
				//letra1=0; //solo si el valor de la letra al enviarse, es por un tiempo de 1,2ms aprox
		end
	end*/


//CODIGO 2
/*always @*
	begin 
	
		if (rx_done_tick==1) begin
			if (dout==8'hF0) begin
				detec1 = dout;
			end
			else begin
				if (detec==8'hF0) begin
					//letra1=dout;
					case (dout)
						8'h2B:
							letra1=dout; //letra F
						8'h33:
							letra1=dout; //letra H
						8'h2C:
							letra1=dout; //letra T
						8'h75:
							letra1=dout; //flecha arriba
						8'h74:
							letra1=dout; //flecha derecha
						8'h6B:
							letra1=dout; //flecha izquierda
						8'h72:
							letra1=dout; //flecha abajo
						8'h76: 
							letra1=dout; //tecla ESC
						default:
							begin
							letra1=0;
							detec1=0;
							end
					endcase
					detec1=0;
				end
				else
					//letra1=0;
					cont=0;
			end
		end
		else begin
				detec1 = detec;
				//letra1=0; //se reinicia el valor de letra, si el tiempo de envio de dato es de 10ns
				//letra1=0; //solo si el valor de la letra al enviarse, es por un tiempo de 1,2ms aprox
		end
	end*/