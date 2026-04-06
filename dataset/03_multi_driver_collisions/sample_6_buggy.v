module driver_mod_6 (
    input clk,
    input [7:0] port_a_6,
    input [7:0] port_b_6,
    output reg [7:0] bus_out_6
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_6 <= port_a_6;
    end

    always @(negedge clk) begin
        bus_out_6 <= port_b_6;
    end
endmodule
