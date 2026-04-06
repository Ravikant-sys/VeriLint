module latch_mod_22 (
    input [4:0] sel_22,
    input en,
    output reg dec_22
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_22 > 0) begin
            dec_22 = 1'b1;
        end else begin
            dec_22 = 1'b0;
        end
    end
endmodule
