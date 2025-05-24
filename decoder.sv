//---------------------------------------------------------
// File Name   : decoder.sv
// Function    : picoMIPS instruction decoder 
//
// Author: Adam
// 
//---------------------------------------------------------

`include "alucodes.sv"
`include "opcodes.sv"

module decoder
( input logic [5:0] opcode, 
input [3:0] flags, 
input logic ready,
output logic PCincr,PCabsbranch,
output logic [2:0] ALUfunc, 
output logic imm, immsw,
output logic w
  );
   
logic takeBranch; 
always_comb 
begin
 
   PCincr = 1'b1; 
   PCabsbranch = 1'b0;
   ALUfunc = opcode[2:0]; 
   imm=1'b0; w=1'b0; immsw = 1'b0;
   case(opcode)
     `NOP: ;
	 
     `ADD : begin 
	        w = 1'b1; 
	      end
		  
     `ADDI: begin 
	       w = 1'b1; 
		   imm = 1'b1; 
	      end
		  
	 `LDI : begin
           w=1'b1;
           immsw = 1'b1;
            end		   
	  
	 `IO1: begin
	       PCincr = ready;
		  end
		
		 
	 `IO2: begin
	       PCincr = ~ready;
		  end
		
		   
	 `MULTI : begin
	       
		   imm = 1'b1;
		   w = 1'b1;
		   
		   end
	
	  `J: begin
	     PCabsbranch = 1'b1;
		 PCincr = 1'b0;
		 end
	 default : ;
 
  endcase 
  

end 


endmodule