#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the generic: multido package
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
$PKG_UNZIP multido.zip
rm multido.zip

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
NAME: tex/multido
VERSION: 1.42
AUTHOR: 2004-2010 Herbert Voﬂ and Rolf Niepraschk 
DESCRIPTION:
	A loop facility for generic TeX. Fixed-point arithmetic
	is used when working on the loop variable, so that the package
	is equally applicable in graphics applications like PSTricks as
	it is with the more common integer loops.
LICENCE: The LaTeX Project Public License
KERTEX_VERSION: 0.99.23.2
KXPATH:
	tex multido
SOURCES:
	LCD HOME/..
	GET /macros/generic/multido.zip
END:
END_CID
