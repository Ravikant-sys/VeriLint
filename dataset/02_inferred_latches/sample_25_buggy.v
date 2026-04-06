module latch_mod_25 (
    input [3:0] sel_25,
    input en,
    output reg dec_25
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_25 > 0) begin
            dec_25 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
