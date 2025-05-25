//-----------------------------------------------------
// File Name : picoMIPS_tb.sv
// Function : Program memory Psize x Isize - reads from file assem.hex
//
// Author: Adam
// 
//-----------------------------------------------------
module picoMIPS_tb;

parameter n = 8;

logic [9:0] SW;
logic[7:0] LED;
logic clk;
  
picoMIPS p0 (.*);

initial 
begin
  clk = 1'b0; 
  forever #40ns clk = ~clk; 
end


initial
  begin
  
    // x1 = 0; y1 = 0;
    SW = 10'b1000000000; //reset = 1
	#80ns SW = 10'b0000000000; // reset = 0; ready = 0;
	#80ns SW = 10'b0000000000; // Enter x1 = 0;
	#160ns SW = 10'b0100000000; // ready = 1;
	#160ns SW = 10'b0100000000; // Enter y1 = 0;
	#40ns SW = 10'b0000000000; // ready = 0;
	
	//show output
	#1100ns SW = 10'b0100000000; //ready = 1; show x2;
	#120ns SW = 10'b0000000000; // ready = 0; show y2;
	
	
	
	
	// x1 = 5; y1 = -4;
	#2900ns;
	#80ns SW = 10'b0000000000; // reset = 0; ready = 0;
	#80ns SW = 10'b0000000101; // Enter x1 = 5;
	#160ns SW = 10'b0100000101; // ready = 1;
	#160ns SW = 10'b0111111100; // Enter y1 = -4;
	#40ns SW = 10'b0011111100; // ready = 0;
	
	//show output
	#1100ns SW = 10'b0111111100; //ready = 1; show x2;
	#120ns SW = 10'b0011111100; // ready = 0; show y2;
	

 
 
    // x1 = 16; y1 = -12;
	#2900ns;
	#80ns SW = 10'b0000000000; // reset = 0; ready = 0;
	#80ns SW = 10'b0000010000; // Enter x1 = 16;
	#160ns SW = 10'b0100010000; // ready = 1;
	#160ns SW = 10'b0111110100; // Enter y1 = -12;
	#40ns SW = 10'b0011110100; // ready = 0;
	
	//show output
	#1100ns SW = 10'b0111110100; //ready = 1; show x2;
	#120ns SW = 10'b0011110100; // ready = 0; show y2;
 
 
 
 
 
 
 
 
 
 
  end
  
endmodule