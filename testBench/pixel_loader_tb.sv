`timescale 1ps/1ps

module pixel_loader_tb;

  // Declare the signals for the pixel_loader module
  logic         clk;
  logic         rstN;
  logic [7:0]   pixel_in;
  logic         pixel_in_valid;
  logic [71:0]  pixel_data_out;
  logic         pixel_data_out_valid;

  // Instantiate the pixel_loader module
  pixel_loader pl1(
    .clk(clk),
    .rstN(rstN),
    .pixel_in(pixel_in),
    .pixel_in_valid(pixel_in_valid),
    .pixel_data_out(pixel_data_out),
    .pixel_data_out_valid(pixel_data_out_valid)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Reset and drive the pixel input with random values
  initial begin
    clk = 0;
    rstN = 0;
    pixel_in = 8'b0;
    pixel_in_valid = 0;

    // Apply reset for a few clock cycles
    #20;
    rstN = 1;

    // Drive random pixel values for 1024 pixels (for example, in 512x512 image)
    for (int i = 0; i < 262144; i++) begin
      pixel_in = $random;  // Generate a random 8-bit value
      pixel_in_valid = 1;  // Set the input valid
      #10;  // Wait for one clock cycle
    end

    // End simulation after driving pixel values
    $finish;
  end

endmodule: pixel_loader_tb
