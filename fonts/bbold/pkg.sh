#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of Alan Jeffrey's bbold symbol fonts (blackboard)
# to the TeX kernel system: kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2018, 2020, 2023--2024
#   Thierry Laronde <tlaronde@polynum.com>
# $Id: pkg.sh,v 1.11 2024/01/21 14:16:47 tlaronde Exp $
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
pkg_log "0. Creating the hierarchy and putting non generated files."
pkg_log ""
# Others are created getting.
#
for subdir in gf pk tfm; do
	mkdir $TMPDIR/lib/$PKG_NAME/$subdir
done

pkg_log ""
pkg_log "1. Generating the gf and tfm with METAFONT"
pkg_log ""

KERTEXINPUTS="$TMPDIR/lib/$PKG_NAME;KERTEXSYS"
KERTEXFONTS="$TMPDIR/lib/$PKG_NAME;KERTEXSYS"
export KERTEXINPUTS
export KERTEXFONTS

cd $TMPDIR/lib/$PKG_NAME/gf

for size in 5 6 7 8 9 10 12 17; do
	$KERTEX_BINDIR/mf "\\mode=localfont; scrollmode; input bbold$size"
	$KERTEX_BINDIR/mf "\\relax; mode_def adhoc = mode_param(pixels_per_inch,1200); mode_param(proofing, 0); enddef; mode=adhoc; scrollmode; input bbold$size;"
done

mv *.tfm $TMPDIR/lib/$PKG_NAME/tfm

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
	if ! pkg_is_installed latex/etoolbox; then
		$KERTEX_SHELL "$KERTEX_LIBDIR/pkg/rcp/etoolbox@latex.sh" \
			install
	fi
	pkg_log ""
	pkg_log "3. Installing LaTeX files."
	pkg_log ""
	mkdir -p $TMPDIR/lib/latex/bbold
	cd $TMPDIR/lib/latex/bbold
	mv $TMPDIR/bbold.dtx .
	$KERTEX_BINDIR/latex bbold.dtx
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
NAME: fonts/bbold
DESCRIPTION: Alan Jeffrey's bbold symbol fonts (blackboard)
AUTHOR: Alan Jeffrey
VERSION: 1.01 (1994-04-06)
LICENCE: BSD style license
KERTEX_VERSION: 0.99.18.0
KXPATH:
	fonts bbold
	latex bbold
SOURCES:
	LCD HOME/doc 
	GET /fonts/bbold/README
	GET INSTALL
	GET bbold.pdf
	LCD HOME/mf 
	GET bbbase.mf
	GET bbgreekl.mf
	GET bbgreeku.mf
	GET bbligs.mf
	GET bblower.mf
	GET bbnum.mf
	GET bbold.mf
	GET bbold10.mf
	GET bbold12.mf
	GET bbold17.mf
	GET bbold5.mf
	GET bbold6.mf
	GET bbold7.mf
	GET bbold8.mf
	GET bbold9.mf
	GET bbparams.mf
	GET bbpunc.mf
	GET bbupper.mf
	LCD / 
	GET bbold.dtx
END:
END_CID
