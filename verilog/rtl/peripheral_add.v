module peripheral_add (
    input      clk,
    input      rst,
    input      c_sel,
    input      in_xor,
    input      in_and,
    input      cin, 
    output     cout,
    output     sum
);
    reg        carry_reg;
    wire       carry_next;
    reg        xor_reg;

    assign carry_next = in_and | carry_reg & xor_reg;
    assign sum = xor_reg ^ carry_reg;
    assign cout = carry_next;

    always @(posedge clk) begin
        if (rst) begin
            xor_reg <= 0;
            carry_reg <= 0;
        end
        else begin
            if (c_sel) begin
                carry_reg <= carry_next; 
            end
            else begin
                carry_reg <= cin;
            end
            xor_reg <= in_xor;
        end
    end
endmodule