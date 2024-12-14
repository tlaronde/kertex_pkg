#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the LaTeX contrib: yfonts
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
$PKG_UNZIP yfonts.zip
rm yfonts.zip
cd $TMPDIR/lib/$PKG_NAME/
$KERTEX_BINDIR/latex yfonts.ins

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
NAME: latex/yfonts
AUTHOR:
	Norbert Preining
	Walter A. Schmidt (deceased)
DESCRIPTION: Support for old German fonts.
	A LaTeX interface to the old-german fonts designed by Yannis
	Haralambous: Gothic, Schwabacher, Fraktur and the baroque
	initials. 
VERSION: 1.4
LICENCE: The LaTeX Project Public License
DEPENDENCIES:
	fonts/ygoth
	fonts/yswab
	fonts/yfrak
	fonts/yinit
	fonts/yfonts-t1
KERTEX_VERSION: 0.99.24.00
KXPATH:
	latex yfonts
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/yfonts.zip
END:
END_CID
