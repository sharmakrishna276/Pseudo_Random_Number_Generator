module pro(clk, reset, number_o);
input clk;
input reset;
output reg[7:0] number_o;

reg[12:0] lfsr_reg;
reg[10:0] casr_reg;
reg[12:0] lfsr_var;
reg outbitlfsr;

always @(posedge clk or negedge reset)
begin
if (!reset)
     begin
        lfsr_reg = 13'b0100100100100;
     end
else
    begin
        lfsr_var = lfsr_reg;
        lfsr_var [12] = lfsr_var[11];
        outbitlfsr = lfsr_var[11];
        lfsr_var[11] = lfsr_var[10]^outbitlfsr;
        lfsr_var[10] = lfsr_var[9];
        lfsr_var[9] = lfsr_var[8]^outbitlfsr;
        lfsr_var[8] = lfsr_var[7]^lfsr_var[11];
        lfsr_var[7] = lfsr_var[6]^outbitlfsr;
        lfsr_var[6] = lfsr_var[5];
        lfsr_var[5] = lfsr_var[4];
        lfsr_var[4] = lfsr_var[3]^lfsr_var[6];
        lfsr_var[3] = lfsr_var[2]^outbitlfsr;
	outbitlfsr = lfsr_var[5];
        lfsr_var[2] = lfsr_var[1]^outbitlfsr;
        lfsr_var[1] = lfsr_var[0]^outbitlfsr;
      lfsr_var[0] = lfsr_var[12];
        lfsr_reg = lfsr_var;
    end
end

reg [10:0] casr_var, casr_out;
always @(posedge clk or negedge reset)
    begin
    if (!reset)
        casr_reg = 11'b00010101010;
    else
        begin
            casr_var = casr_reg;
            casr_out[10] = casr_var[9]^casr_var[0];
                 casr_out[9] = casr_var[8]^casr_out[10];
                 casr_out[8] = casr_var[7]^casr_out[9];
                 casr_out[7] = casr_var[6]^casr_out[8];
                 casr_out[6] = casr_var[5];
                 casr_out[5] = casr_var[4]^casr_out[6];
                 casr_out[4] = casr_var[3]^casr_out[5]^casr_var[4];
                 casr_out[3] = casr_var[2]^casr_out[4];
                 casr_out[2] = casr_var[1]^casr_out[3]^casr_var[6];
                 casr_out[1] = casr_var[0]^casr_out[2];
                 casr_out[0] = casr_var[1]^casr_out[10]^casr_var[8];
            casr_reg = casr_out;
        end
    end

always @(posedge clk or negedge reset)
    begin
         if (!reset)
            begin
                number_o = 8'b0;
            end
         else
            begin
                number_o = (lfsr_reg [7:0] ^ casr_reg [7:0]);
            end
    end
endmodule
