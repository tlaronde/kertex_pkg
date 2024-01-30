#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of pstricks (base with contrib/pstricks-add) to tex
# and, perhaps, latex (if installed).
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2023--2024
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
$PKG_UNZIP base.zip
rm base.zip
cd base
mkdir -p "$TMPDIR/lib/latex/pstricks/base/"
mv latex/* "$TMPDIR/lib/latex/pstricks/base/"
$PKG_RMDIR latex
mkdir -p "$TMPDIR/lib/dvips/pstricks/base/"
mv dvips/* "$TMPDIR/lib/dvips/pstricks/base/"
$PKG_RMDIR dvips
rm config/* # pstricks.con in generic/ already defaults to dvips
$PKG_RMDIR config
mv generic/* .
$PKG_RMDIR generic

cd "$TMPDIR/lib/$PKG_NAME"
$PKG_UNZIP pstricks-add.zip
rm pstricks-add.zip
mv pstricks-add add
mkdir "$TMPDIR/lib/latex/pstricks/add/"
cd add
mv latex/* "$TMPDIR/lib/latex/pstricks/add/"
$PKG_RMDIR latex
mkdir "$TMPDIR/lib/dvips/pstricks/add/"
mv dvips/* "$TMPDIR/lib/dvips/pstricks/add/"
$PKG_RMDIR dvips
mv tex/* .
$PKG_RMDIR tex

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: tex/pstricks
VERSION: 3.19b 2023-11-06
KERTEX_VERSION: 0.99.22.0
LICENSE: The LaTeX Public License 1.3 or later
KXPATH:
	tex pstricks/base;pstricks/add;
	latex pstricks/base;pstricks/add;
	dvips pstricks/base;pstricks/add;
SOURCES:
	LCD HOME/
	GET /graphics/pstricks/base.zip
	GET contrib/pstricks-add.zip
END:
END_CID
