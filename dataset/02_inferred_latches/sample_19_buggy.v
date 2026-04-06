module latch_mod_19 (
    input [4:0] sel_19,
    input en,
    output reg dec_19
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_19 > 0) begin
            dec_19 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
