#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script
# adding the LaTeX koma-script (srcdoc) package to the TeX Kernel system:
# kerTeX.
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
$PKG_UNZIP koma-script.zip
rm koma-script.zip

cd $TMPDIR/lib/$PKG_NAME

# Everything depends on this one, and this one can not be
# unpacked using latex.
#
$KERTEX_BINDIR/etex koma-script-source-doc.dtx

for file in \
  japanlco.dtx scraddr.dtx scrextend.dtx \
  scrjura.dtx scrkernel-addressfiles.dtx scrkernel-basics.dtx \
  scrkernel-bibliography.dtx scrkernel-compatibility.dtx \
  scrkernel-floats.dtx scrkernel-fonts.dtx \
  scrkernel-footnotes.dtx scrkernel-index.dtx scrkernel-language.dtx \
  scrkernel-letterclassoptions.dtx scrkernel-listsof.dtx \
  scrkernel-miscellaneous.dtx scrkernel-notepaper.dtx \
  scrkernel-pagestyles.dtx scrkernel-paragraphs.dtx \
  scrkernel-pseudolength.dtx scrkernel-sections.dtx \
  scrkernel-title.dtx scrkernel-tocstyle.dtx scrkernel-typearea.dtx \
  scrkernel-variables.dtx scrkernel-version.dtx scrlayer.dtx \
  scrlayer-notecolumn.dtx scrlayer-scrpage.dtx scrlfile.dtx \
  scrlfile-hook.dtx scrlfile-patcholdlatex.dtx scrlogo.dtx \
  scrtime.dtx tocbasic.dtx scrjura.dtx scrmain.ins scrstrip.inc \
  scrstrop.inc scrdocstrip.tex; do
	$KERTEX_BINDIR/latex $file
done

# The pdf are already included. Just unpack scrlttr2-examples.dtx and
# let it be.
#
cd doc
$KERTEX_BINDIR/latex scrlttr2-examples.dtx

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex/koma-script
AUTHOR: Markus KOHM
DESCRIPTION:
	KOMA-Script is a versatile bundle of LaTeX2e document
	classes and packages. The classes are designed as replacements
	to the standard LaTeX2e classes. Several features have been
	added to make them more configurable.
VERSION: 3.43 2024/10/24
LICENCE: LPPL 1.3c
DEPENDENCIES:
	tex/stringenc
	latex/l3packages
KERTEX_VERSION: 0.99.23.1
KXPATH:
	latex koma-script
SOURCES:
    LCD HOME/..
	GET /macros/latex/contrib/koma-script.zip
END:
END_CID
