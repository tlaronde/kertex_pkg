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
# (simple adaptation of one of Thierry Laronde's scripts)
# C) 2017, 2020, 2024 Thierry Laronde <tlaronde@polynum.com>
#	2017: Update for requiring e-TeX LaTeX.
#	2020: src served by kergis.com httpd; update.
#	2022-05-18: LaTeX now requires Prote full mode.
#
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

#===== TeX version
#
# unzip
cd ${TMPDIR}/tmp
${PKG_UNZIP} ruhyphen.zip
rm ruhyphen.zip

# generate linux format file for
# english & russian languages
cat <<EOF >language.dat
english hyphen.tex
russian ruhyphen.tex
EOF

cd ${TMPDIR}/tmp
KERTEXFONTS="${KERTEX_LIBDIR}/fonts/latex;KERTEXSYS"
export KERTEXFONTS
KERTEXINPUTS="${TMPDIR}/tmp;${TMPDIR}/tmp/ruhyphen;${KERTEX_LIBDIR}/latex/base;${KERTEX_LIBDIR}/latex;KERTEXSYS"
export KERTEXINPUTS

# LaTeX requires Prote full mode now.
#
cat <<EOT | ${KERTEX_BINDIR}/iniprote
**\input latex.ltx
\dump
EOT

# copy to final place
mv ruhyphen/* ${TMPDIR}/lib/latex/ruhyphen/
mv language.dat ${TMPDIR}/lib/latex/
mkdir -p ${TMPDIR}/bin/lib/
mv latex.dgst ${TMPDIR}/bin/lib/

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex/ruhyphen
VERSION: 1.6
LICENCE: LaTeX Project Public Licence
KERTEX_VERSION: 0.99.22.0
KXPATH:
         latex ruhyphen
SOURCES:
	LCD /tmp/ 
	GET /language/hyphenation/ruhyphen.zip
END:
END_CID
