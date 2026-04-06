module driver_mod_21 (
    input clk,
    input [31:0] port_a_21,
    input [31:0] port_b_21,
    output reg [31:0] bus_out_21
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_21 <= port_a_21;
        else 
            bus_out_21 <= port_b_21;
    end
endmodule
