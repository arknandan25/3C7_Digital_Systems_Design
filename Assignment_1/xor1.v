// THIS MODULE PERFORMS A BITWISE XOR ON TWO ONE-BIT INPUTS
module xor1   
    // I/O:
    (
     input wire i0, i1,
     output wire xor_1
    );
    
    // logic body
    // bitwise xor of two input bits
    assign xor_1 = i0 ^ i1;
    
endmodule
