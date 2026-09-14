set bitfile [file normalize "./build/top.bit"]

if {![file exists $bitfile]} {
    error "Bitstream not found: $bitfile"
}

puts "=========================================="
puts " Programming EGO1"
puts " Bitstream: $bitfile"
puts "=========================================="

open_hw_manager

connect_hw_server

open_hw_target

set devices [get_hw_devices]

if {[llength $devices] == 0} {
    error "No FPGA detected"
}

puts "Detected FPGA devices:"
puts $devices

set device [lindex $devices 0]

current_hw_device $device

refresh_hw_device $device

set_property PROGRAM.FILE $bitfile $device

puts "Programming device..."

program_hw_devices $device

puts "=========================================="
puts " PROGRAM SUCCESS"
puts "=========================================="

close_hw_target
disconnect_hw_server
close_hw_manager
