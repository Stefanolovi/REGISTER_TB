//in this file, a library containing the assertions is written. The expected result is written like a property, which can be then verified as an assertion 
// I need to verify to properties: one about the regular output and one about the reset output. 
//the rf is a synchronous element, $past is used to refer to the values in the past cc. 
// I also need to compute the error number through a function. and make an assertion. 
//note that reset in the dut is synchronous. 

`ifndef ALU_IF_SVA_SVH_
`define ALU_IF_SVA_SVH_

int err_num = 0; 


//this function will return the err_num and reset the counter. 
function int  get_err_num ();
int n = err_num; 
err_num= 0; 
return n; 
endfunction; 

 // in this case I'm checking both rst and regular behaviour with a single property. 
 //property is checked at posedge of the clk 
property p_out begin 
  @(negedge clk)
if ($past(rst)==0) Y == $past (A); 
else Y == 0; 
endproperty  
 

//the assertion checks the property: if it's not true it will print the wrong input to output relation. It will also increase the 
//err_num parameter.
rf_assertion: assert property (p_out); 
else begin 
    $display ("T: %t | ERROR: Previous A: %b, Y: %b, rst: %b", $time, %past(A), Y, $past(rst));
    err_num++;
end


`endif /* ALU_IF_SVA_SVH_ */




