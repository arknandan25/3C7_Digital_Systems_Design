module Top
    // I/O
    (
        input wire clk, reset,
        output wire [3:0] an,
        output wire [7:0] sseg,
        output wire max_t,
        output wire [13:0] lfsr_bitstream
    );
    
    wire [3:0] d3, d2, d1, d0;
    wire lfsr_clk;
    //wire lfsr_bit;
    wire seq_det; 
    //INSTANTIATING THE CLOCK DIVIDER MODULE
    CLOCK Clock_Gen (.cclk(clk), .clkscale(5000000), .clk_out(lfsr_clk));
    //INSTANTIATING THE LFSR
    LFSR_14 Gen_LFSR_Bitstream (.clk(lfsr_clk), .reset(reset), .lfsr_out(lfsr_bitstream), .max_tick_reg(max_t));
    //INSTANTIATING THE SEQUENCE DETECTING FSM
    Seq_Det_FSM Detect_Seq_00011 (.clk(lfsr_clk), .reset(reset), .seq_next(lfsr_bitstream[13]), .seq_det(seq_det));
    //INSTANTIATING THE 7 SEGMENT DISPLAY MULTIPLEXER
    disp_hex_mux Display_Count (.clk(clk), .reset(1'b0), .hex3(d3), .hex2(d2), .hex1(d1), .hex0(d0), .dp_in(4'b1111), .an(an), .sseg(sseg));
    //INSTANTIATING THE SEQUENCE COUNTER
    Seq_Count Count_Seq_00011 (.clk(lfsr_clk), .reset(reset), .max_tick(max_t), .in(seq_det), .d3(d3), .d2(d2), .d1(d1), .d0(d0));
    
    //ENABLING ALL 4 OF THE DIGITS ON THE 7 SEGMENT DISPLAY
    assign an = an | 4'b0000;
endmodule