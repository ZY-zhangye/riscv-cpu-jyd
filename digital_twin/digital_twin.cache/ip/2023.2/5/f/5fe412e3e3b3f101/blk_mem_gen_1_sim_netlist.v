// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Fri Apr  3 10:40:25 2026
// Host        : ZY running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_1_sim_netlist.v
// Design      : blk_mem_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_1,blk_mem_gen_v8_4_7,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_7,Vivado 2023.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_7 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 45200)
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
