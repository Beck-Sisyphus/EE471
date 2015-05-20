library verilog;
use verilog.vl_types.all;
entity addition is
    port(
        busADD          : out    vl_logic_vector(31 downto 0);
        busA            : in     vl_logic_vector(31 downto 0);
        busB            : in     vl_logic_vector(31 downto 0);
        zADD            : out    vl_logic;
        oADD            : out    vl_logic;
        cADD            : out    vl_logic;
        nADD            : out    vl_logic
    );
end addition;
