vlog test.v
vsim -novopt work.test -sv_seed random -l log_25_april.txt
add wave -position insertpoint sim:/test/*
run -all
