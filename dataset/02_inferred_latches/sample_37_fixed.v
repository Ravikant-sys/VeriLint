module latch_mod_37 (
    input [3:0] sel_37,
    input en,
    output reg dec_37
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_37 > 0) begin
            dec_37 = 1'b1;
        end else begin
            dec_37 = 1'b0;
        end
    end
endmodule
