module driver_mod_4 (
    input clk,
    input [15:0] port_a_4,
    input [15:0] port_b_4,
    output reg [15:0] bus_out_4
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_4 <= port_a_4;
    end

    always @(negedge clk) begin
        bus_out_4 <= port_b_4;
    end
endmodule
