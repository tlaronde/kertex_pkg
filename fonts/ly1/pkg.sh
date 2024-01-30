#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script
# adding the LY1 encoding version (tfm and dvips mapping instructions
# of the PostScript standard (Adobe) fonts to the TeX Kernel system:
# kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2018, 2020, 2024
#   Thierry Laronde <tlaronde@polynum.com>
# All rights reserved and absolutely no warranty! Use at your own
# risks.
#

# Needed post action (build, apply, remove) routines.
#
pkg_post_build()
{
	return 0 # 
}

pkg_post_apply()
{
	return 0 #
}

pkg_post_remove()
{
	return 0 #
}

#==================== AUTOMATIC PROCESSING
# First include the pecularities of the TeX kernel system host.
#
. which_kertex >&2

# Then we now how to find the library that defines routines and does
# some checks, argument processing and initializations. See the file
# directly for explanations.
#
. $KERTEX_BINDIR/lib/pkglib.sh


#==================== CUSTOM PROCESSING: we are in TMPDIR
#

pkg_get

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: fonts/ly1
VERSION: 2022-06-11
LICENCE: LaTeX Project Public License
KERTEX_VERSION: 0.99.22.0
DESCRIPTION:
LY1 encoding (tfm and dvips maps) of the PostScript standard fonts.
KXPATH:
	fonts ly1
	latex ly1
	tex ly1
DVIPS:
p +pbk8y.map
p +pag8y.map
p +phv8y.map
p +ppl8y.map
p +pcr8y.map
p +ptm8y.map
p +pzc8y.map
p +pnc8y.map
SOURCES:
	LCD HOME/doc/ 
	GET /fonts/psfonts/ly1/README.md
	LCD HOME/enc/ 
	GET /fonts/psfonts/ly1/enc//texnansi.enc
	LCD /lib/tex/ly1/ 
	GET /fonts/psfonts/ly1/plain/texnansi.tex
	LCD /lib/latex/ly1/ 
	GET /fonts/psfonts/ly1/latex/ly1enc.def
	GET ly1pag.fd
	GET ly1pbk.fd
	GET ly1pcr.fd
	GET ly1phv.fd
	GET ly1pnc.fd
	GET ly1ppl.fd
	GET ly1ptm.fd
	GET ly1pzc.fd
	GET texnansi.sty
	LCD /lib/dvips/ 
	GET /fonts/psfonts/ly1/map/pag8y.map
	GET pbk8y.map
	GET pcr8y.map
	GET phv8y.map
	GET pnc8y.map
	GET ppl8y.map
	GET ptm8y.map
	GET pzc8y.map
	LCD /lib/fonts/adobe/avantgar/tfm 
	GET /fonts/psfonts/ly1/tfm/pagd8y.tfm
	GET pagdo8y.tfm
	GET pagk8y.tfm
	GET pagko8y.tfm
	LCD /lib/fonts/adobe/bookman/tfm 
	GET pbkd8y.tfm
	GET pbkdi8y.tfm
	GET pbkdo8y.tfm
	GET pbkl8y.tfm
	GET pbkli8y.tfm
	GET pbklo8y.tfm
	LCD /lib/fonts/adobe/courier/tfm 
	GET pcrb8y.tfm
	GET pcrbo8y.tfm
	GET pcrr8y.tfm
	GET pcrro8y.tfm
	LCD /lib/fonts/adobe/helvetic/tfm 
	GET phvb8y.tfm
	GET phvb8yn.tfm
	GET phvbo8y.tfm
	GET phvbo8yn.tfm
	GET phvr8y.tfm
	GET phvr8yn.tfm
	GET phvro8y.tfm
	GET phvro8yn.tfm
	LCD /lib/fonts/adobe/ncntrsbk/tfm 
	GET pncb8y.tfm
	GET pncbi8y.tfm
	GET pncbo8y.tfm
	GET pncr8y.tfm
	GET pncri8y.tfm
	GET pncro8y.tfm
	LCD /lib/fonts/adobe/palatino/tfm 
	GET pplb8y.tfm
	GET pplbi8y.tfm
	GET pplbo8y.tfm
	GET pplbu8y.tfm
	GET pplr8y.tfm
	GET pplr8yn.tfm
	GET pplri8y.tfm
	GET pplro8y.tfm
	GET pplrr8ye.tfm
	GET pplru8y.tfm
	LCD /lib/fonts/adobe/zapfchan/tfm 
	GET pzcmi8y.tfm
	LCD /lib/fonts/adobe/times/tfm 
	GET ptmb8y.tfm
	GET ptmbc8y.tfm
	GET ptmbi8y.tfm
	GET ptmbo8y.tfm
	GET ptmr8y.tfm
	GET ptmr8yn.tfm
	GET ptmrc8y.tfm
	GET ptmri8y.tfm
	GET ptmro8y.tfm
	GET ptmrr8ye.tfm
	LCD /lib/fonts/adobe/times/vf 
	GET /fonts/psfonts/ly1/vf/ptmbc8y.vf
	GET ptmrc8y.vf
END:
END_CID
