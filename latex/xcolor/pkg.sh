#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the LaTeX contrib: xcolor
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
$PKG_UNZIP xcolor.zip
rm xcolor.zip
cd $TMPDIR/lib/$PKG_NAME/
pkg_lstree | sed '/\.ins$/!d' | while read file; do
	$KERTEX_BINDIR/latex $file
done

# If there are bibtex bibliography entries, put them in place and add
# the bibtex entry in KXPATH.
#
for suffix in bst bib; do
	has_some=NO
	pkg_lstree | sed "/\.$suffix\$/!d" | while read file; do
		if test $has_some = "NO"; then
			mkdir -p $TMPDIR/lib/bibtex/xcolor/$suffix
			ed -s $PKG_CID <<EOT
/^KXPATH:/a
	bibtex xcolor/$suffix
.
w
q
EOT
			has_some=YES
		fi
		mv $file $TMPDIR/lib/bibtex/xcolor/$suffix/$file
	done
done

# There is one file to put in place: the xcolor.pro for dvips.
#
mkdir $TMPDIR/lib/dvips
mv $TMPDIR/lib/$PKG_NAME/xcolor.pro $TMPDIR/lib/dvips

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
NAME: latex/xcolor
AUTHOR:
	2003-2021 Dr. Uwe Kern
	2021-2024 The LaTeX Project
VERSION: 2024-09-29 v3.02
DESCRIPTION: 
	`xcolor` provides easy driver-independent access to several
	kinds of colors, tints, shades, tones, and mixes of arbitrary
	colors by means of color expressions like
	\color{red!50!green!20!blue}.
	It allows to select a document-wide target color model and
	offers tools for automatic color schemes, conversion between
	nine color models, alternating table row colors, color blending
	and masking, color separation, and color wheel calculations.
LICENCE: LaTeX Project Public License, version 1.3c or later
KERTEX_VERSION: 0.99.23.2
KXPATH:
	latex xcolor
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/xcolor.zip
END:
END_CID
