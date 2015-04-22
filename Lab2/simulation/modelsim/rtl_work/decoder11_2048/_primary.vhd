library verilog;
use verilog.vl_types.all;
entity decoder11_2048 is
    port(
        \in\            : in     vl_logic_vector(10 downto 0);
        \out\           : out    vl_logic_vector(2047 downto 0)
    );
end decoder11_2048;
