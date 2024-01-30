#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# adding the Babel ukrainian to the kerTeX installation.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2020, 2024
#   Thierry Laronde <tlaronde@polynum.com>
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
	if pkg_is_installed latex/ukrainian; then
		pkg_remove latex/ukrainian
	fi
	pkg_remove_rcp_obsolete latex/ukrainian
	return 0 # bash errors on empty function...
}

pkg_post_remove()
{
	return 0
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

pkg_get

# Unzipping and docstripping. We do the minimal.
#
cd $TMPDIR/lib/$PKG_NAME/..
$PKG_UNZIP ukrainian.zip
rm ukrainian.zip

cd ukrainian

pkg_lstree | sed 's/\.ins$/!d' | while read package; do
	$PKG_SED -e 's!\\askonceonly!\\askforoverwritefalse!' $package >_$package
	mv _$package $package
	$KERTEX_BINDIR/tex $package
	rm ${package%.ins}.log
done


#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: tex/babel/ukrainian
VERSION: 1.4e 2020-10-14
LICENCE: The LaTeX Project Public License 1.3
KERTEX_VERSION: 0.99.22.0
DESCRIPTION:
	Babel contrib for ukrainian for the LaTeX engine
KXPATH:
	tex babel/ukrainian
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/babel-contrib/ukrainian.zip
END:
END_CID
