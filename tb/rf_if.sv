//an interface decribing the communicating signals to the dut . different modports can be used to describe the signals as inputs or outputs from different POVS
// CLK and rst can also be initialized here, the clk process can be written here. the rst procedure can be performed by a task.

interface rf_if # (parameter N = 10 );

 logic clk; 
 logic rst; 
 logic [N-1:0] A; 
 logic [N-1:0] Y; 

 modport rf_port (

  input  clk,
  input rst, 
  output A, 
  output Y 
  ); 
 
 initial begin 
  clk = 1'b1; 
  rst <= 1'b0;


 end 
 
always #10ns clk <=  ~clk; 

 task rest_procedure (); 
      @(negedge clk)
      rst = 1'b1; 
      @(negedge clk)
      rst = 1'b0; 
 endtask


endinterface 