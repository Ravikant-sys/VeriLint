module driver_mod_5 (
    input clk,
    input [31:0] port_a_5,
    input [31:0] port_b_5,
    output reg [31:0] bus_out_5
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_5 <= port_a_5;
        else 
            bus_out_5 <= port_b_5;
    end
endmodule
