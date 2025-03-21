module uart_tx  
  include definitions_pkg::*;
  (
    input logic clk,
    input logic rstN,
    input logic [7:0] data,
    input logic data_valid,
    
  );
endmodule: uart_tx