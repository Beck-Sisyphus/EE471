transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+U:/sourceCode {U:/sourceCode/InstrucDecoder.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode {U:/sourceCode/SRAM2Kby16.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode {U:/sourceCode/simpleCPU.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode {U:/sourceCode/CPUcontrol.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode {U:/sourceCode/ALUcontrol.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode/ALU\ operation {U:/sourceCode/ALU operation/xorGate.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode/ALU\ operation {U:/sourceCode/ALU operation/subtract.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode/ALU\ operation {U:/sourceCode/ALU operation/shiftll.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode/ALU\ operation {U:/sourceCode/ALU operation/setLT.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode/ALU\ operation {U:/sourceCode/ALU operation/orGate.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode/ALU\ operation {U:/sourceCode/ALU operation/flag.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode/ALU\ operation {U:/sourceCode/ALU operation/andGate.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode/ALU\ operation {U:/sourceCode/ALU operation/addition.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode {U:/sourceCode/ProgCountReg.v}
vlog -vlog01compat -work work +incdir+U:/sourceCode {U:/sourceCode/InstruMemory.v}
vlog -sv -work work +incdir+U:/sourceCode {U:/sourceCode/ALUnit.sv}
vlog -sv -work work +incdir+U:/sourceCode/Implementation {U:/sourceCode/Implementation/mux2_1.sv}

