// the main testbench module where the components are declared. 
//Here I instanciate the interface, the wrap. Then in task I instance a tester object, a coverage object and run the test with a scertain 
//num_cycles value. at the en of the test I display the coverage and the errors. 

`include "rf_tester.svh"

module rf_tb #(parameter N = 10); 

//if instance called tbrf_if
rf_if #(N) tbrf_if ();
//wrap instance called tbrf_wr
rf_wrap #(N) tbrf_wr (tbrf_if.rf_port);
//tester object instance called tst
rf_tester tst;
int unsigned num_cycles = 10;

//run test
initial begin
//user defined number of cycles
if (0 != $value$plusargs("n%d", num_cycles))
     $display("[CONFIG] Number of test cycles set to %0d", num_cycles);

//call tester constructor
tst = new(tbrf_if);

$display ("\nstarting test...");
tst.run_test(num_cycles); 
$display ("test finished.");

$display("\nTOTAL FUNCTIONAL COVERAGE: %.2f%%", tst.get_cov());

$stop;

end
endmodule 
