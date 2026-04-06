module latch_mod_0 (
    input [2:0] sel_0,
    input en,
    output reg dec_0
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_0 > 0) begin
            dec_0 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
