module driver_mod_9 (
    input clk,
    input [31:0] port_a_9,
    input [31:0] port_b_9,
    output reg [31:0] bus_out_9
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_9 <= port_a_9;
    end

    always @(negedge clk) begin
        bus_out_9 <= port_b_9;
    end
endmodule
