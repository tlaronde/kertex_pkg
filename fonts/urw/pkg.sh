#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of the URW PostScript fonts to the TeX kernel
# system: kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2018, 2020, 2024
#   Thierry Laronde <tlaronde@polynum.com>
# $Id: pkg.sh,v 1.9 2024/01/21 14:16:55 tlaronde Exp $
# All rights reserved and absolutely no warranty! Use at your own 
# risks.
#
# XXX: 8r.enc, which is more or less LaTeX related, should be retrieved
# from latex/psnfss required package. For simplicity, we retrieve a
# copy so that the fonts are not strictly and uniquely LaTeX related.
#

# Needed post action (build, apply, remove) routines.
#
pkg_post_build()
{
	return 0 # bash errors on empty function...
}

pkg_post_apply()
{
	return 0 # bash errors on empty function...
}

pkg_post_remove()
{
	return 0 # bash errors on empty function...
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
# We will generate the gf, tfm and pk version instead of copying.
#
pkg_get

pkg_log ""
pkg_log "1. Extracting URW garamond tfm, vf, map and LaTeX fd."
pkg_log ""
$PKG_UNZIP ugm.zip
rm ugm.zip
mv tex/latex/ugm/* lib/latex/urw
mv dvips/config/ugm.map lib/dvips
mv fonts/tfm/urw/garamond/*.tfm lib/$PKG_NAME/tfm
mv fonts/vf/urw/garamond/*.vf lib/$PKG_NAME/vf

pkg_log ""
pkg_log "2. Extracting URW grotesq tfm, vf, map and LaTeX fd."
pkg_log ""
$PKG_UNZIP ugq.zip
rm ugq.zip
mv tex/latex/ugq/* lib/latex/urw
mv dvips/config/ugq.map lib/dvips
mv fonts/tfm/urw/grotesq/*.tfm lib/$PKG_NAME/tfm
mv fonts/vf/urw/grotesq/*.vf lib/$PKG_NAME/vf

pkg_log ""
pkg_log "3. Extracting URW lettergothic tfm, vf, map and LaTeX fd."
pkg_log ""
$PKG_UNZIP ulg.zip
rm ulg.zip
mv tex/latex/ulg/* lib/latex/urw
mv dvips/config/ulg.map lib/dvips
mv fonts/tfm/urw/lettrgth/*.tfm lib/$PKG_NAME/tfm
mv fonts/vf/urw/lettrgth/*.vf lib/$PKG_NAME/vf

pkg_log ""
pkg_log "4. Generating tfm from afm for URW base35 fonts."
pkg_log ""
urwbase35txtlist=$TMPDIR/urwbase35txt.$$
ed $PKG_FQ_SCRIPT <<EOT >$PKG_NULL_FILE 2>&1
/^BEGIN_URWBASE35_TXT/+,/^END_URWBASE35_TXT/-w $urwbase35txtlist
q
EOT

urwbase35symlist=$TMPDIR/urwbase35sym.$$
ed $PKG_FQ_SCRIPT <<EOT >$PKG_NULL_FILE 2>&1
/^BEGIN_URWBASE35_SYM/+,/^END_URWBASE35_SYM/-w $urwbase35symlist
q
EOT


# Since "some" package may add a "urw.map", we prefix 'k' for not
# namespace pollution.
#
map="$TMPDIR/lib/dvips/kurw.map"

cat <<"EOT" >"$map"
% These are all variants using URW 35 bases fonts, implementation of
# PostScript Core fonts.
%
EOT

#
IFS='|'
cd $TMPDIR/lib/fonts/urw/tfm

KERTEXFONTS="$TMP_LIBDIR/fonts/urw;KERTEXSYS"

while read font urwfqfont psfont psfqfont font8r; do
	$KERTEX_BINDIR/afm2tfm ../afm/$font.afm >>"$map"
	$KERTEX_BINDIR/afm2tfm ../afm/$font.afm -v $font8r -T 8r.enc $font8r\
		| sed "s/\$/ <$font.pfb/" >>"$map"
	# tfm rewritten
	$KERTEX_BINDIR/vptovf $font8r.vpl ../vf/$font8r.vf $font8r.tfm
done <$urwbase35txtlist
rm $urwbase35txtlist

while read font urwfqfont psfont psfqfont; do
	$KERTEX_BINDIR/afm2tfm ../afm/$font.afm $font >>"$map"
done <$urwbase35symlist
rm $urwbase35symlist

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: fonts/urw
DESCRIPTION: URW PostScript Type-1 fonts with tfm and vf
AUTHOR: URW
VERSION: 1992, 2006-03-21, 2014-08-28, 2005-07-07, 1992, 2005-02-02
LICENCE: Aladdin Free Public License and LaTeX PPL >= 1.3
KERTEX_VERSION: 0.99.22.0
KXPATH:
	fonts urw
	latex urw
DVIPS:
p +uaq.map
p +ua1.map
p +classico.map
p +ugm.map
p +ugq.map
p +ulg.map
p +kurw.map
SOURCES:
	GET /fonts/urw/garamond/ugm.zip
	GET /fonts/urw/grotesq/ugq.zip
	GET /fonts/urw/lettergothic/ulg.zip
	LCD HOME/enc 
	GET /macros/latex/required/psnfss/8r.enc
	LCD HOME/doc 
	GET /fonts/urw/antiqua/doc/antiqua.txt
	GET readme.antiqua
	GET uaqr8ac.afm.org
	GET /fonts/urw/arial/doc/arial.txt
	GET urw-arial.pdf
	GET /fonts/urw/base35/COPYING
	GET README.base35
	GET /fonts/urw/classico/README README.classico
	GET /fonts/urw/classico/doc/COPYING.AFPL
	GET classico-samples.pdf
	GET classico-samples.tex
	GET /fonts/urw/garamond/README.garamond
	GET urw-garamond.pdf
	GET /fonts/urw/grotesq/readme.grotesq
	GET ugq.txt
	GET /fonts/urw/lettergothic/README.lettergothic
	GET urw-lettergothic.pdf
	LCD HOME/afm 
	GET /fonts/urw/antiqua/fonts/uaqr8ac.afm
	GET /fonts/urw/arial/afm/ua1b8a.afm
	GET ua1bi8a.afm
	GET ua1r8a.afm
	GET ua1ri8a.afm
	GET /fonts/urw/base35/afm/uagd8a.afm
	GET uagdo8a.afm
	GET uagk8a.afm
	GET uagko8a.afm
	GET ubkd8a.afm
	GET ubkdi8a.afm
	GET ubkl8a.afm
	GET ubkli8a.afm
	GET ucrb8a.afm
	GET ucrbo8a.afm
	GET ucrr8a.afm
	GET ucrro8a.afm
	GET uhvb8a.afm
	GET uhvb8ac.afm
	GET uhvbo8a.afm
	GET uhvbo8ac.afm
	GET uhvr8a.afm
	GET uhvr8ac.afm
	GET uhvro8a.afm
	GET uhvro8ac.afm
	GET uncb8a.afm
	GET uncbi8a.afm
	GET uncr8a.afm
	GET uncri8a.afm
	GET uplb8a.afm
	GET uplbi8a.afm
	GET uplr8a.afm
	GET uplri8a.afm
	GET usyr.afm
	GET utmb8a.afm
	GET utmbi8a.afm
	GET utmr8a.afm
	GET utmri8a.afm
	GET uzcmi8a.afm
	GET uzdr.afm
	GET /fonts/urw/classico/afm/URWClassico-Bold.afm
	GET URWClassico-BoldItalic.afm
	GET URWClassico-Italic.afm
	GET URWClassico-Regular.afm
	GET /fonts/urw/garamond/ugmm8a.afm
	GET ugmmi8a.afm
	GET ugmr8a.afm
	GET ugmri8a.afm
	GET /fonts/urw/grotesq/ugqb8a.afm
	GET /fonts/urw/lettergothic/ulgb8a.afm
	GET ulgbi8a.afm
	LCD HOME/enc 
	GET /fonts/urw/classico/enc/clsc_kucjq6.enc
	GET clsc_kxvyln.enc
	GET clsc_tyth7d.enc
	GET clsc_zsv5c7.enc
	LCD HOME/pfb 
	GET /fonts/urw/antiqua/fonts/uaqr8ac.pfb
	GET /fonts/urw/arial/type1/ua1b8a.pfb
	GET ua1bi8a.pfb
	GET ua1r8a.pfb
	GET ua1ri8a.pfb
	GET /fonts/urw/base35/pfb/uagd8a.pfb
	GET uagdo8a.pfb
	GET uagk8a.pfb
	GET uagko8a.pfb
	GET ubkd8a.pfb
	GET ubkdi8a.pfb
	GET ubkl8a.pfb
	GET ubkli8a.pfb
	GET ucrb8a.pfb
	GET ucrbo8a.pfb
	GET ucrr8a.pfb
	GET ucrro8a.pfb
	GET uhvb8a.pfb
	GET uhvb8ac.pfb
	GET uhvbo8a.pfb
	GET uhvbo8ac.pfb
	GET uhvr8a-105.pfb
	GET uhvr8a.pfb
	GET uhvr8ac.pfb
	GET uhvro8a-105.pfb
	GET uhvro8a.pfb
	GET uhvro8ac.pfb
	GET uncb8a.pfb
	GET uncbi8a.pfb
	GET uncr8a.pfb
	GET uncri8a.pfb
	GET uplb8a.pfb
	GET uplbi8a.pfb
	GET uplr8a.pfb
	GET uplri8a.pfb
	GET usyr.pfb
	GET utmb8a.pfb
	GET utmbi8a.pfb
	GET utmr8a.pfb
	GET utmri8a.pfb
	GET uzcmi8a.pfb
	GET uzdr.pfb
	GET /fonts/urw/classico/type1/URWClassico-Bold.pfb
	GET URWClassico-BoldItalic.pfb
	GET URWClassico-BoldItalicLCDFJ.pfb
	GET URWClassico-BoldLCDFJ.pfb
	GET URWClassico-Italic.pfb
	GET URWClassico-ItalicLCDFJ.pfb
	GET URWClassico-Regular.pfb
	GET URWClassico-RegularLCDFJ.pfb
	GET uopb8a.pfb
	GET uopr8a.pfb
	GET /fonts/urw/garamond/ugmm8a.pfb
	GET ugmmi8a.pfb
	GET ugmr8a.pfb
	GET ugmri8a.pfb
	GET /fonts/urw/grotesq/ugqb8a.pfb
	GET /fonts/urw/lettergothic/ulgb8a.pfb
	GET ulgbi8a.pfb
	LCD HOME/vf 
	GET /fonts/urw/antiqua/fonts/uaqr7tc.vf
	GET uaqr8cc.vf
	GET uaqr8tc.vf
	GET uaqrc7tc.vf
	GET uaqrc8tc.vf
	GET uaqro7tc.vf
	GET uaqro8cc.vf
	GET uaqro8tc.vf
	GET /fonts/urw/arial/vf/ua1b8c.vf
	GET ua1b8t.vf
	GET ua1bi8c.vf
	GET ua1bi8t.vf
	GET ua1r8c.vf
	GET ua1r8t.vf
	GET ua1ri8c.vf
	GET ua1ri8t.vf
	GET /fonts/urw/classico/vf/URWClassico-Bold-lf-ly1.vf
	GET URWClassico-Bold-lf-ot1.vf
	GET URWClassico-Bold-lf-t1.vf
	GET URWClassico-Bold-lf-ts1.vf
	GET URWClassico-BoldItalic-lf-ly1.vf
	GET URWClassico-BoldItalic-lf-ot1.vf
	GET URWClassico-BoldItalic-lf-t1.vf
	GET URWClassico-BoldItalic-lf-ts1.vf
	GET URWClassico-Italic-lf-ly1.vf
	GET URWClassico-Italic-lf-ot1.vf
	GET URWClassico-Italic-lf-t1.vf
	GET URWClassico-Italic-lf-ts1.vf
	GET URWClassico-Regular-lf-ly1.vf
	GET URWClassico-Regular-lf-ot1.vf
	GET URWClassico-Regular-lf-t1.vf
	GET URWClassico-Regular-lf-ts1.vf
	GET uopbc7t.vf
	GET uopbc8t.vf
	GET uoprc7t.vf
	GET uoprc8t.vf
	LCD HOME/tfm 
	GET /fonts/urw/antiqua/fonts/uaqr7tc.tfm
	GET uaqr8ac.tfm
	GET uaqr8cc.tfm
	GET uaqr8rc.tfm
	GET uaqr8tc.tfm
	GET uaqrc7tc.tfm
	GET uaqrc8tc.tfm
	GET uaqro7tc.tfm
	GET uaqro8cc.tfm
	GET uaqro8rc.tfm
	GET uaqro8tc.tfm
	GET /fonts/urw/arial/tfm/ua1b8a.tfm
	GET ua1b8c.tfm
	GET ua1b8r.tfm
	GET ua1b8t.tfm
	GET ua1bi8a.tfm
	GET ua1bi8c.tfm
	GET ua1bi8r.tfm
	GET ua1bi8t.tfm
	GET ua1r8a.tfm
	GET ua1r8c.tfm
	GET ua1r8r.tfm
	GET ua1r8t.tfm
	GET ua1ri8a.tfm
	GET ua1ri8c.tfm
	GET ua1ri8r.tfm
	GET ua1ri8t.tfm
	GET /fonts/urw/classico/tfm/URWClassico-Bold-lf-ly1--base.tfm
	GET URWClassico-Bold-lf-ly1.tfm
	GET URWClassico-Bold-lf-ot1.tfm
	GET URWClassico-Bold-lf-t1--base.tfm
	GET URWClassico-Bold-lf-t1.tfm
	GET URWClassico-Bold-lf-ts1--base.tfm
	GET URWClassico-Bold-lf-ts1.tfm
	GET URWClassico-BoldItalic-lf-ly1--base.tfm
	GET URWClassico-BoldItalic-lf-ly1.tfm
	GET URWClassico-BoldItalic-lf-ot1.tfm
	GET URWClassico-BoldItalic-lf-t1--base.tfm
	GET URWClassico-BoldItalic-lf-t1.tfm
	GET URWClassico-BoldItalic-lf-ts1--base.tfm
	GET URWClassico-BoldItalic-lf-ts1.tfm
	GET URWClassico-Italic-lf-ly1--base.tfm
	GET URWClassico-Italic-lf-ly1.tfm
	GET URWClassico-Italic-lf-ot1.tfm
	GET URWClassico-Italic-lf-t1--base.tfm
	GET URWClassico-Italic-lf-t1.tfm
	GET URWClassico-Italic-lf-ts1--base.tfm
	GET URWClassico-Italic-lf-ts1.tfm
	GET URWClassico-Regular-lf-ly1--base.tfm
	GET URWClassico-Regular-lf-ly1.tfm
	GET URWClassico-Regular-lf-ot1.tfm
	GET URWClassico-Regular-lf-t1--base.tfm
	GET URWClassico-Regular-lf-t1.tfm
	GET URWClassico-Regular-lf-ts1--base.tfm
	GET URWClassico-Regular-lf-ts1.tfm
	GET uopb8r.tfm
	GET uopbc7t.tfm
	GET uopbc8t.tfm
	GET uopr8r.tfm
	GET uoprc7t.tfm
	GET uoprc8t.tfm
	LCD /lib/latex/urw 
	GET /fonts/urw/antiqua/latex/ot1uaq.fd
	GET t1uaq.fd
	GET ts1uaq.fd
	GET /fonts/urw/arial/latex/t1ua1.fd
	GET ts1ua1.fd
	GET uarial.sty
	GET /fonts/urw/classico/latex/LY1URWClassico-LF.fd
	GET OT1URWClassico-LF.fd
	GET T1URWClassico-LF.fd
	GET TS1URWClassico-LF.fd
	GET classico.sty
	GET ot1uop.fd
	GET t1uop.fd
	GET ts1uop.fd
	LCD /lib/dvips/ 
	GET /fonts/urw/antiqua/maps/uaq.map
	GET /fonts/urw/arial/map/ua1.map
	GET /fonts/urw/classico/map/classico.map
END:
END_CID

# We create virtual fonts and TFM files for URW PostScript core fonts
# (afm published by URW). The virtual fonts map the characters in the
# `raw' font so giving the opportunity to use whatever encoding at the
# TeX level.
# Since the URW fonts are "drop-in" replacement for standard PostScript
# fonts, this mimicks what is done with Adobe provided afm for the
# standard fonts. The names are given according to LaTeX expectations
# (partly guessed).
#
#font urwfqfont psfont psfqfont font8r
#
BEGIN_URWBASE35_TXT
uagd8a|URWGothicL-Demi|pagd8a|AvantGarde-Demi|uagd8r
uagdo8a|URWGothicL-DemiObli|pagdo8a|AvantGarde-DemiOblique|uagdo8r
uagk8a|URWGothicL-Book|pagk8a|AvantGarde-Book|uagk8r
uagko8a|URWGothicL-BookObli|pagko8a|AvantGarde-BookOblique|uagko8r
ubkd8a|URWBookmanL-DemiBold|pbkd8a|Bookman-Demi|ubkd8r
ubkdi8a|URWBookmanL-DemiBoldItal|pbkdi8a|Bookman-DemiItalic|ubkdi8r
ubkl8a|URWBookmanL-Ligh|pbkl8a|Bookman-Light|ubkl8r
ubkli8a|URWBookmanL-LighItal|pbkli8a|Bookman-LightItalic|ubkli8r
ucrb8a|NimbusMonL-Bold|pcrb8a|Courier-Bold|ucrb8r
ucrbo8a|NimbusMonL-BoldObli|pcrbo8a|Courier-BoldOblique|ucrbo8r
ucrr8a|NimbusMonL-Regu|pcrr8a|Courier|ucrr8r
ucrro8a|NimbusMonL-ReguObli|pcrro8a|Courier-Oblique|ucrro8r
uhvb8a|NimbusSanL-Bold|phvb8a|Helvetica-Bold|uhvb8r
uhvb8ac|NimbusSanL-BoldCond|phvb8an|Helvetica-Narrow-Bold|uhvb8rc
uhvbo8a|NimbusSanL-BoldItal|phvbo8a|Helvetica-BoldOblique|uhvbo8r
uhvbo8ac|NimbusSanL-BoldCondItal|phvbo8an|Helvetica-Narrow-BoldOblique|uhvbo8rc
uhvr8a|NimbusSanL-Regu|phvr8a|Helvetica|uhvr8r
uhvr8ac|NimbusSanL-ReguCond|phvr8an|Helvetica-Narrow|uhvr8rc
uhvro8a|NimbusSanL-ReguItal|phvro8a|Helvetica-Oblique|uhvro8r
uhvro8ac|NimbusSanL-ReguCondItal|phvro8an|Helvetica-Narrow-Oblique|uhvro8rc
uncb8a|CenturySchL-Bold|pncb8a|NewCenturySchlbk-Bold|uncb8r
uncbi8a|CenturySchL-BoldItal|pncbi8a|NewCenturySchlbk-BoldItalic|uncbi8r
uncr8a|CenturySchL-Roma|pncr8a|NewCenturySchlbk-Roman|uncr8r
uncri8a|CenturySchL-Ital|pncri8a|NewCenturySchlbk-Italic|uncri8r
uplb8a|URWPalladioL-Bold|pplb8a|Palatino-Bold|uplb8r
uplbi8a|URWPalladioL-BoldItal|pplbi8a|Palatino-BoldItalic|uplbi8r
uplr8a|URWPalladioL-Roma|pplr8a|Palatino-Roman|uplr8r
uplri8a|URWPalladioL-Ital|pplri8a|Palatino-Italic|uplri8r
utmb8a|NimbusRomNo9L-Medi|ptmb8a|Times-Bold|utmb8r
utmbi8a|NimbusRomNo9L-MediItal|ptmbi8a|Times-BoldItalic|utmbi8r
utmr8a|NimbusRomNo9L-Regu|ptmr8a|Times-Roman|utmr8r
utmri8a|NimbusRomNo9L-ReguItal|ptmri8a|Times-Italic|utmri8r
uzcmi8a|URWChanceryL-MediItal|pzcmi8a|ZapfChancery-MediumItalic|uzcmi8r
END_URWBASE35_TXT
#
#font urwfqfont psfont psfqfont
#
BEGIN_URWBASE35_SYM
usyr|StandardSymL|psyr|Symbol
uzdr|Dingbats|pzdr|ZapfDingbats
END_URWBASE35_SYM
