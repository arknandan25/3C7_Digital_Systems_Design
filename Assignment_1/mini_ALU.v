// THIS MODULE IMPLEMENTS THE ALU BY CALLING OTHER MODULES FOR EACH FUNCTION
module mini_alu
    // I/O:
    (
    // A AND B = 6-BIT ALU INPUTS
    input wire [5:0] a, b,
    // fxn = 3-BIT ALU CONTROL INPUT
    input wire [2:0] fxn,
    // X = 6-BIT ALU OUTPUT
    output reg [5:0] x
    );
    
    //TEMPORARY 6-BIT WIRES FOR THE OUTPUT OF EACH MODULE
    wire [5:0] notA, notB, AxorB, AplusB, AminusB;
    //TEMPORARY 1-BIT VARIABLE FOR THE 1-BIT OUTPUT OF THE >= CIRCUIT
    wire AgreqB;
    
    //CALLING EACH MODULE IN THE ALU
    // X = -A
    not6 NOT_A (.x(a), .invx(notA));
    // X = -B
    not6 NOT_B (.x(b), .invx(notB));
    // X = A >= B
    gr6 A_GR_EQ_B (.i0(a), .i1(b), .two_comp_greq(AgreqB));
    // X = A ^ B
    xor6 A_XOR_B (.x(a), .y(b), .xor_6(AxorB));
    // X = A + B
    Ripple_Adder A_PLUS_B (.in_x(a), .y(b), .sel(0), .sum(AplusB));
    // X = A - B
    Ripple_Adder A_MINUS_B (.in_x(a), .y(b), .sel(1), .sum(AminusB));
    
    // CONDITIONAL LOGIC FOR fxn CONTROL
    always @(*)
    begin
        // X = A
        if (fxn == 3'b000)
            {x} = {a};
        // X = B
        if (fxn == 3'b001)
            {x} = {b};
        // X = -A
        if (fxn == 3'b010)
            {x} = {notA};
        // X = -B
        if (fxn == 3'b011)
            {x} = {notB};
        // X = A >= B
        if (fxn == 3'b100)
        //STORE THE 1-BIT RESULT OF THE >= CIRCUIT IN THE LSB OF THE 6-BIT OUTPUT X AND SET ALL OTHER BITS TO 0
            {x[5:1], x[0]} = {0, AgreqB};
        // X = A ^ B
        if (fxn == 3'b101)
            {x} = {AxorB};
        // X = A + B
        if (fxn == 3'b110)
            {x} = {AplusB};
        // X = A - B
        if (fxn == 3'b111)
            {x} = {AminusB};
    end
    
endmodule