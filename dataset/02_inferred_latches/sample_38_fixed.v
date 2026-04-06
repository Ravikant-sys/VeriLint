module latch_mod_38 (
    input [3:0] sel_38,
    input en,
    output reg dec_38
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_38 > 0) begin
            dec_38 = 1'b1;
        end else begin
            dec_38 = 1'b0;
        end
    end
endmodule
