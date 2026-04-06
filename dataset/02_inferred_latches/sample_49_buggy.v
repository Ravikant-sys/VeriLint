module latch_mod_49 (
    input [1:0] sel_49,
    input en,
    output reg dec_49
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_49 > 0) begin
            dec_49 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
