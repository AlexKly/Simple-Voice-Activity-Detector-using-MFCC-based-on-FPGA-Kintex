`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2020 15:29:32
// Design Name: 
// Module Name: windowing
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


module windowing(
    input clk,
    input rst,
    input tvalid_stream,
    input [31:0] stream,
    
    output tready_hamm_stream,
    output [31:0] hamm_stream
    );
    
    localparam win_length = 512;
    reg [8:0] ind = 0;
    
    wire [31:0] hamming_win_coeffs [0:511];
    reg [31:0] reg_coeffs = 32'b0;
    reg tvalid_reg_coeffs = 1'b0;
    
    reg [31:0] stream_temp = 32'b0;
    reg tvalid_stream_temp = 1'b0;
    
    assign hamming_win_coeffs[0] = 32'h3da3d70a;
    assign hamming_win_coeffs[1] = 32'h3da3e945;
    assign hamming_win_coeffs[2] = 32'h3da41ff6;
    assign hamming_win_coeffs[3] = 32'h3da47b1a;
    assign hamming_win_coeffs[4] = 32'h3da4faae;
    assign hamming_win_coeffs[5] = 32'h3da59ead;
    assign hamming_win_coeffs[6] = 32'h3da66711;
    assign hamming_win_coeffs[7] = 32'h3da753d1;
    assign hamming_win_coeffs[8] = 32'h3da864e6;
    assign hamming_win_coeffs[9] = 32'h3da99a43;
    assign hamming_win_coeffs[10] = 32'h3daaf3de;
    assign hamming_win_coeffs[11] = 32'h3dac71a8;
    assign hamming_win_coeffs[12] = 32'h3dae1393;
    assign hamming_win_coeffs[13] = 32'h3dafd990;
    assign hamming_win_coeffs[14] = 32'h3db1c38b;
    assign hamming_win_coeffs[15] = 32'h3db3d173;
    assign hamming_win_coeffs[16] = 32'h3db60333;
    assign hamming_win_coeffs[17] = 32'h3db858b5;
    assign hamming_win_coeffs[18] = 32'h3dbad1e2;
    assign hamming_win_coeffs[19] = 32'h3dbd6ea1;
    assign hamming_win_coeffs[20] = 32'h3dc02eda;
    assign hamming_win_coeffs[21] = 32'h3dc3126f;
    assign hamming_win_coeffs[22] = 32'h3dc61946;
    assign hamming_win_coeffs[23] = 32'h3dc9433f;
    assign hamming_win_coeffs[24] = 32'h3dcc903c;
    assign hamming_win_coeffs[25] = 32'h3dd0001c;
    assign hamming_win_coeffs[26] = 32'h3dd392bc;
    assign hamming_win_coeffs[27] = 32'h3dd747fa;
    assign hamming_win_coeffs[28] = 32'h3ddb1fb0;
    assign hamming_win_coeffs[29] = 32'h3ddf19b9;
    assign hamming_win_coeffs[30] = 32'h3de335ed;
    assign hamming_win_coeffs[31] = 32'h3de77423;
    assign hamming_win_coeffs[32] = 32'h3debd432;
    assign hamming_win_coeffs[33] = 32'h3df055ed;
    assign hamming_win_coeffs[34] = 32'h3df4f929;
    assign hamming_win_coeffs[35] = 32'h3df9bdb7;
    assign hamming_win_coeffs[36] = 32'h3dfea369;
    assign hamming_win_coeffs[37] = 32'h3e01d506;
    assign hamming_win_coeffs[38] = 32'h3e0468b9;
    assign hamming_win_coeffs[39] = 32'h3e070cb2;
    assign hamming_win_coeffs[40] = 32'h3e09c0d8;
    assign hamming_win_coeffs[41] = 32'h3e0c8510;
    assign hamming_win_coeffs[42] = 32'h3e0f593f;
    assign hamming_win_coeffs[43] = 32'h3e123d48;
    assign hamming_win_coeffs[44] = 32'h3e15310f;
    assign hamming_win_coeffs[45] = 32'h3e183476;
    assign hamming_win_coeffs[46] = 32'h3e1b4760;
    assign hamming_win_coeffs[47] = 32'h3e1e69af;
    assign hamming_win_coeffs[48] = 32'h3e219b42;
    assign hamming_win_coeffs[49] = 32'h3e24dbfc;
    assign hamming_win_coeffs[50] = 32'h3e282bba;
    assign hamming_win_coeffs[51] = 32'h3e2b8a5d;
    assign hamming_win_coeffs[52] = 32'h3e2ef7c4;
    assign hamming_win_coeffs[53] = 32'h3e3273cb;
    assign hamming_win_coeffs[54] = 32'h3e35fe51;
    assign hamming_win_coeffs[55] = 32'h3e399733;
    assign hamming_win_coeffs[56] = 32'h3e3d3e4d;
    assign hamming_win_coeffs[57] = 32'h3e40f37b;
    assign hamming_win_coeffs[58] = 32'h3e44b697;
    assign hamming_win_coeffs[59] = 32'h3e48877d;
    assign hamming_win_coeffs[60] = 32'h3e4c6608;
    assign hamming_win_coeffs[61] = 32'h3e50520f;
    assign hamming_win_coeffs[62] = 32'h3e544b6e;
    assign hamming_win_coeffs[63] = 32'h3e5851fc;
    assign hamming_win_coeffs[64] = 32'h3e5c6591;
    assign hamming_win_coeffs[65] = 32'h3e608606;
    assign hamming_win_coeffs[66] = 32'h3e64b330;
    assign hamming_win_coeffs[67] = 32'h3e68ece8;
    assign hamming_win_coeffs[68] = 32'h3e6d3302;
    assign hamming_win_coeffs[69] = 32'h3e718555;
    assign hamming_win_coeffs[70] = 32'h3e75e3b6;
    assign hamming_win_coeffs[71] = 32'h3e7a4df9;
    assign hamming_win_coeffs[72] = 32'h3e7ec3f3;
    assign hamming_win_coeffs[73] = 32'h3e81a2bc;
    assign hamming_win_coeffs[74] = 32'h3e83e92d;
    assign hamming_win_coeffs[75] = 32'h3e863537;
    assign hamming_win_coeffs[76] = 32'h3e8886c2;
    assign hamming_win_coeffs[77] = 32'h3e8addb8;
    assign hamming_win_coeffs[78] = 32'h3e8d3a02;
    assign hamming_win_coeffs[79] = 32'h3e8f9b87;
    assign hamming_win_coeffs[80] = 32'h3e920232;
    assign hamming_win_coeffs[81] = 32'h3e946de9;
    assign hamming_win_coeffs[82] = 32'h3e96de94;
    assign hamming_win_coeffs[83] = 32'h3e99541c;
    assign hamming_win_coeffs[84] = 32'h3e9bce69;
    assign hamming_win_coeffs[85] = 32'h3e9e4d61;
    assign hamming_win_coeffs[86] = 32'h3ea0d0ec;
    assign hamming_win_coeffs[87] = 32'h3ea358f1;
    assign hamming_win_coeffs[88] = 32'h3ea5e557;
    assign hamming_win_coeffs[89] = 32'h3ea87604;
    assign hamming_win_coeffs[90] = 32'h3eab0ae0;
    assign hamming_win_coeffs[91] = 32'h3eada3d1;
    assign hamming_win_coeffs[92] = 32'h3eb040bc;
    assign hamming_win_coeffs[93] = 32'h3eb2e189;
    assign hamming_win_coeffs[94] = 32'h3eb5861c;
    assign hamming_win_coeffs[95] = 32'h3eb82e5d;
    assign hamming_win_coeffs[96] = 32'h3ebada30;
    assign hamming_win_coeffs[97] = 32'h3ebd897b;
    assign hamming_win_coeffs[98] = 32'h3ec03c23;
    assign hamming_win_coeffs[99] = 32'h3ec2f20e;
    assign hamming_win_coeffs[100] = 32'h3ec5ab21;
    assign hamming_win_coeffs[101] = 32'h3ec86741;
    assign hamming_win_coeffs[102] = 32'h3ecb2653;
    assign hamming_win_coeffs[103] = 32'h3ecde83b;
    assign hamming_win_coeffs[104] = 32'h3ed0acdf;
    assign hamming_win_coeffs[105] = 32'h3ed37422;
    assign hamming_win_coeffs[106] = 32'h3ed63de9;
    assign hamming_win_coeffs[107] = 32'h3ed90a1a;
    assign hamming_win_coeffs[108] = 32'h3edbd897;
    assign hamming_win_coeffs[109] = 32'h3edea945;
    assign hamming_win_coeffs[110] = 32'h3ee17c09;
    assign hamming_win_coeffs[111] = 32'h3ee450c6;
    assign hamming_win_coeffs[112] = 32'h3ee72760;
    assign hamming_win_coeffs[113] = 32'h3ee9ffbb;
    assign hamming_win_coeffs[114] = 32'h3eecd9bb;
    assign hamming_win_coeffs[115] = 32'h3eefb544;
    assign hamming_win_coeffs[116] = 32'h3ef29239;
    assign hamming_win_coeffs[117] = 32'h3ef5707e;
    assign hamming_win_coeffs[118] = 32'h3ef84ff6;
    assign hamming_win_coeffs[119] = 32'h3efb3086;
    assign hamming_win_coeffs[120] = 32'h3efe1210;
    assign hamming_win_coeffs[121] = 32'h3f007a3c;
    assign hamming_win_coeffs[122] = 32'h3f01ebd1;
    assign hamming_win_coeffs[123] = 32'h3f035db8;
    assign hamming_win_coeffs[124] = 32'h3f04cfe4;
    assign hamming_win_coeffs[125] = 32'h3f064245;
    assign hamming_win_coeffs[126] = 32'h3f07b4ce;
    assign hamming_win_coeffs[127] = 32'h3f09276f;
    assign hamming_win_coeffs[128] = 32'h3f0a9a1c;
    assign hamming_win_coeffs[129] = 32'h3f0c0cc5;
    assign hamming_win_coeffs[130] = 32'h3f0d7f5c;
    assign hamming_win_coeffs[131] = 32'h3f0ef1d3;
    assign hamming_win_coeffs[132] = 32'h3f10641b;
    assign hamming_win_coeffs[133] = 32'h3f11d626;
    assign hamming_win_coeffs[134] = 32'h3f1347e6;
    assign hamming_win_coeffs[135] = 32'h3f14b94c;
    assign hamming_win_coeffs[136] = 32'h3f162a4a;
    assign hamming_win_coeffs[137] = 32'h3f179ad3;
    assign hamming_win_coeffs[138] = 32'h3f190ad7;
    assign hamming_win_coeffs[139] = 32'h3f1a7a48;
    assign hamming_win_coeffs[140] = 32'h3f1be918;
    assign hamming_win_coeffs[141] = 32'h3f1d5739;
    assign hamming_win_coeffs[142] = 32'h3f1ec49d;
    assign hamming_win_coeffs[143] = 32'h3f203136;
    assign hamming_win_coeffs[144] = 32'h3f219cf5;
    assign hamming_win_coeffs[145] = 32'h3f2307cc;
    assign hamming_win_coeffs[146] = 32'h3f2471ae;
    assign hamming_win_coeffs[147] = 32'h3f25da8c;
    assign hamming_win_coeffs[148] = 32'h3f274259;
    assign hamming_win_coeffs[149] = 32'h3f28a906;
    assign hamming_win_coeffs[150] = 32'h3f2a0e86;
    assign hamming_win_coeffs[151] = 32'h3f2b72ca;
    assign hamming_win_coeffs[152] = 32'h3f2cd5c6;
    assign hamming_win_coeffs[153] = 32'h3f2e376a;
    assign hamming_win_coeffs[154] = 32'h3f2f97ab;
    assign hamming_win_coeffs[155] = 32'h3f30f679;
    assign hamming_win_coeffs[156] = 32'h3f3253c7;
    assign hamming_win_coeffs[157] = 32'h3f33af88;
    assign hamming_win_coeffs[158] = 32'h3f3509af;
    assign hamming_win_coeffs[159] = 32'h3f36622d;
    assign hamming_win_coeffs[160] = 32'h3f37b8f7;
    assign hamming_win_coeffs[161] = 32'h3f390dfd;
    assign hamming_win_coeffs[162] = 32'h3f3a6134;
    assign hamming_win_coeffs[163] = 32'h3f3bb28d;
    assign hamming_win_coeffs[164] = 32'h3f3d01fd;
    assign hamming_win_coeffs[165] = 32'h3f3e4f76;
    assign hamming_win_coeffs[166] = 32'h3f3f9aea;
    assign hamming_win_coeffs[167] = 32'h3f40e44e;
    assign hamming_win_coeffs[168] = 32'h3f422b95;
    assign hamming_win_coeffs[169] = 32'h3f4370b1;
    assign hamming_win_coeffs[170] = 32'h3f44b397;
    assign hamming_win_coeffs[171] = 32'h3f45f439;
    assign hamming_win_coeffs[172] = 32'h3f47328c;
    assign hamming_win_coeffs[173] = 32'h3f486e82;
    assign hamming_win_coeffs[174] = 32'h3f49a811;
    assign hamming_win_coeffs[175] = 32'h3f4adf2b;
    assign hamming_win_coeffs[176] = 32'h3f4c13c5;
    assign hamming_win_coeffs[177] = 32'h3f4d45d2;
    assign hamming_win_coeffs[178] = 32'h3f4e7547;
    assign hamming_win_coeffs[179] = 32'h3f4fa219;
    assign hamming_win_coeffs[180] = 32'h3f50cc3a;
    assign hamming_win_coeffs[181] = 32'h3f51f3a1;
    assign hamming_win_coeffs[182] = 32'h3f531841;
    assign hamming_win_coeffs[183] = 32'h3f543a0f;
    assign hamming_win_coeffs[184] = 32'h3f555901;
    assign hamming_win_coeffs[185] = 32'h3f56750a;
    assign hamming_win_coeffs[186] = 32'h3f578e20;
    assign hamming_win_coeffs[187] = 32'h3f58a437;
    assign hamming_win_coeffs[188] = 32'h3f59b746;
    assign hamming_win_coeffs[189] = 32'h3f5ac742;
    assign hamming_win_coeffs[190] = 32'h3f5bd420;
    assign hamming_win_coeffs[191] = 32'h3f5cddd5;
    assign hamming_win_coeffs[192] = 32'h3f5de457;
    assign hamming_win_coeffs[193] = 32'h3f5ee79d;
    assign hamming_win_coeffs[194] = 32'h3f5fe79c;
    assign hamming_win_coeffs[195] = 32'h3f60e44a;
    assign hamming_win_coeffs[196] = 32'h3f61dd9d;
    assign hamming_win_coeffs[197] = 32'h3f62d38c;
    assign hamming_win_coeffs[198] = 32'h3f63c60e;
    assign hamming_win_coeffs[199] = 32'h3f64b518;
    assign hamming_win_coeffs[200] = 32'h3f65a0a2;
    assign hamming_win_coeffs[201] = 32'h3f6688a3;
    assign hamming_win_coeffs[202] = 32'h3f676d11;
    assign hamming_win_coeffs[203] = 32'h3f684de4;
    assign hamming_win_coeffs[204] = 32'h3f692b13;
    assign hamming_win_coeffs[205] = 32'h3f6a0495;
    assign hamming_win_coeffs[206] = 32'h3f6ada62;
    assign hamming_win_coeffs[207] = 32'h3f6bac72;
    assign hamming_win_coeffs[208] = 32'h3f6c7abd;
    assign hamming_win_coeffs[209] = 32'h3f6d453a;
    assign hamming_win_coeffs[210] = 32'h3f6e0be2;
    assign hamming_win_coeffs[211] = 32'h3f6ecead;
    assign hamming_win_coeffs[212] = 32'h3f6f8d94;
    assign hamming_win_coeffs[213] = 32'h3f70488f;
    assign hamming_win_coeffs[214] = 32'h3f70ff97;
    assign hamming_win_coeffs[215] = 32'h3f71b2a4;
    assign hamming_win_coeffs[216] = 32'h3f7261b1;
    assign hamming_win_coeffs[217] = 32'h3f730cb6;
    assign hamming_win_coeffs[218] = 32'h3f73b3ac;
    assign hamming_win_coeffs[219] = 32'h3f74568d;
    assign hamming_win_coeffs[220] = 32'h3f74f553;
    assign hamming_win_coeffs[221] = 32'h3f758ff8;
    assign hamming_win_coeffs[222] = 32'h3f762676;
    assign hamming_win_coeffs[223] = 32'h3f76b8c6;
    assign hamming_win_coeffs[224] = 32'h3f7746e3;
    assign hamming_win_coeffs[225] = 32'h3f77d0c8;
    assign hamming_win_coeffs[226] = 32'h3f78566f;
    assign hamming_win_coeffs[227] = 32'h3f78d7d4;
    assign hamming_win_coeffs[228] = 32'h3f7954f0;
    assign hamming_win_coeffs[229] = 32'h3f79cdc0;
    assign hamming_win_coeffs[230] = 32'h3f7a423f;
    assign hamming_win_coeffs[231] = 32'h3f7ab267;
    assign hamming_win_coeffs[232] = 32'h3f7b1e35;
    assign hamming_win_coeffs[233] = 32'h3f7b85a5;
    assign hamming_win_coeffs[234] = 32'h3f7be8b3;
    assign hamming_win_coeffs[235] = 32'h3f7c475a;
    assign hamming_win_coeffs[236] = 32'h3f7ca197;
    assign hamming_win_coeffs[237] = 32'h3f7cf767;
    assign hamming_win_coeffs[238] = 32'h3f7d48c6;
    assign hamming_win_coeffs[239] = 32'h3f7d95b2;
    assign hamming_win_coeffs[240] = 32'h3f7dde26;
    assign hamming_win_coeffs[241] = 32'h3f7e2221;
    assign hamming_win_coeffs[242] = 32'h3f7e619f;
    assign hamming_win_coeffs[243] = 32'h3f7e9c9f;
    assign hamming_win_coeffs[244] = 32'h3f7ed31e;
    assign hamming_win_coeffs[245] = 32'h3f7f051a;
    assign hamming_win_coeffs[246] = 32'h3f7f3290;
    assign hamming_win_coeffs[247] = 32'h3f7f5b80;
    assign hamming_win_coeffs[248] = 32'h3f7f7fe7;
    assign hamming_win_coeffs[249] = 32'h3f7f9fc5;
    assign hamming_win_coeffs[250] = 32'h3f7fbb17;
    assign hamming_win_coeffs[251] = 32'h3f7fd1dd;
    assign hamming_win_coeffs[252] = 32'h3f7fe416;
    assign hamming_win_coeffs[253] = 32'h3f7ff1c2;
    assign hamming_win_coeffs[254] = 32'h3f7ffadf;
    assign hamming_win_coeffs[255] = 32'h3f7fff6e;
    assign hamming_win_coeffs[256] = 32'h3f7fff6e;
    assign hamming_win_coeffs[257] = 32'h3f7ffadf;
    assign hamming_win_coeffs[258] = 32'h3f7ff1c2;
    assign hamming_win_coeffs[259] = 32'h3f7fe416;
    assign hamming_win_coeffs[260] = 32'h3f7fd1dd;
    assign hamming_win_coeffs[261] = 32'h3f7fbb17;
    assign hamming_win_coeffs[262] = 32'h3f7f9fc5;
    assign hamming_win_coeffs[263] = 32'h3f7f7fe7;
    assign hamming_win_coeffs[264] = 32'h3f7f5b80;
    assign hamming_win_coeffs[265] = 32'h3f7f3290;
    assign hamming_win_coeffs[266] = 32'h3f7f051a;
    assign hamming_win_coeffs[267] = 32'h3f7ed31e;
    assign hamming_win_coeffs[268] = 32'h3f7e9c9f;
    assign hamming_win_coeffs[269] = 32'h3f7e619f;
    assign hamming_win_coeffs[270] = 32'h3f7e2221;
    assign hamming_win_coeffs[271] = 32'h3f7dde26;
    assign hamming_win_coeffs[272] = 32'h3f7d95b2;
    assign hamming_win_coeffs[273] = 32'h3f7d48c6;
    assign hamming_win_coeffs[274] = 32'h3f7cf767;
    assign hamming_win_coeffs[275] = 32'h3f7ca197;
    assign hamming_win_coeffs[276] = 32'h3f7c475a;
    assign hamming_win_coeffs[277] = 32'h3f7be8b3;
    assign hamming_win_coeffs[278] = 32'h3f7b85a5;
    assign hamming_win_coeffs[279] = 32'h3f7b1e35;
    assign hamming_win_coeffs[280] = 32'h3f7ab267;
    assign hamming_win_coeffs[281] = 32'h3f7a423f;
    assign hamming_win_coeffs[282] = 32'h3f79cdc0;
    assign hamming_win_coeffs[283] = 32'h3f7954f0;
    assign hamming_win_coeffs[284] = 32'h3f78d7d4;
    assign hamming_win_coeffs[285] = 32'h3f78566f;
    assign hamming_win_coeffs[286] = 32'h3f77d0c8;
    assign hamming_win_coeffs[287] = 32'h3f7746e3;
    assign hamming_win_coeffs[288] = 32'h3f76b8c6;
    assign hamming_win_coeffs[289] = 32'h3f762676;
    assign hamming_win_coeffs[290] = 32'h3f758ff8;
    assign hamming_win_coeffs[291] = 32'h3f74f553;
    assign hamming_win_coeffs[292] = 32'h3f74568d;
    assign hamming_win_coeffs[293] = 32'h3f73b3ac;
    assign hamming_win_coeffs[294] = 32'h3f730cb6;
    assign hamming_win_coeffs[295] = 32'h3f7261b1;
    assign hamming_win_coeffs[296] = 32'h3f71b2a4;
    assign hamming_win_coeffs[297] = 32'h3f70ff97;
    assign hamming_win_coeffs[298] = 32'h3f70488f;
    assign hamming_win_coeffs[299] = 32'h3f6f8d94;
    assign hamming_win_coeffs[300] = 32'h3f6ecead;
    assign hamming_win_coeffs[301] = 32'h3f6e0be2;
    assign hamming_win_coeffs[302] = 32'h3f6d453a;
    assign hamming_win_coeffs[303] = 32'h3f6c7abd;
    assign hamming_win_coeffs[304] = 32'h3f6bac72;
    assign hamming_win_coeffs[305] = 32'h3f6ada62;
    assign hamming_win_coeffs[306] = 32'h3f6a0495;
    assign hamming_win_coeffs[307] = 32'h3f692b13;
    assign hamming_win_coeffs[308] = 32'h3f684de4;
    assign hamming_win_coeffs[309] = 32'h3f676d11;
    assign hamming_win_coeffs[310] = 32'h3f6688a3;
    assign hamming_win_coeffs[311] = 32'h3f65a0a2;
    assign hamming_win_coeffs[312] = 32'h3f64b518;
    assign hamming_win_coeffs[313] = 32'h3f63c60e;
    assign hamming_win_coeffs[314] = 32'h3f62d38c;
    assign hamming_win_coeffs[315] = 32'h3f61dd9d;
    assign hamming_win_coeffs[316] = 32'h3f60e44a;
    assign hamming_win_coeffs[317] = 32'h3f5fe79c;
    assign hamming_win_coeffs[318] = 32'h3f5ee79d;
    assign hamming_win_coeffs[319] = 32'h3f5de457;
    assign hamming_win_coeffs[320] = 32'h3f5cddd5;
    assign hamming_win_coeffs[321] = 32'h3f5bd420;
    assign hamming_win_coeffs[322] = 32'h3f5ac742;
    assign hamming_win_coeffs[323] = 32'h3f59b746;
    assign hamming_win_coeffs[324] = 32'h3f58a437;
    assign hamming_win_coeffs[325] = 32'h3f578e20;
    assign hamming_win_coeffs[326] = 32'h3f56750a;
    assign hamming_win_coeffs[327] = 32'h3f555901;
    assign hamming_win_coeffs[328] = 32'h3f543a0f;
    assign hamming_win_coeffs[329] = 32'h3f531841;
    assign hamming_win_coeffs[330] = 32'h3f51f3a1;
    assign hamming_win_coeffs[331] = 32'h3f50cc3a;
    assign hamming_win_coeffs[332] = 32'h3f4fa219;
    assign hamming_win_coeffs[333] = 32'h3f4e7547;
    assign hamming_win_coeffs[334] = 32'h3f4d45d2;
    assign hamming_win_coeffs[335] = 32'h3f4c13c5;
    assign hamming_win_coeffs[336] = 32'h3f4adf2b;
    assign hamming_win_coeffs[337] = 32'h3f49a811;
    assign hamming_win_coeffs[338] = 32'h3f486e82;
    assign hamming_win_coeffs[339] = 32'h3f47328c;
    assign hamming_win_coeffs[340] = 32'h3f45f439;
    assign hamming_win_coeffs[341] = 32'h3f44b397;
    assign hamming_win_coeffs[342] = 32'h3f4370b1;
    assign hamming_win_coeffs[343] = 32'h3f422b95;
    assign hamming_win_coeffs[344] = 32'h3f40e44e;
    assign hamming_win_coeffs[345] = 32'h3f3f9aea;
    assign hamming_win_coeffs[346] = 32'h3f3e4f76;
    assign hamming_win_coeffs[347] = 32'h3f3d01fd;
    assign hamming_win_coeffs[348] = 32'h3f3bb28d;
    assign hamming_win_coeffs[349] = 32'h3f3a6134;
    assign hamming_win_coeffs[350] = 32'h3f390dfd;
    assign hamming_win_coeffs[351] = 32'h3f37b8f7;
    assign hamming_win_coeffs[352] = 32'h3f36622d;
    assign hamming_win_coeffs[353] = 32'h3f3509af;
    assign hamming_win_coeffs[354] = 32'h3f33af88;
    assign hamming_win_coeffs[355] = 32'h3f3253c7;
    assign hamming_win_coeffs[356] = 32'h3f30f679;
    assign hamming_win_coeffs[357] = 32'h3f2f97ab;
    assign hamming_win_coeffs[358] = 32'h3f2e376a;
    assign hamming_win_coeffs[359] = 32'h3f2cd5c6;
    assign hamming_win_coeffs[360] = 32'h3f2b72ca;
    assign hamming_win_coeffs[361] = 32'h3f2a0e86;
    assign hamming_win_coeffs[362] = 32'h3f28a906;
    assign hamming_win_coeffs[363] = 32'h3f274259;
    assign hamming_win_coeffs[364] = 32'h3f25da8c;
    assign hamming_win_coeffs[365] = 32'h3f2471ae;
    assign hamming_win_coeffs[366] = 32'h3f2307cc;
    assign hamming_win_coeffs[367] = 32'h3f219cf5;
    assign hamming_win_coeffs[368] = 32'h3f203136;
    assign hamming_win_coeffs[369] = 32'h3f1ec49d;
    assign hamming_win_coeffs[370] = 32'h3f1d5739;
    assign hamming_win_coeffs[371] = 32'h3f1be918;
    assign hamming_win_coeffs[372] = 32'h3f1a7a48;
    assign hamming_win_coeffs[373] = 32'h3f190ad7;
    assign hamming_win_coeffs[374] = 32'h3f179ad3;
    assign hamming_win_coeffs[375] = 32'h3f162a4a;
    assign hamming_win_coeffs[376] = 32'h3f14b94c;
    assign hamming_win_coeffs[377] = 32'h3f1347e6;
    assign hamming_win_coeffs[378] = 32'h3f11d626;
    assign hamming_win_coeffs[379] = 32'h3f10641b;
    assign hamming_win_coeffs[380] = 32'h3f0ef1d3;
    assign hamming_win_coeffs[381] = 32'h3f0d7f5c;
    assign hamming_win_coeffs[382] = 32'h3f0c0cc5;
    assign hamming_win_coeffs[383] = 32'h3f0a9a1c;
    assign hamming_win_coeffs[384] = 32'h3f09276f;
    assign hamming_win_coeffs[385] = 32'h3f07b4ce;
    assign hamming_win_coeffs[386] = 32'h3f064245;
    assign hamming_win_coeffs[387] = 32'h3f04cfe4;
    assign hamming_win_coeffs[388] = 32'h3f035db8;
    assign hamming_win_coeffs[389] = 32'h3f01ebd1;
    assign hamming_win_coeffs[390] = 32'h3f007a3c;
    assign hamming_win_coeffs[391] = 32'h3efe1210;
    assign hamming_win_coeffs[392] = 32'h3efb3086;
    assign hamming_win_coeffs[393] = 32'h3ef84ff6;
    assign hamming_win_coeffs[394] = 32'h3ef5707e;
    assign hamming_win_coeffs[395] = 32'h3ef29239;
    assign hamming_win_coeffs[396] = 32'h3eefb544;
    assign hamming_win_coeffs[397] = 32'h3eecd9bb;
    assign hamming_win_coeffs[398] = 32'h3ee9ffbb;
    assign hamming_win_coeffs[399] = 32'h3ee72760;
    assign hamming_win_coeffs[400] = 32'h3ee450c6;
    assign hamming_win_coeffs[401] = 32'h3ee17c09;
    assign hamming_win_coeffs[402] = 32'h3edea945;
    assign hamming_win_coeffs[403] = 32'h3edbd897;
    assign hamming_win_coeffs[404] = 32'h3ed90a1a;
    assign hamming_win_coeffs[405] = 32'h3ed63de9;
    assign hamming_win_coeffs[406] = 32'h3ed37422;
    assign hamming_win_coeffs[407] = 32'h3ed0acdf;
    assign hamming_win_coeffs[408] = 32'h3ecde83b;
    assign hamming_win_coeffs[409] = 32'h3ecb2653;
    assign hamming_win_coeffs[410] = 32'h3ec86741;
    assign hamming_win_coeffs[411] = 32'h3ec5ab21;
    assign hamming_win_coeffs[412] = 32'h3ec2f20e;
    assign hamming_win_coeffs[413] = 32'h3ec03c23;
    assign hamming_win_coeffs[414] = 32'h3ebd897b;
    assign hamming_win_coeffs[415] = 32'h3ebada30;
    assign hamming_win_coeffs[416] = 32'h3eb82e5d;
    assign hamming_win_coeffs[417] = 32'h3eb5861c;
    assign hamming_win_coeffs[418] = 32'h3eb2e189;
    assign hamming_win_coeffs[419] = 32'h3eb040bc;
    assign hamming_win_coeffs[420] = 32'h3eada3d1;
    assign hamming_win_coeffs[421] = 32'h3eab0ae0;
    assign hamming_win_coeffs[422] = 32'h3ea87604;
    assign hamming_win_coeffs[423] = 32'h3ea5e557;
    assign hamming_win_coeffs[424] = 32'h3ea358f1;
    assign hamming_win_coeffs[425] = 32'h3ea0d0ec;
    assign hamming_win_coeffs[426] = 32'h3e9e4d61;
    assign hamming_win_coeffs[427] = 32'h3e9bce69;
    assign hamming_win_coeffs[428] = 32'h3e99541c;
    assign hamming_win_coeffs[429] = 32'h3e96de94;
    assign hamming_win_coeffs[430] = 32'h3e946de9;
    assign hamming_win_coeffs[431] = 32'h3e920232;
    assign hamming_win_coeffs[432] = 32'h3e8f9b87;
    assign hamming_win_coeffs[433] = 32'h3e8d3a02;
    assign hamming_win_coeffs[434] = 32'h3e8addb8;
    assign hamming_win_coeffs[435] = 32'h3e8886c2;
    assign hamming_win_coeffs[436] = 32'h3e863537;
    assign hamming_win_coeffs[437] = 32'h3e83e92d;
    assign hamming_win_coeffs[438] = 32'h3e81a2bc;
    assign hamming_win_coeffs[439] = 32'h3e7ec3f3;
    assign hamming_win_coeffs[440] = 32'h3e7a4df9;
    assign hamming_win_coeffs[441] = 32'h3e75e3b6;
    assign hamming_win_coeffs[442] = 32'h3e718555;
    assign hamming_win_coeffs[443] = 32'h3e6d3302;
    assign hamming_win_coeffs[444] = 32'h3e68ece8;
    assign hamming_win_coeffs[445] = 32'h3e64b330;
    assign hamming_win_coeffs[446] = 32'h3e608606;
    assign hamming_win_coeffs[447] = 32'h3e5c6591;
    assign hamming_win_coeffs[448] = 32'h3e5851fc;
    assign hamming_win_coeffs[449] = 32'h3e544b6e;
    assign hamming_win_coeffs[450] = 32'h3e50520f;
    assign hamming_win_coeffs[451] = 32'h3e4c6608;
    assign hamming_win_coeffs[452] = 32'h3e48877d;
    assign hamming_win_coeffs[453] = 32'h3e44b697;
    assign hamming_win_coeffs[454] = 32'h3e40f37b;
    assign hamming_win_coeffs[455] = 32'h3e3d3e4d;
    assign hamming_win_coeffs[456] = 32'h3e399733;
    assign hamming_win_coeffs[457] = 32'h3e35fe51;
    assign hamming_win_coeffs[458] = 32'h3e3273cb;
    assign hamming_win_coeffs[459] = 32'h3e2ef7c4;
    assign hamming_win_coeffs[460] = 32'h3e2b8a5d;
    assign hamming_win_coeffs[461] = 32'h3e282bba;
    assign hamming_win_coeffs[462] = 32'h3e24dbfc;
    assign hamming_win_coeffs[463] = 32'h3e219b42;
    assign hamming_win_coeffs[464] = 32'h3e1e69af;
    assign hamming_win_coeffs[465] = 32'h3e1b4760;
    assign hamming_win_coeffs[466] = 32'h3e183476;
    assign hamming_win_coeffs[467] = 32'h3e15310f;
    assign hamming_win_coeffs[468] = 32'h3e123d48;
    assign hamming_win_coeffs[469] = 32'h3e0f593f;
    assign hamming_win_coeffs[470] = 32'h3e0c8510;
    assign hamming_win_coeffs[471] = 32'h3e09c0d8;
    assign hamming_win_coeffs[472] = 32'h3e070cb2;
    assign hamming_win_coeffs[473] = 32'h3e0468b9;
    assign hamming_win_coeffs[474] = 32'h3e01d506;
    assign hamming_win_coeffs[475] = 32'h3dfea369;
    assign hamming_win_coeffs[476] = 32'h3df9bdb7;
    assign hamming_win_coeffs[477] = 32'h3df4f929;
    assign hamming_win_coeffs[478] = 32'h3df055ed;
    assign hamming_win_coeffs[479] = 32'h3debd432;
    assign hamming_win_coeffs[480] = 32'h3de77423;
    assign hamming_win_coeffs[481] = 32'h3de335ed;
    assign hamming_win_coeffs[482] = 32'h3ddf19b9;
    assign hamming_win_coeffs[483] = 32'h3ddb1fb0;
    assign hamming_win_coeffs[484] = 32'h3dd747fa;
    assign hamming_win_coeffs[485] = 32'h3dd392bc;
    assign hamming_win_coeffs[486] = 32'h3dd0001c;
    assign hamming_win_coeffs[487] = 32'h3dcc903c;
    assign hamming_win_coeffs[488] = 32'h3dc9433f;
    assign hamming_win_coeffs[489] = 32'h3dc61946;
    assign hamming_win_coeffs[490] = 32'h3dc3126f;
    assign hamming_win_coeffs[491] = 32'h3dc02eda;
    assign hamming_win_coeffs[492] = 32'h3dbd6ea1;
    assign hamming_win_coeffs[493] = 32'h3dbad1e2;
    assign hamming_win_coeffs[494] = 32'h3db858b5;
    assign hamming_win_coeffs[495] = 32'h3db60333;
    assign hamming_win_coeffs[496] = 32'h3db3d173;
    assign hamming_win_coeffs[497] = 32'h3db1c38b;
    assign hamming_win_coeffs[498] = 32'h3dafd990;
    assign hamming_win_coeffs[499] = 32'h3dae1393;
    assign hamming_win_coeffs[500] = 32'h3dac71a8;
    assign hamming_win_coeffs[501] = 32'h3daaf3de;
    assign hamming_win_coeffs[502] = 32'h3da99a43;
    assign hamming_win_coeffs[503] = 32'h3da864e6;
    assign hamming_win_coeffs[504] = 32'h3da753d1;
    assign hamming_win_coeffs[505] = 32'h3da66711;
    assign hamming_win_coeffs[506] = 32'h3da59ead;
    assign hamming_win_coeffs[507] = 32'h3da4faae;
    assign hamming_win_coeffs[508] = 32'h3da47b1a;
    assign hamming_win_coeffs[509] = 32'h3da41ff6;
    assign hamming_win_coeffs[510] = 32'h3da3e945;
    assign hamming_win_coeffs[511] = 32'h3da3d70a;
    
    always@(posedge clk) begin
    
        stream_temp <= stream;
        if (tvalid_stream) begin
            tvalid_stream_temp <= 1'b1;
        end
        else begin
           tvalid_stream_temp <= 1'b0; 
        end
    
        if (tvalid_stream == 1'b1) begin
            tvalid_reg_coeffs <= 1'b1;
            reg_coeffs <= hamming_win_coeffs[ind];
            ind <= ind + 1;
        end
        else begin
            tvalid_reg_coeffs <= 1'b0;
            reg_coeffs = 32'h00000000;
            ind = 0;
        end
    end
    
    floating_point_mult multiplier (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_stream_temp),
        .s_axis_a_tready(),
        .s_axis_a_tdata(stream_temp),
        .s_axis_b_tvalid(tvalid_reg_coeffs),
        .s_axis_b_tready(),
        .s_axis_b_tdata(reg_coeffs),
        .m_axis_result_tvalid(tready_hamm_stream),
        .m_axis_result_tdata(hamm_stream)
    );
    
endmodule
