#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of Gilles F. Robert's "blackboard style" cm fonts
# to the TeX kernel system: kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2018, 2020, 2024
#   Thierry Laronde <tlaronde@polynum.com>
# $Id: pkg.sh,v 1.9 2024/01/21 14:16:46 tlaronde Exp $
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
	pkg_log "bbmsltt10.mf bbminch.mf bbmtt10.mf bbmvtt10.m not generated"
	pkg_log "due to errors."
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
# We will generate the gf, tfm and pk version instead of copying.
#
pkg_get

pkg_log ""
pkg_log "0. Creating the hierarchy and putting non generated files."
pkg_log ""
for subdir in doc mf gf pk tfm; do
	mkdir $TMPDIR/lib/$PKG_NAME/$subdir
done

# We are in $TMPDIR.
#
$PKG_UNZIP bbm.zip
rm bbm.zip

mv bbm/*.mf  $TMPDIR/lib/$PKG_NAME/mf
mv bbm/README  $TMPDIR/lib/$PKG_NAME/doc

pkg_log ""
pkg_log "1. Generating the gf and tfm with METAFONT"
pkg_log ""

# The parm list is embedded here after exit.
#
parmlist=$TMPDIR/parm.$$
ed $PKG_FQ_SCRIPT <<EOT >$PKG_NULL_FILE 2>&1
/^BEGIN_PARM/+,/^END_PARM/-w $parmlist
q
EOT

KERTEXINPUTS="$TMPDIR/lib/$PKG_NAME;KERTEXSYS"
KERTEXFONTS="$TMPDIR/lib/$PKG_NAME;KERTEXSYS"
export KERTEXINPUTS
export KERTEXFONTS

cd $TMPDIR/lib/$PKG_NAME/gf

while read parm; do
	$KERTEX_BINDIR/mf "\\mode=localfont; scrollmode; input $parm;"
done <$parmlist

mv *.tfm $TMPDIR/lib/$PKG_NAME/tfm

pkg_log ""
pkg_log "2. Generating the pk versions."
pkg_log ""

for file in *.*gf; do
	$KERTEX_BINDIR/gftopk $file
done
mv *.*pk $TMPDIR/lib/$PKG_NAME/pk

#
# Cleaning.
#
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
NAME: fonts/bbm
DESCRIPTION: Gilles F. Robert's "blackboard style" cm fonts
AUTHOR: Gilles Robert
VERSION: 1993-04-13
LICENCE: free unspecified (see README) 
KERTEX_VERSION: 0.99.22.0
KXPATH:
	fonts bbm
SOURCES:
	GET /fonts/cm/bbm.zip
END:
END_CID

# Error: bbmsltt10.mf bbminch.mf bbmtt10.mf bbmvtt10.mf
BEGIN_PARM
bbm10.mf
bbm12.mf
bbm17.mf
bbm5.mf
bbm6.mf
bbm7.mf
bbm8.mf
bbm9.mf
bbmb10.mf
bbmbx10.mf
bbmbx12.mf
bbmbx5.mf
bbmbx6.mf
bbmbx7.mf
bbmbx8.mf
bbmbx9.mf
bbmbxsl10.mf
bbmdunh10.mf
bbmfib8.mf
bbmfxib8.mf
bbmsl10.mf
bbmsl12.mf
bbmsl8.mf
bbmsl9.mf
bbmss10.mf
bbmss12.mf
bbmss17.mf
bbmss8.mf
bbmss9.mf
bbmssbx10.mf
bbmssdc10.mf
bbmssi10.mf
bbmssi12.mf
bbmssi17.mf
bbmssi8.mf
bbmssi9.mf
bbmssq8.mf
bbmssqi8.mf
bbmtt12.mf
bbmtt8.mf
bbmtt9.mf
END_PARM
