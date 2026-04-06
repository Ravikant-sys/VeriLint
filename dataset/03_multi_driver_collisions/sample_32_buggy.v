module driver_mod_32 (
    input clk,
    input [31:0] port_a_32,
    input [31:0] port_b_32,
    output reg [31:0] bus_out_32
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_32 <= port_a_32;
    end

    always @(negedge clk) begin
        bus_out_32 <= port_b_32;
    end
endmodule
