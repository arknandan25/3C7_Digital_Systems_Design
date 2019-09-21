// THIS MODULE INVERTS THE 1-BIT INPUT

module not1
    // I/0:
    (
    input wire i,
    output wire noti
    );
      
    //logic body
    assign noti = ~i;
    
endmodule