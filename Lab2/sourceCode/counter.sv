module counter(df);

always @(*) begin
	NS = PS ++;
end

always @(posedge clk) begin
	PS=NS;
end

endmodule


