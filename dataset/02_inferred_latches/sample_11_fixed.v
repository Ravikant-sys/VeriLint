module latch_mod_11 (
    input [2:0] sel_11,
    input en,
    output reg dec_11
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_11 > 0) begin
            dec_11 = 1'b1;
        end else begin
            dec_11 = 1'b0;
        end
    end
endmodule
