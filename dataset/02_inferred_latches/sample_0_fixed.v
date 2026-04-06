module latch_mod_0 (
    input [2:0] sel_0,
    input en,
    output reg dec_0
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_0 > 0) begin
            dec_0 = 1'b1;
        end else begin
            dec_0 = 1'b0;
        end
    end
endmodule
