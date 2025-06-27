# File saved with Nlview 7.8.0 2024-04-26 e1825d835c VDI=44 GEI=38 GUI=JA:21.0 threadsafe
# 
# non-default properties - (restore without -noprops)
property -colorscheme classic
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 18
property maxzoom 7.5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlaycolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 4
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 18
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 1
property timelimit 1
#
module new four_bit_subtractor work:four_bit_subtractor:NOFILE -nosplit
load symbol RTL_INV0 work INV pin I0 input pin O output fillcolor 1
load symbol RTL_ADD0 work RTL(+) pinBus I0 input.left [4:0] pinBus I1 input.left [4:0] pinBus O output.right [4:0] fillcolor 1
load symbol RTL_INV work INV pinBus I0 input [3:0] pinBus O output [3:0] fillcolor 1
load symbol RTL_ADD work RTL(+) pin I1 input.left pinBus I0 input.left [4:0] pinBus O output.right [4:0] fillcolor 1
load port borrow output -pg 1 -lvl 5 -x 730 -y 60
load portBus a input [3:0] -attr @name a[3:0] -pg 1 -lvl 0 -x 0 -y 40
load portBus b input [3:0] -attr @name b[3:0] -pg 1 -lvl 0 -x 0 -y 80
load portBus sub output [3:0] -attr @name sub[3:0] -pg 1 -lvl 5 -x 730 -y 20
load inst borrow_i RTL_INV0 work -attr @cell(#000000) RTL_INV -pg 1 -lvl 4 -x 630 -y 60
load inst temp0_i RTL_ADD0 work -attr @cell(#000000) RTL_ADD -pinBusAttr I0 @name I0[4:0] -pinBusAttr I1 @name I1[4:0] -pinBusAttr O @name O[4:0] -pg 1 -lvl 2 -x 270 -y 70
load inst temp1_i RTL_INV work -attr @cell(#000000) RTL_INV -pinBusAttr I0 @name I0[3:0] -pinBusAttr O @name O[3:0] -pg 1 -lvl 1 -x 70 -y 80
load inst temp_i RTL_ADD work -attr @cell(#000000) RTL_ADD -pinBusAttr I0 @name I0[4:0] -pinBusAttr O @name O[4:0] -pg 1 -lvl 3 -x 450 -y 60
load net <const0> -ground -attr @rip 4 -pin temp0_i I0[4] -pin temp0_i I1[4]
load net <const1> -power -pin temp_i I1
load net a[0] -attr @rip a[0] -port a[0] -pin temp0_i I0[0]
load net a[1] -attr @rip a[1] -port a[1] -pin temp0_i I0[1]
load net a[2] -attr @rip a[2] -port a[2] -pin temp0_i I0[2]
load net a[3] -attr @rip a[3] -port a[3] -pin temp0_i I0[3]
load net b[0] -attr @rip b[0] -port b[0] -pin temp1_i I0[0]
load net b[1] -attr @rip b[1] -port b[1] -pin temp1_i I0[1]
load net b[2] -attr @rip b[2] -port b[2] -pin temp1_i I0[2]
load net b[3] -attr @rip b[3] -port b[3] -pin temp1_i I0[3]
load net borrow -port borrow -pin borrow_i O
netloc borrow 1 4 1 NJ 60
load net p_0_in[0] -attr @rip O[0] -pin temp0_i I1[0] -pin temp1_i O[0]
load net p_0_in[1] -attr @rip O[1] -pin temp0_i I1[1] -pin temp1_i O[1]
load net p_0_in[2] -attr @rip O[2] -pin temp0_i I1[2] -pin temp1_i O[2]
load net p_0_in[3] -attr @rip O[3] -pin temp0_i I1[3] -pin temp1_i O[3]
load net sub[0] -attr @rip O[0] -port sub[0] -pin temp_i O[0]
load net sub[1] -attr @rip O[1] -port sub[1] -pin temp_i O[1]
load net sub[2] -attr @rip O[2] -port sub[2] -pin temp_i O[2]
load net sub[3] -attr @rip O[3] -port sub[3] -pin temp_i O[3]
load net temp0_i_n_0 -attr @rip O[4] -pin temp0_i O[4] -pin temp_i I0[4]
load net temp0_i_n_1 -attr @rip O[3] -pin temp0_i O[3] -pin temp_i I0[3]
load net temp0_i_n_2 -attr @rip O[2] -pin temp0_i O[2] -pin temp_i I0[2]
load net temp0_i_n_3 -attr @rip O[1] -pin temp0_i O[1] -pin temp_i I0[1]
load net temp0_i_n_4 -attr @rip O[0] -pin temp0_i O[0] -pin temp_i I0[0]
load net temp[4] -attr @rip O[4] -pin borrow_i I0 -pin temp_i O[4]
netloc temp[4] 1 3 1 580J 60
load netBundle @a 4 a[3] a[2] a[1] a[0] -autobundled
netbloc @a 1 0 2 NJ 40 200J
load netBundle @b 4 b[3] b[2] b[1] b[0] -autobundled
netbloc @b 1 0 1 NJ 80
load netBundle @sub 4 sub[3] sub[2] sub[1] sub[0] -autobundled
netbloc @sub 1 3 2 560J 20 NJ
load netBundle @temp0_i_n_ 5 temp0_i_n_0 temp0_i_n_1 temp0_i_n_2 temp0_i_n_3 temp0_i_n_4 -autobundled
netbloc @temp0_i_n_ 1 2 1 N 70
load netBundle @p_0_in 4 p_0_in[3] p_0_in[2] p_0_in[1] p_0_in[0] -autobundled
netbloc @p_0_in 1 1 1 180J 80
levelinfo -pg 1 0 70 270 450 630 730
pagesize -pg 1 -db -bbox -sgen -90 0 830 140
show
fullfit
#
# initialize ictrl to current module four_bit_subtractor work:four_bit_subtractor:NOFILE
ictrl init topinfo |
