#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# adding the LaTeX comment package to the TeX Kernel system: 
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
# The instructions are in the README.
# First unpack using latex facilities.
#
# nothing needed

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
NAME: latex/comment
VERSION: version 3.8, October 1999
LICENCE: GNU GPL version 2
KERTEX_VERSION: 0.99.22.0
KXPATH:
	latex comment
SOURCES:
	LCD HOME/
	GET /macros/latex/contrib/comment/comment.pdf
	GET comment.sty
	GET comment.tex
	GET comm_bug.tex
	GET comm_test.pdf
	GET comm_test.tex
	GET comm_test_ivo.tex
	GET comm_test_l.tex
	GET comment_plain.tex
	GET t1test.pdf
	GET t1test.tex
	GET writeup.pdf
	GET writeup.tex
END:
END_CID
