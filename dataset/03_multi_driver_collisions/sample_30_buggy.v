module driver_mod_30 (
    input clk,
    input [31:0] port_a_30,
    input [31:0] port_b_30,
    output reg [31:0] bus_out_30
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_30 <= port_a_30;
    end

    always @(negedge clk) begin
        bus_out_30 <= port_b_30;
    end
endmodule
