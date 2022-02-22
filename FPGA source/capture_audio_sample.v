`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 13:30:09
// Design Name: 
// Module Name: capture_audio_sample
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module capture_audio_sample(
    // I2S audio interface:
    input bclk,
    input wclk,
    input d_audio,
    
    output tvalid_sample16,
    output [15:0] sample16
    );
    
    reg tvalid_audio_sample16   = 1'b0;
    reg [15:0] audio_sample16   = 16'b0;
    reg [4:0] cnt_audio_bits    = 0;
    
    always@ (negedge bclk) begin
        if (!wclk) begin // Right channel
            audio_sample16[0]       <= d_audio;
            audio_sample16[15:1]    <= audio_sample16[14:0];
            
            cnt_audio_bits <= cnt_audio_bits + 1;
            if (cnt_audio_bits == 15) begin
                tvalid_audio_sample16 <= 1'b1;
            end
        end
        else begin  // Left chennal -> not connected
            tvalid_audio_sample16   <= 1'b0;
            audio_sample16          <= 16'b0;
            cnt_audio_bits          <= 0;
        end
    end
    
    assign tvalid_sample16  = tvalid_audio_sample16;
    assign sample16         = tvalid_audio_sample16 ? audio_sample16 : 16'b0;
    
endmodule
