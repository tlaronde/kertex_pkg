#
#$Id: pkg.sh,v 1.7 2024/01/21 14:17:23 tlaronde Exp $
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# sketching the addition of the MetaPost m3D package to the TeX Kernel
# system: kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2017, 2020 Thierry Laronde <tlaronde@polynum.com>
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
	pkg_log ""
	pkg_log "You can try the examples (trials)."
	pkg_log "In a writable directory (cmd prefixed by 'kertex/' on Plan9):"
	pkg_log ""
	pkg_log "	mpost m3Darcade"
	pkg_log "	mpost m3Dchess"
	pkg_log "	mpost m3Dtriceratops"
	pkg_log "	mpost m3Dmolecule"
	pkg_log ""
	pkg_log "And then, the figures being created (ditto):"
	pkg_log ""
	pkg_log "	tex \$KERTEX_LIBDIR/mp/m3D/trials/showcase.tex"
	pkg_log ""
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

# Unpack at TMPDIR and then move the directories content. By rule,
# the manual goes into the doc/ subdir. The other directories are kept
# as is.
#
# We can not pipe uncompression and extraction since Plan9 tar has
# not the same syntax ("-f -" for stdin).
#
gunzip m3D.tar.gz
tar xvf m3D.tar
mkdir $TMPDIR/lib/$PKG_NAME/doc
mkdir $TMPDIR/lib/$PKG_NAME/trials
mkdir $TMPDIR/lib/$PKG_NAME/gallery
mv README $TMPDIR/lib/$PKG_NAME
mv mpinputs/* $TMPDIR/lib/$PKG_NAME
mv manual/* $TMPDIR/lib/$PKG_NAME/doc
mv trials/* $TMPDIR/lib/$PKG_NAME/trials
mv @distrib $TMPDIR/lib/$PKG_NAME/trials
mv gallery/* $TMPDIR/lib/$PKG_NAME/gallery

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: mp/m3D
AUTHOR: Anthony PHAN
LICENCE: LaTeX
VERSION: 
KERTEX_VERSION: 0.99.22.0
KXPATH:
	mp m3D;m3D/trials
SOURCES:
http://downloads.kergis.com/kertex/pkg/src/
	GET /adhoc/mp/m3D.tar.gz
END:
END_CID
