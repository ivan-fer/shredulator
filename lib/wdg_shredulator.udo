#define CHOICE_FFT_SIZE(xpos'ypos)
#
        ix = $xpos
        iy = $ypos
        iwidth = 150
        iheight = 80
    ih FLbox "", 8, 5, 14, iwidth, iheight, ix, iy + 10    
    ih2 FLbox "FFT Size", 8, 5, 14, 75, 20, ix + 8, iy
    FLlabel 12, 1, 1, $ColorPanel
    FLcolor -1
        ix = $xpos + 6
        iy = $ypos + 23
    gkdel_fft, ihdel_fft FLbutBank 4, 2, 3, 140, 60, ix, iy, -1 
    FLsetVal_i 4, ihdel_fft
    FLlabel 12, 1, 1, $ColorWithe
    FLcolor $ColorGroup
        ix = ix + 21
        idespl = 20
        iwidth = 40
        iheight = 22
    ih FLbox "128 ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "256 ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "512 ", 1, 5, 14, iwidth, iheight, ix, iy
        ix = ix + 70
        iy = $ypos + 23
    ih FLbox "1024", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "2048", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "4096", 1, 5, 14, iwidth, iheight, ix, iy
#

#define FLGROUP_DELAY(xpos'ypos)
#
	idespl = 75
	iw = idespl * 7 + 25
	ih = 105
	$GROUP_HEAD($xpos'$ypos'iw)
	FLgroup "    D  e  l  a  y", iw, ih, $xpos, $ypos, 0
        $CHOICE_FFT_SIZE($xpos+10'$ypos+8)
        	idespl = 75
			ix = ix + idespl
			iy = $ypos + 16
		$KNOB(del_max'"max.del"'ix'iy'.1'8'3.7'0)
			ix = ix + idespl
		$KNOB(del_rate'"rate"'ix'iy'.1'500'10'-1)
			ix = ix + idespl
		$KNOB(del_depth'"depth"'ix'iy'0'1'.2'0)
			ix = ix + idespl
		$KNOB(del_gran'"granulat"'ix'iy'0'1'.2'0)
			ix = ix + idespl
		$KNOB(del_fb'"feedback"'ix'iy'0'1'.5'0)
	FLgroupEnd
        ix = $xpos + iw - 24
        iy = $ypos - 18
    $BUTTON_ON_OFF(del_x'ix'iy)
#

#define CHOICE_PRE_POST(xpos'ypos)
#
    FLcolor $ColorGroup
        ix = $xpos
        iy = $ypos
        iwidth = 106
        iheight = 60
    ih FLbox "", 8, 5, 14, iwidth, iheight, ix, iy + 10    
    ih2 FLbox "Pre / Post", 8, 5, 14, 90, 20, ix + 8, iy
    FLlabel 12, 1, 1, $ColorPanel
    FLcolor -1
        ix = $xpos + 6
        iy = $ypos + 23
    gktrn_pp, ihtrn_pp FLbutBank 4, 1, 2, 75, 40, ix, iy, -1 
    FLsetVal_i 1, ihtrn_pp
    FLlabel 12, 1, 1, $ColorWithe
    FLcolor $ColorGroup
        ix = ix + 21
        idespl = 20
        iwidth = 40
        iheight = 22
    ih FLbox "Pre ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "Post", 1, 5, 14, iwidth, iheight, ix, iy
#

#define FLGROUP_TRANSPOSE(xpos'ypos)
#
	idespl = 75
	iw = 550
	ih = 95
	$GROUP_HEAD($xpos'$ypos'iw)
	FLgroup "    T  r  a  n  s  p  o  s  e", iw, ih, $xpos, $ypos, 0
			ix = $xpos + 14 + 70
            iy = $ypos + 8
		$KNOB(trn_sems'"semitones"'ix'iy'-12'12'5'0)
			ix = ix + idespl
		$KNOB(trn_cents'"cents"'ix'iy'-100'100'0'0)
			ix = ix + idespl
			iy = $ypos + 8
        $CHOICE_PRE_POST(ix'iy)
			ix = $xpos + 370
   			iy = $ypos + 8
		$KNOB(trn_rnd'"randomise"'ix'iy'0'1'.350'0)
	FLgroupEnd
        ix = $xpos + iw - 24
        iy = $ypos - 18
    $BUTTON_ON_OFF(trn_x'ix'iy)
#

#define FLGROUP_OUTPUT(xpos'ypos)
#
	idespl = 75
	iw = 550
	ih = 95
	$GROUP_HEAD($xpos'$ypos'iw)
	FLgroup "    O  u  t  p  u  t", iw, ih, $xpos, $ypos, 0
			ix = $xpos + 10 + 155
			iy = $ypos + 8
		$KNOB(out_width'"width"'ix'iy'0'1'1'0)
			ix = ix + idespl
		$KNOB(out_mix'"dry/wet"'ix'iy'0'1'1'0)
			ix = ix + idespl
		$KNOB(out_level'"level"'ix'iy'0'1'1'0)
	FLgroupEnd
        ix = $xpos + iw - 24
        iy = $ypos - 18
    $BUTTON_ON_OFF(out_x'ix'iy)
#