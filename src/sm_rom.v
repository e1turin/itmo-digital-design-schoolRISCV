/*
 * schoolRISCV - small RISC-V CPU 
 *
 * originally based on Sarah L. Harris MIPS CPU 
 *                   & schoolMIPS project
 * 
 * Copyright(c) 2017-2020 Stanislav Zhelnio 
 *                        Aleksandr Romanov 
 */ 

module sm_rom
#(
    parameter SIZE = 64
)
(
    input  [31:0] a,
    output [31:0] rd [1:0]
);
    reg [31:0] rom [SIZE - 1:0];
    assign rd[0] = rom [a];
    assign rd[1] = rom [a + 1];

    initial begin
        $readmemh ("program.hex", rom);
    end

endmodule
