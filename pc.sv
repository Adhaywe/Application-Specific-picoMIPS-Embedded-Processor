//-----------------------------------------------------
// File Name : pc.sv
// Function : picoMIPS Program Counter
// functions: increment, absolute branch
//
// Author: Adam
// 
//-----------------------------------------------------
module pc #(parameter Psize = 6) // up to 64 instructions
(input logic clk, reset, PCincr,PCabsbranch,
 input logic [Psize-1:0] Branchaddr,
 output logic [Psize-1 : 0]PCout
);

logic[Psize-1:0] Rbranch; // temp variable for addition operand
always_comb
  if (PCincr)
       Rbranch = { {(Psize-1){1'b0}}, 1'b1};
  else Rbranch =  Branchaddr;


always_ff @ ( posedge clk or posedge reset) // async reset
  if (reset) // sync reset
     PCout <= {Psize{1'b0}};
  else if (PCincr)
     PCout <= PCout + Rbranch; 
  else if (PCabsbranch) 
     PCout <= Branchaddr;
	 
endmodule 