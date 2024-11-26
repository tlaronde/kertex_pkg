#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# adding the Babel esperanto to the kerTeX installation.
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
	if pkg_is_installed latex/esperanto; then
		pkg_remove latex/esperanto
	fi
	pkg_remove_rcp_obsolete latex/esperanto
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
$PKG_UNZIP esperanto.zip
rm esperanto.zip

cd esperanto

pkg_lstree | sed '/\.ins$/!d' | while read package; do
	package=${package#./}
	$PKG_SED -e 's!\\def\\batchfile{'$package'}!\\def\\batchfile{_'$package'}!' \
	-e 's!\\askonceonly!\\askforoverwritefalse!' $package >_$package
	$KERTEX_BINDIR/tex _$package
	rm _$package
	rm _${package%.ins}.log
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
NAME: tex/babel/esperanto
VERSION: 1.4t
LICENCE: The LaTeX Project Public License 1.3
KERTEX_VERSION: 0.99.22.0
DESCRIPTION:
	Babel contrib for esperanto for the LaTeX engine
KXPATH:
	tex babel/esperanto
SOURCES:
	LCD HOME/..
	GET /macros/latex/contrib/babel-contrib/esperanto.zip
END:
END_CID
