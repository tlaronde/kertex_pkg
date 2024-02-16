#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# adding of plain AMS-TeX to the TeX Kernel system: kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2012, 2017, 2020--2021, 2024
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
	pkg_log
	pkg_log "This is the final archival distribution of AMS-TeX.  AMS-TeX is no"
	pkg_log "longer supported by the AMS, nor is it used by the AMS publishing"
	pkg_log "program.  The AMS does not recommend creating any new documents using"
	pkg_log "AMS-TeX; this distribution will be left on CTAN to facilitate"
	pkg_log "processing of legacy documents and as a historical record of a"
	pkg_log "pioneering TeX macro collection that played a key role in popularizing"
	pkg_log "TeX and revolutionizing mathematics publishing."
	pkg_log
	pkg_log "You can produce PostScript versions of the documentation"
	pkg_log "by running:"
	pkg_log "	amstex doc/amsguide.tex"
	pkg_log "	amstex doc/joyerr.tex"
	pkg_log
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
# Note: we download directly the TFM. We could generate the fonts with
# the .mf instead.
#
pkg_get

# We retrieved it in a temporary directory, out the future packed
# hirearchy. Unzip and move files to their destination.
#
cd $TMPDIR/tmp
$PKG_UNZIP amstex.zip
rm amstex.zip

# The doc will be put in source (PS can be generated afterwards with
# kerTeX it seems...).
mkdir $TMPDIR/lib/$PKG_NAME/doc
cd $TMPDIR/tmp/amstex/doc
mv * $TMPDIR/lib/$PKG_NAME/doc
cd ..
$PKG_RMDIR doc

# Fix the path for inclusion of amsinst in amsguide. We simply PKG_SED
# and overwrite (avoiding ed(1) because it may not be used in future
# required utilities of pkglib.sh).
#
cd $TMPDIR/lib/$PKG_NAME/doc
$PKG_SED 's@\\input amstinst.tex@\\input doc/amstinst.tex@'\
	amsguide.tex >amsguide.tex.fixed
mv amsguide.tex.fixed amsguide.tex

# The macros.
#
cd $TMPDIR/tmp/amstex
mv * $TMPDIR/lib/$PKG_NAME

#===== e-TeX version
#
# The full instructions to install are in source/amstex/README.
#
cd $TMPDIR/lib/$PKG_NAME
$KERTEX_BINDIR/iniprote '*amstex.ini' >$TMPDIR/.log 2>&1

# Put the dump where TeX (kerTeX) looks for.
#
mkdir $TMPDIR/bin/lib/
mv amstex.dgst $TMPDIR/bin/lib/
mv amstex.log $TMPDIR/bin/lib/

# And name virprote $PKG_NAME so that he loads $PKG_NAME.dgst.
#
cp $KERTEX_BINDIR/virprote $TMPDIR/bin/amstex

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: amstex
VERSION: 2.2 (final; obsolete)
KERTEX_VERSION: 0.99.22.0
DESCRIPTION:
	The plain TeX AMS-TeX. (TeX and e-TeX versions.)
KXPATH:
	tex ../amstex
SOURCES:
	LCD /tmp/
	GET /macros/amstex.zip
END:
END_CID
