library verilog;
use verilog.vl_types.all;
entity subtract is
    port(
        busSUB          : out    vl_logic_vector(31 downto 0);
        busA            : in     vl_logic_vector(31 downto 0);
        busB            : in     vl_logic_vector(31 downto 0);
        zSUB            : out    vl_logic;
        oSUB            : out    vl_logic;
        cSUB            : out    vl_logic;
        nSUB            : out    vl_logic
    );
end subtract;
