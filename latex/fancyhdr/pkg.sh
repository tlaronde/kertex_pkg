#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# sketching the addition of LaTeX/fancyhdr to the TeX Kernel system: 
# kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2014 blstuart <blstuart@bellsouth.net>
# C) 2019, 2020, 2024 Thierry Laronde <tlaronde@polynum.com>
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

cd $TMPDIR/tmp
$PKG_UNZIP fancyhdr.zip
rm fancyhdr.zip

cd fancyhdr

$KERTEX_BINDIR/latex fancyhdr.ins

mv *.sty *.dtx *.pdf $TMPDIR/lib/latex/fancyhdr/

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex/fancyhdr
VERSION: 4.1 2022-11-09
LICENCE: LaTeX Project Public Licence 
	http://www.latex-project.org/lppl.txt
KERTEX_VERSION: 0.99.22.0
DESCRIPTION:
	The package provides extensive facilities, both for constructing
	headers and footers, and for controlling their use (for example, at
	times when LaTeX would automatically change the heading style in use).
KXPATH:
	latex fancyhdr
SOURCES:
	LCD /tmp/ 
	GET /macros/latex/contrib/fancyhdr.zip
END:
END_CID
