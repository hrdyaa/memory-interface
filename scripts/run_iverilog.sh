#!/bin/bash
set -e
cd "$(dirname "$0")/.."

mkdir -p build logs

for L in 1 2 3; do
  iverilog -g2012 -Wall \
    -Ptb_sram_model.LAT=$L \
    -o build/sim_sram_L$L \
    rtl/sram_model.sv tb/tb_sram_model.sv

  vvp build/sim_sram_L$L | tee logs/log_sram_L$L.txt | grep -E "FAIL|RESULT"
done

iverilog -g2012 -Wall \
  -o build/sim_spi \
  rtl/spi_master.sv tb/tb_spi_master.sv

vvp build/sim_spi | tee logs/log_spi.txt | grep -E "FAIL|RESULT"
