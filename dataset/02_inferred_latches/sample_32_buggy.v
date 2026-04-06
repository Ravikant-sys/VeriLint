module latch_mod_32 (
    input [2:0] sel_32,
    input en,
    output reg dec_32
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_32 > 0) begin
            dec_32 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
