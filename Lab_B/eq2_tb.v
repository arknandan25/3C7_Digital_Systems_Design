//setting timescale
`timescale 1 ns/10 ps

module eq8_testbench;
   //declaring signals
   reg  [7:0] test_in0, test_in1;
   wire  test_out;

   //instantiating eq8 circuit
   eq8 uut
      (.c(test_in0), .d(test_in1), .greq(test_out));

   //test vectors
   initial
   begin
      //terminal output
      
      $display ("                time  a7 a6 a5 a4 a3 a2 a1 a0  b7 b6 b5 b4 b3 b2 b1 b0  aeqb");
      $monitor("%d   %b  %b  %b  %b  %b  %b  %b  %b   %b  %b  %b  %b  %b  %b  %b  %b     %b", $time, test_in0[7], test_in0[6], test_in0[5], test_in0[4], test_in0[3], test_in0[2], test_in0[1], test_in0[0],
       test_in1[7], test_in1[6], test_in1[5], test_in1[4], test_in1[3], test_in1[2], test_in1[1], test_in1[0], test_out);
       
      //vector 1, equal to, should be high
      test_in0 = 8'b00000000;
      test_in1 = 8'b00000000;
      # 200;
      //vector 2, greater than, should be high
      test_in0 = 8'b01010001;
      test_in1 = 8'b00010001;
      # 200;
      //vector 3, less than, should be low
      test_in0 = 8'b01010001;
      test_in1 = 8'b11111111;
      # 200;
      //vector 4, equal to, should be high
      test_in0 = 8'b10000111;
      test_in1 = 8'b10000111;
      # 200;
      //vector 5, greater then, should be high
      test_in0 = 8'b10000000;
      test_in1 = 8'b01111111;
      # 200;
      //vector 6, less than, should be low
      test_in0 = 8'b01111111;
      test_in1 = 8'b10000000;
      # 200;
      //vector 7, greater than, should be high
      test_in0 = 8'b11111111;
      test_in1 = 8'b01111110;
      # 200;
      //stop
      $stop;
   end
   

endmodule