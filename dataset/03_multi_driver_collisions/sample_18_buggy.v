module driver_mod_18 (
    input clk,
    input [31:0] port_a_18,
    input [31:0] port_b_18,
    output reg [31:0] bus_out_18
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_18 <= port_a_18;
    end

    always @(negedge clk) begin
        bus_out_18 <= port_b_18;
    end
endmodule
