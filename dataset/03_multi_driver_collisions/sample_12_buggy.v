module driver_mod_12 (
    input clk,
    input [31:0] port_a_12,
    input [31:0] port_b_12,
    output reg [31:0] bus_out_12
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_12 <= port_a_12;
    end

    always @(negedge clk) begin
        bus_out_12 <= port_b_12;
    end
endmodule
