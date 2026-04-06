module latch_mod_18 (
    input [2:0] sel_18,
    input en,
    output reg dec_18
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_18 > 0) begin
            dec_18 = 1'b1;
        end else begin
            dec_18 = 1'b0;
        end
    end
endmodule
