# EGO1 FPGA Development

## Hardware

Target board:
- EGO1

FPGA:
- Xilinx Artix-7
- XC7A35T-1CSG324C

Clock:
- 100 MHz
- Pin P17

Current I/O:
- S0 / PB0: R11, active high
- D1_0 / LED1_0: K3, active high

Vivado:
- Version 2025.2
- Runs on Windows
- Called from WSL through scripts/vivado_build.bat

## Project structure

Synthesizable RTL:

    rtl/

Simulation testbenches:

    tb/

Pin/timing constraints:

    constraints/

Vivado automation:

    scripts/

Generated output:

    build/

Never place generated files outside build/.

## RTL language

Use SystemVerilog.

Prefer:

- always_ff for sequential logic
- always_comb for combinational logic
- nonblocking assignments in sequential blocks
- synchronous logic
- clock enables instead of generated clocks

Do not use #delay in synthesizable RTL.

## Clock

System clock is 100 MHz.

Clock period:

    10 ns

## Development workflow

Every RTL change must follow this sequence:

1. Modify RTL.
2. Modify or add the relevant testbench.
3. Run:

       make lint

4. Fix all lint errors.
5. Run:

       make sim

6. Fix all simulation failures.
7. Run:

       make build

8. Check:

       build/timing_summary.rpt
       build/utilization.rpt
       build/drc.rpt

Do not call a task complete if:

- lint fails
- simulation fails
- synthesis fails
- implementation fails
- timing fails

## FPGA pins

Never guess FPGA pin assignments.

Only modify constraints/ego1.xdc when the pin assignment has
been verified against EGO1 documentation.

## External inputs

External asynchronous inputs must be synchronized before being
used by state machines or other timing-sensitive logic.

Mechanical buttons should be debounced if button transitions
affect normal operation.

## Simulation

Timing constants should be parameters where practical so that
simulation can use smaller values.

Test normal operation and important edge cases.

## Physical programming

DO NOT execute:

    make program

unless the user explicitly asks you to program the physical FPGA.

Building a bitstream with:

    make build

is allowed.

## Completion report

After completing an FPGA task, report:

1. Files changed
2. Tests performed
3. Simulation result
4. Synthesis result
5. Implementation result
6. Timing result / worst slack
7. Important warnings
8. Whether build/top.bit was generated
