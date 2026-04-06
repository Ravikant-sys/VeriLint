module driver_mod_11 (
    input clk,
    input [15:0] port_a_11,
    input [15:0] port_b_11,
    output reg [15:0] bus_out_11
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_11 <= port_a_11;
    end

    always @(negedge clk) begin
        bus_out_11 <= port_b_11;
    end
endmodule
