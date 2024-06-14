
TOPMODULE=arbiter_tb
IVARG = -g2012
IVARG += -D ICARUS
IVARG += -I ../
IVARG += -s $(TOPMODULE)
IVARG += ../*.sv

# don't forget to add Icarus dumpvars workaround into testbench source file for dump.vcd
icarus:
	rm -rf sim
	mkdir sim
	cd sim && iverilog $(IVARG)
	cd sim && vvp -n -la.lst a.out  
