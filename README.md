# Synchronous FIFO Design Using Verilog

## Overview

This project implements a **Synchronous FIFO (First-In First-Out) buffer** using Verilog HDL.

A FIFO is a memory-based data storage structure in which data is read in the same order in which it was written. It follows the First-In First-Out principle and is commonly used in digital systems for temporary data storage, buffering, and data transfer between functional blocks.

The design uses a single clock for both read and write operations and includes status flags to indicate whether the FIFO is full or empty.

## Features

- Synchronous FIFO architecture using a single clock.
- Parameterized FIFO depth and data width.
- Independent read and write control signals.
- Write and read pointer management.
- Automatic full and empty flag generation.
- Active-low asynchronous reset.
- Protection against writing when the FIFO is full.
- Protection against reading when the FIFO is empty.
- Verilog testbench for functional simulation.

## Design Specifications

| Parameter | Description | Default Value |
|---|---|---|
| DEPTH | FIFO storage capacity | 8 |
| DATA_WIDTH | Width of each data word | 8 bits |
| Clock | Common read/write clock | 10 ns period |
| Reset | Active-low reset | rst_n |

**Default FIFO capacity:** 8 × 8 = 64 bits.

## Architecture

The FIFO consists of three main components:

### 1. FIFO Memory

A memory array stores the incoming data.

```verilog
reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
```

### 2. Read and Write Pointers

- `w_ptr`: Keeps track of the next memory location where data will be written.
- `r_ptr`: Keeps track of the next memory location from which data will be read.

Both pointers are updated on the positive edge of the clock.

The memory location is accessed using modulo operation:

```verilog
mem[w_ptr % DEPTH] <= data_in;
data_out <= mem[r_ptr % DEPTH];
```

### 3. FIFO Status Flags

Two status flags indicate the current FIFO condition.

**Full Flag**

```verilog
assign full = (w_ptr - r_ptr == DEPTH);
```

Indicates that the FIFO has reached its maximum storage capacity.

**Empty Flag**

```verilog
assign empty = (w_ptr == r_ptr);
```

Indicates that no unread data is available in the FIFO.

## Module Interface

| Signal | Direction | Description |
|---|---|---|
| clk | Input | Common clock signal |
| rst_n | Input | Active-low reset |
| wr_en | Input | Enables write operation |
| rd_en | Input | Enables read operation |
| data_in | Input | Input data bus |
| data_out | Output | Output data bus |
| full | Output | Indicates FIFO is full |
| empty | Output | Indicates FIFO is empty |

## Working Principle

### Write Operation

1. Write operation is initiated when `wr_en` is HIGH.
2. The incoming data is stored at the memory location indicated by the write pointer.
3. The write pointer increments after a successful write.
4. Writing is prevented when the FIFO is full.

### Read Operation

1. Read operation is initiated when `rd_en` is HIGH.
2. Data is retrieved from the memory location indicated by the read pointer.
3. The read pointer increments after a successful read.
4. Reading is prevented when the FIFO is empty.

### Reset Operation

When `rst_n` is LOW:
- Write pointer is reset to zero.
- Read pointer is reset to zero.
- Output data is reset to zero.

## Testbench and Verification

A Verilog testbench is included to verify the functionality of the FIFO.

The testbench performs the following operations:

1. Generates a clock with a 10 ns period.
2. Applies an active-low reset.
3. Writes four randomly generated 8-bit data values into the FIFO.
4. Performs four consecutive read operations.
5. Monitors input data, output data, control signals, and FIFO status flags.
6. Terminates the simulation after completing the operations.

The `$monitor` system task is used to observe signal changes throughout the simulation.

## Simulation

The design can be simulated using tools such as:

- Xilinx Vivado
- ModelSim
- QuestaSim
- Icarus Verilog

Add the design and testbench files to your simulation project and execute the testbench to observe the FIFO read/write operations.

## Applications

Synchronous FIFOs are widely used in:

- Digital system data buffering.
- Processor and peripheral interfaces.
- Communication protocol controllers.
- RTL datapath design.
- Temporary storage between digital functional blocks.
- Data flow management in FPGA and ASIC designs.

## Skills Demonstrated

- Verilog HDL
- RTL Design
- Sequential Logic Design
- Memory Modeling
- Pointer Management
- FIFO Architecture
- Testbench Development
- Functional Simulation

## Future Improvements

- Implement parameterized pointer wrapping without modulo operations.
- Add overflow and underflow handling.
- Support simultaneous read and write operations.
- Develop a self-checking testbench.
- Add assertions for FIFO protocol verification.
- Verify boundary conditions, including full and empty transitions.

## Author

**Akash Singh**

Electronics and Communication Engineering  
Interested in Digital VLSI, RTL Design, and Verification.
