//
// Screen Controller
// Generates master timing signals and addresses for memory modules.
// Takes the final pixel data and drives the RGB outputs.
//
module screen_controller
  (
   input              lcd_clk,
   input              rst_n,
   input              pixel_on,  // Input from font_rom: is this pixel ON?

   output             lcd_en,
   output reg [5:0]   lcd_r,
   output reg [5:0]   lcd_b,
   output reg [5:0]   lcd_g,

   output wire [11:0] char_addr, // Output address for text_buffer
   output wire [ 3:0] local_x,   // Output local X for font_rom
   output wire [ 3:0] local_y    // Output local Y for font_rom
   );

   // LCD Timing Parameters
   parameter H_Pixel_Valid = 16'd800, H_FrontPorch = 16'd210, H_BackPorch = 16'd182;
   parameter PixelForHS = H_Pixel_Valid + H_FrontPorch + H_BackPorch;
   parameter V_Pixel_Valid = 16'd480, V_FrontPorch = 16'd45, V_BackPorch = 16'd8;
   parameter PixelForVS = V_Pixel_Valid + V_FrontPorch + V_BackPorch;

   // Pixel Counters
   reg [15:0] H_PixelCount;
   reg [15:0] V_PixelCount;

   always @(posedge lcd_clk or negedge rst_n) begin
      if (!rst_n) begin
         V_PixelCount <= 0;
         H_PixelCount <= 0;
      end else begin
         if (H_PixelCount < PixelForHS - 1) begin
            H_PixelCount <= H_PixelCount + 1;
         end else begin
            H_PixelCount <= 0;
            if (V_PixelCount < PixelForVS - 1) V_PixelCount <= V_PixelCount + 1;
            else V_PixelCount <= 0;
         end
      end
   end


   // Address Generation
   localparam CHAR_CELL_WIDTH = 10;
   localparam CHAR_CELL_HEIGHT = 12;
   localparam SCREEN_COLS = 80;

   wire [15:0] h_pos_visible = H_PixelCount - H_BackPorch;
   wire [15:0] v_pos_visible = V_PixelCount - V_BackPorch;


   // Outputs for other modules
   assign char_addr = (v_pos_visible / CHAR_CELL_HEIGHT) * SCREEN_COLS + (h_pos_visible / CHAR_CELL_WIDTH);

   wire [ 3:0] local_x_w = h_pos_visible % CHAR_CELL_WIDTH;
   wire [ 3:0] local_y_w = v_pos_visible % CHAR_CELL_HEIGHT;

   // Output to physical LCD
   wire        lcd_en_w  = (H_PixelCount >= H_BackPorch)
               && (H_PixelCount < (H_BackPorch + H_Pixel_Valid))
               && (V_PixelCount >= V_BackPorch) && (V_PixelCount < (V_BackPorch + V_Pixel_Valid));

   reg [3:0]   local_x_reg;
   reg [3:0]   local_y_reg;
   reg         lcd_en_reg;

   always @(posedge lcd_clk or negedge rst_n) begin
      if (!rst_n) begin
         local_x_reg <= 0;
         local_y_reg <= 0;
         lcd_en_reg  <= 0;
      end else begin
         local_x_reg <= local_x_w;
         local_y_reg <= local_y_w;
         lcd_en_reg  <= lcd_en_w;
      end
   end

   assign local_x = local_x_reg;
   assign local_y = local_y_reg;
   assign lcd_en  = lcd_en_reg;


   // Final Color Selection Logic
   localparam [17:0] FOREGROUND_COLOR = {6'hFF, 6'hFF, 6'hFF};  // White
   localparam [17:0] BACKGROUND_COLOR = {6'h00, 6'h00, 6'h20};  // Dark Blue

   reg [17:0]        final_pixel_color;

   always @(*) begin
      if (pixel_on) begin
         final_pixel_color = FOREGROUND_COLOR;
      end else begin
         final_pixel_color = BACKGROUND_COLOR;
      end

      if (lcd_en) begin
         lcd_r = final_pixel_color[17:12];
         lcd_g = final_pixel_color[11:6];
         lcd_b = final_pixel_color[5:0];
      end else begin
         lcd_r = 6'd0;
         lcd_g = 6'd0;
         lcd_b = 6'd0;
      end
   end

endmodule
