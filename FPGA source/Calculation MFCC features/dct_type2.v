`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.12.2020 11:39:11
// Design Name: 
// Module Name: dct_type2
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


module dct_type2(
    input clk,
    input rst,
    
    input tvalid_log_feat_filterbanks,
    input [31:0] log_feat_filterbanks,
    
    output reg tvalid_dct2_sample,
    output reg [31:0] dct2_sample
    );
    
    wire [31:0] dct_coefs1 [0:25];
    wire [31:0] dct_coefs2 [0:25];
    wire [31:0] dct_coefs3 [0:25];
    wire [31:0] dct_coefs4 [0:25];
    wire [31:0] dct_coefs5 [0:25];
    wire [31:0] dct_coefs6 [0:25];
    wire [31:0] dct_coefs7 [0:25];
    wire [31:0] dct_coefs8 [0:25];
    wire [31:0] dct_coefs9 [0:25];
    wire [31:0] dct_coefs10 [0:25];
    wire [31:0] dct_coefs11 [0:25];
    wire [31:0] dct_coefs12 [0:25];
    wire [31:0] dct_coefs13 [0:25];
    
    reg tvalid_log_feat_filterbanks_temp = 1'b0;
    reg [31:0] log_feat_filterbanks_temp;
    
    reg [0:12] tvalid_reg_coef_dct2;
    reg [31:0] reg1_coef_dct2;
    reg [31:0] reg2_coef_dct2;
    reg [31:0] reg3_coef_dct2;
    reg [31:0] reg4_coef_dct2;
    reg [31:0] reg5_coef_dct2;
    reg [31:0] reg6_coef_dct2;
    reg [31:0] reg7_coef_dct2;
    reg [31:0] reg8_coef_dct2;
    reg [31:0] reg9_coef_dct2;
    reg [31:0] reg10_coef_dct2;
    reg [31:0] reg11_coef_dct2;
    reg [31:0] reg12_coef_dct2;
    reg [31:0] reg13_coef_dct2;
    
    wire [0:12] tvalid_res_mult;
    wire [31:0] res_mult_1;
    wire [31:0] res_mult_2;
    wire [31:0] res_mult_3;
    wire [31:0] res_mult_4;
    wire [31:0] res_mult_5;
    wire [31:0] res_mult_6;
    wire [31:0] res_mult_7;
    wire [31:0] res_mult_8;
    wire [31:0] res_mult_9;
    wire [31:0] res_mult_10;
    wire [31:0] res_mult_11;
    wire [31:0] res_mult_12;
    wire [31:0] res_mult_13;
    
    wire [0:12] tvalid_res_add;
    wire [31:0] res_add_1;
    wire [31:0] res_add_2;
    wire [31:0] res_add_3;
    wire [31:0] res_add_4;
    wire [31:0] res_add_5;
    wire [31:0] res_add_6;
    wire [31:0] res_add_7;
    wire [31:0] res_add_8;
    wire [31:0] res_add_9;
    wire [31:0] res_add_10;
    wire [31:0] res_add_11;
    wire [31:0] res_add_12;
    wire [31:0] res_add_13;
    
    reg [0:12] tvalid_out_acc;
    reg [31:0] out_acc_1;
    reg [31:0] out_acc_2;
    reg [31:0] out_acc_3;
    reg [31:0] out_acc_4;
    reg [31:0] out_acc_5;
    reg [31:0] out_acc_6;
    reg [31:0] out_acc_7;
    reg [31:0] out_acc_8;
    reg [31:0] out_acc_9;
    reg [31:0] out_acc_10;
    reg [31:0] out_acc_11;
    reg [31:0] out_acc_12;
    reg [31:0] out_acc_13;
    
    reg [31:0] reg1_temp;
    reg [31:0] reg2_temp;
    reg [31:0] reg3_temp;
    reg [31:0] reg4_temp;
    reg [31:0] reg5_temp;
    reg [31:0] reg6_temp;
    reg [31:0] reg7_temp;
    reg [31:0] reg8_temp;
    reg [31:0] reg9_temp;
    reg [31:0] reg10_temp;
    reg [31:0] reg11_temp;
    reg [31:0] reg12_temp;
    reg [31:0] reg13_temp;
    
    reg [7:0] ind = 0;
    reg [3:0] cnt_feat = 0;
    reg [3:0] cnt_stop = 0;
    
    reg enable_transmit_result = 1'b0;
    
    assign dct_coefs1[0] = 32'h3f800000;
    assign dct_coefs1[1] = 32'h3f800000;
    assign dct_coefs1[2] = 32'h3f800000;
    assign dct_coefs1[3] = 32'h3f800000;
    assign dct_coefs1[4] = 32'h3f800000;
    assign dct_coefs1[5] = 32'h3f800000;
    assign dct_coefs1[6] = 32'h3f800000;
    assign dct_coefs1[7] = 32'h3f800000;
    assign dct_coefs1[8] = 32'h3f800000;
    assign dct_coefs1[9] = 32'h3f800000;
    assign dct_coefs1[10] = 32'h3f800000;
    assign dct_coefs1[11] = 32'h3f800000;
    assign dct_coefs1[12] = 32'h3f800000;
    assign dct_coefs1[13] = 32'h3f800000;
    assign dct_coefs1[14] = 32'h3f800000;
    assign dct_coefs1[15] = 32'h3f800000;
    assign dct_coefs1[16] = 32'h3f800000;
    assign dct_coefs1[17] = 32'h3f800000;
    assign dct_coefs1[18] = 32'h3f800000;
    assign dct_coefs1[19] = 32'h3f800000;
    assign dct_coefs1[20] = 32'h3f800000;
    assign dct_coefs1[21] = 32'h3f800000;
    assign dct_coefs1[22] = 32'h3f800000;
    assign dct_coefs1[23] = 32'h3f800000;
    assign dct_coefs1[24] = 32'h3f800000;
    assign dct_coefs1[25] = 32'h3f800000;
    assign dct_coefs2[0] = 32'h3f7f886f;
    assign dct_coefs2[1] = 32'h3f7bce84;
    assign dct_coefs2[2] = 32'h3f746896;
    assign dct_coefs2[3] = 32'h3f697245;
    assign dct_coefs2[4] = 32'h3f5b147b;
    assign dct_coefs2[5] = 32'h3f4984db;
    assign dct_coefs2[6] = 32'h3f3504f3;
    assign dct_coefs2[7] = 32'h3f1de14a;
    assign dct_coefs2[8] = 32'h3f047040;
    assign dct_coefs2[9] = 32'h3ed221a1;
    assign dct_coefs2[10] = 32'h3e985252;
    assign dct_coefs2[11] = 32'h3e3894c7;
    assign dct_coefs2[12] = 32'h3d774f71;
    assign dct_coefs2[13] = 32'hbd774f71;
    assign dct_coefs2[14] = 32'hbe3894c7;
    assign dct_coefs2[15] = 32'hbe985252;
    assign dct_coefs2[16] = 32'hbed221a1;
    assign dct_coefs2[17] = 32'hbf047040;
    assign dct_coefs2[18] = 32'hbf1de14a;
    assign dct_coefs2[19] = 32'hbf3504f3;
    assign dct_coefs2[20] = 32'hbf4984db;
    assign dct_coefs2[21] = 32'hbf5b147b;
    assign dct_coefs2[22] = 32'hbf697245;
    assign dct_coefs2[23] = 32'hbf746896;
    assign dct_coefs2[24] = 32'hbf7bce84;
    assign dct_coefs2[25] = 32'hbf7f886f;
    assign dct_coefs3[0] = 32'h3f7e222b;
    assign dct_coefs3[1] = 32'h3f6f5d39;
    assign dct_coefs3[2] = 32'h3f52af12;
    assign dct_coefs3[3] = 32'h3f29c268;
    assign dct_coefs3[4] = 32'h3eedf032;
    assign dct_coefs3[5] = 32'h3e750f2a;
    assign dct_coefs3[6] = 32'ha5396767;
    assign dct_coefs3[7] = 32'hbe750f2a;
    assign dct_coefs3[8] = 32'hbeedf032;
    assign dct_coefs3[9] = 32'hbf29c268;
    assign dct_coefs3[10] = 32'hbf52af12;
    assign dct_coefs3[11] = 32'hbf6f5d39;
    assign dct_coefs3[12] = 32'hbf7e222b;
    assign dct_coefs3[13] = 32'hbf7e222b;
    assign dct_coefs3[14] = 32'hbf6f5d39;
    assign dct_coefs3[15] = 32'hbf52af12;
    assign dct_coefs3[16] = 32'hbf29c268;
    assign dct_coefs3[17] = 32'hbeedf032;
    assign dct_coefs3[18] = 32'hbe750f2a;
    assign dct_coefs3[19] = 32'ha553c9ca;
    assign dct_coefs3[20] = 32'h3e750f2a;
    assign dct_coefs3[21] = 32'h3eedf032;
    assign dct_coefs3[22] = 32'h3f29c268;
    assign dct_coefs3[23] = 32'h3f52af12;
    assign dct_coefs3[24] = 32'h3f6f5d39;
    assign dct_coefs3[25] = 32'h3f7e222b;
    assign dct_coefs4[0] = 32'h3f7bce84;
    assign dct_coefs4[1] = 32'h3f5b147b;
    assign dct_coefs4[2] = 32'h3f1de14a;
    assign dct_coefs4[3] = 32'h3e985252;
    assign dct_coefs4[4] = 32'hbd774f71;
    assign dct_coefs4[5] = 32'hbed221a1;
    assign dct_coefs4[6] = 32'hbf3504f3;
    assign dct_coefs4[7] = 32'hbf697245;
    assign dct_coefs4[8] = 32'hbf7f886f;
    assign dct_coefs4[9] = 32'hbf746896;
    assign dct_coefs4[10] = 32'hbf4984db;
    assign dct_coefs4[11] = 32'hbf047040;
    assign dct_coefs4[12] = 32'hbe3894c7;
    assign dct_coefs4[13] = 32'h3e3894c7;
    assign dct_coefs4[14] = 32'h3f047040;
    assign dct_coefs4[15] = 32'h3f4984db;
    assign dct_coefs4[16] = 32'h3f746896;
    assign dct_coefs4[17] = 32'h3f7f886f;
    assign dct_coefs4[18] = 32'h3f697245;
    assign dct_coefs4[19] = 32'h3f3504f3;
    assign dct_coefs4[20] = 32'h3ed221a1;
    assign dct_coefs4[21] = 32'h3d774f71;
    assign dct_coefs4[22] = 32'hbe985252;
    assign dct_coefs4[23] = 32'hbf1de14a;
    assign dct_coefs4[24] = 32'hbf5b147b;
    assign dct_coefs4[25] = 32'hbf7bce84;
    assign dct_coefs5[0] = 32'h3f788fa5;
    assign dct_coefs5[1] = 32'h3f3f9e67;
    assign dct_coefs5[2] = 32'h3eb58ec6;
    assign dct_coefs5[3] = 32'hbdf6dbef;
    assign dct_coefs5[4] = 32'hbf116cb1;
    assign dct_coefs5[5] = 32'hbf62ad3f;
    assign dct_coefs5[6] = 32'hbf800000;
    assign dct_coefs5[7] = 32'hbf62ad3f;
    assign dct_coefs5[8] = 32'hbf116cb1;
    assign dct_coefs5[9] = 32'hbdf6dbef;
    assign dct_coefs5[10] = 32'h3eb58ec6;
    assign dct_coefs5[11] = 32'h3f3f9e67;
    assign dct_coefs5[12] = 32'h3f788fa5;
    assign dct_coefs5[13] = 32'h3f788fa5;
    assign dct_coefs5[14] = 32'h3f3f9e67;
    assign dct_coefs5[15] = 32'h3eb58ec6;
    assign dct_coefs5[16] = 32'hbdf6dbef;
    assign dct_coefs5[17] = 32'hbf116cb1;
    assign dct_coefs5[18] = 32'hbf62ad3f;
    assign dct_coefs5[19] = 32'hbf800000;
    assign dct_coefs5[20] = 32'hbf62ad3f;
    assign dct_coefs5[21] = 32'hbf116cb1;
    assign dct_coefs5[22] = 32'hbdf6dbef;
    assign dct_coefs5[23] = 32'h3eb58ec6;
    assign dct_coefs5[24] = 32'h3f3f9e67;
    assign dct_coefs5[25] = 32'h3f788fa5;
    assign dct_coefs6[0] = 32'h3f746896;
    assign dct_coefs6[1] = 32'h3f1de14a;
    assign dct_coefs6[2] = 32'h3d774f71;
    assign dct_coefs6[3] = 32'hbf047040;
    assign dct_coefs6[4] = 32'hbf697245;
    assign dct_coefs6[5] = 32'hbf7bce84;
    assign dct_coefs6[6] = 32'hbf3504f3;
    assign dct_coefs6[7] = 32'hbe3894c7;
    assign dct_coefs6[8] = 32'h3ed221a1;
    assign dct_coefs6[9] = 32'h3f5b147b;
    assign dct_coefs6[10] = 32'h3f7f886f;
    assign dct_coefs6[11] = 32'h3f4984db;
    assign dct_coefs6[12] = 32'h3e985252;
    assign dct_coefs6[13] = 32'hbe985252;
    assign dct_coefs6[14] = 32'hbf4984db;
    assign dct_coefs6[15] = 32'hbf7f886f;
    assign dct_coefs6[16] = 32'hbf5b147b;
    assign dct_coefs6[17] = 32'hbed221a1;
    assign dct_coefs6[18] = 32'h3e3894c7;
    assign dct_coefs6[19] = 32'h3f3504f3;
    assign dct_coefs6[20] = 32'h3f7bce84;
    assign dct_coefs6[21] = 32'h3f697245;
    assign dct_coefs6[22] = 32'h3f047040;
    assign dct_coefs6[23] = 32'hbd774f71;
    assign dct_coefs6[24] = 32'hbf1de14a;
    assign dct_coefs6[25] = 32'hbf746896;
    assign dct_coefs7[0] = 32'h3f6f5d39;
    assign dct_coefs7[1] = 32'h3eedf032;
    assign dct_coefs7[2] = 32'hbe750f2a;
    assign dct_coefs7[3] = 32'hbf52af12;
    assign dct_coefs7[4] = 32'hbf7e222b;
    assign dct_coefs7[5] = 32'hbf29c268;
    assign dct_coefs7[6] = 32'ha553c9ca;
    assign dct_coefs7[7] = 32'h3f29c268;
    assign dct_coefs7[8] = 32'h3f7e222b;
    assign dct_coefs7[9] = 32'h3f52af12;
    assign dct_coefs7[10] = 32'h3e750f2a;
    assign dct_coefs7[11] = 32'hbeedf032;
    assign dct_coefs7[12] = 32'hbf6f5d39;
    assign dct_coefs7[13] = 32'hbf6f5d39;
    assign dct_coefs7[14] = 32'hbeedf032;
    assign dct_coefs7[15] = 32'h3e750f2a;
    assign dct_coefs7[16] = 32'h3f52af12;
    assign dct_coefs7[17] = 32'h3f7e222b;
    assign dct_coefs7[18] = 32'h3f29c268;
    assign dct_coefs7[19] = 32'h261ed758;
    assign dct_coefs7[20] = 32'hbf29c268;
    assign dct_coefs7[21] = 32'hbf7e222b;
    assign dct_coefs7[22] = 32'hbf52af12;
    assign dct_coefs7[23] = 32'hbe750f2a;
    assign dct_coefs7[24] = 32'h3eedf032;
    assign dct_coefs7[25] = 32'h3f6f5d39;
    assign dct_coefs8[0] = 32'h3f697245;
    assign dct_coefs8[1] = 32'h3e985252;
    assign dct_coefs8[2] = 32'hbf047040;
    assign dct_coefs8[3] = 32'hbf7bce84;
    assign dct_coefs8[4] = 32'hbf4984db;
    assign dct_coefs8[5] = 32'hbd774f71;
    assign dct_coefs8[6] = 32'h3f3504f3;
    assign dct_coefs8[7] = 32'h3f7f886f;
    assign dct_coefs8[8] = 32'h3f1de14a;
    assign dct_coefs8[9] = 32'hbe3894c7;
    assign dct_coefs8[10] = 32'hbf5b147b;
    assign dct_coefs8[11] = 32'hbf746896;
    assign dct_coefs8[12] = 32'hbed221a1;
    assign dct_coefs8[13] = 32'h3ed221a1;
    assign dct_coefs8[14] = 32'h3f746896;
    assign dct_coefs8[15] = 32'h3f5b147b;
    assign dct_coefs8[16] = 32'h3e3894c7;
    assign dct_coefs8[17] = 32'hbf1de14a;
    assign dct_coefs8[18] = 32'hbf7f886f;
    assign dct_coefs8[19] = 32'hbf3504f3;
    assign dct_coefs8[20] = 32'h3d774f71;
    assign dct_coefs8[21] = 32'h3f4984db;
    assign dct_coefs8[22] = 32'h3f7bce84;
    assign dct_coefs8[23] = 32'h3f047040;
    assign dct_coefs8[24] = 32'hbe985252;
    assign dct_coefs8[25] = 32'hbf697245;
    assign dct_coefs9[0] = 32'h3f62ad3f;
    assign dct_coefs9[1] = 32'h3df6dbef;
    assign dct_coefs9[2] = 32'hbf3f9e67;
    assign dct_coefs9[3] = 32'hbf788fa5;
    assign dct_coefs9[4] = 32'hbeb58ec6;
    assign dct_coefs9[5] = 32'h3f116cb1;
    assign dct_coefs9[6] = 32'h3f800000;
    assign dct_coefs9[7] = 32'h3f116cb1;
    assign dct_coefs9[8] = 32'hbeb58ec6;
    assign dct_coefs9[9] = 32'hbf788fa5;
    assign dct_coefs9[10] = 32'hbf3f9e67;
    assign dct_coefs9[11] = 32'h3df6dbef;
    assign dct_coefs9[12] = 32'h3f62ad3f;
    assign dct_coefs9[13] = 32'h3f62ad3f;
    assign dct_coefs9[14] = 32'h3df6dbef;
    assign dct_coefs9[15] = 32'hbf3f9e67;
    assign dct_coefs9[16] = 32'hbf788fa5;
    assign dct_coefs9[17] = 32'hbeb58ec6;
    assign dct_coefs9[18] = 32'h3f116cb1;
    assign dct_coefs9[19] = 32'h3f800000;
    assign dct_coefs9[20] = 32'h3f116cb1;
    assign dct_coefs9[21] = 32'hbeb58ec6;
    assign dct_coefs9[22] = 32'hbf788fa5;
    assign dct_coefs9[23] = 32'hbf3f9e67;
    assign dct_coefs9[24] = 32'h3df6dbef;
    assign dct_coefs9[25] = 32'h3f62ad3f;
    assign dct_coefs10[0] = 32'h3f5b147b;
    assign dct_coefs10[1] = 32'hbd774f71;
    assign dct_coefs10[2] = 32'hbf697245;
    assign dct_coefs10[3] = 32'hbf4984db;
    assign dct_coefs10[4] = 32'h3e3894c7;
    assign dct_coefs10[5] = 32'h3f746896;
    assign dct_coefs10[6] = 32'h3f3504f3;
    assign dct_coefs10[7] = 32'hbe985252;
    assign dct_coefs10[8] = 32'hbf7bce84;
    assign dct_coefs10[9] = 32'hbf1de14a;
    assign dct_coefs10[10] = 32'h3ed221a1;
    assign dct_coefs10[11] = 32'h3f7f886f;
    assign dct_coefs10[12] = 32'h3f047040;
    assign dct_coefs10[13] = 32'hbf047040;
    assign dct_coefs10[14] = 32'hbf7f886f;
    assign dct_coefs10[15] = 32'hbed221a1;
    assign dct_coefs10[16] = 32'h3f1de14a;
    assign dct_coefs10[17] = 32'h3f7bce84;
    assign dct_coefs10[18] = 32'h3e985252;
    assign dct_coefs10[19] = 32'hbf3504f3;
    assign dct_coefs10[20] = 32'hbf746896;
    assign dct_coefs10[21] = 32'hbe3894c7;
    assign dct_coefs10[22] = 32'h3f4984db;
    assign dct_coefs10[23] = 32'h3f697245;
    assign dct_coefs10[24] = 32'h3d774f71;
    assign dct_coefs10[25] = 32'hbf5b147b;
    assign dct_coefs11[0] = 32'h3f52af12;
    assign dct_coefs11[1] = 32'hbe750f2a;
    assign dct_coefs11[2] = 32'hbf7e222b;
    assign dct_coefs11[3] = 32'hbeedf032;
    assign dct_coefs11[4] = 32'h3f29c268;
    assign dct_coefs11[5] = 32'h3f6f5d39;
    assign dct_coefs11[6] = 32'h25b07d7e;
    assign dct_coefs11[7] = 32'hbf6f5d39;
    assign dct_coefs11[8] = 32'hbf29c268;
    assign dct_coefs11[9] = 32'h3eedf032;
    assign dct_coefs11[10] = 32'h3f7e222b;
    assign dct_coefs11[11] = 32'h3e750f2a;
    assign dct_coefs11[12] = 32'hbf52af12;
    assign dct_coefs11[13] = 32'hbf52af12;
    assign dct_coefs11[14] = 32'h3e750f2a;
    assign dct_coefs11[15] = 32'h3f7e222b;
    assign dct_coefs11[16] = 32'h3eedf032;
    assign dct_coefs11[17] = 32'hbf29c268;
    assign dct_coefs11[18] = 32'hbf6f5d39;
    assign dct_coefs11[19] = 32'ha7422f0f;
    assign dct_coefs11[20] = 32'h3f6f5d39;
    assign dct_coefs11[21] = 32'h3f29c268;
    assign dct_coefs11[22] = 32'hbeedf032;
    assign dct_coefs11[23] = 32'hbf7e222b;
    assign dct_coefs11[24] = 32'hbe750f2a;
    assign dct_coefs11[25] = 32'h3f52af12;
    assign dct_coefs12[0] = 32'h3f4984db;
    assign dct_coefs12[1] = 32'hbed221a1;
    assign dct_coefs12[2] = 32'hbf7bce84;
    assign dct_coefs12[3] = 32'hbd774f71;
    assign dct_coefs12[4] = 32'h3f746896;
    assign dct_coefs12[5] = 32'h3f047040;
    assign dct_coefs12[6] = 32'hbf3504f3;
    assign dct_coefs12[7] = 32'hbf5b147b;
    assign dct_coefs12[8] = 32'h3e985252;
    assign dct_coefs12[9] = 32'h3f7f886f;
    assign dct_coefs12[10] = 32'h3e3894c7;
    assign dct_coefs12[11] = 32'hbf697245;
    assign dct_coefs12[12] = 32'hbf1de14a;
    assign dct_coefs12[13] = 32'h3f1de14a;
    assign dct_coefs12[14] = 32'h3f697245;
    assign dct_coefs12[15] = 32'hbe3894c7;
    assign dct_coefs12[16] = 32'hbf7f886f;
    assign dct_coefs12[17] = 32'hbe985252;
    assign dct_coefs12[18] = 32'h3f5b147b;
    assign dct_coefs12[19] = 32'h3f3504f3;
    assign dct_coefs12[20] = 32'hbf047040;
    assign dct_coefs12[21] = 32'hbf746896;
    assign dct_coefs12[22] = 32'h3d774f71;
    assign dct_coefs12[23] = 32'h3f7bce84;
    assign dct_coefs12[24] = 32'h3ed221a1;
    assign dct_coefs12[25] = 32'hbf4984db;
    assign dct_coefs13[0] = 32'h3f3f9e67;
    assign dct_coefs13[1] = 32'hbf116cb1;
    assign dct_coefs13[2] = 32'hbf62ad3f;
    assign dct_coefs13[3] = 32'h3eb58ec6;
    assign dct_coefs13[4] = 32'h3f788fa5;
    assign dct_coefs13[5] = 32'hbdf6dbef;
    assign dct_coefs13[6] = 32'hbf800000;
    assign dct_coefs13[7] = 32'hbdf6dbef;
    assign dct_coefs13[8] = 32'h3f788fa5;
    assign dct_coefs13[9] = 32'h3eb58ec6;
    assign dct_coefs13[10] = 32'hbf62ad3f;
    assign dct_coefs13[11] = 32'hbf116cb1;
    assign dct_coefs13[12] = 32'h3f3f9e67;
    assign dct_coefs13[13] = 32'h3f3f9e67;
    assign dct_coefs13[14] = 32'hbf116cb1;
    assign dct_coefs13[15] = 32'hbf62ad3f;
    assign dct_coefs13[16] = 32'h3eb58ec6;
    assign dct_coefs13[17] = 32'h3f788fa5;
    assign dct_coefs13[18] = 32'hbdf6dbef;
    assign dct_coefs13[19] = 32'hbf800000;
    assign dct_coefs13[20] = 32'hbdf6dbef;
    assign dct_coefs13[21] = 32'h3f788fa5;
    assign dct_coefs13[22] = 32'h3eb58ec6;
    assign dct_coefs13[23] = 32'hbf62ad3f;
    assign dct_coefs13[24] = 32'hbf116cb1;
    assign dct_coefs13[25] = 32'h3f3f9e67;
    
    floating_point_mult_non_blocking m1_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[0]),
        .s_axis_b_tdata(reg1_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[0]),
        .m_axis_result_tdata(res_mult_1)
    );
    
    floating_point_mult_non_blocking m2_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[1]),
        .s_axis_b_tdata(reg2_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[1]),
        .m_axis_result_tdata(res_mult_2)
    );
    
    floating_point_mult_non_blocking m3_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[2]),
        .s_axis_b_tdata(reg3_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[2]),
        .m_axis_result_tdata(res_mult_3)
    );
    
    floating_point_mult_non_blocking m4_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[3]),
        .s_axis_b_tdata(reg4_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[3]),
        .m_axis_result_tdata(res_mult_4)
    );
    
    floating_point_mult_non_blocking m5_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[4]),
        .s_axis_b_tdata(reg5_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[4]),
        .m_axis_result_tdata(res_mult_5)
    );
    
    floating_point_mult_non_blocking m6_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[5]),
        .s_axis_b_tdata(reg6_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[5]),
        .m_axis_result_tdata(res_mult_6)
    );
    
    floating_point_mult_non_blocking m7_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[6]),
        .s_axis_b_tdata(reg7_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[6]),
        .m_axis_result_tdata(res_mult_7)
    );
    
    floating_point_mult_non_blocking m8_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[7]),
        .s_axis_b_tdata(reg8_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[7]),
        .m_axis_result_tdata(res_mult_8)
    );
    
    floating_point_mult_non_blocking m9_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[8]),
        .s_axis_b_tdata(reg9_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[8]),
        .m_axis_result_tdata(res_mult_9)
    );
    
    floating_point_mult_non_blocking m10_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[9]),
        .s_axis_b_tdata(reg10_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[9]),
        .m_axis_result_tdata(res_mult_10)
    );
    
    floating_point_mult_non_blocking m11_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[10]),
        .s_axis_b_tdata(reg11_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[10]),
        .m_axis_result_tdata(res_mult_11)
    );
    
    floating_point_mult_non_blocking m12_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[11]),
        .s_axis_b_tdata(reg12_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[11]),
        .m_axis_result_tdata(res_mult_12)
    );
    
    floating_point_mult_non_blocking m13_mult (
        .s_axis_a_tvalid(tvalid_log_feat_filterbanks),
        .s_axis_a_tdata(log_feat_filterbanks_temp),
        .s_axis_b_tvalid(tvalid_reg_coef_dct2[12]),
        .s_axis_b_tdata(reg13_coef_dct2),
        .m_axis_result_tvalid(tvalid_res_mult[12]),
        .m_axis_result_tdata(res_mult_13)
    );
    
    floating_point_add_non_blocking m1_add (
        .s_axis_a_tvalid(tvalid_res_mult[0]),
        .s_axis_a_tdata(res_mult_1),
        .s_axis_b_tvalid(tvalid_out_acc[0]),
        .s_axis_b_tdata(out_acc_1),
        .m_axis_result_tvalid(tvalid_res_add[0]),
        .m_axis_result_tdata(res_add_1)
    );
    
    floating_point_add_non_blocking m2_add (
        .s_axis_a_tvalid(tvalid_res_mult[1]),
        .s_axis_a_tdata(res_mult_2),
        .s_axis_b_tvalid(tvalid_out_acc[1]),
        .s_axis_b_tdata(out_acc_2),
        .m_axis_result_tvalid(tvalid_res_add[1]),
        .m_axis_result_tdata(res_add_2)
    );
    
    floating_point_add_non_blocking m3_add (
        .s_axis_a_tvalid(tvalid_res_mult[2]),
        .s_axis_a_tdata(res_mult_3),
        .s_axis_b_tvalid(tvalid_out_acc[2]),
        .s_axis_b_tdata(out_acc_3),
        .m_axis_result_tvalid(tvalid_res_add[2]),
        .m_axis_result_tdata(res_add_3)
    );
    
    floating_point_add_non_blocking m4_add (
        .s_axis_a_tvalid(tvalid_res_mult[3]),
        .s_axis_a_tdata(res_mult_4),
        .s_axis_b_tvalid(tvalid_out_acc[3]),
        .s_axis_b_tdata(out_acc_4),
        .m_axis_result_tvalid(tvalid_res_add[3]),
        .m_axis_result_tdata(res_add_4)
    );
    
    floating_point_add_non_blocking m5_add (
        .s_axis_a_tvalid(tvalid_res_mult[4]),
        .s_axis_a_tdata(res_mult_5),
        .s_axis_b_tvalid(tvalid_out_acc[4]),
        .s_axis_b_tdata(out_acc_5),
        .m_axis_result_tvalid(tvalid_res_add[4]),
        .m_axis_result_tdata(res_add_5)
    );
    
    floating_point_add_non_blocking m6_add (
        .s_axis_a_tvalid(tvalid_res_mult[5]),
        .s_axis_a_tdata(res_mult_6),
        .s_axis_b_tvalid(tvalid_out_acc[5]),
        .s_axis_b_tdata(out_acc_6),
        .m_axis_result_tvalid(tvalid_res_add[5]),
        .m_axis_result_tdata(res_add_6)
    );
    
    floating_point_add_non_blocking m7_add (
        .s_axis_a_tvalid(tvalid_res_mult[6]),
        .s_axis_a_tdata(res_mult_7),
        .s_axis_b_tvalid(tvalid_out_acc[6]),
        .s_axis_b_tdata(out_acc_7),
        .m_axis_result_tvalid(tvalid_res_add[6]),
        .m_axis_result_tdata(res_add_7)
    );
    
    floating_point_add_non_blocking m8_add (
        .s_axis_a_tvalid(tvalid_res_mult[7]),
        .s_axis_a_tdata(res_mult_8),
        .s_axis_b_tvalid(tvalid_out_acc[7]),
        .s_axis_b_tdata(out_acc_8),
        .m_axis_result_tvalid(tvalid_res_add[7]),
        .m_axis_result_tdata(res_add_8)
    );
    
    floating_point_add_non_blocking m9_add (
        .s_axis_a_tvalid(tvalid_res_mult[8]),
        .s_axis_a_tdata(res_mult_9),
        .s_axis_b_tvalid(tvalid_out_acc[8]),
        .s_axis_b_tdata(out_acc_9),
        .m_axis_result_tvalid(tvalid_res_add[8]),
        .m_axis_result_tdata(res_add_9)
    );
    
    floating_point_add_non_blocking m10_add (
        .s_axis_a_tvalid(tvalid_res_mult[9]),
        .s_axis_a_tdata(res_mult_10),
        .s_axis_b_tvalid(tvalid_out_acc[9]),
        .s_axis_b_tdata(out_acc_10),
        .m_axis_result_tvalid(tvalid_res_add[9]),
        .m_axis_result_tdata(res_add_10)
    );
    
    floating_point_add_non_blocking m11_add (
        .s_axis_a_tvalid(tvalid_res_mult[10]),
        .s_axis_a_tdata(res_mult_11),
        .s_axis_b_tvalid(tvalid_out_acc[10]),
        .s_axis_b_tdata(out_acc_11),
        .m_axis_result_tvalid(tvalid_res_add[10]),
        .m_axis_result_tdata(res_add_11)
    );
    
    floating_point_add_non_blocking m12_add (
        .s_axis_a_tvalid(tvalid_res_mult[11]),
        .s_axis_a_tdata(res_mult_12),
        .s_axis_b_tvalid(tvalid_out_acc[11]),
        .s_axis_b_tdata(out_acc_12),
        .m_axis_result_tvalid(tvalid_res_add[11]),
        .m_axis_result_tdata(res_add_12)
    );
    
    floating_point_add_non_blocking m13_add (
        .s_axis_a_tvalid(tvalid_res_mult[12]),
        .s_axis_a_tdata(res_mult_13),
        .s_axis_b_tvalid(tvalid_out_acc[12]),
        .s_axis_b_tdata(out_acc_13),
        .m_axis_result_tvalid(tvalid_res_add[12]),
        .m_axis_result_tdata(res_add_13)
    );
    
    always@(posedge clk) begin
    
        log_feat_filterbanks_temp <= log_feat_filterbanks;
        tvalid_log_feat_filterbanks_temp <= tvalid_log_feat_filterbanks;
        
        if (tvalid_log_feat_filterbanks || enable_transmit_result) begin
            tvalid_reg_coef_dct2 <= 13'b1111111111111;
            reg1_coef_dct2 <= dct_coefs1[ind];
            reg2_coef_dct2 <= dct_coefs2[ind];
            reg3_coef_dct2 <= dct_coefs3[ind];
            reg4_coef_dct2 <= dct_coefs4[ind];
            reg5_coef_dct2 <= dct_coefs5[ind];
            reg6_coef_dct2 <= dct_coefs6[ind];
            reg7_coef_dct2 <= dct_coefs7[ind];
            reg8_coef_dct2 <= dct_coefs8[ind];
            reg9_coef_dct2 <= dct_coefs9[ind];
            reg10_coef_dct2 <= dct_coefs10[ind];
            reg11_coef_dct2 <= dct_coefs11[ind];
            reg12_coef_dct2 <= dct_coefs12[ind];
            reg13_coef_dct2 <= dct_coefs13[ind];
            
            
            out_acc_1 <= res_add_1;
            out_acc_2 <= res_add_2;
            out_acc_3 <= res_add_3;
            out_acc_4 <= res_add_4;
            out_acc_5 <= res_add_5;
            out_acc_6 <= res_add_6;
            out_acc_7 <= res_add_7;
            out_acc_8 <= res_add_8;
            out_acc_9 <= res_add_9;
            out_acc_10 <= res_add_10;
            out_acc_11 <= res_add_11;
            out_acc_12 <= res_add_12;
            out_acc_13 <= res_add_13;
            
            
            ind <= ind + 1;
            cnt_stop <= cnt_stop + 1;
            
            if (tvalid_log_feat_filterbanks) begin
                enable_transmit_result <= 1'b1;
            end
            else begin
                enable_transmit_result <= 1'b0;
            end
            
        end
        else begin
        
            tvalid_reg_coef_dct2 <= 13'b0000000000000;
            reg1_coef_dct2 <= 32'h00000000;
            reg2_coef_dct2 <= 32'h00000000;
            reg3_coef_dct2 <= 32'h00000000;
            reg4_coef_dct2 <= 32'h00000000;
            reg5_coef_dct2 <= 32'h00000000;
            reg6_coef_dct2 <= 32'h00000000;
            reg7_coef_dct2 <= 32'h00000000;
            reg8_coef_dct2 <= 32'h00000000;
            reg9_coef_dct2 <= 32'h00000000;
            reg10_coef_dct2 <= 32'h00000000;
            reg11_coef_dct2 <= 32'h00000000;
            reg12_coef_dct2 <= 32'h00000000;
            reg13_coef_dct2 <= 32'h00000000;
            
            
            out_acc_1 <= 32'h00000000;
            out_acc_2 <= 32'h00000000;
            out_acc_3 <= 32'h00000000;
            out_acc_4 <= 32'h00000000;
            out_acc_5 <= 32'h00000000;
            out_acc_6 <= 32'h00000000;
            out_acc_7 <= 32'h00000000;
            out_acc_8 <= 32'h00000000;
            out_acc_9 <= 32'h00000000;
            out_acc_10 <= 32'h00000000;
            out_acc_11 <= 32'h00000000;
            out_acc_12 <= 32'h00000000;
            out_acc_13 <= 32'h00000000;
            
            ind <= 0;
            cnt_stop <= 0;
            
        end
        
        tvalid_out_acc <= tvalid_res_mult;
        
        if (!enable_transmit_result) begin
            if (cnt_feat < 14) begin
                cnt_feat <= cnt_feat + 1;
                if (cnt_feat == 1) begin
                    dct2_sample <= reg1_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 2) begin
                    dct2_sample <= reg2_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 3) begin
                    dct2_sample <= reg3_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 4) begin
                    dct2_sample <= reg4_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 5) begin
                    dct2_sample <= reg5_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 6) begin
                    dct2_sample <= reg6_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 7) begin
                    dct2_sample <= reg7_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 8) begin
                    dct2_sample <= reg8_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 9) begin
                    dct2_sample <= reg9_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 10) begin
                    dct2_sample <= reg10_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 11) begin
                    dct2_sample <= reg11_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 12) begin
                    dct2_sample <= reg12_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
                else if (cnt_feat == 13) begin
                    dct2_sample <= reg13_temp;
                    tvalid_dct2_sample <= 1'b1;
                end
            end
            else begin
                dct2_sample <= 32'h00000000;
                tvalid_dct2_sample <= 1'b0;
            end
        end
        else begin
            cnt_feat <= 0;
        end
    
    end
    
    always@(negedge enable_transmit_result) begin
    
        reg1_temp <= out_acc_1;
        reg2_temp <= out_acc_2;
        reg3_temp <= out_acc_3;
        reg4_temp <= out_acc_4;
        reg5_temp <= out_acc_5;
        reg6_temp <= out_acc_6;
        reg7_temp <= out_acc_7;
        reg8_temp <= out_acc_8;
        reg9_temp <= out_acc_9;
        reg10_temp <= out_acc_10;
        reg11_temp <= out_acc_11;
        reg12_temp <= out_acc_12;
        reg13_temp <= out_acc_13;
        
    end
    
endmodule
