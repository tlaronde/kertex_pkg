#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the LaTeX contrib: stringenc
# to kerTeX.
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
$PKG_UNZIP stringenc.zip
rm stringenc.zip
cd $TMPDIR/lib/$PKG_NAME/
$KERTEX_BINDIR/tex stringenc.dtx

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
NAME: tex/stringenc
VERSION: 1.12 2019-11-29
LICENCE: LPPL 1.3
AUTHOR:
	Heiko Oberdiek 2007--2011;
	Oberdiek Package Support Group 2016--2019.
DESCRIPTION:
	This package provides StringEncodingConvert for
	converting a string between different encodings.
	Both LaTeX and plain TeX are supported.
KERTEX_VERSION: 0.99.23.0
KXPATH:
	tex stringenc
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/stringenc.zip
END:
END_CID
