`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2021 13:54:50
// Design Name: 
// Module Name: make_pipeline
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


module pipeline(
    input clk,
    input rst,
    
    input tvalid_mfcc_feat,
    input [31:0] mfcc_feat,
    
    output tvalid_prediction,
    output prediction
    );
    
    wire tvalid_transformed_sample;
    wire [31:0] transformed_sample;
    
    StandardScaler PreProc (
        .clk(clk),
        .reset(rst),
    
        .tvalid_mfcc_feat(tvalid_mfcc_feat),
        .mfcc_feat(mfcc_feat),
    
        .tvalid_transformed_sample(tvalid_transformed_sample),
        .transformed_sample(transformed_sample)
    );
    
    LinearSVC clf_SVM (
        .clk(clk),
        .reset(rst),
    
        .tvalid_scaled_feat(tvalid_transformed_sample),
        .scaled_feat(transformed_sample),
    
        .tvalid_prediction(tvalid_prediction),
        .prediction(prediction)
    );
    
endmodule
