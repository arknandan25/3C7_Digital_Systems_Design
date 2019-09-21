//TESTBENCH MODULE FOR 6-BIT 2'S COMPLEMENT INVERTER
//setting the timescale
`timescale 1 ns/10 ps

module not_tb;
    //declaring test signals
    reg [5:0] test_in;
    wire [5:0] test_out;
    
    not6 uut (.x(test_in), .invx(test_out));
    
    initial
    begin
    
    //TEST VECTORS
          //vector 1
          test_in = 6'b000001;
          # 200;
          //vector 2
          test_in = 6'b101110;
          # 200;
          //vector 3
          test_in = 6'b110010;
          # 200;
          //vector 4
          test_in = 6'b100111;
          # 200;
          //vector 5
          test_in = 6'b011110;
          # 200;
          
          $stop;
    end
    
endmodule