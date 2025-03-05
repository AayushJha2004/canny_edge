module line_buffer
  import definitions_pkg::*;
(
  input   logic clk, 
  input   logic rstN, 
  input   logic [7:0] i_data, 
  input   logic i_data_valid,
  input   logic rd_data, 
  output  logic [23:0] o_data
);

  logic [7:0] line [0:IMAGE_WIDTH-1];
  logic [$clog2(IMAGE_WIDTH)-1:0] rdPtr, wrPtr;

  always @(posedge clk, negedge rstN) begin
    if (!rstN) begin
      wrPtr <= '0;
    end
    else if (i_data_valid) begin
      line[wrPtr] <= i_data;
      wrPtr <= wrPtr + 1; 
    end
  end

  always @(posedge clk, negedge rstN) begin
    if (!rstN) begin
      rdPtr <= '0;
    end
    else if (rd_data) begin
      rdPtr <= rdPtr + 1;
    end
  end

  assign o_data = {line[rdPtr], line[rdPtr + 1], line[rdPtr + 2]};

endmodule: line_buffer