module latch_mod_29 (
    input [1:0] sel_29,
    input en,
    output reg dec_29
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_29 > 0) begin
            dec_29 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
