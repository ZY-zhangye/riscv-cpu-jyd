`define FS_TO_DS_BUS_WD 64 // fs_inst[31:0], fs_pc[31:0]
`define DS_TO_ES_BUS_WD 212 // 
`define ES_TO_MS_BUS_WD 122
`define MS_TO_WS_BUS_WD 70

//定义部分包含PC基地址等
`define PC_START 32'h00000000
`define DATA_START 32'h00004000
`define MIMO_START 32'h0000F000
`define MEMORY_MAP 1

//MIMO外设地址
`define SW_START 32'h0000F000
`define SW_SIZE  15
`define KEY_START 32'h0000F010
`define KEY_SIZE  15
`define SEG_ADDR 32'h0000F020
`define LED_START 32'h0000F040
`define LED_SIZE  15