module latch_mod_43 (
    input [1:0] sel_43,
    input en,
    output reg dec_43
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && sel_43 > 0) begin
            dec_43 = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
