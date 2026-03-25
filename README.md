# riscv-cpu-jyd

本仓库为集创赛竞业达杯参赛项目（队伍：`CICC1005400`）的 RISC-V CPU 实现与回归测试工程。

当前工程基于历史仓库版本演进而来，主要面向 **RV32I + 部分 RV32M + CSR/异常机制** 的功能验证，提供了可直接运行的 Questa/ModelSim 批量测试脚本。

---

## 1. 项目概览

该 CPU 采用经典五级流水线：`IF -> ID -> EXE -> MEM -> WB`，支持：

- 基础整数指令（RV32I 常用子集）
- 乘法指令（`mul/mulh/mulhu/mulhsu`）
- CSR 指令与异常入口/返回（含 `ecall/ebreak/mret`）
- 基本数据冒险处理（前递 + load-use 停顿）
- 简单外设映射（LED）

测试方面，仓库内置了 `hex/riscv-tests` 镜像与 `run_all.bat` 批处理脚本，支持自动编译、逐条测试、结果判定与日志落盘。

---

## 2. 仓库结构

```text
.
├─ rtl/                 # 核心RTL（流水线各级、寄存器堆、CSR、RAM、桥接、顶层等）
├─ test/                # 测试平台（tb_top.v）
├─ hex/riscv-tests/     # RISC-V 测试程序HEX镜像
├─ results/             # 批量测试输出日志（每条指令一个txt）
├─ run_all.bat          # 批量编译+回归脚本
├─ clean.bat            # 清理仿真临时文件
└─ README.md
```

---

## 3. 设计架构说明

### 3.1 顶层连接

- `test/tb_top.v`：仿真入口，例化 `my_cpu`
- `rtl/my_cpu.v`：SoC 级封装，连接 CPU Core、桥接、指令/数据 RAM
- `rtl/top.v`：CPU 主体（五级流水 + regfile + csr + mult）

主数据通路：

`tb_top -> my_cpu -> top -> bridge -> inst_ram/data_ram`

### 3.2 流水线与关键机制

- `if_stage.v`：PC 更新、跳转/异常入口选路
- `id_stage.v`：指令译码、立即数生成、前递、load-use 检测、控制信号打包
- `exe_stage.v`：ALU、分支决策、访存地址与字节写使能生成、异常类型补充
- `mem_stage.v`：load 数据对齐/扩展、写回数据选择、CSR写控制
- `wb_stage.v`：寄存器写回与调试口输出

### 3.3 CSR/异常

`regfiles_csr.v` 中实现了常见机器态 CSR（如 `mstatus/mepc/mcause/mtvec` 等）与异常/中断相关逻辑，支持异常跳转与 `mret` 返回流程。

### 3.4 内存与外设映射

`bridge.v` 将核心访存接口路由到 RAM 与简单 IO：

- 指令访问：直连 `inst_ram`
- 数据访问：当前实现下主要走 `data_ram`
- LED：当写地址高4位为 `0x8` 且有写使能时，更新 `led[3:0]`

---

## 4. 已覆盖测试（脚本级）

`run_all.bat` 目前分三组运行：

- UI：`rv32ui-p-*`（如 `add/addi/lw/sw/beq/jal/...`）
- MI：`rv32mi-p-*`（`csr/scall/sbreak/ma_fetch`）
- UM：`rv32um-p-*`（`mul/mulh/mulhu/mulhsu`）

脚本会在每次测试前把目标 `.hex` 复制为统一入口镜像：

- `hex/riscv-tests/rv32-p-riscv.hex`

判定规则：日志中出现 `Test passed.` 视为通过，否则立即停止并报告失败。

---

## 5. 运行方式

### 5.1 环境要求

- Windows
- Questa Sim / ModelSim（支持 `vlog`、`vsim` 命令）
- 可用批处理环境（`.bat`）

### 5.2 批量回归

在仓库根目录执行 `run_all.bat`：

1. 编译 `rtl/*.v` 与 `test/*.v`
2. 逐条运行指令测试
3. 日志输出到 `results/<case>.txt`

### 5.3 清理工程

执行 `clean.bat` 可清理 `work/`、`transcript`、`vsim.wlf`、`*.vcd`、`*.log` 等仿真临时文件。

---

## 6. 常见问题与注意事项

### 6.1 HEX 文件路径问题（非常关键）

`test/tb_top.v` 里有宏：

- `` `define MEM_HEX_PATH "C:\\Users\\ZY\\Desktop\\riscv-cpu-rnew\\hex\\riscv-tests\\rv32-p-riscv.hex" ``

如果你的本地路径不是这个绝对路径，仿真会出现找不到镜像或加载错误。请改成你机器上的真实路径，或改为相对路径管理。

### 6.2 修改 RTL 后仿真仍像“没生效”

若在 Questa 中看到类似 `Loading existing optimized design _opt`，说明可能复用了旧优化网表。建议每次改 RTL 后先重新 `vlog` 编译，再 `vsim` 运行。

### 6.3 单个用例失败定位

- 先看 `results/<case>.txt` 的最后几十行
- 重点检查 `debug_wb_pc/debug_wb_rf_* / debug_data`
- `tb_top.v` 在 `debug_wb_pc == 32'h00000044` 处进行收敛判定

---

## 7. 开发建议

- 新增指令时优先同步以下模块：`id_stage.v`、`exe_stage.v`、`mem_stage.v`
- 若涉及异常/特权语义，记得同步 `regfiles_csr.v`
- 新增测试时可先手动替换 `rv32-p-riscv.hex` 验证，再加入 `run_all.bat` 指令列表

---

## 8. 当前状态

仓库内 `results/` 已保留多条回归输出，便于对照分析。整体工程可作为课程/竞赛场景下 RV32 流水 CPU 的实现与验证基线。