package definitions_pkg;
  parameter IMAGE_WIDTH = 512;

  const logic [8:0] gaussian_kernel_3 [0:8] =  '{
    8'h1, 8'h2, 8'h1, 
    8'h2, 8'h4, 8'h2, 
    8'h1, 8'h2, 8'h1 
  };

  // 5x5 kernel not used atp
  const logic [8:0] gaussian_kernel_5 [0:24] = '{
    8'h1, 8'h4, 8'h7, 8'h4, 8'h1, 
    8'h4, 8'h16, 8'h26, 8'h16, 8'h4, 
    8'h7, 8'h26, 8'h41, 8'h26, 8'h7,
    8'h4, 8'h16, 8'h26, 8'h16, 8'h4, 
    8'h1, 8'h4, 8'h7, 8'h4, 8'h1 
  };

endpackage: definitions_pkg