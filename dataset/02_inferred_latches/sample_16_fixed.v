module latch_mod_16 (
    input [2:0] sel_16,
    input en,
    output reg dec_16
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_16 > 0) begin
            dec_16 = 1'b1;
        end else begin
            dec_16 = 1'b0;
        end
    end
endmodule
