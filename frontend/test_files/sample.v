module example (
    input wire clk,
    input wire rst_active_low, // R003 Naming Convention Warning (missing _n)
    output reg [7:0] q
);

always @(posedge clk or negedge rst_active_low) begin
    if (!rst_active_low)
        q = 8'd0;    // Bug: mixed assignment (= instead of <=)
    else
        q <= q + 1;
end

always @(*) begin
    if (enable) begin
        data_out = data_in;
    end
end

endmodule
