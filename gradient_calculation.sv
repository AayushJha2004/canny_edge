`timescale 1ps/1ps

module gradient_calculation
  import definitions_pkg::*;
  (
    input   logic         clk,
    input   logic         rstN,
    input   logic [71:0]  gradient_data_in,
    input   logic         gradient_data_in_valid,
    output  logic [10:0]   gradient_magnitude,
    // output  logic [7:0]   gradient_direction,
    output  logic         gradient_out_valid,
    // temp signals for intermediate edge detection output 
    output  logic [7:0]   pixel_out,
    output  logic         pixel_out_valid        
  );

  logic signed  [10:0] mult_data_x [8:0];
  logic signed  [10:0] mult_data_y [8:0];
  logic signed  [10:0] sum_data_x, sum_data_x_next;
  logic signed  [10:0] sum_data_y, sum_data_y_next;
  logic         [21:0] square_data_x, square_data_y;
  logic square_data_valid;
  logic mult_data_valid, sum_data_valid;
  // logic         [21:0] sqrt_ip;
  // logic         [10:0] sqrt_op;

  // pipeline for multiplication logic
  always @(posedge clk) begin
    if (!rstN) begin
      mult_data_x <= '{default: 16'b0};
      mult_data_y <= '{default: 16'b0};
      mult_data_valid <= 1'b0;
    end
    else begin
      for (int i=0; i < 9; i++) begin
        if (^(gradient_data_in[i*8+:8]) === 1'bX)
          mult_data_x[i] <= $signed(sobel_x[i]) * 9'sb0_0000_0000;
        else
          mult_data_y[i] <= $signed(sobel_y[i]) * $signed({1'b0, gradient_data_in[i*8+:8]});
      end
      mult_data_valid <= gradient_data_in_valid;
    end
  end

  // pipeline and combo logic for sum
  always @(posedge clk) begin
    if (!rstN) begin
      sum_data_x <= '0;
      sum_data_y <= '0;
      sum_data_valid <= 1'b0;
    end
    else begin
      sum_data_x <= sum_data_x_next;
      sum_data_y <= sum_data_y_next;
      sum_data_valid <= mult_data_valid;
    end
  end

  always_comb begin
    sum_data_x_next = '0;
    sum_data_y_next = '0;
    for (int i = 0; i < 9; i++)begin
      sum_data_x_next = sum_data_x_next + mult_data_x[i];
      sum_data_y_next = sum_data_y_next + mult_data_y[i];
    end
  end

  // pipeling logic for finding the square of the sum_data_x and sum_data_y
  always @(posedge clk) begin
    if (!rstN) begin
      square_data_x <= '0;
      square_data_y <= '0;
      square_data_valid <= 1'b0;
    end
    else begin
      square_data_x <= $signed(sum_data_x) * $signed(sum_data_x);
      square_data_y <= $signed(sum_data_y) * $signed(sum_data_y);
      square_data_valid <= sum_data_valid;
    end
  end

  // assign sqrt_ip = square_data_x + square_data_y;

  // sqrt_22b sl(
  //   .value(sqrt_ip),
  //   .sqrt(sqrt_op)
  // );

  // pipeline logic for gradient magnitude
  always @(posedge clk) begin
    if (!rstN) begin
      gradient_magnitude <= '0;
      gradient_out_valid <= 1'b0;
    end
    else begin
      gradient_magnitude <= square_data_x + square_data_y;
      // gradient_magnitude <= sqrt_op;
      gradient_out_valid <= square_data_valid;
    end
  end

  // combo logic for intermediate pixel out for edge tracking
  always_comb begin
    if (gradient_magnitude > 300)  pixel_out = 8'hff;
    else                            pixel_out = 8'h00;
  end

endmodule: gradient_calculation