
module gr2
   //I/O
   (
    input  wire[1:0] a, b,
    output wire agrb
   );

   //declaring signals
   wire p0, p1, p2;

   //sum of product expression
   assign agrb = p0 | p1 | p2;
   //products
   assign p0 = a[1] & ~b[1];
   assign p1 = a[0] & ~b[1] & ~b[0];
   assign p2 = a[1] & a[0] & ~b[0];

endmodule