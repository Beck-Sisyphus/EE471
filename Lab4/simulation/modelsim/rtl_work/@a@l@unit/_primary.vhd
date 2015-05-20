library verilog;
use verilog.vl_types.all;
entity ALUnit is
    generic(
        nul             : vl_logic_vector(31 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        NOP             : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi0);
        ADD             : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        SUB             : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        \AND\           : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi1);
        \OR\            : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi0);
        \XOR\           : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi1);
        SLT             : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi0);
        \SLL\           : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi1)
    );
    port(
        control         : in     vl_logic_vector(2 downto 0);
        busA            : in     vl_logic_vector(31 downto 0);
        busB            : in     vl_logic_vector(31 downto 0);
        busOut          : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic;
        overflow        : out    vl_logic;
        carryout        : out    vl_logic;
        negative        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of nul : constant is 2;
    attribute mti_svvh_generic_type of NOP : constant is 2;
    attribute mti_svvh_generic_type of ADD : constant is 2;
    attribute mti_svvh_generic_type of SUB : constant is 2;
    attribute mti_svvh_generic_type of \AND\ : constant is 2;
    attribute mti_svvh_generic_type of \OR\ : constant is 2;
    attribute mti_svvh_generic_type of \XOR\ : constant is 2;
    attribute mti_svvh_generic_type of SLT : constant is 2;
    attribute mti_svvh_generic_type of \SLL\ : constant is 2;
end ALUnit;
