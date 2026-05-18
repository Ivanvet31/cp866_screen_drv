# FPGA Dynamic Text Display Driver for LCD (CP866 Font)

This project implements a Verilog driver for displaying text on an 800x480 parallel RGB LCD. It features a real-time writable text buffer (VRAM) and a built-in CP866 font ROM.

## Features

*   **Dynamic VRAM:** The text buffer is implemented as a dual-port BRAM, allowing external modules (like a CPU, UART, or custom logic) to update the screen content in real-time.
*   **Modular Architecture:** The design is separated into a timing controller, a text buffer (VRAM), and a font ROM (character decoder).
*   **80x40 Character Grid:** Renders a grid of 80 columns by 40 rows of text.
*   **10x12 Character Cells:** Each character is rendered within a 10x12 pixel cell, including a 1-pixel border for clear separation and readability.
*   **CP866 Font Support:** Includes a full 8x8 pixel font for the CP866 charset, providing comprehensive support for English, Russian, and pseudographics characters.

## Hardware Requirements

*   **FPGA Board:** Sipeed Tang Mega 138K Pro (or any FPGA with sufficient resources).
*   **Display:** An 800x480 parallel RGB LCD panel.
*   **System Clock:** An external 50 MHz clock source.

## Architecture

The driver is composed of three main logical blocks, instantiated and connected by a top-level wrapper.

#### `cp866_screen_drv.v` (Top-Level Wrapper)
This is the main module you will instantiate in your own projects. It encapsulates the entire driver, connecting the sub-modules and exposing a simple write interface to the outside world.

#### `screen_controller.v`
It generates all master timing signals, calculates addresses for the VRAM, and computes the local pixel coordinates for the font ROM. It then selects the final pixel color based on the output from the font ROM and drives the physical RGB signals.

#### `text_buffer.v`
This module is the Video RAM (VRAM) for the display. It is implemented as a **dual-port BRAM**:
*   **Read Port:** An asynchronous port used by the `screen_controller` to continuously read character codes for display.
*   **Write Port:** A synchronous port exposed via the top-level module, allowing external logic to update the screen content safely.

#### `font_rom.v`
This is the Character Generator ROM. It acts as a pixel decoder, taking a character code and a local (x, y) coordinate within a character cell and outputting a single bit (`pixel_on`) that determines if the pixel should be foreground or background color.

## How to Use

### Integration

To use this driver, instantiate the `cp866_screen_drv` module in your top-level design and connect its VRAM write interface to your control logic (e.g., a soft-core CPU's memory bus, a UART receiver, etc.).

### VRAM Write Interface

The driver exposes a simple synchronous write port to update the video memory. To write a character, provide the address and data, and assert `vram_wr_en` for one `clk` cycle.

| Port Name      | Width | Direction | Description                                       |
|----------------|-------|-----------|---------------------------------------------------|
| `clk`          | 1     | Input     | Main system clock (used as `wr_clk`).             |
| `vram_wr_en`   | 1     | Input     | Write Enable. Must be high for one `clk` cycle. |
| `vram_wr_addr` | 12    | Input     | Linear address of the character cell (0-3199).    |
| `vram_wr_data` | 8     | Input     | 8-bit CP866 character code to write.              |

**Address Calculation:**
The linear address for a given `(COLUMN, ROW)` coordinate can be calculated as:
`address = ROW * 80 + COLUMN;` (where ROW is 0-39 and COLUMN is 0-79).

**Example Usage (within another Verilog module):**
```verilog
// Example: Write the letter 'X' (8'h58) to row 5, column 10
// when a trigger signal 'do_write' goes high.

reg start_write_pulse = 0;
always @(posedge clk) begin
    start_write_pulse <= do_write; // Creates a single-cycle pulse
end

cp866_screen_drv my_screen_driver (
    .clk(clk),
    .rst_n(rst_n),
    // ... connect LCD outputs ...

    // Connect the write interface
    .vram_wr_en(start_write_pulse),
    .vram_wr_addr(5 * 80 + 10),
    .vram_wr_data(8'h58)
);
```

### Modifying the Initial Text

The text that appears on the screen at power-on is defined in the `initial` block of `src/text_buffer.v`. You can remove/edit this block to set a default or boot-up screen. Any text written via the VRAM interface will overwrite this initial content.

