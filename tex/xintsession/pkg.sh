#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script
# adding the Jean-Fran�ois Burnol's xintsession package to the TeX Kernel system:
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
$PKG_UNZIP xintsession.zip
rm xintsession.zip

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: tex/xintsession
AUTHOR: Jean-Fran\,cois Burnol
DESCRIPTION:
	Interactive computing sessions (fractions, floating points,
	polynomials) with etex, executed on the command line, on the
	basis of the xintexpr and polexpr packages. 
VERSION: 0.4alpha 2021-11-01
LICENCE: LPPL 1.3c
KERTEX_VERSION: 0.99.23.0
DEPENDENCIES:
	tex/poormanlog
	tex/polexpr
	tex/xint
KXPATH:
	tex xintsession
SOURCES:
	LCD HOME/..
	GET /macros/plain/contrib/xintsession.zip
END:
END_CID
