module driver_mod_48 (
    input clk,
    input [15:0] port_a_48,
    input [15:0] port_b_48,
    output reg [15:0] bus_out_48
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_48 <= port_a_48;
    end

    always @(negedge clk) begin
        bus_out_48 <= port_b_48;
    end
endmodule
