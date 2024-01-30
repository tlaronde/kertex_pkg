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
	pkg_log "You can generate the documented source code by running:"
	pkg_log "	latex filecontents.dtx"
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
$PKG_UNZIP filecontents.zip
rm filecontents.zip
cd $TMPDIR/lib/$PKG_NAME/
$KERTEX_BINDIR/latex filecontents.ins

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
NAME: latex/filecontents
VERSION: 1.5a 2023-04-02
LICENCE: LaTeX Project Public Licence 1.3c
KERTEX_VERSION: 0.99.22.0
DESCRIPTION: Extended filecontents and filecontents* environments
KXPATH:
	latex filecontents
SOURCES:
	LCD /lib/latex/ 
	GET /macros/latex/contrib/filecontents.zip
END:
END_CID
