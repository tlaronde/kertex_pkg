#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add the LaTeX contrib: beamer
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
	pkg_log 
	pkg_log "You can generate a sample by processing:"
	pkg_log "doc/examples/a-conference-talk/beamerexample-conference-talk.tex"
	pkg_log
	pkg_log "(the other example is in german so needs this lang"
	pkg_log "  compiled in in latex)"
	pkg_log
	pkg_log "Do run twice latex on it, since the summary and"
	pkg_log "  cross-references need a second pass."
	pkg_log
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
$PKG_UNZIP beamer.zip
rm beamer.zip

# Useless to have a subdir for point entry classes.
#
cd $TMPDIR/lib/$PKG_NAME/
mv base/* .
$PKG_RMDIR base

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
NAME: latex/beamer
VERSION: 3.71 2024-01-06
AUTHORS:
	2003-2007 Till Tantau
	2010 Vedran Mileti#
	2011-2015 Vedran Mileti\'c, Joseph Wright
	2019-2024 Joseph Wright, samcarter
LICENCE:
	GPL version 2 or newer
	The LaTeX Project Public License 1.3c
	Free Documentation License
DESCRIPTION:
	This LaTeX package can be used for producing slides. The
	class works in both PostScript and direct PDF output modes,
	using the pgf package (pgf@tex.sh).
DEPENDENCIES:
	fonts/sansmathaccent
	tex/pgf
	tex/stringenc
	latex/extsizes
	latex/geometry
	latex/hyperref
	latex/etoolbox
	latex/translator
	latex/xcolor
KERTEX_VERSION: 0.99.23.0
KXPATH:
	latex beamer;beamer/art;beamer/emulation;
	latex beamer/multimedia;beamer/patch;
	latex beamer/themes/outer;beamer/themes/font;
	latex beamer/themes/color;beamer/themes/inner;
	latex beamer/themes/theme;beamer/themes/theme/compatibility;
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/beamer.zip
END:
END_CID
