//
// Dynamic Video RAM / Text Buffer
// Stores the character map for the screen and allows external write access.
// This module is inferred as a Dual-Port BRAM by the synthesis tool.
//
module text_buffer (
    // Read Port (for the screen controller)
    input  wire [11:0] read_addr,
    output reg  [ 7:0] ascii_code,

    // Write Port (for external modules like a CPU or UART)
    input wire        wr_clk,      // Write clock
    input wire        wr_en,       // Write enable signal
    input wire [11:0] write_addr,  // Address to write to
    input wire [ 7:0] write_data   // Character code to write
);

  localparam MEM_DEPTH = 3200;  // 80 columns * 40 rows
  localparam COLS = 80;

  // Memory array to hold the screen characters
  reg [7:0] screen_memory[0:MEM_DEPTH-1];
  integer i;

  // Initialize memory content on synthesis. This defines the default screen content.
  initial begin
    // Fill the entire screen with space characters
    for (i = 0; i < 2000; i = i + 1) begin
      screen_memory[i] = 8'h20;  // Space char, part 1
    end
    for (i = 2000; i < MEM_DEPTH; i = i + 1) begin
      screen_memory[i] = 8'h20;  // Space char, part 2
    end

    // Write uppercase English alphabet (A-Z) on screen row 2
    for (i = 0; i < 26; i = i + 1) begin
      screen_memory[2*COLS+i] = 8'h41 + i;
    end

    // Write lowercase English alphabet (a-z) on screen row 4
    for (i = 0; i < 26; i = i + 1) begin
      screen_memory[4*COLS+i] = 8'h61 + i;
    end

    // Write digits (0-9) on screen row 6
    for (i = 0; i < 10; i = i + 1) begin
      screen_memory[6*COLS+i] = 8'h30 + i;
    end

    // Write uppercase Cyrillic alphabet (А-Я) on screen rows 10, 11
    // Using CP866 encoding
    for (i = 0; i < 16; i = i + 1) begin
      screen_memory[10*COLS+i] = 8'h80 + i;  // А-П
    end
    for (i = 0; i < 16; i = i + 1) begin
      screen_memory[11*COLS+i] = 8'hE0 + i;  // Р-Я
    end

    // Write lowercase Cyrillic alphabet (а-я) on screen rows 13, 14
    // Using CP866 encoding
    for (i = 0; i < 16; i = i + 1) begin
      screen_memory[13*COLS+i] = 8'hA0 + i;  // а-п
    end
    for (i = 0; i < 16; i = i + 1) begin
      screen_memory[14*COLS+i] = 8'hE0 + i;  // р-я
    end
  end

  // Read Port Logic (Asynchronous read)
  // This part is for the screen controller, which needs data instantly on address change.
  always @(*) begin
    ascii_code = screen_memory[read_addr];
  end

  // Write Port Logic (Synchronous write)
  // Writing is synchronized to a clock to ensure data integrity.
  always @(posedge wr_clk) begin
    if (wr_en) begin
      screen_memory[write_addr] <= write_data;
    end
  end

endmodule
