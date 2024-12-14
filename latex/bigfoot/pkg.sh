#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the LaTeX contrib: bigfoot
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
$PKG_UNZIP bigfoot.zip
rm bigfoot.zip
cd $TMPDIR/lib/$PKG_NAME/
$KERTEX_BINDIR/latex bigfoot.ins

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
NAME: latex/bigfoot
AUTHOR:	David Kastrup
DESCRIPTION: Footnotes for critical editions.
	  The package aims to provide a `one-stop' solution to
	requirements for footnotes. It offers:
	 - Multiple footnote apparatus superior to that of manyfoot
    	 - Footnotes can be formatted in separate paragraphs, or be run
	   into a single paragraph (this choice may be selected per
	   footnote series);
	 - Things you might have expected (such as \verb-like material
	   in footnotes, and colour selections over page breaks) now
	   work.

	  Note that the majority of the bigfoot package's interface is
	identical to that of manyfoot; users should seek information
	from that package's documentation.

	  The bigfoot bundle also provides the perpage and suffix
	packages. 
VERSION: 2.1 2015-08-30
LICENCE: GNU General Public License, version 2
KERTEX_VERSION: 0.99.24.00
KXPATH:
	latex bigfoot
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/bigfoot.zip
END:
END_CID
