module driver_mod_16 (
    input clk,
    input [31:0] port_a_16,
    input [31:0] port_b_16,
    output reg [31:0] bus_out_16
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_16 <= port_a_16;
    end

    always @(negedge clk) begin
        bus_out_16 <= port_b_16;
    end
endmodule
