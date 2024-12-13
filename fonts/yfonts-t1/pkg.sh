#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the Adobe T1 format of Yannis
# Haralambous' old German fonts to kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2024 Thierry Laronde <tlaronde@polynum.com>
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
#
pkg_get

#===== Proceeding
#
# unzip
cd $TMPDIR/lib/$PKG_NAME/.. 
$PKG_UNZIP yfonts.zip
rm yfonts.zip
cd yfonts
mv * ../yfonts-t1
cd ..
$PKG_RMDIR yfonts
cd $TMPDIR/lib/$PKG_NAME/
mkdir afm
mv *.afm afm
mkdir pfb
mv *.pfb pfb

# There is no need to create TFM files since the original are
# METAFONT fonts, that have their tfm. Hence the dependency.
#
mkdir $TMPDIR/lib/dvips
mv *.map $TMPDIR/lib/dvips

#
# The path will be added by KXPATH. So we let files here.

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: fonts/yfonts-t1
AUTHOR:
	Torsten Bronger
	Yannis Haralambous
DESCRIPTION: PostScript T1 implementation of yfrak, yswab, yfonts-t1.
	  This PostScript Type 1 implementation of the fonts yfrak,
	yswab and ygoth, originally created by Yannis Haralambous using
	METAFONT, is freely available for general use.
VERSION: 1.0 2002-05-23
LICENCE: Free license not otherwise listed
DEPENDENCIES:
	fonts/yfrak
	fonts/ygoth
	fonts/yswab
KERTEX_VERSION: 0.99.24.00
KXPATH:
	fonts yfonts-t1
DVIPS:
p +yfrak.map
SOURCES:
	LCD HOME/..
	GET /fonts/ps-type1/yfonts.zip
END:
END_CID
