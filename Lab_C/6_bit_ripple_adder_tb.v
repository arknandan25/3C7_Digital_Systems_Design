//SETTING TIMESCALE
`timescale 1 ns/10 ps

module Ripple_Adder_Testbench;
   //SIGNALS
   reg  [5:0] test_in0, test_in1;
   reg selection;
   wire [5:0] test_out;
   wire carry_out, overflow_flag;

   // instantiate the circuit under test
   Ripple_Adder uut
      (.x(test_in0), .y(test_in1), .sel(selection), .sum(test_out), .c_out(carry_out), .overflow(overflow_flag));

   //TEST VECTORS
   initial
   begin
        
        $display ("                time  x5 x4 x3 x2 x1 x0  y5 y4 y3 y2 y1 y0  sel  s5 s4 s3 s2 s1 s0  c_out  over");
         $monitor("%d   %b  %b  %b  %b  %b  %b   %b  %b  %b  %b  %b  %b   %b   %b  %b  %b  %b  %b  %b     %b      %b", $time, test_in0[5], test_in0[4], test_in0[3], test_in0[2], test_in0[1], test_in0[0],
          test_in1[5], test_in1[4], test_in1[3], test_in1[2], test_in1[1], test_in1[0], selection, test_out[5], test_out[4], test_out[3], test_out[2], test_out[1], test_out[0], carry_out, overflow_flag);
        
      //vector 1
      selection = 1'b1;
      test_in0 = 6'b110000;
      test_in1 = 6'b001111;
      # 200;
      //vector 2
      selection = 1'b1;
      test_in0 = 6'b101010;
      test_in1 = 6'b010101;
      # 200;
      //vector 3
      selection = 1'b1;
      test_in0 = 6'b110000;
      test_in1 = 6'b110000;
      # 200;
      //vector 4
      selection = 1'b1;
      test_in0 = 6'b000111;
      test_in1 = 6'b000101;
      # 200;
      //vector 5
      selection = 1'b1;
      test_in0 = 6'b100111;
      test_in1 = 6'b011110;
      # 200;
      
      //stop
      $stop;
   end
   

endmodule