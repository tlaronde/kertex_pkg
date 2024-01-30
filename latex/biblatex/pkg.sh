#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# sketching the addition of LaTeX/biblatex to the TeX Kernel system: 
# kerTeX. 
#
# This package requires elatex for its use!
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2012 Mark van Atten <Mark.vanAtten@univ-paris1.fr>
# C) 2017, 2020, 2024 Thierry Laronde <tlaronde@polynum.com>
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


# nothing else to be done

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
NAME: latex/biblatex
AUTHORS:
	2006-2012 Philipp Lehman
	2012-2017 Philip Kime, Audrey Boruvka, Joseph Wright
	2018-2023 Philip Kime, Moritz Wemheuer
VERSION: 3.19 2023-03-05
LICENCE: LaTeX Project Public Licence v 1.3 or later.
	http://www.latex-project.org/lppl.txt
KERTEX_VERSION: 0.99.22.0
DESCRIPTION:
	Bibliographies in LaTeX using BibTeX for sorting only.
NOTES:
	The traditional bibtex back-end is used. Biber, depending on Perl,
	is not included in the distribution.
KXPATH:
	latex biblatex;biblatex/bbx;biblatex/cbx;biblatex/lbx
	bibtex biblatex/bib;biblatex/bst;biblatex/csf
SOURCES:
	LCD /lib/bibtex/biblatex/bib/
	GET /macros/latex/contrib/biblatex/bibtex/bib/biblatex/biblatex-examples.bib
	LCD /lib/bibtex/biblatex/bst/
	GET /macros/latex/contrib/biblatex/bibtex/bst/biblatex.bst
	LCD /lib/latex/biblatex/
	GET /macros/latex/contrib/biblatex/latex/ /\.def$/
	GET biblatex.cfg
	GET biblatex.sty
	LCD /lib/latex/biblatex/bbx/
	GET /macros/latex/contrib/biblatex/latex/bbx/ /\.bbx$/
	LCD /lib/latex/biblatex/cbx/
	GET /macros/latex/contrib/biblatex/latex/cbx/ /\.cbx$/
	LCD /lib/latex/biblatex/lbx/
	GET /macros/latex/contrib/biblatex/latex/lbx/ /\.lbx$/
	LCD /lib/latex/biblatex/doc/
	GET /macros/latex/contrib/biblatex/doc/biblatex.pdf
	GET biblatex.tex
	LCD /lib/latex/biblatex/doc/examples/
	GET /macros/latex/contrib/biblatex/doc/examples/ /bibtex\..$/
END:
END_CID
