//
// Font ROM (Character Pixel Decoder)
// Takes a character code and local pixel coordinates (x,y) within a cell,
// and outputs a single bit indicating if the pixel should be ON.
//
module font_rom (
    input wire [7:0] ascii_code,  // Character code from text_buffer
    input wire [3:0] local_x,     // Local X-coordinate within the cell (0-9)
    input wire [3:0] local_y,     // Local Y-coordinate within the cell (0-11)

    output reg pixel_on  // Output: 1 if pixel is ON, 0 if OFF
);
  reg [7:0] pixel_row_data;  // Internal register for the 8-pixel row

  always @(*) begin
    // Step 1: Check for padding
    // If the pixel is on the border of the cell, it's always OFF (background).
    if (local_x == 0 || local_x == 9 || local_y == 0 || local_y == 11) begin
      pixel_on = 1'b0;
    end else begin
      // Step 2: Get the 8-bit pixel row from the internal ROM logic
      // The actual font data is 8x8, located inside the 10x12 cell.
      // We use local_y-1 as the row address for the font data.
      if (local_y > 8) begin  // Rows 9 and 10 of the symbol are blank (font is 8x8)
        pixel_row_data = 8'h00;
      end else begin
        case (ascii_code)
          8'h00:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h01:
          case (local_y - 1)
            0: pixel_row_data = 8'h7e;
            1: pixel_row_data = 8'h81;
            2: pixel_row_data = 8'ha5;
            3: pixel_row_data = 8'h81;
            4: pixel_row_data = 8'hbd;
            5: pixel_row_data = 8'h99;
            6: pixel_row_data = 8'h81;
            7: pixel_row_data = 8'h7e;
            default: pixel_row_data = 8'h0;
          endcase
          8'h02:
          case (local_y - 1)
            0: pixel_row_data = 8'h3c;
            1: pixel_row_data = 8'h7e;
            2: pixel_row_data = 8'hdb;
            3: pixel_row_data = 8'hff;
            4: pixel_row_data = 8'hc3;
            5: pixel_row_data = 8'h7e;
            6: pixel_row_data = 8'h3c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h03:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'hee;
            2: pixel_row_data = 8'hfe;
            3: pixel_row_data = 8'hfe;
            4: pixel_row_data = 8'h7c;
            5: pixel_row_data = 8'h38;
            6: pixel_row_data = 8'h10;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h04:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h38;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'hfe;
            4: pixel_row_data = 8'h7c;
            5: pixel_row_data = 8'h38;
            6: pixel_row_data = 8'h10;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h05:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h3c;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'hff;
            4: pixel_row_data = 8'hff;
            5: pixel_row_data = 8'h08;
            6: pixel_row_data = 8'h18;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h06:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h38;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'hfe;
            4: pixel_row_data = 8'hfe;
            5: pixel_row_data = 8'h10;
            6: pixel_row_data = 8'h38;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h07:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h3c;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h08:
          case (local_y - 1)
            0: pixel_row_data = 8'hff;
            1: pixel_row_data = 8'hff;
            2: pixel_row_data = 8'he7;
            3: pixel_row_data = 8'hc3;
            4: pixel_row_data = 8'he7;
            5: pixel_row_data = 8'hff;
            6: pixel_row_data = 8'hff;
            7: pixel_row_data = 8'hff;
            default: pixel_row_data = 8'h0;
          endcase
          8'h09:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h3c;
            2: pixel_row_data = 8'h42;
            3: pixel_row_data = 8'h81;
            4: pixel_row_data = 8'h81;
            5: pixel_row_data = 8'h42;
            6: pixel_row_data = 8'h3c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h0a:
          case (local_y - 1)
            0: pixel_row_data = 8'hff;
            1: pixel_row_data = 8'hc3;
            2: pixel_row_data = 8'hbd;
            3: pixel_row_data = 8'h7e;
            4: pixel_row_data = 8'h7e;
            5: pixel_row_data = 8'hbd;
            6: pixel_row_data = 8'hc3;
            7: pixel_row_data = 8'hff;
            default: pixel_row_data = 8'h0;
          endcase
          8'h0b:
          case (local_y - 1)
            0: pixel_row_data = 8'h1f;
            1: pixel_row_data = 8'h07;
            2: pixel_row_data = 8'h0d;
            3: pixel_row_data = 8'h7c;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h0c:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h7e;
            2: pixel_row_data = 8'hc3;
            3: pixel_row_data = 8'hc3;
            4: pixel_row_data = 8'h7e;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h7e;
            7: pixel_row_data = 8'h18;
            default: pixel_row_data = 8'h0;
          endcase
          8'h0d:
          case (local_y - 1)
            0: pixel_row_data = 8'h04;
            1: pixel_row_data = 8'h06;
            2: pixel_row_data = 8'h07;
            3: pixel_row_data = 8'h04;
            4: pixel_row_data = 8'h04;
            5: pixel_row_data = 8'hfc;
            6: pixel_row_data = 8'hf8;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h0e:
          case (local_y - 1)
            0: pixel_row_data = 8'h0c;
            1: pixel_row_data = 8'h0a;
            2: pixel_row_data = 8'h0d;
            3: pixel_row_data = 8'h0b;
            4: pixel_row_data = 8'hf9;
            5: pixel_row_data = 8'hf9;
            6: pixel_row_data = 8'h1f;
            7: pixel_row_data = 8'h1f;
            default: pixel_row_data = 8'h0;
          endcase
          8'h0f:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h92;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'h44;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'h7c;
            6: pixel_row_data = 8'h92;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h10:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h60;
            3: pixel_row_data = 8'h78;
            4: pixel_row_data = 8'h7e;
            5: pixel_row_data = 8'h78;
            6: pixel_row_data = 8'h60;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h11:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h06;
            3: pixel_row_data = 8'h1e;
            4: pixel_row_data = 8'h7e;
            5: pixel_row_data = 8'h1e;
            6: pixel_row_data = 8'h06;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h12:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h7e;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h7e;
            7: pixel_row_data = 8'h18;
            default: pixel_row_data = 8'h0;
          endcase
          8'h13:
          case (local_y - 1)
            0: pixel_row_data = 8'h66;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h66;
            3: pixel_row_data = 8'h66;
            4: pixel_row_data = 8'h66;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h66;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h14:
          case (local_y - 1)
            0: pixel_row_data = 8'hff;
            1: pixel_row_data = 8'hb6;
            2: pixel_row_data = 8'h76;
            3: pixel_row_data = 8'h36;
            4: pixel_row_data = 8'h36;
            5: pixel_row_data = 8'h36;
            6: pixel_row_data = 8'h36;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h15:
          case (local_y - 1)
            0: pixel_row_data = 8'h7e;
            1: pixel_row_data = 8'hc1;
            2: pixel_row_data = 8'hdc;
            3: pixel_row_data = 8'h22;
            4: pixel_row_data = 8'h22;
            5: pixel_row_data = 8'h1f;
            6: pixel_row_data = 8'h83;
            7: pixel_row_data = 8'h7e;
            default: pixel_row_data = 8'h0;
          endcase
          8'h16:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h7e;
            4: pixel_row_data = 8'h7e;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h17:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h7e;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h7e;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'hff;
            default: pixel_row_data = 8'h0;
          endcase
          8'h18:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h7e;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h18;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h19:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h18;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h7e;
            6: pixel_row_data = 8'h18;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h1a:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h04;
            2: pixel_row_data = 8'h06;
            3: pixel_row_data = 8'hff;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'h04;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h1b:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h20;
            2: pixel_row_data = 8'h60;
            3: pixel_row_data = 8'hff;
            4: pixel_row_data = 8'h60;
            5: pixel_row_data = 8'h20;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h1c:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'hc0;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'hc0;
            6: pixel_row_data = 8'hff;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h1d:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h24;
            2: pixel_row_data = 8'h66;
            3: pixel_row_data = 8'hff;
            4: pixel_row_data = 8'h66;
            5: pixel_row_data = 8'h24;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h1e:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h10;
            3: pixel_row_data = 8'h38;
            4: pixel_row_data = 8'h7c;
            5: pixel_row_data = 8'hfe;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h1f:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'hfe;
            4: pixel_row_data = 8'h7c;
            5: pixel_row_data = 8'h38;
            6: pixel_row_data = 8'h10;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h20:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h21:
          case (local_y - 1)
            0: pixel_row_data = 8'h30;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h30;
            3: pixel_row_data = 8'h30;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h30;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h22:
          case (local_y - 1)
            0: pixel_row_data = 8'h66;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h23:
          case (local_y - 1)
            0: pixel_row_data = 8'h6c;
            1: pixel_row_data = 8'h6c;
            2: pixel_row_data = 8'hfe;
            3: pixel_row_data = 8'h6c;
            4: pixel_row_data = 8'hfe;
            5: pixel_row_data = 8'h6c;
            6: pixel_row_data = 8'h6c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h24:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h7c;
            2: pixel_row_data = 8'hd2;
            3: pixel_row_data = 8'h7c;
            4: pixel_row_data = 8'h86;
            5: pixel_row_data = 8'h7c;
            6: pixel_row_data = 8'h10;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h25:
          case (local_y - 1)
            0: pixel_row_data = 8'hf0;
            1: pixel_row_data = 8'h96;
            2: pixel_row_data = 8'hfc;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h3e;
            5: pixel_row_data = 8'h72;
            6: pixel_row_data = 8'hde;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h26:
          case (local_y - 1)
            0: pixel_row_data = 8'h30;
            1: pixel_row_data = 8'h48;
            2: pixel_row_data = 8'h30;
            3: pixel_row_data = 8'h78;
            4: pixel_row_data = 8'hce;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'h78;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h27:
          case (local_y - 1)
            0: pixel_row_data = 8'h0c;
            1: pixel_row_data = 8'h0c;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h28:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h60;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hc0;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'h60;
            6: pixel_row_data = 8'h10;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h29:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h0c;
            2: pixel_row_data = 8'h06;
            3: pixel_row_data = 8'h06;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'h0c;
            6: pixel_row_data = 8'h10;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h2a:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h54;
            2: pixel_row_data = 8'h38;
            3: pixel_row_data = 8'hfe;
            4: pixel_row_data = 8'h38;
            5: pixel_row_data = 8'h54;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h2b:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h18;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h7e;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h2c:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h18;
            7: pixel_row_data = 8'h70;
            default: pixel_row_data = 8'h0;
          endcase
          8'h2d:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h7e;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h2e:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h18;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h2f:
          case (local_y - 1)
            0: pixel_row_data = 8'h02;
            1: pixel_row_data = 8'h06;
            2: pixel_row_data = 8'h0c;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h60;
            6: pixel_row_data = 8'hc0;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h30:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hce;
            2: pixel_row_data = 8'hde;
            3: pixel_row_data = 8'hf6;
            4: pixel_row_data = 8'he6;
            5: pixel_row_data = 8'he6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h31:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h38;
            2: pixel_row_data = 8'h78;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h3c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h32:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'h06;
            3: pixel_row_data = 8'h0c;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h60;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h33:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'h06;
            3: pixel_row_data = 8'h3c;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h34:
          case (local_y - 1)
            0: pixel_row_data = 8'h0e;
            1: pixel_row_data = 8'h1e;
            2: pixel_row_data = 8'h36;
            3: pixel_row_data = 8'h66;
            4: pixel_row_data = 8'hfe;
            5: pixel_row_data = 8'h06;
            6: pixel_row_data = 8'h06;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h35:
          case (local_y - 1)
            0: pixel_row_data = 8'hfe;
            1: pixel_row_data = 8'hc0;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hfc;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'h06;
            6: pixel_row_data = 8'hfc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h36:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hfc;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h37:
          case (local_y - 1)
            0: pixel_row_data = 8'hfe;
            1: pixel_row_data = 8'h06;
            2: pixel_row_data = 8'h0c;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h60;
            6: pixel_row_data = 8'h60;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h38:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'h7c;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h39:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'h7e;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h3a:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h30;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h3b:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h30;
            6: pixel_row_data = 8'h20;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h3c:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h1c;
            2: pixel_row_data = 8'h30;
            3: pixel_row_data = 8'h60;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h1c;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h3d:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7e;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h7e;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h3e:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h70;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h0c;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h70;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h3f:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'h0c;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h30;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h40:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'h82;
            2: pixel_row_data = 8'h9a;
            3: pixel_row_data = 8'haa;
            4: pixel_row_data = 8'haa;
            5: pixel_row_data = 8'h9e;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h41:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hfe;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h42:
          case (local_y - 1)
            0: pixel_row_data = 8'hfc;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h66;
            3: pixel_row_data = 8'h7c;
            4: pixel_row_data = 8'h66;
            5: pixel_row_data = 8'h66;
            6: pixel_row_data = 8'hfc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h43:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hc0;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h44:
          case (local_y - 1)
            0: pixel_row_data = 8'hfc;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h66;
            3: pixel_row_data = 8'h66;
            4: pixel_row_data = 8'h66;
            5: pixel_row_data = 8'h66;
            6: pixel_row_data = 8'hfc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h45:
          case (local_y - 1)
            0: pixel_row_data = 8'hfe;
            1: pixel_row_data = 8'h62;
            2: pixel_row_data = 8'h68;
            3: pixel_row_data = 8'h78;
            4: pixel_row_data = 8'h68;
            5: pixel_row_data = 8'h62;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h46:
          case (local_y - 1)
            0: pixel_row_data = 8'hfe;
            1: pixel_row_data = 8'h62;
            2: pixel_row_data = 8'h68;
            3: pixel_row_data = 8'h78;
            4: pixel_row_data = 8'h68;
            5: pixel_row_data = 8'h60;
            6: pixel_row_data = 8'hf0;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h47:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc0;
            4: pixel_row_data = 8'hde;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h48:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hfe;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h49:
          case (local_y - 1)
            0: pixel_row_data = 8'h3c;
            1: pixel_row_data = 8'h18;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h3c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h4a:
          case (local_y - 1)
            0: pixel_row_data = 8'h1e;
            1: pixel_row_data = 8'h0c;
            2: pixel_row_data = 8'h0c;
            3: pixel_row_data = 8'h0c;
            4: pixel_row_data = 8'h0c;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'h78;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h4b:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hcc;
            2: pixel_row_data = 8'hd8;
            3: pixel_row_data = 8'hf0;
            4: pixel_row_data = 8'hd8;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h4c:
          case (local_y - 1)
            0: pixel_row_data = 8'hf0;
            1: pixel_row_data = 8'h60;
            2: pixel_row_data = 8'h60;
            3: pixel_row_data = 8'h60;
            4: pixel_row_data = 8'h60;
            5: pixel_row_data = 8'h62;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h4d:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hee;
            2: pixel_row_data = 8'hfe;
            3: pixel_row_data = 8'hd6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h4e:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'he6;
            2: pixel_row_data = 8'hf6;
            3: pixel_row_data = 8'hde;
            4: pixel_row_data = 8'hce;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h4f:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h50:
          case (local_y - 1)
            0: pixel_row_data = 8'hfc;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h66;
            3: pixel_row_data = 8'h7c;
            4: pixel_row_data = 8'h60;
            5: pixel_row_data = 8'h60;
            6: pixel_row_data = 8'hf0;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h51:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h0c;
            default: pixel_row_data = 8'h0;
          endcase
          8'h52:
          case (local_y - 1)
            0: pixel_row_data = 8'hfc;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h66;
            3: pixel_row_data = 8'h7c;
            4: pixel_row_data = 8'h66;
            5: pixel_row_data = 8'h66;
            6: pixel_row_data = 8'he6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h53:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'h7c;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h54:
          case (local_y - 1)
            0: pixel_row_data = 8'h7e;
            1: pixel_row_data = 8'h5a;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h3c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h55:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h56:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'h6c;
            6: pixel_row_data = 8'h38;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h57:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hd6;
            5: pixel_row_data = 8'hee;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h58:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'h6c;
            2: pixel_row_data = 8'h38;
            3: pixel_row_data = 8'h38;
            4: pixel_row_data = 8'h38;
            5: pixel_row_data = 8'h6c;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h59:
          case (local_y - 1)
            0: pixel_row_data = 8'h66;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h66;
            3: pixel_row_data = 8'h3c;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h3c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h5a:
          case (local_y - 1)
            0: pixel_row_data = 8'hfe;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'h0c;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h66;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h5b:
          case (local_y - 1)
            0: pixel_row_data = 8'h1c;
            1: pixel_row_data = 8'h18;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h1c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h5c:
          case (local_y - 1)
            0: pixel_row_data = 8'hc0;
            1: pixel_row_data = 8'h60;
            2: pixel_row_data = 8'h30;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h0c;
            5: pixel_row_data = 8'h06;
            6: pixel_row_data = 8'h02;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h5d:
          case (local_y - 1)
            0: pixel_row_data = 8'h70;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h30;
            3: pixel_row_data = 8'h30;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h30;
            6: pixel_row_data = 8'h70;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h5e:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h10;
            3: pixel_row_data = 8'h38;
            4: pixel_row_data = 8'h6c;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h5f:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'hff;
            default: pixel_row_data = 8'h0;
          endcase
          8'h60:
          case (local_y - 1)
            0: pixel_row_data = 8'h30;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h61:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'h06;
            4: pixel_row_data = 8'h7e;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7e;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h62:
          case (local_y - 1)
            0: pixel_row_data = 8'hc0;
            1: pixel_row_data = 8'hc0;
            2: pixel_row_data = 8'hfc;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hfc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h63:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h64:
          case (local_y - 1)
            0: pixel_row_data = 8'h06;
            1: pixel_row_data = 8'h06;
            2: pixel_row_data = 8'h7e;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7e;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h65:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hfe;
            5: pixel_row_data = 8'hc0;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h66:
          case (local_y - 1)
            0: pixel_row_data = 8'h3c;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h60;
            3: pixel_row_data = 8'hf0;
            4: pixel_row_data = 8'h60;
            5: pixel_row_data = 8'h60;
            6: pixel_row_data = 8'h60;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h67:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7e;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'h7e;
            6: pixel_row_data = 8'h06;
            7: pixel_row_data = 8'h7c;
            default: pixel_row_data = 8'h0;
          endcase
          8'h68:
          case (local_y - 1)
            0: pixel_row_data = 8'hc0;
            1: pixel_row_data = 8'hc0;
            2: pixel_row_data = 8'hfc;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h69:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h38;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h3c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h6a:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h0c;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h1c;
            4: pixel_row_data = 8'h0c;
            5: pixel_row_data = 8'h0c;
            6: pixel_row_data = 8'hcc;
            7: pixel_row_data = 8'h78;
            default: pixel_row_data = 8'h0;
          endcase
          8'h6b:
          case (local_y - 1)
            0: pixel_row_data = 8'hc0;
            1: pixel_row_data = 8'hc0;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hd8;
            4: pixel_row_data = 8'hf0;
            5: pixel_row_data = 8'hd8;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h6c:
          case (local_y - 1)
            0: pixel_row_data = 8'h38;
            1: pixel_row_data = 8'h18;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h3c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h6d:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hee;
            3: pixel_row_data = 8'hfe;
            4: pixel_row_data = 8'hd6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h6e:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hfc;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h6f:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h70:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hfc;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hfc;
            6: pixel_row_data = 8'hc0;
            7: pixel_row_data = 8'hc0;
            default: pixel_row_data = 8'h0;
          endcase
          8'h71:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7e;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'h7e;
            6: pixel_row_data = 8'h06;
            7: pixel_row_data = 8'h06;
            default: pixel_row_data = 8'h0;
          endcase
          8'h72:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hde;
            3: pixel_row_data = 8'h76;
            4: pixel_row_data = 8'h60;
            5: pixel_row_data = 8'h60;
            6: pixel_row_data = 8'h60;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h73:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'hc0;
            4: pixel_row_data = 8'h7c;
            5: pixel_row_data = 8'h06;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h74:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h18;
            2: pixel_row_data = 8'h7e;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h1e;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h75:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7e;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h76:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'h6c;
            6: pixel_row_data = 8'h38;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h77:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hd6;
            5: pixel_row_data = 8'hfe;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h78:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'h6c;
            4: pixel_row_data = 8'h38;
            5: pixel_row_data = 8'h6c;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h79:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'h7e;
            6: pixel_row_data = 8'h06;
            7: pixel_row_data = 8'h7c;
            default: pixel_row_data = 8'h0;
          endcase
          8'h7a:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hfe;
            3: pixel_row_data = 8'h0c;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h60;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h7b:
          case (local_y - 1)
            0: pixel_row_data = 8'h0e;
            1: pixel_row_data = 8'h18;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h70;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h0e;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h7c:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h18;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h18;
            6: pixel_row_data = 8'h18;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h7d:
          case (local_y - 1)
            0: pixel_row_data = 8'he0;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h30;
            3: pixel_row_data = 8'h1c;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h30;
            6: pixel_row_data = 8'he0;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h7e:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h70;
            3: pixel_row_data = 8'h9a;
            4: pixel_row_data = 8'h0e;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h7f:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h3c;
            4: pixel_row_data = 8'h66;
            5: pixel_row_data = 8'hff;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h80:
          case (local_y - 1)
            0: pixel_row_data = 8'h0e;
            1: pixel_row_data = 8'h1e;
            2: pixel_row_data = 8'h36;
            3: pixel_row_data = 8'h66;
            4: pixel_row_data = 8'hfe;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h81:
          case (local_y - 1)
            0: pixel_row_data = 8'hfc;
            1: pixel_row_data = 8'hc0;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hfc;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hfc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h82:
          case (local_y - 1)
            0: pixel_row_data = 8'hf8;
            1: pixel_row_data = 8'hcc;
            2: pixel_row_data = 8'hcc;
            3: pixel_row_data = 8'hfc;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hfc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h83:
          case (local_y - 1)
            0: pixel_row_data = 8'hfc;
            1: pixel_row_data = 8'hc0;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hc0;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'hc0;
            6: pixel_row_data = 8'hc0;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h84:
          case (local_y - 1)
            0: pixel_row_data = 8'h7e;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h66;
            3: pixel_row_data = 8'h66;
            4: pixel_row_data = 8'h66;
            5: pixel_row_data = 8'h66;
            6: pixel_row_data = 8'hff;
            7: pixel_row_data = 8'hc3;
            default: pixel_row_data = 8'h0;
          endcase
          8'h85:
          case (local_y - 1)
            0: pixel_row_data = 8'hfc;
            1: pixel_row_data = 8'hc0;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hf8;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'hc0;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h86:
          case (local_y - 1)
            0: pixel_row_data = 8'hdb;
            1: pixel_row_data = 8'hdb;
            2: pixel_row_data = 8'h7e;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h7e;
            5: pixel_row_data = 8'hdb;
            6: pixel_row_data = 8'hdb;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h87:
          case (local_y - 1)
            0: pixel_row_data = 8'h3c;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h06;
            3: pixel_row_data = 8'h3c;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h88:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hce;
            3: pixel_row_data = 8'hde;
            4: pixel_row_data = 8'hf6;
            5: pixel_row_data = 8'he6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h89:
          case (local_y - 1)
            0: pixel_row_data = 8'hd6;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hce;
            3: pixel_row_data = 8'hde;
            4: pixel_row_data = 8'hf6;
            5: pixel_row_data = 8'he6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h8a:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hcc;
            2: pixel_row_data = 8'hd8;
            3: pixel_row_data = 8'hf8;
            4: pixel_row_data = 8'hcc;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h8b:
          case (local_y - 1)
            0: pixel_row_data = 8'h06;
            1: pixel_row_data = 8'h0e;
            2: pixel_row_data = 8'h1e;
            3: pixel_row_data = 8'h36;
            4: pixel_row_data = 8'h66;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h8c:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hee;
            2: pixel_row_data = 8'hfe;
            3: pixel_row_data = 8'hd6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h8d:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hfe;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h8e:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h8f:
          case (local_y - 1)
            0: pixel_row_data = 8'hfe;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h90:
          case (local_y - 1)
            0: pixel_row_data = 8'hfc;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hfc;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'hc0;
            6: pixel_row_data = 8'hc0;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h91:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hc0;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h92:
          case (local_y - 1)
            0: pixel_row_data = 8'hfc;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h30;
            3: pixel_row_data = 8'h30;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h30;
            6: pixel_row_data = 8'h30;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h93:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'h7e;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h94:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h7e;
            2: pixel_row_data = 8'hdb;
            3: pixel_row_data = 8'hdb;
            4: pixel_row_data = 8'hdb;
            5: pixel_row_data = 8'h7e;
            6: pixel_row_data = 8'h18;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h95:
          case (local_y - 1)
            0: pixel_row_data = 8'hc3;
            1: pixel_row_data = 8'h66;
            2: pixel_row_data = 8'h3c;
            3: pixel_row_data = 8'h18;
            4: pixel_row_data = 8'h3c;
            5: pixel_row_data = 8'h66;
            6: pixel_row_data = 8'hc3;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h96:
          case (local_y - 1)
            0: pixel_row_data = 8'hcc;
            1: pixel_row_data = 8'hcc;
            2: pixel_row_data = 8'hcc;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hcc;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h06;
            default: pixel_row_data = 8'h0;
          endcase
          8'h97:
          case (local_y - 1)
            0: pixel_row_data = 8'hc6;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'h7e;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'h06;
            6: pixel_row_data = 8'h06;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h98:
          case (local_y - 1)
            0: pixel_row_data = 8'hd6;
            1: pixel_row_data = 8'hd6;
            2: pixel_row_data = 8'hd6;
            3: pixel_row_data = 8'hd6;
            4: pixel_row_data = 8'hd6;
            5: pixel_row_data = 8'hd6;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h99:
          case (local_y - 1)
            0: pixel_row_data = 8'hd6;
            1: pixel_row_data = 8'hd6;
            2: pixel_row_data = 8'hd6;
            3: pixel_row_data = 8'hd6;
            4: pixel_row_data = 8'hd6;
            5: pixel_row_data = 8'hd6;
            6: pixel_row_data = 8'hff;
            7: pixel_row_data = 8'h03;
            default: pixel_row_data = 8'h0;
          endcase
          8'h9a:
          case (local_y - 1)
            0: pixel_row_data = 8'hf0;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h30;
            3: pixel_row_data = 8'h3e;
            4: pixel_row_data = 8'h33;
            5: pixel_row_data = 8'h33;
            6: pixel_row_data = 8'h3e;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h9b:
          case (local_y - 1)
            0: pixel_row_data = 8'hc2;
            1: pixel_row_data = 8'hc2;
            2: pixel_row_data = 8'hc2;
            3: pixel_row_data = 8'hf2;
            4: pixel_row_data = 8'hda;
            5: pixel_row_data = 8'hda;
            6: pixel_row_data = 8'hf2;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h9c:
          case (local_y - 1)
            0: pixel_row_data = 8'hc0;
            1: pixel_row_data = 8'hc0;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hfc;
            4: pixel_row_data = 8'hc6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hfc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h9d:
          case (local_y - 1)
            0: pixel_row_data = 8'h7c;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'h06;
            3: pixel_row_data = 8'h1e;
            4: pixel_row_data = 8'h06;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h9e:
          case (local_y - 1)
            0: pixel_row_data = 8'hce;
            1: pixel_row_data = 8'hdb;
            2: pixel_row_data = 8'hdb;
            3: pixel_row_data = 8'hfb;
            4: pixel_row_data = 8'hdb;
            5: pixel_row_data = 8'hdb;
            6: pixel_row_data = 8'hce;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'h9f:
          case (local_y - 1)
            0: pixel_row_data = 8'h7e;
            1: pixel_row_data = 8'hc6;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'h7e;
            4: pixel_row_data = 8'h36;
            5: pixel_row_data = 8'h66;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha0:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h78;
            3: pixel_row_data = 8'h0c;
            4: pixel_row_data = 8'h7c;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'h7e;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha1:
          case (local_y - 1)
            0: pixel_row_data = 8'h04;
            1: pixel_row_data = 8'h78;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hf8;
            4: pixel_row_data = 8'hcc;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'h78;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha2:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hf8;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hf8;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hfc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha3:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hfc;
            3: pixel_row_data = 8'hc0;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'hc0;
            6: pixel_row_data = 8'hc0;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha4:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7e;
            3: pixel_row_data = 8'h66;
            4: pixel_row_data = 8'h66;
            5: pixel_row_data = 8'h66;
            6: pixel_row_data = 8'hff;
            7: pixel_row_data = 8'hc3;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha5:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h78;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hfc;
            5: pixel_row_data = 8'hc0;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha6:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hdb;
            3: pixel_row_data = 8'h7e;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h7e;
            6: pixel_row_data = 8'hdb;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha7:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h78;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'h78;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha8:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hcc;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hdc;
            5: pixel_row_data = 8'hec;
            6: pixel_row_data = 8'hcc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'ha9:
          case (local_y - 1)
            0: pixel_row_data = 8'h30;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hcc;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hdc;
            5: pixel_row_data = 8'hec;
            6: pixel_row_data = 8'hcc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'haa:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hcc;
            3: pixel_row_data = 8'hd8;
            4: pixel_row_data = 8'hf0;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'hcc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hab:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h0e;
            3: pixel_row_data = 8'h1e;
            4: pixel_row_data = 8'h36;
            5: pixel_row_data = 8'h66;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hac:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'hee;
            4: pixel_row_data = 8'hd6;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'had:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hcc;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hfc;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'hcc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hae:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h78;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hcc;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'h78;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'haf:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hfc;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hcc;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'hcc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb0:
          case (local_y - 1)
            0: pixel_row_data = 8'h22;
            1: pixel_row_data = 8'h88;
            2: pixel_row_data = 8'h22;
            3: pixel_row_data = 8'h88;
            4: pixel_row_data = 8'h22;
            5: pixel_row_data = 8'h88;
            6: pixel_row_data = 8'h22;
            7: pixel_row_data = 8'h88;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb1:
          case (local_y - 1)
            0: pixel_row_data = 8'h55;
            1: pixel_row_data = 8'haa;
            2: pixel_row_data = 8'h55;
            3: pixel_row_data = 8'haa;
            4: pixel_row_data = 8'h55;
            5: pixel_row_data = 8'haa;
            6: pixel_row_data = 8'h55;
            7: pixel_row_data = 8'haa;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb2:
          case (local_y - 1)
            0: pixel_row_data = 8'hdb;
            1: pixel_row_data = 8'h77;
            2: pixel_row_data = 8'hdb;
            3: pixel_row_data = 8'hee;
            4: pixel_row_data = 8'hdb;
            5: pixel_row_data = 8'h77;
            6: pixel_row_data = 8'hdb;
            7: pixel_row_data = 8'hee;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb3:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h10;
            3: pixel_row_data = 8'h10;
            4: pixel_row_data = 8'h10;
            5: pixel_row_data = 8'h10;
            6: pixel_row_data = 8'h10;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb4:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h20;
            3: pixel_row_data = 8'h40;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h40;
            6: pixel_row_data = 8'h20;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb5:
          case (local_y - 1)
            0: pixel_row_data = 8'h20;
            1: pixel_row_data = 8'h40;
            2: pixel_row_data = 8'h80;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h40;
            6: pixel_row_data = 8'h20;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb6:
          case (local_y - 1)
            0: pixel_row_data = 8'h14;
            1: pixel_row_data = 8'h14;
            2: pixel_row_data = 8'h24;
            3: pixel_row_data = 8'h44;
            4: pixel_row_data = 8'h84;
            5: pixel_row_data = 8'h44;
            6: pixel_row_data = 8'h24;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb7:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'he0;
            5: pixel_row_data = 8'h50;
            6: pixel_row_data = 8'h28;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb8:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h80;
            3: pixel_row_data = 8'h40;
            4: pixel_row_data = 8'ha0;
            5: pixel_row_data = 8'h50;
            6: pixel_row_data = 8'h30;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hb9:
          case (local_y - 1)
            0: pixel_row_data = 8'h24;
            1: pixel_row_data = 8'h44;
            2: pixel_row_data = 8'h84;
            3: pixel_row_data = 8'h04;
            4: pixel_row_data = 8'h84;
            5: pixel_row_data = 8'h44;
            6: pixel_row_data = 8'h24;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hba:
          case (local_y - 1)
            0: pixel_row_data = 8'h14;
            1: pixel_row_data = 8'h14;
            2: pixel_row_data = 8'h14;
            3: pixel_row_data = 8'h14;
            4: pixel_row_data = 8'h14;
            5: pixel_row_data = 8'h14;
            6: pixel_row_data = 8'h14;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hbb:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'he0;
            3: pixel_row_data = 8'h10;
            4: pixel_row_data = 8'h88;
            5: pixel_row_data = 8'h44;
            6: pixel_row_data = 8'h24;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hbc:
          case (local_y - 1)
            0: pixel_row_data = 8'h24;
            1: pixel_row_data = 8'h44;
            2: pixel_row_data = 8'h88;
            3: pixel_row_data = 8'h10;
            4: pixel_row_data = 8'he0;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hbd:
          case (local_y - 1)
            0: pixel_row_data = 8'h14;
            1: pixel_row_data = 8'h14;
            2: pixel_row_data = 8'h28;
            3: pixel_row_data = 8'h50;
            4: pixel_row_data = 8'he0;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hbe:
          case (local_y - 1)
            0: pixel_row_data = 8'h30;
            1: pixel_row_data = 8'h50;
            2: pixel_row_data = 8'ha0;
            3: pixel_row_data = 8'h40;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hbf:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h40;
            6: pixel_row_data = 8'h20;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc0:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h08;
            3: pixel_row_data = 8'h04;
            4: pixel_row_data = 8'h03;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc1:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h28;
            3: pixel_row_data = 8'h44;
            4: pixel_row_data = 8'h83;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc2:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h83;
            5: pixel_row_data = 8'h44;
            6: pixel_row_data = 8'h28;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc3:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h08;
            3: pixel_row_data = 8'h04;
            4: pixel_row_data = 8'h03;
            5: pixel_row_data = 8'h04;
            6: pixel_row_data = 8'h08;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc4:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'hff;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc5:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h28;
            3: pixel_row_data = 8'h44;
            4: pixel_row_data = 8'h83;
            5: pixel_row_data = 8'h44;
            6: pixel_row_data = 8'h28;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc6:
          case (local_y - 1)
            0: pixel_row_data = 8'h08;
            1: pixel_row_data = 8'h04;
            2: pixel_row_data = 8'h03;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h03;
            5: pixel_row_data = 8'h04;
            6: pixel_row_data = 8'h08;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc7:
          case (local_y - 1)
            0: pixel_row_data = 8'h14;
            1: pixel_row_data = 8'h14;
            2: pixel_row_data = 8'h12;
            3: pixel_row_data = 8'h11;
            4: pixel_row_data = 8'h10;
            5: pixel_row_data = 8'h11;
            6: pixel_row_data = 8'h12;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc8:
          case (local_y - 1)
            0: pixel_row_data = 8'h12;
            1: pixel_row_data = 8'h11;
            2: pixel_row_data = 8'h08;
            3: pixel_row_data = 8'h04;
            4: pixel_row_data = 8'h03;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hc9:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h03;
            3: pixel_row_data = 8'h04;
            4: pixel_row_data = 8'h08;
            5: pixel_row_data = 8'h11;
            6: pixel_row_data = 8'h12;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hca:
          case (local_y - 1)
            0: pixel_row_data = 8'h22;
            1: pixel_row_data = 8'h41;
            2: pixel_row_data = 8'h80;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'hff;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hcb:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hff;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h41;
            6: pixel_row_data = 8'h22;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hcc:
          case (local_y - 1)
            0: pixel_row_data = 8'h12;
            1: pixel_row_data = 8'h11;
            2: pixel_row_data = 8'h10;
            3: pixel_row_data = 8'h10;
            4: pixel_row_data = 8'h10;
            5: pixel_row_data = 8'h11;
            6: pixel_row_data = 8'h12;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hcd:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hff;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'hff;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hce:
          case (local_y - 1)
            0: pixel_row_data = 8'h22;
            1: pixel_row_data = 8'h41;
            2: pixel_row_data = 8'h80;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h41;
            6: pixel_row_data = 8'h22;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hcf:
          case (local_y - 1)
            0: pixel_row_data = 8'h28;
            1: pixel_row_data = 8'h44;
            2: pixel_row_data = 8'h83;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'hff;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd0:
          case (local_y - 1)
            0: pixel_row_data = 8'h14;
            1: pixel_row_data = 8'h14;
            2: pixel_row_data = 8'h22;
            3: pixel_row_data = 8'h41;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd1:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hff;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h83;
            5: pixel_row_data = 8'h44;
            6: pixel_row_data = 8'h28;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd2:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h41;
            6: pixel_row_data = 8'h22;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd3:
          case (local_y - 1)
            0: pixel_row_data = 8'h14;
            1: pixel_row_data = 8'h14;
            2: pixel_row_data = 8'h0a;
            3: pixel_row_data = 8'h05;
            4: pixel_row_data = 8'h03;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd4:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h14;
            2: pixel_row_data = 8'h0b;
            3: pixel_row_data = 8'h04;
            4: pixel_row_data = 8'h03;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd5:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h03;
            3: pixel_row_data = 8'h04;
            4: pixel_row_data = 8'h0b;
            5: pixel_row_data = 8'h14;
            6: pixel_row_data = 8'h18;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd6:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h03;
            5: pixel_row_data = 8'h05;
            6: pixel_row_data = 8'h0a;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd7:
          case (local_y - 1)
            0: pixel_row_data = 8'h14;
            1: pixel_row_data = 8'h14;
            2: pixel_row_data = 8'h22;
            3: pixel_row_data = 8'h41;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h41;
            6: pixel_row_data = 8'h22;
            7: pixel_row_data = 8'h14;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd8:
          case (local_y - 1)
            0: pixel_row_data = 8'h28;
            1: pixel_row_data = 8'h44;
            2: pixel_row_data = 8'h83;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h83;
            5: pixel_row_data = 8'h44;
            6: pixel_row_data = 8'h28;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hd9:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h20;
            3: pixel_row_data = 8'h40;
            4: pixel_row_data = 8'h80;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hda:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h03;
            5: pixel_row_data = 8'h04;
            6: pixel_row_data = 8'h08;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hdb:
          case (local_y - 1)
            0: pixel_row_data = 8'hff;
            1: pixel_row_data = 8'hff;
            2: pixel_row_data = 8'hff;
            3: pixel_row_data = 8'hff;
            4: pixel_row_data = 8'hff;
            5: pixel_row_data = 8'hff;
            6: pixel_row_data = 8'hff;
            7: pixel_row_data = 8'hff;
            default: pixel_row_data = 8'h0;
          endcase
          8'hdc:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'hff;
            5: pixel_row_data = 8'hff;
            6: pixel_row_data = 8'hff;
            7: pixel_row_data = 8'hff;
            default: pixel_row_data = 8'h0;
          endcase
          8'hdd:
          case (local_y - 1)
            0: pixel_row_data = 8'hf0;
            1: pixel_row_data = 8'hf0;
            2: pixel_row_data = 8'hf0;
            3: pixel_row_data = 8'hf0;
            4: pixel_row_data = 8'hf0;
            5: pixel_row_data = 8'hf0;
            6: pixel_row_data = 8'hf0;
            7: pixel_row_data = 8'hf0;
            default: pixel_row_data = 8'h0;
          endcase
          8'hde:
          case (local_y - 1)
            0: pixel_row_data = 8'h0f;
            1: pixel_row_data = 8'h0f;
            2: pixel_row_data = 8'h0f;
            3: pixel_row_data = 8'h0f;
            4: pixel_row_data = 8'h0f;
            5: pixel_row_data = 8'h0f;
            6: pixel_row_data = 8'h0f;
            7: pixel_row_data = 8'h0f;
            default: pixel_row_data = 8'h0;
          endcase
          8'hdf:
          case (local_y - 1)
            0: pixel_row_data = 8'hff;
            1: pixel_row_data = 8'hff;
            2: pixel_row_data = 8'hff;
            3: pixel_row_data = 8'hff;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'he0:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hf8;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hcc;
            5: pixel_row_data = 8'hf8;
            6: pixel_row_data = 8'hc0;
            7: pixel_row_data = 8'hc0;
            default: pixel_row_data = 8'h0;
          endcase
          8'he1:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h78;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hc0;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'h78;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'he2:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hfc;
            3: pixel_row_data = 8'h30;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h30;
            6: pixel_row_data = 8'h30;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'he3:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hcc;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'h7c;
            5: pixel_row_data = 8'h0c;
            6: pixel_row_data = 8'hcc;
            7: pixel_row_data = 8'h78;
            default: pixel_row_data = 8'h0;
          endcase
          8'he4:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h18;
            2: pixel_row_data = 8'h7e;
            3: pixel_row_data = 8'hdb;
            4: pixel_row_data = 8'hdb;
            5: pixel_row_data = 8'h7e;
            6: pixel_row_data = 8'h18;
            7: pixel_row_data = 8'h18;
            default: pixel_row_data = 8'h0;
          endcase
          8'he5:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hc6;
            3: pixel_row_data = 8'h6c;
            4: pixel_row_data = 8'h38;
            5: pixel_row_data = 8'h6c;
            6: pixel_row_data = 8'hc6;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'he6:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hcc;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'hcc;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h06;
            default: pixel_row_data = 8'h0;
          endcase
          8'he7:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hcc;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'h7c;
            5: pixel_row_data = 8'h0c;
            6: pixel_row_data = 8'h0c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'he8:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hd6;
            3: pixel_row_data = 8'hd6;
            4: pixel_row_data = 8'hd6;
            5: pixel_row_data = 8'hd6;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'he9:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hd6;
            3: pixel_row_data = 8'hd6;
            4: pixel_row_data = 8'hd6;
            5: pixel_row_data = 8'hd6;
            6: pixel_row_data = 8'hff;
            7: pixel_row_data = 8'h03;
            default: pixel_row_data = 8'h0;
          endcase
          8'hea:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hf0;
            3: pixel_row_data = 8'h30;
            4: pixel_row_data = 8'h3e;
            5: pixel_row_data = 8'h33;
            6: pixel_row_data = 8'h3e;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'heb:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hc2;
            3: pixel_row_data = 8'hc2;
            4: pixel_row_data = 8'hf2;
            5: pixel_row_data = 8'hda;
            6: pixel_row_data = 8'hf2;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hec:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hc0;
            3: pixel_row_data = 8'hc0;
            4: pixel_row_data = 8'hf8;
            5: pixel_row_data = 8'hcc;
            6: pixel_row_data = 8'hf8;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hed:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'hc6;
            4: pixel_row_data = 8'h1e;
            5: pixel_row_data = 8'hc6;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hee:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hce;
            3: pixel_row_data = 8'hdb;
            4: pixel_row_data = 8'hfb;
            5: pixel_row_data = 8'hdb;
            6: pixel_row_data = 8'hce;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hef:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'hcc;
            4: pixel_row_data = 8'h7c;
            5: pixel_row_data = 8'h6c;
            6: pixel_row_data = 8'hcc;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf0:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'hfe;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'hfe;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'hfe;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf1:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h7c;
            3: pixel_row_data = 8'h10;
            4: pixel_row_data = 8'h10;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h7c;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf2:
          case (local_y - 1)
            0: pixel_row_data = 8'h60;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h18;
            3: pixel_row_data = 8'h30;
            4: pixel_row_data = 8'h60;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h78;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf3:
          case (local_y - 1)
            0: pixel_row_data = 8'h18;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h60;
            3: pixel_row_data = 8'h30;
            4: pixel_row_data = 8'h18;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h78;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf4:
          case (local_y - 1)
            0: pixel_row_data = 8'h08;
            1: pixel_row_data = 8'h14;
            2: pixel_row_data = 8'h10;
            3: pixel_row_data = 8'h10;
            4: pixel_row_data = 8'h10;
            5: pixel_row_data = 8'h10;
            6: pixel_row_data = 8'h10;
            7: pixel_row_data = 8'h10;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf5:
          case (local_y - 1)
            0: pixel_row_data = 8'h10;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h10;
            3: pixel_row_data = 8'h10;
            4: pixel_row_data = 8'h10;
            5: pixel_row_data = 8'h50;
            6: pixel_row_data = 8'h20;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf6:
          case (local_y - 1)
            0: pixel_row_data = 8'h30;
            1: pixel_row_data = 8'h30;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'hfc;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h30;
            6: pixel_row_data = 8'h30;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf7:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h64;
            3: pixel_row_data = 8'h98;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h64;
            6: pixel_row_data = 8'h98;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf8:
          case (local_y - 1)
            0: pixel_row_data = 8'h60;
            1: pixel_row_data = 8'h90;
            2: pixel_row_data = 8'h90;
            3: pixel_row_data = 8'h60;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hf9:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h30;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hfa:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h30;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hfb:
          case (local_y - 1)
            0: pixel_row_data = 8'h1f;
            1: pixel_row_data = 8'h10;
            2: pixel_row_data = 8'h10;
            3: pixel_row_data = 8'h90;
            4: pixel_row_data = 8'h50;
            5: pixel_row_data = 8'h30;
            6: pixel_row_data = 8'h10;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hfc:
          case (local_y - 1)
            0: pixel_row_data = 8'ha0;
            1: pixel_row_data = 8'hd0;
            2: pixel_row_data = 8'h90;
            3: pixel_row_data = 8'h90;
            4: pixel_row_data = 8'h90;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hfd:
          case (local_y - 1)
            0: pixel_row_data = 8'h60;
            1: pixel_row_data = 8'h90;
            2: pixel_row_data = 8'h20;
            3: pixel_row_data = 8'h40;
            4: pixel_row_data = 8'hf0;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hfe:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h3c;
            3: pixel_row_data = 8'h3c;
            4: pixel_row_data = 8'h3c;
            5: pixel_row_data = 8'h3c;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          8'hff:
          case (local_y - 1)
            0: pixel_row_data = 8'h00;
            1: pixel_row_data = 8'h00;
            2: pixel_row_data = 8'h00;
            3: pixel_row_data = 8'h00;
            4: pixel_row_data = 8'h00;
            5: pixel_row_data = 8'h00;
            6: pixel_row_data = 8'h00;
            7: pixel_row_data = 8'h00;
            default: pixel_row_data = 8'h0;
          endcase
          default: pixel_row_data = 8'hFF;  // Default character is a solid block
        endcase
      end

      // Step 3: Select the correct bit from the 8-bit row
      // The 8 data pixels are offset by 1 for the left padding.
      // MSB (bit 7) is the leftmost pixel.
      pixel_on = pixel_row_data[7-(local_x-1)];
    end
  end
endmodule
