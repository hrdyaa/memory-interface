#!/bin/sh
set -e
for L in 1 2 3; do
  iverilog -g2012 -Wall -Ptb_sram_model.LAT=$L -o sim_sram_L$L sram_model.sv tb_sram_model.sv
  vvp sim_sram_L$L | tee log_sram_L$L.txt | grep -E "FAIL|RESULT"
done
iverilog -g2012 -Wall -o sim_spi spi_master.sv tb_spi_master.sv
vvp sim_spi | tee log_spi.txt | grep -E "FAIL|RESULT"
