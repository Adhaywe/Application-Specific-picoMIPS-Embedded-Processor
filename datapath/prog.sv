//-----------------------------------------------------
// File Name : prog.sv
// Function : Program memory Psize x Isize - reads from file assem.hex
//
// Author: Adam
// 
//-----------------------------------------------------
module prog #(parameter Psize = 6, Isize = 24) 
(input logic [Psize-1:0] address,
output logic [Isize:0] I); 

// program memory declaration, note: 1<<n is same as 2^n
logic [Isize:0] progMem[ (1<<Psize)-1:0];


initial
  $readmemh("assem.hex", progMem);
  

always_comb
  I = progMem[address];
  
endmodule 