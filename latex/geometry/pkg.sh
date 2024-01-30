#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script
# adding the LaTeX geometry package to the TeX Kernel system:
# kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# (C) 2012 Yellow Rabbit <yrabbit@sdf.lonestar.org>
# (simple adaptation for geometry of one of Thierry Laronde's scripts)
# (C) 2018, 2020, 2024 Thierry Laronde <tlaronde@polynum.com>
# Modification due to source modification of geometry.ins generation.
#
# All rights reserved and absolutely no warranty! Use at your own
# risks.
#

# Needed post action (build, apply, remove) routines.
#
pkg_post_build()
{
	return 0 # 
}

pkg_post_apply()
{
	return 0 #
}

pkg_post_remove()
{
	return 0 #
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

cd $TMPDIR/lib/$PKG_NAME/..
$PKG_UNZIP geometry.zip
rm geometry.zip
cd $TMPDIR/lib/$PKG_NAME

# Needs latex docstrip.tex.
#
KERTEXINPUTS="$KERTEX_LIBDIR/latex;KERTEXSYS" $KERTEX_BINDIR/tex geometry.dtx

# Geometry: correct dvips driver: only dvips.
#
cat <<"EOF" >patch.sed
/\\RequirePackage{ifpdf}%/d
/\\RequirePackage{ifvtex}%/d
/\\RequirePackage{ifxetex}%/d

/\\def\\Gm@detectdriver{%/ {
:deldef
	N
	/\\fi}% *$/!b deldef
	i\
\\def\\Gm@detectdriver{%\
	\\Gm@setdriver{dvips}%\
  }%
  d
}

/\\ifvtexdvi/,/\\fi/ {
	d
}

/\\if@tempswa *$/,/\\fi *$/ {
	d
}
EOF

mv geometry.sty geometry.sty.orig

$PKG_SED -f patch.sed geometry.sty.orig >geometry.sty

rm geometry.sty.orig
rm patch.sed

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex/geometry
VERSION: 5.9 2020-01-02
AUTHOR: Hideo Umeki and David Carlisle
LICENCE: LaTeX Project Public License version 1.3c
KERTEX_VERSION: 0.99.22.0
KXPATH:
	latex geometry
SOURCES:
    LCD HOME/..
	GET /macros/latex/contrib/geometry.zip
END:
END_CID
