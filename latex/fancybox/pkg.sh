#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# sketching the addition of LaTeX/fancybox to the TeX Kernel system: 
# kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2018, 2020, 2024
#   Thierry Laronde <tlaronde@polynum.com>
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
# Note: we use FTP to be able to list the dir, since there is no
# bundle.
#

pkg_get

cd $TMPDIR/tmp
$PKG_UNZIP fancybox.zip
rm fancybox.zip
mv fancybox/*.sty $TMPDIR/lib/latex/fancybox/
mkdir -p $TMPDIR/lib/tex/fancybox
mv fancybox/*.tex $TMPDIR/lib/tex/fancybox

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex/fancybox
VERSION: 1.4
LICENCE: LaTeX Project Public Licence v1.2
	http://www.latex-project.org/lppl.txt
KERTEX_VERSION: 0.99.22.0
DESCRIPTION:
	The package provides variants of \fbox: \shadowbox,
	\doublebox, \ovalbox, \Ovalbox, with helpful tools for using
	box macros and flexible verbatim macros. You can box
	mathematics, floats, center, flushleft, and flushright, lists,
	and pages. 
KXPATH:
	latex fancybox
	tex fancybox
SOURCES:
	LCD /tmp/ 
	GET /macros/latex/contrib/fancybox.zip
END:
END_CID
