module latch_mod_30 (
    input [3:0] sel_30,
    input en,
    output reg dec_30
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_30 > 0) begin
            dec_30 = 1'b1;
        end else begin
            dec_30 = 1'b0;
        end
    end
endmodule
