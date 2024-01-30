#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script
# adding the LaTeX psnfss font package to the TeX Kernel system:
# kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# (C) 2017, 2020, 2022, 2024
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
	pkg_log
	pkg_log "The rsfs font has a separate package."
	pkg_log
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
#

pkg_log "This package is now included directly in the latex.sh rcp."
pkg_log "The rcp is here only to remove a previous separate instance."
pkg_clean_tmp
exit 0

pkg_get

$PKG_UNZIP psnfss.zip
cd psnfss
mv *.tex *.dtx *.ins $TMPDIR/lib/$PKG_NAME

mkdir $TMPDIR/lib/$PKG_NAME/doc
mv README $TMPDIR/lib/$PKG_NAME/doc
mv *.pdf $TMPDIR/lib/$PKG_NAME/doc

# dvips/ subdir not created.
#
mkdir $TMPDIR/lib/dvips
mv *.map $TMPDIR/lib/dvips

mkdir -p $TMPDIR/lib/fonts/psnfss/enc
mv *.enc $TMPDIR/lib/fonts/psnfss/enc

# This is included.
#
for bundle in freenfss lw35nfss; do
	$PKG_UNZIP $bundle.zip
	mv $bundle/tex/latex/psnfss/*.fd $TMPDIR/lib/$PKG_NAME
	for dir in "adobe/avantgar" "adobe/bookman" "adobe/courier"\
		"adobe/helvetic" "adobe/ncntrsbk" "adobe/palatino"\
		"adobe/symbol"\
		"adobe/times" "adobe/utopia" "adobe/zapfchan"\
		"adobe/zapfding"\
		"bitstrea/charter"\
		"public/pazo"; do
		mkdir -p $TMPDIR/lib/fonts/$dir/tfm
		mkdir -p $TMPDIR/lib/fonts/$dir/vf
		if test -d "$bundle/fonts/tfm/$dir/"; then
			mv $bundle/fonts/tfm/$dir/*.* $TMPDIR/lib/fonts/$dir/tfm
		fi
		if test -d "$bundle/fonts/vf/$dir/"; then
			mv $bundle/fonts/vf/$dir/*.* $TMPDIR/lib/fonts/$dir/vf
		fi
	done
done


# Generating the *.sty.
#
cd $TMPDIR/lib/$PKG_NAME
$KERTEX_BINDIR/latex psfonts.ins

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex/psnfss
VERSION: 9.3
LICENCE: LaTeX Project Public License
KERTEX_VERSION: 0.99.10.2
DESCRIPTION:
Font support for various PostScript fonts.
KXPATH:
	fonts bitstrea/charter
	fonts adobe/avantgar
	fonts adobe/bookman
	fonts adobe/courier
	fonts adobe/helvetic
	fonts adobe/ncntrsbk
	fonts adobe/palatino
	fonts adobe/symbol
	fonts adobe/times
	fonts adobe/utopia
	fonts adobe/zapfchan
	fonts adobe/zapfding
	fonts charter
	fonts fpl
	fonts mathpazo
	fonts psnfss
	fonts public/pazo
	fonts utopia
	latex psnfss
	tex rsfs
DVIPS:
p +charter.map
p +fpls.map
p +pazo.map 
p +psnfss.map
p +utopia.map
SOURCES:
	GET /macros/latex/required/psnfss.zip 
	LCD /lib/fonts/utopia/
	GET /fonts/utopia/LICENSE-utopia.txt
	GET README-utopia.txt
	LCD /lib/fonts/utopia/afm
	GET /fonts/utopia/putb8a.afm
	GET putbi8a.afm
	GET putr8a.afm
	GET putri8a.afm
	LCD /lib/fonts/utopia/pfb
	GET /fonts/utopia/putb8a.pfb
	GET putbi8a.pfb
	GET putr8a.pfb
	GET putri8a.pfb
	LCD /lib/fonts/charter/
	GET /fonts/charter/readme.charter 
	LCD /lib/fonts/charter/afm
	GET /fonts/charter/bchb8a.afm
	GET bchbi8a.afm
	GET bchr8a.afm
	GET bchri8a.afm
	LCD /lib/fonts/charter/pfb
	GET /fonts/charter/bchb8a.pfb
	GET bchbi8a.pfb
	GET bchr8a.pfb
	GET bchri8a.pfb
	LCD /lib/fonts/fpl
	GET /fonts/fpl/COPYING 
	GET /fonts/fpl/README 
	LCD /lib/fonts/fpl/afm
	GET /fonts/fpl/afm/fplbij8a.afm
	GET fplbj8a.afm
	GET fplrc8a.afm
	GET fplrij8a.afm
	LCD /lib/fonts/fpl/pfb
	GET /fonts/fpl/type1/fplbij8a.pfb
	GET fplbj8a.pfb
	GET fplrc8a.pfb
	GET fplrij8a.pfb
	LCD /lib/fonts/mathpazo
	GET /fonts/mathpazo/README 
	GET /fonts/mathpazo/gpl.txt 
	LCD /lib/fonts/mathpazo/afm
	GET /fonts/mathpazo/afm/fplmb.afm
	GET fplmbb.afm
	GET fplmbi.afm
	GET fplmr.afm
	GET fplmri.afm
	LCD /lib/fonts/mathpazo/pfb
	GET /fonts/mathpazo/type1/fplmb.pfb
	GET fplmbb.pfb
	GET fplmbi.pfb
	GET fplmr.pfb
	GET fplmri.pfb
END:
END_CID
