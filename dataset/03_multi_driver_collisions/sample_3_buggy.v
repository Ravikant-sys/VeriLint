module driver_mod_3 (
    input clk,
    input [15:0] port_a_3,
    input [15:0] port_b_3,
    output reg [15:0] bus_out_3
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_3 <= port_a_3;
    end

    always @(negedge clk) begin
        bus_out_3 <= port_b_3;
    end
endmodule
