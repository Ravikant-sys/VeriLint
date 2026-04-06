module driver_mod_30 (
    input clk,
    input [31:0] port_a_30,
    input [31:0] port_b_30,
    output reg [31:0] bus_out_30
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_30 <= port_a_30;
        else 
            bus_out_30 <= port_b_30;
    end
endmodule
