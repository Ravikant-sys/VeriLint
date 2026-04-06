module driver_mod_23 (
    input clk,
    input [15:0] port_a_23,
    input [15:0] port_b_23,
    output reg [15:0] bus_out_23
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_23 <= port_a_23;
    end

    always @(negedge clk) begin
        bus_out_23 <= port_b_23;
    end
endmodule
