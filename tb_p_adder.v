module p_adder_tb;
reg t_cin;
reg [7:0] t_a,t_b;
wire [7:0] t_s;
initial begin $dumpfile("dump.vcd"); $dumpvars(0, p_adder_tb); end
bit8_prefix_adder b8pa (.a(t_a), .b(t_b), .cin(t_cin), .sum(t_s));
initial
begin
	t_a [7:0] = 8'b00001010;
	t_b [7:0] = 8'b00010100;
	t_cin = 1'b0;
	#5
	t_a [7:0] = 8'b00010100;
	t_b [7:0] = 8'b00011110;
	t_cin = 1'b0;
	#5
	t_a [7:0] = 8'b01101000;
	t_b [7:0] = 8'b00101011;
	t_cin = 1'b0;
	#5
	t_a [7:0] = 8'b00101100;
	t_b [7:0] = 8'b01000011;
	t_cin = 1'b0;
	#5
	t_a [7:0] = 8'b0110110;
	t_b [7:0] = 8'b0001110;
	t_cin = 1'b0;
	#5
	t_a [7:0] = 8'b0011010;
	t_b [7:0] = 8'b1001000;
	t_cin = 1'b0;
	#5
	t_a [7:0] = 8'b00000000;
	t_b [7:0] = 8'b00000001;
	t_cin = 1'b0;
end
endmodule
