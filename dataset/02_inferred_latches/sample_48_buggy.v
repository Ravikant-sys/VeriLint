module latch_mod_48 (
    input [2:0] sel_48,
    input en,
    output reg dec_48
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_48 > 0) begin
            dec_48 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
