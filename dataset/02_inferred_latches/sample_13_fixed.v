module latch_mod_13 (
    input [2:0] sel_13,
    input en,
    output reg dec_13
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_13 > 0) begin
            dec_13 = 1'b1;
        end else begin
            dec_13 = 1'b0;
        end
    end
endmodule
