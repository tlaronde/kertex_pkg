#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# adding the LaTeX memoir package to the TeX Kernel system: 
# kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2012 Mark van Atten <Mark.vanAtten@univ-paris1.fr>
# C) 2020, 2024 Thierry Laronde <tlaronde@polynum.com>
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
	pkg_log "A brief introduction to all packages of the bundle" 
	pkg_log "is found in ncctools/doc/ncctools.pdf"
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

#===== TeX version
#
# unzip
cd $TMPDIR/lib/$PKG_NAME/.. 
$PKG_UNZIP ncctools.zip
rm ncctools.zip

cd $TMPDIR/lib/$PKG_NAME/source
$KERTEX_BINDIR/latex ncctools.ins
rm *.log

mv *.tex *.sty ..

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex/ncctools
VERSION: 3.5.3 2019-08-03
LICENCE: LaTeX Project Public Licence 
KERTEX_VERSION: 0.99.22.0
DESCRIPTION: A collection of general packages for LaTeX.
KXPATH:
	latex ncctools
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/ncctools.zip
END:
END_CID
