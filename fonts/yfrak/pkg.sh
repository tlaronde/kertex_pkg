#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# automatically generated to add Yannis Haralambous' gothic Fraktur
# fonts to kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2024 Thierry Laronde <tlaronde@polynum.com>
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

#===== Proceeding
#
# unzip
cd $TMPDIR/lib/$PKG_NAME/.. 
$PKG_UNZIP yfrak.zip
rm yfrak.zip
cd $TMPDIR/lib/$PKG_NAME/
mkdir mf
mv *.mf mf
mkdir tfm
mkdir pk
cd tfm
KERTEXINPUTS="..;KERTEXSYS"
export KERTEXINPUTS
mf "\\mode=ljfour; scrollmode; input yfrak"
gftopk yfrak.600gf
mf "\\mode=ljfour; scrollmode; input ysmfrak"
gftopk ysmfrak.600gf
rm *.600gf
mv *.600pk *.log ../pk


#
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
NAME: fonts/yfrak
AUTHOR: Yannis Haralambous
DESCRIPTION: Old German Fraktur font.
	  This original is provided as METAFONT source; an Adobe Type 1
	version is available as part of yfonts-t1.
	  The fonts are encoded somewhat like OT1, but a virtual font,
	that presents the font as if T1-encoded, is available. 
VERSION: 1991-03-22
LICENCE: Public Domain Software
KERTEX_VERSION: 0.99.24.00
KXPATH:
	fonts yfrak
SOURCES:
	LCD HOME/..
	GET /fonts/gothic/yfrak.zip
END:
END_CID
