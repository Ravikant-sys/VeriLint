module driver_mod_46 (
    input clk,
    input [7:0] port_a_46,
    input [7:0] port_b_46,
    output reg [7:0] bus_out_46
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_46 <= port_a_46;
    end

    always @(negedge clk) begin
        bus_out_46 <= port_b_46;
    end
endmodule
