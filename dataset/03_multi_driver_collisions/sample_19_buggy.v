module driver_mod_19 (
    input clk,
    input [31:0] port_a_19,
    input [31:0] port_b_19,
    output reg [31:0] bus_out_19
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_19 <= port_a_19;
    end

    always @(negedge clk) begin
        bus_out_19 <= port_b_19;
    end
endmodule
