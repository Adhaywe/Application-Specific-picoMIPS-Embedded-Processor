//-----------------------------------------------------
// File Name : regs.sv
// Function : picoMIPS 8 x 5 registers, %0 == 0
// 
// Author: Adam
// 
//-----------------------------------------------------
module regs #(parameter n=8)(input logic clk, w, 
 input logic [n-1:0] Wdata,
 input logic [4:0] Raddr1, Raddr2,
 output logic [7:0] Rdata1, Rdata2);

 	// Declare 5, 8-bit registers 
	logic [7:0] gpr [4:0];

	
	initial begin
    for (int i = 0; i < 5; ++i)
        gpr[i] = 0;
		end
	

	// write process, dest reg is Raddr2
	always @ (posedge clk)
	begin
		if (w) begin
            gpr[Raddr2] <= Wdata;
			end
	end
			
	// read process
	assign Rdata1 = gpr[Raddr1];
			
	assign Rdata2 = gpr[Raddr2];
	  

endmodule 

