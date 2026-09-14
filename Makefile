.RECIPEPREFIX := >

.PHONY: help lint sim check build program clean

help:
> @echo "EGO1 FPGA development"
> @echo ""
> @echo "make lint     Run Verilator lint"
> @echo "make sim      Run simulation"
> @echo "make check    Run lint + simulation"
> @echo "make build    Check + Vivado build"
> @echo "make program  Program EGO1 FPGA"
> @echo "make clean    Remove generated files"

lint:
> @echo "=========================================="
> @echo " Verilator lint"
> @echo "=========================================="
> mkdir -p build
> verilator --lint-only --sv -Wall rtl/*.sv

sim:
> @echo "=========================================="
> @echo " Simulation"
> @echo "=========================================="
> mkdir -p build/sim
> iverilog \
>     -g2012 \
>     -s top_tb \
>     -o build/sim/top_tb.vvp \
>     rtl/*.sv \
>     tb/top_tb.sv
> vvp build/sim/top_tb.vvp

check: lint sim

build: check
> @echo "=========================================="
> @echo " Vivado FPGA build"
> @echo "=========================================="
> cmd.exe /C scripts\\vivado_build.bat

program:
> @echo "=========================================="
> @echo " Programming EGO1"
> @echo "=========================================="
> cmd.exe /C scripts\\vivado_program.bat

clean:
> rm -rf build
> mkdir -p build
