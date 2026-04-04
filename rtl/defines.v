`define FS_TO_DS_BUS_WD 64 // fs_inst[31:0], fs_pc[31:0]
`define DS_TO_ES_BUS_WD 212 // 
`define ES_TO_MS_BUS_WD 122
`define MS_TO_WS_BUS_WD 70

//定义部分包含PC基地址等
`define PC_START 32'h8000_0000
`define DATA_START 32'h00004000
`define MIMO_START 32'h0000F000
`define MEMORY_MAP 1

//MIMO外设地址
`define SW_LOW_ADDR  32'h8020_0000
`define SW_HIGH_ADDR 32'h8020_0004
`define KEY_ADDR     32'h8020_0010
`define SEG_ADDR     32'h8020_0020
`define LED_ADDR     32'h8020_0040
`define CNT_ADDR     32'h8020_0050

//定义debug接口使能，注释掉为不启用debug接口
//`define DEBUG_INTERFACE_ENABLE 1
//定义逻辑验证时使用的测试指令文件路径
`define TEST_INST_PATH "C:\\Users\\ZY\\Desktop\\coe\\src0\\irom.hex"
`define TEST_DATA_PATH "C:\\Users\\ZY\\Desktop\\coe\\src0\\dram.hex"