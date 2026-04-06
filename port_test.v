module math_unit (
    input [7:0] a,
    input [7:0] b,
    input clk,       // VIOLATION: clk is declared but never used in the logic.
    output [7:0] sum
);
    assign sum = a + b; 
    // If this is purely combinational, why is 'clk' in the port list?
endmodule
