module driver_mod_1 (
    input clk,
    input [15:0] port_a_1,
    input [15:0] port_b_1,
    output reg [15:0] bus_out_1
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_1 <= port_a_1;
    end

    always @(negedge clk) begin
        bus_out_1 <= port_b_1;
    end
endmodule
