#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the LaTeX contrib: titlesec
# to kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2025 Thierry Laronde <tlaronde@polynum.com>
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
$PKG_UNZIP titlesec.zip
rm titlesec.zip
cd $TMPDIR/lib/$PKG_NAME/
pkg_lstree | sed '/\.ins$/!d' | while read file; do
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
NAME: latex/titlesec
AUTHOR: 1998-2025 Javier Bezos
DESCRIPTION: This package provides an interface to sectioning commands
for selection from various title syles.
	E.g. marginal titles and to change the font of all heading
	with a single command, also providing simple one-step page
	styles. 
	Also includes a package to change the page stules when there
	are floats in a page. You may assign headers/footers to 
	individual floats, too.
VERSION: 2.17 202-01-04
LICENCE: MIT License
KERTEX_VERSION: 0.99.25.00
KXPATH:
	latex titlesec
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/titlesec.zip
END:
END_CID
