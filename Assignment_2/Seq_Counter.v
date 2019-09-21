//MODULE TO COUNT THE NUMBER OF TIMES THE SEQUENCE '00011' IS DETECTED BY THE FSM
module Seq_Count
    (
    input wire clk, reset, in, max_tick, //INPUT 'in' FROM THE FSM IS 1 WHEN THE SEQUENCE HAS BEEN FOUND AND 0 OTHERWISE
    //output reg [9:0] count //THE 10-BIT OUTPUT REGISTER FOR THE COUNTER
    output wire [3:0] d3, d2, d1, d0
    );

    //reg [23:0] count_reg;
    //wire [23:0] next_count;
    reg [3:0] d3_reg, d2_reg, d1_reg, d0_reg;
    reg [3:0] d3_next, d2_next, d1_next, d0_next;
    
   always @(posedge clk)
    begin
       //count_reg <= next_count;
       d3_reg <= d3_next;
       d2_reg <= d2_next;
       d1_reg <= d1_next;
       d0_reg <= d0_next;
    end
    
   always @*
    begin
       d0_next = d0_reg;
       d1_next = d1_reg;
       d2_next = d2_reg;
       d3_next = d3_reg;
       
       if (max_tick)
          begin
             d0_next = 4'b0;
             d1_next = 4'b0;
             d2_next = 4'b0;
             d3_next = 4'b0;
          end
          
       else if (in)
          if (d0_reg != 9)
             d0_next = d0_reg + 1;
          else
             begin
                d0_next = 4'b0;
                if (d1_reg != 9)
                   d1_next = d1_reg + 1;
                else
                   begin
                      d1_next = 4'b0;
                      if (d2_reg != 9)
                         d2_next = d2_reg + 1;
                      else
                         begin
                             d2_next = 4'b0;
                             if(d3_reg != 9)
                                 d3_next = d3_reg + 1;
                             else 
                                 d3_next = 4'b0;
                         end
                   end
             end
    end
 
    // output logic
    assign d0 = d0_reg;
    assign d1 = d1_reg;
    assign d2 = d2_reg;
    assign d3 = d3_reg;
    
endmodule