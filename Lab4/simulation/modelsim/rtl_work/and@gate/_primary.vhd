library verilog;
use verilog.vl_types.all;
entity andGate is
    port(
        busAND          : out    vl_logic_vector(31 downto 0);
        busA            : in     vl_logic_vector(31 downto 0);
        busB            : in     vl_logic_vector(31 downto 0);
        zAND            : out    vl_logic;
        oAND            : out    vl_logic;
        cAND            : out    vl_logic;
        \nAND\          : out    vl_logic
    );
end andGate;
