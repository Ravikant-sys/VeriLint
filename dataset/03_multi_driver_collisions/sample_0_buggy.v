module driver_mod_0 (
    input clk,
    input [15:0] port_a_0,
    input [15:0] port_b_0,
    output reg [15:0] bus_out_0
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_0 <= port_a_0;
    end

    always @(negedge clk) begin
        bus_out_0 <= port_b_0;
    end
endmodule
