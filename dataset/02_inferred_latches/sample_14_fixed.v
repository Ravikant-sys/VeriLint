module latch_mod_14 (
    input [2:0] sel_14,
    input en,
    output reg dec_14
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_14 > 0) begin
            dec_14 = 1'b1;
        end else begin
            dec_14 = 1'b0;
        end
    end
endmodule
