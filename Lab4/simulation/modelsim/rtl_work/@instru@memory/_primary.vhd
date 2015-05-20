library verilog;
use verilog.vl_types.all;
entity InstruMemory is
    generic(
        DATA_WIDTH      : integer := 32;
        DATA_LENGTH     : integer := 128;
        ADX_LENGTH      : integer := 7
    );
    port(
        clk             : in     vl_logic;
        adx             : in     vl_logic_vector;
        WrEn            : in     vl_logic;
        data            : inout  vl_logic_vector;
        rst             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_LENGTH : constant is 1;
    attribute mti_svvh_generic_type of ADX_LENGTH : constant is 1;
end InstruMemory;
