// Listing 4.18
module stop_watch_if
   (
    input wire clk,
    input wire go, clr,
    //***PART 1 - ADDED OUTPUT WIRE "d3" FOR MINUTE DISPLAY***
    output wire [3:0] d3, d2, d1, d0
   );

   // declaration
   localparam  DVSR = 10000000;
   reg [23:0] ms_reg;
   wire [23:0] ms_next;
   //***PART 1 - ADDED d3_reg AND d3_next FOR STORING AND CHANGING VALUE OF MINUTE DISPLAY***
   reg [3:0] d3_reg, d2_reg, d1_reg, d0_reg;
   reg [3:0] d3_next, d2_next, d1_next, d0_next;
   wire ms_tick;

   // body
   // register
   always @(posedge clk)
   begin
      ms_reg <= ms_next;
      //***PART 1 - ADDED d3_reg <= d3_next TO UPDATE VALUE OF MINUTE DISPLAY***
      d3_reg <= d3_next;
      d2_reg <= d2_next;
      d1_reg <= d1_next;
      d0_reg <= d0_next;
   end

   // next-state logic
   // 0.1 sec tick generator: mod-5000000
   assign ms_next = (clr || (ms_reg==DVSR && go)) ? 4'b0 :
                    (go) ? ms_reg + 1 :
                           ms_reg;
   assign ms_tick = (ms_reg==DVSR) ? 1'b1 : 1'b0;
   // 3-digit bcd counter
   always @*
   begin
      // default: keep the previous value
      d0_next = d0_reg;
      d1_next = d1_reg;
      d2_next = d2_reg;
      //***PART 1 - ADDED d3_next = d3_reg*** 
      d3_next = d3_reg;
      if (clr)
         begin
            d0_next = 4'b0;
            d1_next = 4'b0;
            d2_next = 4'b0;
            //***PART 1 - ADDED d3_next = 4'b0 TO SET MINUTE DISPLAY TO 0 WHEN clr IS HIGH***
            d3_next = 4'b0;
         end
      else if (ms_tick)
         if (d0_reg != 9)
            d0_next = d0_reg + 1;
         else              // reach X.XX.9
            begin
               d0_next = 4'b0;
               if (d1_reg != 9)
                  d1_next = d1_reg + 1;
               else       // reach X.X9.9
                  begin
                     d1_next = 4'b0;
                     //***PART 1 - CHANGED TO !=5, AS X.59.X IS THE MAX VALUE FOR SECONDS COUNTER***
                     if (d2_reg != 5)
                        d2_next = d2_reg + 1;
                        //***PART 1 - ADDED LOGIC TO COUNT USING THE MINUTES DISPLAY***
                     else // reach X.99.9
                        begin
                            d2_next = 4'b0;//SET SECONDS TENS DISPLAY TO 0
                            if(d3_reg != 9)//MAX MINUTE DISPLAYED = 9
                                d3_next = d3_reg + 1;//INCREASE MINUTES
                            else 
                                d3_next = 4'b0;//SET TO 0 WHEN OVER 9
                        end
                  end
            end
   end

   // output logic
   assign d0 = d0_reg;
   assign d1 = d1_reg;
   assign d2 = d2_reg;
   //***PART 1 - ADDED d3 = d3_reg TO ASSIGN THE UPDATED VALUE TO THE MINUTE DISPLAY REGISTER***
   assign d3 = d3_reg;

endmodule