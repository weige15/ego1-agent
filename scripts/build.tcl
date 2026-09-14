puts "=========================================="
puts " EGO1 FPGA BUILD"
puts "=========================================="

set output_dir "./build"

file mkdir $output_dir

# ============================================================
# Read design
# ============================================================

puts "Reading RTL..."

read_verilog -sv [glob ./rtl/*.sv]

puts "Reading constraints..."

read_xdc ./constraints/ego1.xdc


# ============================================================
# Synthesis
# ============================================================

puts "Running synthesis..."

synth_design \
    -top top \
    -part xc7a35tcsg324-1

write_checkpoint \
    -force \
    $output_dir/post_synth.dcp

report_utilization \
    -file $output_dir/post_synth_utilization.rpt

report_timing_summary \
    -file $output_dir/post_synth_timing.rpt


# ============================================================
# Implementation
# ============================================================

puts "Running opt_design..."

opt_design

puts "Running place_design..."

place_design

puts "Running phys_opt_design..."

phys_opt_design

puts "Running route_design..."

route_design


# ============================================================
# Reports
# ============================================================

write_checkpoint \
    -force \
    $output_dir/post_route.dcp

report_utilization \
    -file $output_dir/utilization.rpt

report_timing_summary \
    -file $output_dir/timing_summary.rpt

report_drc \
    -file $output_dir/drc.rpt


# ============================================================
# Timing check
# ============================================================

set timing_paths [get_timing_paths -max_paths 1 -nworst 1]

if {[llength $timing_paths] > 0} {

    set worst_path [lindex $timing_paths 0]

    set worst_slack [get_property SLACK $worst_path]

    puts "=========================================="
    puts " Worst setup slack: $worst_slack ns"
    puts "=========================================="

    if {$worst_slack < 0.0} {

        puts stderr "ERROR: Timing violation"

        exit 2
    }
}


# ============================================================
# Generate bitstream
# ============================================================

puts "Generating bitstream..."

write_bitstream \
    -force \
    $output_dir/top.bit

puts "=========================================="
puts " BUILD SUCCESS"
puts " Bitstream: build/top.bit"
puts "=========================================="
