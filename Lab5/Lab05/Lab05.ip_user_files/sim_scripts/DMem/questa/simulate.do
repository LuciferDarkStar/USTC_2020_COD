onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DMem_opt

do {wave.do}

view wave
view structure
view signals

do {DMem.udo}

run -all

quit -force
