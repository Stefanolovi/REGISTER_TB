// in this class we will write the actual task of the testbench. 
//we create an instance of the interface and of the coverage class. 
// we need to implement a init() and a run_test() procedure. 
//in this case A is the only input we need to attribute a value to.
// rand_A will assume a random value and then be assignes to the .A inn the IF

`ifndef RF_TESTER_SVH_
`define RF_TESTER_SVH_

`include "rf_cov.svh"

class rf_tester #(parameter N = 10); 

rand logic [N-1:0] rand_A;

virtual interface rf_if trf_if;

    constraint ab_dist_c {
        rand_A dist {
            0                   :=10, 
            (1<<N)-1       :=10,
            (1<<(N-1))-1   :=10, 
            [1:(1<<N)-2]   :=1
        };
    };


protected static rf_cov trf_cvg;

function new(virtual interface rf_if _if);
trf_if = _if;
trf_cvg = new(_if);
endfunction

//run_test
task run_test (int unsigned num_cycles);
init (); 
trf_cvg.cov_start();

repeat (num_cycles) begin
@(posedge trf_if.clk);
gen_rand_in();
@(negedge trf_if.clk)  
$display ("rst = %b, A = %b, Y = %b", trf_if.rst, trf_if.A, trf_if.Y);
end 

@(posedge trf_if.clk)
trf_cvg.cov_stop();
endtask 


//generate random inputas and drive it to A in the dut if.
function void gen_rand_in (); 
assert (this.randomize())
else $display("error in random input generation");
trf_if.A = rand_A;
trf_cvg.cov_sample();
endfunction

task init(); 
trf_if.A = 0;
trf_if.rest_procedure ();
@(posedge trf_if.clk);
endtask: init 

function real get_cov();
    return trf_cvg.get_cov();
endfunction: get_cov

endclass; 

`endif 