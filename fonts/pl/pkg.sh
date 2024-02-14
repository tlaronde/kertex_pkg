#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of the polish extensions to the CM fonts
# to the TeX kernel system: kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2018, 2020, 2024
#   Thierry Laronde <tlaronde@polynum.com>
# $Id: pkg.sh,v 1.9 2024/01/21 14:16:53 tlaronde Exp $
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
	pkg_log "I have added plother.map and pltext.map to"
	pkg_log "$KERTEX_LIBDIR/dvips/dvips.cnf."
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
pkg_log "1. Treating pl-mf (the METAFONT sources fonts; generating)."
pkg_log ""
pkg_log "1.1 Creating the hierarchy and putting non generated files."
pkg_log ""
# Others are created getting.
#
cd $TMPDIR/lib/$PKG_NAME/

for subdir in doc gf pk tfm; do
	mkdir $TMPDIR/lib/$PKG_NAME/$subdir
done

cd $TMPDIR
$PKG_UNZIP pl-mf.zip
rm pl-mf.zip

mv pl-mf*/*.mf $TMPDIR/lib/$PKG_NAME/
mv pl-mf*/README* $TMPDIR/lib/$PKG_NAME/doc

pkg_log ""
pkg_log "1.2 Generating the gf and tfm with METAFONT"
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
	$KERTEX_BINDIR/mf "\\mode=ljfour; scrollmode; input $parm"
done <$parmlist

mv *.tfm $TMPDIR/lib/$PKG_NAME/tfm

pkg_log ""
pkg_log "2. Generating the pk versions."
pkg_log ""

for file in *.*gf; do
	$KERTEX_BINDIR/gftopk $file
	rm $file
done
mv *.*pk $TMPDIR/lib/$PKG_NAME/pk

#
# Cleaning.
#
rm *.log

pkg_log ""
pkg_log "2. Treating plpsfont (the T1 version; no generation)."
pkg_log ""

cd $TMPDIR
$PKG_UNZIP plpsfont.zip
rm plpsfont.zip

pkg_log "1.1 Creating the font hierarchy and putting non generated files."
pkg_log ""
# Others are created getting.
#
cd $TMPDIR/lib/$PKG_NAME/

for subdir in afm enc pfb ; do
	mkdir $TMPDIR/lib/$PKG_NAME/$subdir
done
mv $TMPDIR/plpsfont/fonts/afm/public/pl/*.afm $TMPDIR/lib/$PKG_NAME/afm
mv $TMPDIR/plpsfont/fonts/enc/dvips/pl/*.enc $TMPDIR/lib/$PKG_NAME/enc
mv $TMPDIR/plpsfont/fonts/type1/public/pl/*.pfb $TMPDIR/lib/$PKG_NAME/pfb

mv $TMPDIR/plpsfont/doc/fonts/pl/* doc

# The map will be put with the PS pfb variant. Should be read there
# by dvips(1). For the moment, in the dvips/ hierarchy.
#
mkdir $TMPDIR/lib/dvips
mv $TMPDIR/plpsfont/fonts/map/dvips/pl/*.map $TMPDIR/lib/dvips

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: fonts/pl
DESCRIPTION: polish extensions to the CM fonts
AUTHOR: Bogus\\l{}aw Jackowski, Marek Ry\\'cko
VERSION: 1.09 (pl-mf) and 1.15 (plpsfont)
LICENCE: Public Domain
KERTEX_VERSION: 0.99.22.0
KXPATH:
	fonts pl
DVIPS:
p +plother.map
p +pltext.map
SOURCES:
	LCD / 
	GET /language/polish/pl-mf.zip
	GET plpsfont.zip
END:
END_CID

# 80 + 1 parameters files.
BEGIN_PARM
plb10.mf
plbsy10.mf
plbsy5.mf
plbsy7.mf
plbx10.mf
plbx12.mf
plbx5.mf
plbx6.mf
plbx7.mf
plbx8.mf
plbx9.mf
plbxsl10.mf
plbxti10.mf
plcsc10.mf
pldunh10.mf
plex10.mf
plff10.mf
plfi10.mf
plfib8.mf
plinch.mf
plitt10.mf
plmi10.mf
plmi12.mf
plmi5.mf
plmi6.mf
plmi7.mf
plmi8.mf
plmi9.mf
plmib10.mf
plmib5.mf
plmib7.mf
plr10.mf
plr12.mf
plr17.mf
plr5.mf
plr6.mf
plr7.mf
plr8.mf
plr9.mf
plsl10.mf
plsl12.mf
plsl8.mf
plsl9.mf
plsltt10.mf
plss10.mf
plss12.mf
plss17.mf
plss8.mf
plss9.mf
plssbi10.mf
plssbx10.mf
plssdc10.mf
plssi10.mf
plssi12.mf
plssi17.mf
plssi8.mf
plssi9.mf
plssq8.mf
plssqi8.mf
plsy10.mf
plsy5.mf
plsy6.mf
plsy7.mf
plsy8.mf
plsy9.mf
pltcsc10.mf
pltex10.mf
pltex8.mf
pltex9.mf
plti10.mf
plti12.mf
plti7.mf
plti8.mf
plti9.mf
pltt10.mf
pltt12.mf
pltt8.mf
pltt9.mf
plu10.mf
plvtt10.mf
cmssbi10.mf
END_PARM
