module driver_mod_21 (
    input clk,
    input [31:0] port_a_21,
    input [31:0] port_b_21,
    output reg [31:0] bus_out_21
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_21 <= port_a_21;
    end

    always @(negedge clk) begin
        bus_out_21 <= port_b_21;
    end
endmodule
