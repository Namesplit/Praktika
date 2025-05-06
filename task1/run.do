vlib work
vlog scr_1dim_core.sv tb_scr_1dim_core.sv
vsim -voptargs=+acc work.tb_scr_1dim_core
do wave.do 
run -all
