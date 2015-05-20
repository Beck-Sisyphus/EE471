library verilog;
use verilog.vl_types.all;
entity SRAM2Kby16 is
    generic(
        DATA_WIDTH      : integer := 16;
        DATA_LENGTH     : integer := 256;
        ADX_LENGTH      : integer := 11
    );
    port(
        clk             : in     vl_logic;
        adx             : in     vl_logic_vector;
        WrEn            : in     vl_logic;
        data            : inout  vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_LENGTH : constant is 1;
    attribute mti_svvh_generic_type of ADX_LENGTH : constant is 1;
end SRAM2Kby16;
