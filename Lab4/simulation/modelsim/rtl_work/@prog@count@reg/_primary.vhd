library verilog;
use verilog.vl_types.all;
entity ProgCountReg is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        jAdx            : in     vl_logic_vector(25 downto 0);
        brAdx           : in     vl_logic_vector(31 downto 0);
        j               : in     vl_logic;
        br              : in     vl_logic;
        n               : in     vl_logic;
        prgCount        : out    vl_logic_vector(6 downto 0)
    );
end ProgCountReg;
