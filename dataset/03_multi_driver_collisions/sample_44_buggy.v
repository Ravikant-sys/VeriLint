module driver_mod_44 (
    input clk,
    input [15:0] port_a_44,
    input [15:0] port_b_44,
    output reg [15:0] bus_out_44
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_44 <= port_a_44;
    end

    always @(negedge clk) begin
        bus_out_44 <= port_b_44;
    end
endmodule
