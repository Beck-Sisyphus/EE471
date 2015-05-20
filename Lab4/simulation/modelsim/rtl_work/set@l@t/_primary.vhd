library verilog;
use verilog.vl_types.all;
entity setLT is
    port(
        busSLT          : out    vl_logic_vector(31 downto 0);
        busA            : in     vl_logic_vector(31 downto 0);
        busB            : in     vl_logic_vector(31 downto 0);
        zSLT            : out    vl_logic;
        oSLT            : out    vl_logic;
        cSLT            : out    vl_logic;
        nSLT            : out    vl_logic
    );
end setLT;
