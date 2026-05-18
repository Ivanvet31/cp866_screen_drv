//
// Top-level module for the dynamic text display driver.
// Instantiates and connects all sub-modules.
// Provides an external interface to write to the Video RAM.
//
module cp866_screen_drv
  (
   // System Inputs
   input        rst_n,
   input        clk,          // Main system clock (50 MHz)

   // LCD Outputs
   output       lcd_clk,
   output       lcd_en,
   output [5:0] lcd_r,
   output [5:0] lcd_b,
   output [5:0] lcd_g,

   // VRAM Write Interface
   input        vram_wr_en,   // Write Enable for VRAM
   input [11:0] vram_wr_addr, // Write Address for VRAM
   input [ 7:0] vram_wr_data  // Write Data for VRAM
   );

   // Internal Wires for connecting sub-modules
   wire [11:0] char_addr_wire;
   wire [ 7:0] ascii_code_wire;
   wire [ 3:0] local_x_wire;
   wire [ 3:0] local_y_wire;
   wire        pixel_on_wire;

   assign lcd_clk = clk;

   // Module Instantiation

   // // PLL to generate the pixel clock (38 MHz)
   // Gowin_PLL Gowin_PLL_inst (
   //     .clkout0(lcd_clk),
   //     .clkin  (clk)
   // );

   // The main Screen Controller
   screen_controller controller_inst
     (
      .lcd_clk          (lcd_clk),
      .rst_n            (rst_n),
      .pixel_on         (pixel_on_wire), // Receives pixel status from font_rom

      .lcd_en           (lcd_en),
      .lcd_r            (lcd_r),
      .lcd_b            (lcd_b),
      .lcd_g            (lcd_g),

      .char_addr        (char_addr_wire),  // Outputs address for text_buffer
      .local_x          (local_x_wire),    // Outputs local X for font_rom
      .local_y          (local_y_wire)     // Outputs local Y for font_rom
      );

   // The Text Buffer (Video RAM)
   text_buffer text_buffer_inst
     (
      .clk              (clk),

      // Read Port      (connected to screen controller)
      .read_addr        (char_addr_wire),
      .ascii_code       (ascii_code_wire),

      // Write Port     (connected to the top-level interface)
      .wr_en            (vram_wr_en),
      .write_addr       (vram_wr_addr),
      .write_data       (vram_wr_data)
      );

   // The Font ROM (Character Pixel Decoder)
   font_rom font_rom_inst
     (
      .ascii_code       (ascii_code_wire),  // Receives character code from text_buffer
      .local_x          (local_x_wire),     // Receives local X from controller
      .local_y          (local_y_wire),     // Receives local Y from controller
      .pixel_on         (pixel_on_wire)     // Outputs pixel status to controller
      );

endmodule
