module latch_mod_38 (
    input [3:0] sel_38,
    input en,
    output reg dec_38
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_38 > 0) begin
            dec_38 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
