module latch_mod_24 (
    input [3:0] sel_24,
    input en,
    output reg dec_24
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_24 > 0) begin
            dec_24 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
