module latch_mod_39 (
    input [3:0] sel_39,
    input en,
    output reg dec_39
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_39 > 0) begin
            dec_39 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
