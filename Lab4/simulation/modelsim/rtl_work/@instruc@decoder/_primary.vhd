library verilog;
use verilog.vl_types.all;
entity InstrucDecoder is
    generic(
        nop             : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi0);
        add             : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        sub             : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi0, Hi1, Hi0);
        \AND\           : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi0);
        \OR\            : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1);
        \XOR\           : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi0);
        slt             : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi1, Hi0, Hi1, Hi0);
        \sll\           : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        lw              : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi0, Hi1, Hi1);
        sw              : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi1, Hi0, Hi1, Hi1);
        jmp             : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        jr              : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        bgt             : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi1)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of nop : constant is 1;
    attribute mti_svvh_generic_type of add : constant is 1;
    attribute mti_svvh_generic_type of sub : constant is 1;
    attribute mti_svvh_generic_type of \AND\ : constant is 1;
    attribute mti_svvh_generic_type of \OR\ : constant is 1;
    attribute mti_svvh_generic_type of \XOR\ : constant is 1;
    attribute mti_svvh_generic_type of slt : constant is 1;
    attribute mti_svvh_generic_type of \sll\ : constant is 1;
    attribute mti_svvh_generic_type of lw : constant is 1;
    attribute mti_svvh_generic_type of sw : constant is 1;
    attribute mti_svvh_generic_type of jmp : constant is 1;
    attribute mti_svvh_generic_type of jr : constant is 1;
    attribute mti_svvh_generic_type of bgt : constant is 1;
    -- This module cannot be connected to/from
    -- VHDL because it has unnamed ports.
end InstrucDecoder;
