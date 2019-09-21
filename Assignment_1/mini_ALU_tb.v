//SETTING TIMESCALE
`timescale 1 ns/10 ps

module mini_alu_tb;
    reg [5:0] in_A, in_B;
    reg [2:0] sel_fxn;
    wire [5:0] out_X;
        
    mini_alu uut (.a(in_A), .b(in_B), .fxn(sel_fxn), .x(out_X));
    
    //TEST VECTORS
    initial
    begin
    
    //VECTOR 1
    sel_fxn = 3'b101;
    in_A = 6'b111111;
    in_B = 6'b000000;
    # 100;
    //VECTOR 2
    sel_fxn = 3'b101;
    in_A = 6'b111111;
    in_B = 6'b111111;
    # 100;
    //VECTOR 3
    sel_fxn = 3'b101;
    in_A = 6'b111111;
    in_B = 6'b010010;
    # 100;
    //VECTOR 4
    sel_fxn = 3'b101;
    in_A = 6'b110011;
    in_B = 6'b111111;
    # 100;
    //VECTOR 5
    sel_fxn = 3'b101;
    in_A = 6'b101011;
    in_B = 6'b011001;
    # 100;
    
          //STOP
          $stop;
       end
    
endmodule
