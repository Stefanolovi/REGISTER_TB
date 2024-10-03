// this is a library that contains the coverage class. In the class the covergroup is defined. These are significant values 
//that i want to check if they were verified or not. I also need a constructor class, and 4 functions: start, end, sample,get. 

`ifndef RF_COV_SVH_
`define RF_COV_SVH_

class rf_cov #(parameter N = 10);

virtual interface rf_if _if;

covergroup rf_cg; 

A_cp: coverpoint _if.A  iff(_if.rst == 0 )
{
  bins corner[] = {0, (1<<N) -1, (1<<(N-1))-1};
  bins others = default; 
} 
endgroup: rf_cg

//constructor
function new (virtual interface rf_if new_if);
_if = new_if; 
rf_cg = new();

rf_cg.stop();
endfunction


//cov_start
function void cov_start ();
rf_cg.start();
endfunction:cov_start


//cov_stop
function void cov_stop (); 
rf_cg.stop();
endfunction

function void cov_sample (); 
rf_cg.sample();
endfunction

function real get_cov (); 
 return rf_cg.get_inst_coverage();
endfunction

endclass

`endif /* ALU_COV_SVH_ */