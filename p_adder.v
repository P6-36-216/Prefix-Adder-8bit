module and1 (input wire i0, i1, output wire o);
	assign o = i0 & i1;
endmodule

module or1 (input wire i0, i1, output wire o);
	assign o = i0 | i1;
endmodule

module xor1 (input wire i0, i1, output wire o);
	assign o = i0 ^ i1;
endmodule

module xor2 (input wire i0, i1, i2, output wire o);
	wire t;
	xor1 x1 (i0, i1, t);
	xor1 x2 (i2, t, o);
endmodule

module pigi (input wire a, b, output wire p, g);
	or1 or_1 (a, b, p);
	and1 and_1 (a, b, g);
endmodule

module sum1 (input wire a, b, gi, output wire s);
	xor2 x3 (a, b, gi, s);
endmodule

module box (input wire pi, gi, pj, gj, output wire pf, gf);
	wire t;
	and1 a1 (pi, pj, pf);
	and1 a2 (pi, gj, t);
	or1 o1 (gi, t, gf);
endmodule


module bit8_prefix_adder (input wire [7:0] a, b, input wire cin, output wire [7:0] sum);
	wire [7:0] p, g;
	
	pigi p0_g0 (a[0], b[0], p[0], g[0]);
	pigi p1_g1 (a[1], b[1], p[1], g[1]);
	pigi p2_g2 (a[2], b[2], p[2], g[2]);
	pigi p3_g3 (a[3], b[3], p[3], g[3]);
	pigi p4_g4 (a[4], b[4], p[4], g[4]);
	pigi p5_g5 (a[5], b[5], p[5], g[5]);
	pigi p6_g6 (a[6], b[6], p[6], g[6]);
	pigi p7_g7 (a[7], b[7], p[7], g[7]);
	
	wire [3:0] lvl1_P, lvl1_G;
	box box_lvl1_0 (p[0], g[0], 1'b0, cin, lvl1_P[0], lvl1_G[0]);
	box box_lvl1_1 (p[2], g[2], p[1], g[1], lvl1_P[1], lvl1_G[1]);
	box box_lvl1_2 (p[4], g[4], p[3], g[3], lvl1_P[2], lvl1_G[2]);
	box box_lvl1_3 (p[6], g[6], p[5], g[5], lvl1_P[3], lvl1_G[3]);
	
	wire [3:0] lvl2_P, lvl2_G;
	box box_lvl2_0 (p[1], g[1], lvl1_P[0], lvl1_G[0], lvl2_P[0], lvl2_G[0]);
	box box_lvl2_1 (lvl1_P[1], lvl1_G[1], lvl1_P[0], lvl1_G[0], lvl2_P[1], lvl2_G[1]);
	box box_lvl2_2 (p[5], g[5], lvl1_P[2], lvl1_G[2], lvl2_P[2], lvl2_G[2]);
	box box_lvl2_3 (lvl1_P[3], lvl1_G[3], lvl1_P[2], lvl1_G[2], lvl2_P[3], lvl2_G[3]);
	
	wire [3:0] lvl3_P, lvl3_G;
	box box_lvl3_0 (p[3], g[3], lvl2_P[1], lvl2_G[1], lvl3_P[0], lvl3_G[0]);
	box box_lvl3_1 (lvl1_P[2], lvl1_G[2], lvl2_P[1], lvl2_G[1], lvl3_P[1], lvl3_G[1]);
	box box_lvl3_2 (lvl2_P[2], lvl2_G[2], lvl2_P[1], lvl2_G[1], lvl3_P[2], lvl3_G[2]);
	box box_lvl3_3 (lvl2_P[3], lvl2_G[3], lvl2_P[1], lvl2_G[1], lvl3_P[3], lvl3_G[3]);
	
	sum1 sum_0 (a[0], b[0], cin, sum[0]);
	sum1 sum_1 (a[1], b[1], lvl1_G[0], sum[1]);
	sum1 sum_2 (a[2], b[2], lvl2_G[0], sum[2]);
	sum1 sum_3 (a[3], b[3], lvl2_G[1], sum[3]);
	sum1 sum_4 (a[4], b[4], lvl3_G[0], sum[4]);
	sum1 sum_5 (a[5], b[5], lvl3_G[1], sum[5]);
	sum1 sum_6 (a[6], b[6], lvl3_G[2], sum[6]);
	sum1 sum_7 (a[7], b[7], lvl3_G[3], sum[7]);
	
endmodule
