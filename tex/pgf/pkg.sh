#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the pgf graphics package
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
cd $TMPDIR
$PKG_UNZIP base.zip
rm base.zip

pkg_log "1) Installing documentation;"
pkg_dircp base/doc $TMPDIR/lib/$PKG_NAME/doc
rm -fr base/doc

pkg_log "2) Installing shared files;"
pkg_dircp base/tex/context $TMPDIR/lib/$PKG_NAME/context
rm -fr base/tex/context
pkg_dircp base/tex/generic $TMPDIR/lib/$PKG_NAME/generic
rm -fr base/tex/generic

pkg_log "3) Installing plain TeX support;"
pkg_dircp base/tex/plain $TMPDIR/lib/$PKG_NAME/
rm -fr base/tex/plain

pkg_log "4) Installing LaTeX support;"
pkg_dircp base/tex/latex $TMPDIR/lib/$PKG_NAME/latex
rm -fr base/tex/latex

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
NAME: tex/pgf
AUTHORS:
	2005-2016 Till Tantau
	2019-2020 Henri Menke
	2021-2023 The PGF/TikZ Team
LICENCE:
	Free Documentation license
	The LaTeX Project Public License 1.3c
	GPL, version 2
DESCRIPTION: 
	Pgf is a macro package for creating graphics.  It is
	platform- and format-independent and works together with the
	most important TeX backend drivers, including pdfTeX and dvips. 
	It comes with a user-friendly syntax layer called TikZ. 
KERTEX_VERSION: 0.99.24.0
DEPENDENCIES:
	tex/atbegshi
KXPATH:
	tex pgf/context/basiclayer
	tex pgf/context/frontendlayer
	tex pgf/context/math
	tex pgf/context/systemlayer
	tex pgf/context/utilities
	tex pgf/generic
	tex pgf/generic/basiclayer
	tex pgf/generic/frontendlayer/tikz
	tex pgf/generic/frontendlayer/tikz/libraries
	tex pgf/generic/frontendlayer/tikz/libraries/circuits
	tex pgf/generic/frontendlayer/tikz/libraries/datavisualization
	tex pgf/generic/frontendlayer/tikz/libraries/graphs
	tex pgf/generic/graphdrawing/tex
	tex pgf/generic/graphdrawing/tex/experimental
	tex pgf/generic/libraries
	tex pgf/generic/libraries/datavisualization
	tex pgf/generic/libraries/decorations
	tex pgf/generic/libraries/luamath
	tex pgf/generic/libraries/shapes
	tex pgf/generic/libraries/shapes/circuits
	tex pgf/generic/math
	tex pgf/generic/modules
	tex pgf/generic/systemlayer
	tex pgf/generic/utilities
	tex pgf/latex/basiclayer
	tex pgf/latex/compatibility
	tex pgf/latex/doc
	tex pgf/latex/frontendlayer
	tex pgf/latex/frontendlayer/libraries
	tex pgf/latex/math
	tex pgf/latex/systemlayer
	tex pgf/latex/utilities
	tex pgf/basiclayer
	tex pgf/frontendlayer
	tex pgf/math
	tex pgf/systemlayer
	tex pgf/utilities
SOURCES:
	GET /graphics/pgf/base.zip
END:
END_CID
