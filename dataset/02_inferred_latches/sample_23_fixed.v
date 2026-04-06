module latch_mod_23 (
    input [4:0] sel_23,
    input en,
    output reg dec_23
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_23 > 0) begin
            dec_23 = 1'b1;
        end else begin
            dec_23 = 1'b0;
        end
    end
endmodule
