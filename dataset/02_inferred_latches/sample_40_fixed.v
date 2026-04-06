module latch_mod_40 (
    input [2:0] sel_40,
    input en,
    output reg dec_40
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_40 > 0) begin
            dec_40 = 1'b1;
        end else begin
            dec_40 = 1'b0;
        end
    end
endmodule
