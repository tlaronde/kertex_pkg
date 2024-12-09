#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script
# adding the Jean-François Burnol's poormanlog package to the TeX Kernel system:
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
$PKG_UNZIP poormanlog.zip
rm poormanlog.zip

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: tex/poormanlog
AUTHOR: Jean-Fran\,cois Burnol
DESCRIPTION: 
	This small package (usable with Plain e-TeX, LaTeX, or
	others) with no dependencies provides two fast expandable macros
	computing logarithms in base 10 and fractional powers of 10 with
	(almost) 9 digits. 
VERSION: 0.07 2022-05-25
LICENCE: LPPL 1.3c
KERTEX_VERSION: 0.99.23.0
KXPATH:
	tex poormanlog
SOURCES:
	LCD HOME/..
	GET /macros/generic/poormanlog.zip
END:
END_CID
