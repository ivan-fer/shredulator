<CsoundSynthesizer>
<CsOptions>
	-odac -iadc -b512 -B1024
</CsOptions>
<CsInstruments>

	sr = 48000
	ksmps = 16
	nchnls = 2
	0dbfs = 1

	#include "lib/wdg_main.udo"

    garevL init 0
    garevR init 0

	alwayson "Shrelator"
	alwayson "Reverb"


instr Shrelator
    kmax_delay = gkdel_max
	kmax_delay init 1
	ksemitones = gktrn_sems
	kcents = gktrn_cents
	ktrn_rand = gktrn_rnd
	kdepth = gkdel_depth
	krate = gkdel_rate
	ktranspose = ksemitones + kcents * .01
	kfeedback = gkdel_fb
	kwidth = gkout_width
	kdry_wet = gkout_mix
	klevel = gkout_level
	kfft_index = gkdel_fft
	kfft_index init 4
	kgranulation = gkdel_gran
	kpre_post = gktrn_pp
	kpre_post init 1
	iFFT_sizes[] fillarray 128, 256, 512, 1024, 2048, 4096

	aL, aR ins

	if changed(kmax_delay, kfft_index) == 1 then
		reinit RESTART
	endif
	RESTART:
	ifft_size = iFFT_sizes[i(kfft_index)]
	fsigInL pvsanal aL, ifft_size, ifft_size / 4, ifft_size, 1
	fsigInR pvsanal aR, ifft_size, ifft_size / 4, ifft_size, 1
	fsigFB pvsinit ifft_size
	fsigMixL pvsmix fsigInL, fsigFB
	fsigMixR pvsmix fsigInR, fsigFB

	iHandel1, kTime pvsbuffer fsigMixL, i(kmax_delay)
	kDly1 randomh 0, i(kmax_delay) * kdepth, krate, 1
	kAmp1 trandom changed(kDly1), -kgranulation * 60, 0
	ktransp1 trandom changed(kDly1), ktranspose - (2 * ktranspose + ktrn_rand), ktranspose

	fsigOut pvsbufread kTime - kDly1, iHandel1
	fsigGran pvsgain fsigOut, ampdbfs(kAmp1)
	fScale pvscale fsigGran, semitone(ktransp1)
	fsigFB pvsgain fScale, kfeedback
	if kpre_post == 1 then
		aDly pvsynth fsigGran
	else
		aDly pvsynth fScale
	endif
	aMix ntrpol aL, aDly, kdry_wet
		outs aMix * klevel * (1 - kwidth), aMix * klevel

	iHandel2, kTime pvsbuffer fsigMixR, i(kmax_delay)
	kDly2 randomh 0, i(kmax_delay) * kdepth, krate, 1
	kAmp2 trandom changed(kDly2), -kgranulation * 60, 0
	ktransp2 trandom changed(kDly2), ktranspose - (2 * ktranspose + ktrn_rand), ktranspose

	fsigOut pvsbufread kTime - kDly2, iHandel2
	fsigGran pvsgain fsigOut, ampdbfs(kAmp2)
	fScale pvscale fsigGran, semitone(ktransp2)
	fsigFB pvsgain fScale, kfeedback
	if kpre_post == 1 then
		aDly pvsynth fsigGran
	else
		aDly pvsynth fScale
	endif
	aMix ntrpol aR, aDly, kdry_wet
		outs aMix * klevel, aMix * klevel * (1 - kwidth)
endin


instr Reverb
    if gkrevsc_x == 0 goto SKIP

    	kporttime linseg 0, 0.001, 0.02
	kfblvl portk gkrevsc_fblvl, kporttime
	kfco portk gkrevsc_fco, kporttime

	ktrig changed gkrevsc_sr, gkrevsc_pv, gkrevsc_skip
	if ktrig == 1 then
		reinit UPDATE
	endif
	UPDATE:
			israte init i(gkrevsc_sr)
			ipitchm init i(gkrevsc_pv)
			iskip init i(gkrevsc_skip)
		aL, aR reverbsc garevL, garevR, kfblvl, kfco, israte, ipitchm, iskip
	rireturn
		outs aL, aR
	clear garevL, garevR

    SKIP:
endin

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>