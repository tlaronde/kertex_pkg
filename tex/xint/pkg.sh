#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script
# adding the Jean-François Burnol's xint package to the TeX Kernel system:
# kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2024 Thierry Laronde <tlaronde@kergis.com>
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
#

pkg_get

cd $TMPDIR/lib/$PKG_NAME/..
$PKG_UNZIP xint.zip
rm xint.zip
cd xint
$KERTEX_BINDIR/etex xint.dtx

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: tex/xint
AUTHOR: Jean-Fran\,cois Burnol
DESCRIPTION:
	Expandable arbitrary precision floating point and integer
	operations.
	Bundle of xinttools, xintcore, xint, xintfrac and xintexpr.
VERSION: 1.4m
LICENCE: LPPL 1.3c
KERTEX_VERSION: 0.99.23.0
KXPATH:
	tex xint
SOURCES:
	LCD HOME/..
	GET /macros/generic/xint.zip
END:
END_CID
