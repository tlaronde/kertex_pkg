#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the LaTeX contrib: atbegshi
# (but usable with the TeX engine and plain tex, so put under
# tex) to kerTeX.
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
# Since some files may be used with the TeX engine and plain tex,
# files are put under tex, and are reachable by LaTeX.
#
# unzip
cd $TMPDIR/lib/$PKG_NAME/.. 
$PKG_UNZIP atbegshi.zip
rm atbegshi.zip
cd $TMPDIR/lib/$PKG_NAME/
$KERTEX_BINDIR/tex atbegshi.dtx

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
NAME: tex/atbegshi
AUTHOR: 
	2007-2016 Heiko Oberdiek
	2016-2019 Oberdiek Package Support Group
DESCRIPTION: Execute stuff at \shipout time.
	  This package is a modern reimplementation of package
everyshi, providing various commands to be executed before a \shipout
command. It makes use of e-TeX's facilities if they are available.
	  The package may be used either with LaTeX or with plain TeX. 
VERSION: 1.19 2019-12-05
LICENCE: The LaTeX Project Public License 1.3
KERTEX_VERSION: 0.99.24.00
KXPATH:
	tex atbegshi
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/atbegshi.zip
END:
END_CID
