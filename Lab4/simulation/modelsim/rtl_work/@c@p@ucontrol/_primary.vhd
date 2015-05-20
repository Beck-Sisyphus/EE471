library verilog;
use verilog.vl_types.all;
entity CPUcontrol is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        n               : in     vl_logic;
        IMR             : in     vl_logic;
        instr2Load      : in     vl_logic_vector(31 downto 0);
        loadAdx         : in     vl_logic_vector(6 downto 0);
        regWR           : out    vl_logic;
        Mem2Reg         : out    vl_logic;
        ALUop           : out    vl_logic;
        MemWrEn         : out    vl_logic;
        ALUsrc          : out    vl_logic;
        RegDst          : out    vl_logic;
        regAdx1         : out    vl_logic_vector(4 downto 0);
        regAdx2         : out    vl_logic_vector(4 downto 0);
        writeAdx        : out    vl_logic_vector(4 downto 0);
        imd             : out    vl_logic_vector(31 downto 0)
    );
end CPUcontrol;
