module latch_mod_15 (
    input [2:0] sel_15,
    input en,
    output reg dec_15
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_15 > 0) begin
            dec_15 = 1'b1;
        end else begin
            dec_15 = 1'b0;
        end
    end
endmodule
