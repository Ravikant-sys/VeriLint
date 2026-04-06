module latch_mod_17 (
    input [3:0] sel_17,
    input en,
    output reg dec_17
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_17 > 0) begin
            dec_17 = 1'b1;
        end else begin
            dec_17 = 1'b0;
        end
    end
endmodule
