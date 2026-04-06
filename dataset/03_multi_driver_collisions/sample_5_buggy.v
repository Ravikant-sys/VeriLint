module driver_mod_5 (
    input clk,
    input [31:0] port_a_5,
    input [31:0] port_b_5,
    output reg [31:0] bus_out_5
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_5 <= port_a_5;
    end

    always @(negedge clk) begin
        bus_out_5 <= port_b_5;
    end
endmodule
