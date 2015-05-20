library verilog;
use verilog.vl_types.all;
entity orGate is
    port(
        busOR           : out    vl_logic_vector(31 downto 0);
        busA            : in     vl_logic_vector(31 downto 0);
        busB            : in     vl_logic_vector(31 downto 0);
        zOR             : out    vl_logic;
        oOR             : out    vl_logic;
        cOR             : out    vl_logic;
        \nOR\           : out    vl_logic
    );
end orGate;
