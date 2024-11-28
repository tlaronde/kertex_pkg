#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the LaTeX contrib: l3packages
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
$PKG_UNZIP l3packages.zip
rm l3packages.zip
cd $TMPDIR/lib/$PKG_NAME/
pkg_lstree | sed '/\.ins$/!d' | while read file; do
	file=${file#./}
	$KERTEX_BINDIR/latex $file
done

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
NAME: latex/l3packages
AUTHOR: The LaTeX Project Team 
LICENCE: LPPL 1.3c
COPYRIGHT: 2009-2024 The LaTeX3 project
KERTEX_VERSION: 0.99.23.0
DESCRIPTION: Deprecated interfaces for LaTeX2e to LaTeX3 (now included
directly in the latex format).
KXPATH:
	latex l3packages
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/l3packages.zip
END:
END_CID
