// setting the timescale
`timescale 1 ns/10 ps

module gr_testbench;
   //declare signals
   reg  [1:0] test_in0, test_in1;
   wire  test_out;

   //instantiate circuit under test
   gr2 uut
      (.a(test_in0), .b(test_in1), .agrb(test_out));

   //generate test vectors
   initial
   begin
      $display ("                time  a1 a0  b1 b0  agrb");
      $monitor("%d   %b %b   %b %b     %b", $time, test_in0[1], test_in0[0], test_in1[1], test_in1[0], test_out);
      //vector 1
      test_in0 = 2'b11;
      test_in1 = 2'b00;
      # 200;
      //vector 2
      test_in0 = 2'b00;
      test_in1 = 2'b01;
      # 200;
      //vector 3
      test_in0 = 2'b10;
      test_in1 = 2'b01;
      # 200;
      //vector 4
      test_in0 = 2'b10;
      test_in1 = 2'b10;
      # 200;
      //vector 5
      test_in0 = 2'b10;
      test_in1 = 2'b00;
      # 200;
      //vector 6
      test_in0 = 2'b11;
      test_in1 = 2'b11;
      # 200;
      //vector 7
      test_in0 = 2'b11;
      test_in1 = 2'b01;
      # 200;
      //stop
      $stop;
   end
  
endmodule