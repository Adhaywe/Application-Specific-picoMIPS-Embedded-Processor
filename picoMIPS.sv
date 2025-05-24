//------------------------------------
// File Name   : picoMIPS.sv
// Function    : picoMIPS CPU top level encapsulating module
//
// Author      : Adam
// 
//------------------------------------

`include "alucodes.sv"
module picoMIPS #( parameter n = 8)
(input logic clk,
input logic [9:0] SW,
output logic[7:0] LED
);       


assign reset = SW[9];
assign ready = SW[8];


logic [2:0] ALUfunc; 
logic [3:0] flags; 
logic imm; 
logic immsw;
logic [n-1:0] Alub;

logic [n-1:0] Rdata1, Rdata2, Wdata, Mdata; 
logic w;  


logic r;
logic w1;

parameter Psize = 6; 
logic PCincr,PCabsbranch;
logic [Psize-1 : 0]ProgAddress;

parameter Isize = n+16; 
logic [Isize:0] I; 

// module instantiations
pc  #(.Psize(Psize)) progCounter (.clk(clk),.reset(reset),
        .PCincr(PCincr),
        .PCabsbranch(PCabsbranch),
        .Branchaddr(I[Psize-1:0]), 
        .PCout(ProgAddress) );

prog #(.Psize(Psize),.Isize(Isize)) 
      progMemory (.address(ProgAddress),.I(I));

decoder  D (.opcode(I[Isize-1:Isize-6]),
            .PCincr(PCincr),
            .PCabsbranch(PCabsbranch), 
            .flags(flags),
		  .ALUfunc(ALUfunc),.imm(imm),.w(w),.immsw(immsw), .ready(ready));

regs   #(.n(n))  gpr(.clk(clk),.w(w),.Wdata(Wdata),
		.Raddr2(I[Isize-7:Isize-11]), 
		.Raddr1(I[Isize-12:Isize-16]),
        .Rdata1(Rdata1),.Rdata2(Rdata2));


alu    #(.n(n))  iu(.a(Rdata1),.b(Alub),
       .func(ALUfunc),.flags(flags), 
       .result(Wdata)); 
	   


assign Alub = immsw ? SW[7:0] : (imm ? I[n-1:0] : Rdata2);

assign LED = Wdata;

endmodule