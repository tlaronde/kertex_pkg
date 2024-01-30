#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of docstrip for all the kerTeX engines.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2024
#	Thierry Laronde <tlaronde@polynum.com>
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
	return 0 # compound cmd can not be empty
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

cd lib/$PKG_NAME

# Avoid blocking because the file already exists in the kerTeX
# hierarchy: move it temporarily and adjust KERTEXINPUTS.
#
mv docstrip.ins ..
export KERTEXINPUTS="."

echo '\input ../docstrip.ins' | $KERTEX_BINDIR/iniprote >$TMPDIR/.log 2>&1
mv ../docstrip.ins .

rm *.log

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: tex/docstrip
VERSION: v2.6b
KERTEX_VERSION: 0.99.22.0
LICENSE: The LaTeX Public License 1.3c
KXPATH:
	tex docstrip
SOURCES:
	LCD HOME/
	GET /macros/latex/base/ /^docstrip\..*$/
	GET doc.dtx
	GET ltxdoc.dtx
END:
END_CID
