module latch_mod_20 (
    input [3:0] sel_20,
    input en,
    output reg dec_20
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_20 > 0) begin
            dec_20 = 1'b1;
        end else begin
            dec_20 = 1'b0;
        end
    end
endmodule
