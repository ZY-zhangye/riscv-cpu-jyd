// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Fri Apr  3 10:40:26 2026
// Host        : ZY running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/ZY/Desktop/riscv-cpu-jyd/digital_twin/digital_twin.gen/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1_sim_netlist.v
// Design      : blk_mem_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_1,blk_mem_gen_v8_4_7,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_7,Vivado 2023.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_1
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [10:0]addra;
  wire clka;
  wire [31:0]douta;
  wire ena;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.8711 mW" *) 
  (* C_FAMILY = "kintex7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_1.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_1.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_1_blk_mem_gen_v8_4_7 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jLV29U0rrfMIZhYJzdoUrPoqB9eHQ5NXmWyCdqnN3Wgm+GU4C3zthrN1m4QGiaj0thPCIynZbX+0
7yjtkv+T5ByJ6NhiofAwWseGLvPXlYu6ERAPvi4SAYpF2VUqQHtPAbPmnPubGdDRgIEpeobF7hsz
rEcpEru1pyiScUriyuo=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vsoizVrOONWw/DhjRLEYrtRmtji+Ok63CbpSg/l9VnoKAi8tAzqRbQ57atGB2N6IGGbKHkbK2Uzh
EHgWvYZeyt4hE+bpQX91vc9PNxfjQMGzPoFD3jCWk30EmEk+AND39eWx+DhJ8xhFuucoOQ2GwyAk
B+Mjs15naPE7DvlHel8hnD4dfSdYhGKp96oozu8JeBto8aHG6poOuYkxSwaut7NCI+mabCkMxtMp
RrydgmRuTvhRTbJMyx5CxFSZTRDrS5aU1vaRlnMiqKCI7g2KY9pemYaJsFeVodBuo6IyKGynyEhs
wr+VtUhQDtaVhMkwB95WwmMoDk9F2L5Au1I+TQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
W081dPMCWhKs5YlQD7n3zvf7+PTcnb8eFWxoVs8+zHLkxDMA1klITbsfztGYvJFce8Yao5XQLLqZ
oUE5Pq2arq+zwICFUcLjdMsmP1WmL82znHOPHm83zNwrxWMloHkySAqzFbgJeHa973uZqj0M8ydc
sYmzCYVlGVjt0QX0xqA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Zpc3MmdLWaVOv+S4z2POuoyslYoAbWc+Npxq2UyQRtDwf566IId3uwAetolMAgfLo/G3ezuSOXMn
8NznS37h9XvmVrxA50SAux68P87WgkLtiUYqM3CMBKkxNlZ/TR8WzTuQyFdvzkOE9lp8HC7LXnk5
RDsnOM+su46FW7ysY01COslo9Xc7rhs6WFqx29+Xcqk8+ZMLSzaJfuwZdNmJFS3Q1vhlq3ZeYqMl
wMieB731KsPxjxp7VKNHpTbgFryC2isqc4ohBDOt52M/Bz4B/rIpFeHfZ7X3jWSiKtSuBsDN2NXf
EMjfAT248dlK7NxJ+NBNPhS5sLxTiGyQhta57A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rPMYqnkKhJKV1wltOfDrKos9ZbucaoX3WGTuqsdLkGpcKObzslHBwlGrKtWV7bZYmS2SM+QuEMfa
CE+tCUdsSiprp+n5BuSQlJa6BJ8mlqccjoo/JLw2QEmUhyMXQ3TLGomGGoZdeTmMPXhUBAOyLPea
Ddc8mgtTN8Kpy117GOTXDKP+IKJqW01fLrPJpgEhFiJCbyElLgtCRWmI94gX+y4XNVS0Cd1YwNw6
4nHgnEdC7fXARDKcYO3VsWC/pdzPQgursXloNLrVYa6i2xr+8E1V0+nSWwNYQZP7XUIVqXKMU8Ea
bT4acXrRCF/5tJJ5B9JparYI0zxXSbaakn1dIw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mfroTgL8g2pyIXQ/mGO9YHm19cd5mOlJ++qpusOYeVxGmkIhvF4aKx+AyIUz2yGGAeCtOzIasHty
pyqKgZhibSqxcpHgR0m6GOxXXOXJiHaK8NzxUzXeRJovcBI/WjtDhXeb1LRMI1J97jVBtJPJQH0Y
fGOD7jWvkvQwxnrZdyLp6kPWgSIcavHHDbO7iJv4gnyGp6W3/FCDo2RKWNLoW+SNjSdLZ6YRP8a+
ldaGU8TYvJ03KWlmik7repuN6AwxCjg2KeQ+x1sBAEXzROXomuSbvX3ZAo8UiIKAQY1SJumHLG3L
QI/S4Wbl1Hz6LDTsttMwP480gq6+tb6s1E4oWw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QJIabgm8dx/gVHbOQFwt8maOKVHFgkpZTPR6dzD8fqoGo9M9oGPTqBqchtPZWgv2UYFF2KEUSlV4
L3SDXBKrLs+NsAVTcICaEMiEi6j82zj/C1LsPkQfS8RLrg0ab8lbDMb5YqJ7lkHs3iM65x2iN1Mf
66cTgCbkAdl3rDpab75btpTQt5ZKiq5CSY3RZfyIW0uWbTGTELm6liuRKM9+K8BQwTU7A+FFFQBA
/9eJwQYzNNA/iwoYJ2WTPd6pBlzXriNLu9M+/2bYicNBSuH1PBR9v2ESrTB6k7EiV1zvBXV9NuG/
sFt4MumWMuSNwP2W38bQATxxW/l0IrmaXGOC/w==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
lhKf/Vgj6pHpme1ji4HVe36BU8pMkam/2I9lFeyOiBnIbzgdEGfLJBcEvkL33A7s0hxa6LFbHnkT
upgMpPjmIghBz3xUQ13vpiY152thFec6qvlcdg1r+GTmnBOSFl6g/OfZ3eFUhfsve6ZjQHpXnKFo
a55hN2+eP1EG9+VxGeM7XkHaeFhEIry52qtnmg072KEFIwRiGs2d/TJ4AqupuIdIiP1kTN9k+oqa
2ta1vdtqPY0dDHqrf+5YSd0CejkhQeCqg/bauLP3755SwdOPRgooG5ANT8hUpTiFMFXtU+GC9NSp
evJtMHUy1NbgMmhFHO+w3URLEdjSaBxZPD7YLdWkF65jY526tJzoek+BzEKoBaGfCaY7O1nHKXm+
89k3rPUy0Xo4/0nHpno+N/Db09heJPbnGsCwN/l+KnR6Lz8kvWziBjZe0ijOkKI+T12y3T1VeOtY
H/aqtNlQt1mhFwrbw6ezaAiDPVbCQXnly6b4tbb8+nFsxWOGIGAfLozB

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PNsQ8uEcQYrl+GaDuBaq1tQ5br5aAdaqHnyrc0NVu/JnQUk53jaiLx8Oz5fNACvWelUUk2/C+P5I
b2rbU1bb/dC6TqC5J1N0yoMYRYw58u4Lrl8Kgqgt9Rlph5Qgzzfxp+oblXF/pO4mRyAXpZhpNkFT
0Ar9BUtPOTOtJ9/g53SRnZ6GjxzfeD+25J4fcXBNo2gCTgUkwiLSsJRwTB/cJmn+dZPwPdIOHEP9
TkfDK+OrbLYO3T+DFBTCMRNH2NB1J9sc5s+nPU8iYnjgPTo6HoGW+LIlCz6yNJMZzJzoeW708utc
0fJXkT7vLDVh7olvy3V9AAY8Do0YR1kiZlhVhQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
zAz8RnGHFebkJFAS+gjC+mXHW7m7We+JgSmIz15mS01u/4+9Ng0sJfkeXOClmVPTQ2Mp2Yuv6/6f
ehzUTcANilWsqLM6Q1FToCPNX/NTqodlcHirGM7b5R9yevouNT/aqH12nmbunBQmBHmehNutdCjG
r6Z7kZgeZ2ZE7MMOF0rTy1XHEPkqgMNTRoS8R/pPWPTW4/j+bn3aJj0Q/fTz4Gi3mbSUKWs2fREQ
UKiuolNJkN6DiDvhlVYHUyytXNJG44ikmBXehoQQRLapkYaxnQmMRT1ok9uY6pKoy71CtvJ3Mt2x
EQv1GU2i4qQyAOwa0mkEohWXduicU6tDz3zQwQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TK3eE9V+v1z2P1KjG4GrjhA1n3qDOpNzLGXdtjnjhF0QBFPSuhC+nmNqTPOb3p2a9r5KD0miY3Cd
+KpjH6Ao09E2/LD2Go4aLQh6vP+9BldlSKEwCGfx2NjBQrXWVH21lQR7IRjOvyTOclpd7SgtUJLw
dvebETyLiKr9C6RfnIBeptuCA3iJlXfwkh6I0JfzD5WBizQkotioZmmrXv5105pCXQ4Ta1WThFsA
2ll9dZeSjEDHUxxhfyfjryv9m4VL89ZDU/rGITsdptwB1BC1jLqmPDymY05lyECnjA6NIR5GGfI4
K2y2f4GfikKoN5r9IOvFzw963Wm82ZZPtXOKGg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 45072)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
