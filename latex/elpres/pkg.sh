#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# sketching the addition of LaTeX/elpres to the TeX Kernel system: 
# kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2014 blstuart <blstuart@bellsouth.net>
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

cd $TMPDIR/lib/latex/
$PKG_UNZIP elpres.zip
rm elpres.zip

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex/elpres
VERSION: 1.0.1 2021-08-10
LICENCE: LaTeX Project Public Licence 
KERTEX_VERSION: 0.99.22.0
DESCRIPTION:
	Elpres is a simple class for electronic presentations to be shown on
	screen or a beamer.  Elpres is derived from article.cls and may be
	used with LaTeX or pdfLaTeX.
DVIPS:
@ slide 128mm 96mm
@+ ! %%DocumentPaperSizes: Slide
@+ %%BeginPaperSize: Slide
@+ << /PageSize [363 272] >> setpagedevice
@+ %%EndPaperSize
KXPATH:
	latex elpres
SOURCES:
	LCD HOME/../
	GET /macros/latex/contrib/elpres.zip
END:
END_CID
