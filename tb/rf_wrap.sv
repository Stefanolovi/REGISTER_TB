// it's a SV module where the vhdl entity is instantiated and connected to an instance of the interface.

module rf_wrap #(parameter N = 10 )
               (rf_if.rf_port   r );

       REG #(N) dut        
       (.en(r.clk),
        .rst (r.rst),
        .A(r.A),
        .Y(r.Y));
endmodule 