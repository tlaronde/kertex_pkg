#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script
# adding the LaTeX lm font package to the TeX Kernel system:
# kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# (C) 2012 Yellow Rabbit <yrabbit@sdf.lonestar.org>
# (simple adaptation for lh of one of Thierry Laronde's scripts)
# C) 2020, 2024
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
#
#XXX should be fixed for kerTeX 1.0 release.
#
! pkg_is_installed latex/lh\
	|| pkg_error "Please remove lh@latex first!"
	

pkg_get

#===== TeX version
#
# unzip
cd $TMPDIR/tmp
$PKG_UNZIP lhfnt35g-source.zip
rm lhfnt35g-source.zip

# generate driver files
cd texmf/source/fonts/lh/tex/
# replace '{MF ' by '{mf '
$PKG_SED -e 's/{MF /{mf /g' \
    -e 's/^\\MakeFileHeadsfalse/\\MakeFileHeadstrue/g' \
    -e 's/\\BatchLine{mf "\\string\\mode=jetiiisi; input #1"}%300/\\BatchLine{mf "\\string\\mode=localfont; input #1"}%600/g' \
    -e 's/^\\doBatchfalse/\\doBatchtrue/g' \
    setter.tex >setter.tex.new && mv setter.tex.new setter.tex


$KERTEX_BINDIR/tex 99allenc


# generate tfm and gf files
cd wrk/lh-t2a/
KERTEXINPUTS="${TMPDIR}/tmp/texmf/fonts/source/lh/base;KERTEXSYS"
export KERTEXINPUTS
. ./labatch.bat

# pack the generic font files
find . -name "*gf" -exec gftopk \{\} \;

# move the tfm files
mkdir -p $TMPDIR/lib/fonts/lh/tfm
mv *.tfm $TMPDIR/lib/fonts/lh/tfm/

# move the pk files
mkdir -p $TMPDIR/lib/fonts/lh/pk
mv *pk $TMPDIR/lib/fonts/lh/pk/

# move the mf files
mkdir -p $TMPDIR/lib/fonts/lh/mf
mv *.mf $TMPDIR/lib/fonts/lh/mf/


#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: fonts/lh
VERSION: 3.5g
LICENCE: LaTeX Project Public Licence
         http://www.latex-project.org/lppl.txt
         either version 1 of the license, or (at your option) any
         later version.
KERTEX_VERSION: 0.99.22.0
KXPATH:
         fonts lh
SOURCES:
	LCD /tmp/
	GET /fonts/cyrillic/lh/lhfnt35g-source.zip
END:
END_CID
