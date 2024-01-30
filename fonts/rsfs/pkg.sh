#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of Ralph Smith's Formal Script Symbol cm fonts
# to the TeX kernel system: kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2018, 2020, 2024
#   Thierry Laronde <tlaronde@polynum.com>
# $Id: pkg.sh,v 1.9 2024/01/21 14:16:54 tlaronde Exp $
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
pkg_log "0. Creating the hierarchy."
pkg_log ""
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

for size in 5 7 10; do
	$KERTEX_BINDIR/mf "\\mode=ljfour; scrollmode; input rsfs$size"
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

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: fonts/rsfs
DESCRIPTION: Ralph Smith's Formal Script Symbol cm fonts
AUTHOR: Ralph Smith
VERSION: 1.0 1998-04-24
LICENCE: free unspecified
KERTEX_VERSION: 0.99.22.0
KXPATH:
	fonts rsfs
DVIPS:
p +rsfs.map
SOURCES:
	LCD HOME/doc 
	GET /fonts/rsfs/README
	LCD HOME/mf 
	GET rsfs10.mf
	GET rsfs5.mf
	GET rsfs7.mf
	GET script.mf
	GET scriptu.mf
	LCD HOME/doc 
	GET type1/README README_T1
	LCD HOME/pfb 
	GET rsfs10.pfb
	GET rsfs5.pfb
	GET rsfs7.pfb
	LCD HOME/afm 
	GET afm/rsfs10.afm
	GET rsfs5.afm
	GET rsfs7.afm
	LCD /lib/dvips 
	GET ../map/rsfs.map
END:
END_CID
