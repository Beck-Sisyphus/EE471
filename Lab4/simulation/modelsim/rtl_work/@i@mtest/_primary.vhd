library verilog;
use verilog.vl_types.all;
entity IMtest is
    generic(
        d               : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of d : constant is 1;
end IMtest;
