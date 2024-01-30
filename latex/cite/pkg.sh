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
# (simple adaptation for cite of one of Thierry Laronde's scripts)
# C) 2020, 2024 Thierry Laronde <tlaronde@kergis.com>
#	Update for sources served from kergis.com httpd.
# All rights reserved and absolutely no warranty! Use at your own
# risks.
#

# Needed post action (build, apply, remove) routines.
#
pkg_post_build()
{
	return 0 # 
}

pkg_post_apply()
{
	return 0 #
}

pkg_post_remove()
{
	return 0 #
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

cd $TMPDIR/lib/$PKG_NAME/..
$PKG_UNZIP cite.zip
rm cite.zip

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex/cite
VERSION: 5.5
LICENCE: Very simple permissive license in the MIT/BSD style:  They may be freely used, transmitted, reproduced,
 or modified provided that [the copyright and permission] notice is left intact.
KERTEX_VERSION: 0.99.22.0
KXPATH:
	latex cite
SOURCES:
    LCD HOME/..
	GET /macros/latex/contrib/cite.zip
END:
END_CID
