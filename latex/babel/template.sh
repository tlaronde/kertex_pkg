#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# adding the Babel @@LANGUAGE@@ to the kerTeX LaTeX installation.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2020 Thierry Laronde <tlaronde@polynum.com>
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
	return 0
}

#==================== AUTOMATIC PROCESSING
# First include the pecularities of the TeX kernel system host.
#
. which_kertex

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
$PKG_UNZIP @@LANGUAGE@@.zip
rm @@LANGUAGE@@.zip

cd @@LANGUAGE@@

for package in *.ins; do
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
NAME: latex/@@LANGUAGE@@
VERSION: Babel 3.50 (see dir for language specifics)
LICENCE: The LaTeX Project Public License 1.3
KERTEX_VERSION: 0.99.10.2
DESCRIPTION:
	Babel contrib for @@LANGUAGE@@ for the LaTeX engine
KXPATH:
	latex @@LANGUAGE@@
SOURCES:
http://downloads.kergis.com/kertex/pkg/src/macros/latex/contrib/babel-contrib/
	LCD HOME/..
	GET /@@LANGUAGE@@.zip
SOURCES_FTP:
ftp://anonymous:kertex@ftp.fu-berlin.de/tex/CTAN/macros/latex/contrib/babel-contrib/
	LCD HOME/..
	GET /@@LANGUAGE@@.zip
SOURCES_HTTP:
http://mirrors.ircam.fr/CTAN/macros/latex/contrib/babel-contrib/
	LCD HOME/..
	GET /@@LANGUAGE@@.zip
END:
END_CID
