// Listing 4.19
module stop_watch_test
   (
    input wire clk,
    input wire go, clr,
    output wire [3:0] an,
    output wire [7:0] sseg
   );

   // signal declaration
   wire [3:0]  d3, d2, d1, d0;

   // instantiate 7-seg LED display module
   //***PART 1 - ADDED .hex3(d3) TO ALLOW MINUTE DISPLAY TO BE UPDATED***
   //***PART 1 - CHANGED TO dp_in(4'b0101) TO ENABLE DECIMAL POINT BESIDE MINUTE DISPLAY***
   disp_hex_mux disp_unit (.clk(clk), .reset(1'b0), .hex3(d3), .hex2(d2), .hex1(d1), .hex0(d0), .dp_in(4'b0101), .an(an), .sseg(sseg));

   // instantiate stopwatch
   //***PART 1 - ADDED .d3(d3) AS INPUT TO THE STOPWATCH LOGIC***
   stop_watch_if counter_unit (.clk(clk), .go(go), .clr(clr), .d3(d3), .d2(d2), .d1(d1), .d0(d0) );
       
   //disable the unused display by setting it to 1
   //***PART 1 - CHANGED TO 4'b0000 TO ENABLE 4TH DISPLAY***
   assign an = an | 4'b0000;

endmodule
