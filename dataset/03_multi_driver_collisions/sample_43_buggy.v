module driver_mod_43 (
    input clk,
    input [31:0] port_a_43,
    input [31:0] port_b_43,
    output reg [31:0] bus_out_43
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_43 <= port_a_43;
    end

    always @(negedge clk) begin
        bus_out_43 <= port_b_43;
    end
endmodule
