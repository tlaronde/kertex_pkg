#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the LaTeX contrib: preprint
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
$PKG_UNZIP preprint.zip
rm preprint.zip
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
			mkdir -p $TMPDIR/lib/bibtex/preprint/$suffix
			ed -s $PKG_CID <<EOT
/^KXPATH:/a
	bibtex preprint/$suffix
.
w
q
EOT
			has_some=YES
		fi
		mv $file $TMPDIR/lib/bibtex/preprint/$suffix/$file
	done
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
NAME: latex/preprint
AUTHOR: Patrick W Daly
DESCRIPTION: A collection of LaTeX style files for preprint
customization. It includes:
	- authblx, which permits footnote style author/affiliation
	input in the \author command;
	- balance, to balance the end of \twocolumn pages;
	- figcaps, to send figure captions etc., to end document;
	- fullpage, to set narrow page margins and set a fixed
	page style;
	- sublabel, which permits coutners to be subnumbered.
VERSION: 1.1
LICENCE: The LaTeX Project Public License
KERTEX_VERSION: 0.99.25.00
KXPATH:
	latex preprint
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/preprint.zip
END:
END_CID
