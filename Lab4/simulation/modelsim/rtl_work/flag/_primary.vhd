library verilog;
use verilog.vl_types.all;
entity flag is
    port(
        busOut          : in     vl_logic_vector(31 downto 0);
        busA            : in     vl_logic_vector(31 downto 0);
        busB            : in     vl_logic_vector(31 downto 0);
        carryOut        : in     vl_logic;
        z               : out    vl_logic;
        o               : out    vl_logic;
        c               : out    vl_logic;
        n               : out    vl_logic
    );
end flag;
