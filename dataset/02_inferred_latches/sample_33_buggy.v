module latch_mod_33 (
    input [4:0] sel_33,
    input en,
    output reg dec_33
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_33 > 0) begin
            dec_33 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
