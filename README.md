# CSE221: Computer Architecture - MIPS Processor (Phase 1)

Coursework project for Ain Shams University & University of East London.

## Phase 1 Modules

1. **Register File (`src/RegisterFile.vhd`)**: 32x32-bit registers with dual read ports and single write port.
2. **ALU (`src/ALU.vhd`)**: 32-bit ALU supporting 6 operations (AND, OR, ADD, SUB, NOR, SLT) and zero flag.
3. **Datapath (`src/datapath.vhd`)**: Integrates the Register File and ALU for R-type instruction execution.

## Directory Structure

```text
Project/
├── .gitignore
├── README.md
├── src/
│   ├── RegisterFile.vhd
│   ├── ALU.vhd
│   └── datapath.vhd
├── sim/
│   ├── tb_RegisterFile.vhd
│   ├── tb_ALU.vhd
│   └── tb_datapath.vhd
└── 1_CSE221_Major_Task_students.pdf
```
