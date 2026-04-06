module driver_mod_13 (
    input clk,
    input [15:0] port_a_13,
    input [15:0] port_b_13,
    output reg [15:0] bus_out_13
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_13 <= port_a_13;
    end

    always @(negedge clk) begin
        bus_out_13 <= port_b_13;
    end
endmodule
