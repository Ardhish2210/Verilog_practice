module mux_new (a, sel, out);

input [1:0] a;
input sel;
output out;

assign out = (sel) ? a[1] : a[0];

endmodule