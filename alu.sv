//-----------------------------------------------------
// File Name   : alu.sv
// Function    : ALU module for picoMIPS
//
// Author: Adam
// 
//-----------------------------------------------------


`include "alucodes.sv"  
module alu  #(parameter n=8)(
   input logic signed [n-1:0] a, b, 
   input logic [2:0] func, 
   output logic [3:0] flags, 
   output logic [n-1:0] result 
);       


logic signed [15:0] m;

assign   m = a * b;

always_comb
begin
  
  flags = 3'b0;
  result = a; 
  case(func)
  	 
     `RADD  : begin
	     result = a + b;
		end
	 `RMUL: result = m[14:7];
	 
    default: ;
   endcase
	 
 
  flags[1] = result == {8{1'b0}}; 
 
 end

endmodule 