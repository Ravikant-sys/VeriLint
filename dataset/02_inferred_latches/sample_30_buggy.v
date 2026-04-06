module latch_mod_30 (
    input [3:0] sel_30,
    input en,
    output reg dec_30
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_30 > 0) begin
            dec_30 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
