module driver_mod_27 (
    input clk,
    input [7:0] port_a_27,
    input [7:0] port_b_27,
    output reg [7:0] bus_out_27
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_27 <= port_a_27;
    end

    always @(negedge clk) begin
        bus_out_27 <= port_b_27;
    end
endmodule
