onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_scr_1dim_core/clk
add wave -noupdate /tb_scr_1dim_core/kill
add wave -noupdate /tb_scr_1dim_core/init_val_en
add wave -noupdate /tb_scr_1dim_core/data_in 
add wave -noupdate /tb_scr_1dim_core/data_out 
add wave -noupdate /tb_scr_1dim_core/data_in_en
add wave -noupdate /tb_scr_1dim_core/scr_en 
add wave -noupdate -radix binary /tb_scr_1dim_core/init_val 
add wave -noupdate /tb_scr_1dim_core/data_out_en 
add wave -noupdate -radix binary /tb_scr_1dim_core/DUT/scr_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 283
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
wave zoom full

