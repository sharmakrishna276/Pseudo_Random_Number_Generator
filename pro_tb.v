`timescale 1ns / 1ps

module testbench();

  // Inputs
  reg clk;
  reg reset;
  
  // Outputs
  wire [7:0] number_o;
  
  pro UUT(
      .clk(clk),
      .reset(reset),
      .number_o(number_o)
  );
  
  // Clock generation
  always #1 clk = ~clk; // Toggle clock every 1 time unit

  // Initial reset assertion
  initial begin
    clk = 0;
    reset = 0;
    #5 reset = 1;
  end

  integer f;
  // Monitor and write to file
  initial begin
    f = $fopen("out.txt", "w");
    repeat (100000) begin
      @(posedge clk or negedge reset); 
      $fwrite(f, "%d\n", number_o);
    end

    $fclose(f);
    $finish;
  end
  
endmodule 