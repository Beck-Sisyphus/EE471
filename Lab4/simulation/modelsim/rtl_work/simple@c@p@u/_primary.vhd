library verilog;
use verilog.vl_types.all;
entity simpleCPU is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IMR             : in     vl_logic;
        instr2load      : in     vl_logic_vector(31 downto 0);
        loadAdx         : in     vl_logic_vector(6 downto 0)
    );
end simpleCPU;
