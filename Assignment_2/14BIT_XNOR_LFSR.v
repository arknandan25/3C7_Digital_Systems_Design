//MODULE TO IMPLEMENT A LINEAR FEEDBACK SHIFT REGISTER
//USING 14 BITS AND XNOR FEEDBACK
module LFSR_14
    (
    //I/O:
    input wire clk, reset, //CLOCK AND RESET SIGNALS FROM TESTBENCH
    output wire max_tick_reg, //1-BIT OUTPUT SIGNAL AND MAX TICK
    output wire [13:0] lfsr_out //OUTPUT BITSTREAM OF THE LFSR
    );
    
    //SIGNAL DECLARATIONS
    reg [13:0] lfsr_reg; //SHIFT REGISTER STORAGE
    reg [13:0] lfsr_next; //NEXT VALUE TO BE STORED
    reg lfsr_tap, temp; //TO HOLD RESULT OF FEEDBACK, TEMP VALUE FOR MAX TICK
    localparam seed = 14'b11110000111100; //SEED VALUE
    
    //----------LFSR MODULE BODY----------
    //REGISTER LOGIC
    //ASYNCHRONOUS, POSITIVE EDGE TRIGGERED
    always @(posedge clk, posedge reset)
        if (reset)
        begin
            lfsr_reg <= seed; //SET TO SEED VALUE WHEN RESET IS HIGH
        end
        else
            lfsr_reg <= lfsr_next; //OTHERWISE SET TO NEXT VALUE AS CALCULATED BELOW

    //FEEDBACK AND SHIFT LOGIC
    always @*
    begin
        //GENERATE THE FEEDBACK ON TAPS 0, 2, 4, 13
        lfsr_tap = lfsr_reg[0] ^~ lfsr_reg[2] ^~ lfsr_reg[4] ^~ lfsr_reg[13];
        
        //FEEDBACK RESULT GOES INTO POSITION 0, OTHER BITS SHIFT UP BY 1
        lfsr_next = {lfsr_reg[12:0],lfsr_tap};
        
        //DETECT MAX TICK
        if(lfsr_reg == seed)
            temp = 1'b1;//MAX TICK IS HIGH IF SEED VALUE IS STORED
        else
            temp = 1'b0;//OTHERWISE MAX TICK IS LOW
    end 
    
    //LFSR BITSTREAM OUTPUT
    assign lfsr_out = lfsr_reg;
    //SET MAX TICK
    assign max_tick_reg = temp;
    
endmodule