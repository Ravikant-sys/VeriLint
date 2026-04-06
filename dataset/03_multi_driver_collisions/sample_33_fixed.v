module driver_mod_33 (
    input clk,
    input [31:0] port_a_33,
    input [31:0] port_b_33,
    output reg [31:0] bus_out_33
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_33 <= port_a_33;
        else 
            bus_out_33 <= port_b_33;
    end
endmodule
