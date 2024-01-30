#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of Babel core to the TeX/e-TeX engines.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2020, 2024
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
	pkg_log 
	pkg_log "Core Babel has been installed for TeX/e-TeX."
	pkg_log "You can now add language/country specific Babel files."
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

pkg_log "	Correcting dummy babel.log for not asking..."
$PKG_SED -e 's!^\\input docstrip.tex$!&\
\\askforoverwritefalse!'\
	-e 's/\\file{babel.log}/\\file{dummy.log}/' babel.ins >_babel.ins
mv _babel.ins babel.ins

# We have downloaded a docstrip.tex that will be installed in the
# tex/babel directory for use by languages unpacking. dot is in the
# default KERTEX_INPUTS definition.
#
$KERTEX_BINDIR/tex babel.ins

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
NAME: tex/babel
VERSION: 3.50
DEPENDENCIES: tex/docstrip
KERTEX_VERSION: 0.99.22.0
LICENSE: The LaTeX Public License 1.3
KXPATH:
	tex babel
SOURCES:
	LCD HOME/
	GET /macros/latex/required/babel/base/README.md
	GET babel.dtx
	GET babel.ins
	GET babel.pdf
	GET bbcompat.dtx
	GET bbidxglo.dtx
	GET locale.zip
END:
END_CID
