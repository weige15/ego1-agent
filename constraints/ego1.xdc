# ============================================================
# EGO1
# FPGA: XC7A35T-1CSG324C
# ============================================================

# ------------------------------------------------------------
# 100 MHz system clock
# EGO1 SYS_CLK = P17
# ------------------------------------------------------------

set_property PACKAGE_PIN P17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

create_clock \
    -name sys_clk \
    -period 10.000 \
    [get_ports clk]


# ------------------------------------------------------------
# Push button S0 / PB0
# EGO1 S0 = R11
# Active high
# ------------------------------------------------------------

set_property PACKAGE_PIN R11 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]


# ------------------------------------------------------------
# LED D1_0 / LED1_0
# EGO1 D1_0 = K3
# Active high
# ------------------------------------------------------------

set_property PACKAGE_PIN K3 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports led]
