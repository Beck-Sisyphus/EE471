library verilog;
use verilog.vl_types.all;
entity shiftll is
    port(
        busSLL          : out    vl_logic_vector(31 downto 0);
        busA            : in     vl_logic_vector(31 downto 0);
        sel             : in     vl_logic_vector(31 downto 0);
        zSLL            : out    vl_logic;
        oSLL            : out    vl_logic;
        cSLL            : out    vl_logic;
        nSLL            : out    vl_logic
    );
end shiftll;
