module driver_mod_29 (
    input clk,
    input [31:0] port_a_29,
    input [31:0] port_b_29,
    output reg [31:0] bus_out_29
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_29 <= port_a_29;
        else 
            bus_out_29 <= port_b_29;
    end
endmodule
