#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# sketching the addition of LaTeX/logreq to the TeX Kernel system: 
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
# Note: we use FTP to be able to list the dir, since there is no
# bundle.
#

pkg_get


# nothing else to be done

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
NAME: latex/logreq
VERSION: v 1.0 2010/08/04
LICENCE: LaTeX Project Public Licence  1.3
KERTEX_VERSION: 0.99.22.0
DESCRIPTION:
Support for automation of the LaTeX workflow.
KXPATH:
	latex logreq
SOURCES:
	LCD HOME/
	GET /macros/latex/contrib/logreq/logreq.def
	GET logreq.sty
	LCD /lib/latex/logreq/examples/
	GET /macros/latex/contrib/logreq/examples/01-basic.run.xml
	GET 01-basic.tex
	GET 02-index.run.xml
	GET 02-index.tex
	GET 03-biblatex+bibtex8.run.xml
	GET 03-biblatex+bibtex8.tex
	GET 04-biblatex+bibtex+refsections.run.xml
	GET 04-biblatex+bibtex+refsections.tex
	GET 05-biblatex+biber.run.xml
	GET 05-biblatex+biber.tex
END:
END_CID
