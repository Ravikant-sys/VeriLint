module latch_mod_17 (
    input [3:0] sel_17,
    input en,
    output reg dec_17
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_17 > 0) begin
            dec_17 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
