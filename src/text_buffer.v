//
// Dynamic Video RAM / Text Buffer
// Stores the character map for the screen and allows external write access.
// This module is inferred as a Dual-Port BRAM by the synthesis tool.
//
module text_buffer
  (
   input wire        clk,

   // Read Port (for the screen controller)
   input wire [11:0] read_addr,
   output reg [ 7:0] ascii_code,

   // Write Port (for external modules like a CPU or UART)
   input wire        wr_en,      // Write enable signal
   input wire [11:0] write_addr, // Address to write to
   input wire [ 7:0] write_data  // Character code to write
   );

   localparam MEM_DEPTH = 3200;  // 80 columns * 40 rows
   localparam COLS = 80;

   // Memory array to hold the screen characters
   reg [7:0]  screen_memory[0:MEM_DEPTH-1];
   integer    i;

   // Read Port Logic (Asynchronous read)
   // This part is for the screen controller, which needs data instantly on address change.
   always @(posedge clk) begin
      ascii_code <= screen_memory[read_addr];
   end

   // Write Port Logic (Synchronous write)
   // Writing is synchronized to a clock to ensure data integrity.
   always @(posedge clk) begin
      if (wr_en) begin
         screen_memory[write_addr] <= write_data;
      end
   end

endmodule
