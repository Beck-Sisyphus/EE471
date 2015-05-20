library verilog;
use verilog.vl_types.all;
entity xorGate is
    port(
        busXOR          : out    vl_logic_vector(31 downto 0);
        busA            : in     vl_logic_vector(31 downto 0);
        busB            : in     vl_logic_vector(31 downto 0);
        zXOR            : out    vl_logic;
        oXOR            : out    vl_logic;
        cXOR            : out    vl_logic;
        nXOR            : out    vl_logic
    );
end xorGate;
