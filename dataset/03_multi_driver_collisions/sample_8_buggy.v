module driver_mod_8 (
    input clk,
    input [15:0] port_a_8,
    input [15:0] port_b_8,
    output reg [15:0] bus_out_8
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_8 <= port_a_8;
    end

    always @(negedge clk) begin
        bus_out_8 <= port_b_8;
    end
endmodule
