#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of Emmanuel Beffara's frcursive METAFONT generated
# font to the TeX kernel system: kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2017, 2020, 2024
#   Thierry Laronde <tlaronde@polynum.com>
# $Id: pkg.sh,v 1.9 2024/01/21 14:16:49 tlaronde Exp $
# All rights reserved and absolutely no warranty! Use at your own 
# risks.
#

# Needed post action (build, apply, remove) routines.
#
pkg_post_build()
{
	return 0 # bash errors on empty function...
}

pkg_post_apply()
{
	pkg_log 
	pkg_log "I have added frcursive.map to $KERTEX_LIBDIR/dvips/dvips.cnf."
	pkg_log 
	pkg_log "To generate the frcursive.dtx, you need the T1 fonts since"
	pkg_log "some METAFONT paramaters files are missing."
	pkg_log ""
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
# Note: we will generate the gf, tfm and pk version instead of copying.
#
pkg_get

$PKG_UNZIP frcursive.zip

pkg_log ""
pkg_log "0. Creating the hierarchy and putting non generated files."
pkg_log ""
for subdir in doc gf mf pk tfm pfb; do
	mkdir $TMPDIR/lib/$PKG_NAME/$subdir
done

# The map will be put with the PS pfb variant. Should be read there
# by dvips(1). For the moment, in the dvips/ hierarchy.
#
mkdir $TMPDIR/lib/dvips

cd $TMPDIR/frcursive # extracted there

mv frcursive.map $TMPDIR/lib/dvips

mv type1/* $TMPDIR/lib/$PKG_NAME/pfb

# The METAFONT sources. We will generate the gf, tfm and pk.
#
mv mf/* $TMPDIR/lib/$PKG_NAME/mf

# The doc.
#
mv README COPYING frcursive.pdf $TMPDIR/lib/$PKG_NAME/doc

pkg_log ""
pkg_log "1. Generating the gf and tfm with METAFONT"
pkg_log ""

KERTEXINPUTS="$TMPDIR/lib/$PKG_NAME;KERTEXSYS"
KERTEXFONTS="$TMPDIR/lib/$PKG_NAME;KERTEXSYS"
export KERTEXINPUTS
export KERTEXFONTS

cd $TMPDIR/lib/$PKG_NAME/gf

parmlist="frcbx10 frcbx14 frcbx6 frcc10 frcc14\
	frcc6 frcf10 frcf14 frcf6 frcr10 frcr14\
	frcr6 frcsl10 frcsl14 frcsl6 frcslbx10 frcslbx14\
	frcslbx6 frcslc10 frcslc14 frcslc6"

for parm in $parmlist; do
	$KERTEX_BINDIR/mf "\\mode=ljfour; scrollmode; input $parm"
done

mv *.tfm $TMPDIR/lib/$PKG_NAME/tfm

# XXX These ones are missing in METAFONT.
#
for font in frca10 frcw10 frcslbx10; do
	mv $TMPDIR/frcursive/tfm/$font.tfm $TMPDIR/lib/$PKG_NAME/tfm
done

pkg_log ""
pkg_log "2. Generating the pk versions."
pkg_log ""

for file in *.*gf; do
	$KERTEX_BINDIR/gftopk $file
	rm $file
done
mv *.*pk $TMPDIR/lib/$PKG_NAME/pk

#
# Cleaning.
#
rm *.log

if pkg_is_installed latex; then
	pkg_log ""
	pkg_log "3. Installing LaTeX files."
	pkg_log ""
	mkdir -p $TMPDIR/lib/latex/frcursive
	mv $TMPDIR/frcursive/latex/* $TMPDIR/lib/latex/frcursive
	mv $TMPDIR/frcursive/frcursive.dtx $TMPDIR/lib/latex/frcursive
fi

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: fonts/frcursive
AUTHOR: Emmanuel Beffara
VERSION: 2011-11-09
LICENCE: The LaTeX Public License 1.2
KERTEX_VERSION: 0.99.22.0
KXPATH:
	fonts frcursive
	latex frcursive
DVIPS:
p +frcursive.map
SOURCES:
	GET /fonts/frcursive.zip
END:
END_CID
