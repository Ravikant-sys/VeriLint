module driver_mod_20 (
    input clk,
    input [15:0] port_a_20,
    input [15:0] port_b_20,
    output reg [15:0] bus_out_20
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_20 <= port_a_20;
    end

    always @(negedge clk) begin
        bus_out_20 <= port_b_20;
    end
endmodule
