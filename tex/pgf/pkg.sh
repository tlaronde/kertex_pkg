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
# C) 2024, 2025 Thierry Laronde <tlaronde@polynum.com>
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
pkg_dircp base/tex/context/third/pgf $TMPDIR/lib/$PKG_NAME/context
rm -fr base/tex/context
pkg_dircp base/tex/generic/pgf $TMPDIR/lib/$PKG_NAME/generic
rm -fr $TMPDIR/lib/$PKG_NAME/generic/lua
rm -fr $TMPDIR/lib/$PKG_NAME/generic/graphdrawing/lua
rm -fr base/tex/generic

pkg_log "3) Installing plain TeX support;"
pkg_dircp base/tex/plain $TMPDIR/lib/$PKG_NAME/
rm -fr base/tex/plain

pkg_log "4) Installing LaTeX support;"
pkg_dircp base/tex/latex/pgf $TMPDIR/lib/latex/pgf
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
VERSION: 3.1.11a 2025-08-29
AUTHORS:
	Christian Feuersänger
	Henri Menke
	The PGF/TikZ Team
	Till Tantau
LICENCE:
	Free Documentation license
	The LaTeX Project Public License 1.3c
	GPL, version 2
DESCRIPTION: 
	Pgf is a macro package for creating graphics.  It is
	platform- and format-independent and works together with the
	most important TeX backend drivers, including pdfTeX and dvips. 
	It comes with a user-friendly syntax layer called TikZ. 
KERTEX_VERSION: 0.99.26.0
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
	tex pgf/basiclayer
	tex pgf/frontendlayer
	tex pgf/math
	tex pgf/systemlayer
	tex pgf/utilities
	latex pgf/basiclayer
	latex pgf/compatibility
	latex pgf/doc
	latex pgf/frontendlayer
	latex pgf/frontendlayer/libraries
	latex pgf/math
	latex pgf/systemlayer
	latex pgf/utilities
SOURCES:
	GET /graphics/pgf/base.zip
END:
END_CID
