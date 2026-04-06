module driver_mod_35 (
    input clk,
    input [15:0] port_a_35,
    input [15:0] port_b_35,
    output reg [15:0] bus_out_35
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_35 <= port_a_35;
    end

    always @(negedge clk) begin
        bus_out_35 <= port_b_35;
    end
endmodule
