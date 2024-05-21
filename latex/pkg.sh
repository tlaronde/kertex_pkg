#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# sketching the addition of LaTeX to the TeX Kernel system: kerTeX.
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2010-2012, 2016, 2017, 2019--2024
#	Thierry Laronde <tlaronde@polynum.com>
# All rights reserved and absolutely no warranty! Use at your own 
# risks.
#

# SUPPORTED_LANGUAGES must be defined to add languages by their Babel
# name in the format. If not defined, will default to D.E.K. hyphen.tex.
# As well, "english" (not a Babel name) will add normal hyphen.tex
# (Babel has ukenglish and usenglishmax, english being reserved for the
# original version of D.E.K.'s hyphen.tex).
#

# Needed post action (build, apply, remove) routines.
#
pkg_post_build()
{
	return 0 # bash errors on empty function...
}

pkg_post_apply()
{
	for pkg in ams babel cyrillic graphics psnfss tools; do
		if pkg_is_installed latex/$pkg; then
			pkg_log "This LaTeX package now includes $pkg."
			pkg_log "I will then remove the old conflicting one."
			pkg_remove latex/$pkg\
				|| pkg_log "Failed to remove. Please remove obsolete $pkg@latex.sh package."
		fi
		pkg_remove_rcp_obsolete latex/$pkg
	done

	pkg_log 
	pkg_log "You can check the installation by processing ltxcheck."
	pkg_log 
	pkg_log "You can generate a sample by processing sample2e."
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

#==================== CHECKING: Prote is required

command -v $KERTEX_BINDIR/iniprote \
	|| pkg_error "Your kerTeX installation is too old. Update it."
	
#==================== CUSTOM PROCESSING: we are in TMPDIR
#
#
pkg_get

pkg_log "0) Unpacking the base (for docstrip.ins)..."
#
# Unpack the base (that creates a base/, so we move files afterwards).
#
cd $TMPDIR
$PKG_UNZIP base.zip
rm base.zip
cd base
mv *.* $TMPDIR/lib/$PKG_NAME

#
# We start by creating files from the "packed" version distributed.
#
cd $TMPDIR/lib/$PKG_NAME
export KERTEXINPUTS="."
echo '\input docstrip.ins' | $KERTEX_BINDIR/iniprote >$TMPDIR/.log 2>&1
echo '\input unpack.ins' | $KERTEX_BINDIR/iniprote >$TMPDIR/.log 2>&1

pkg_log "1) Unpacking l3kernel..."
$PKG_UNZIP $TMPDIR/l3kernel.zip
rm $TMPDIR/l3kernel.zip
cd l3kernel
KERTEXINPUTS=".;.." # .. for docstrip.tex
echo '\input l3.ins'|$KERTEX_BINDIR/iniprote
cd ..
$PKG_UNZIP $TMPDIR/l3backend.zip
rm $TMPDIR/l3backend.zip
cd l3backend
echo '\input l3backend.ins'|$KERTEX_BINDIR/iniprote
mkdir $TMPDIR/lib/dvips
mv l3backend-dvips.pro $TMPDIR/lib/dvips
cd ..


pkg_log "2) Compiling the LaTeX fonts..."
#
# We could just download the tfm since the T1 version of the files
# are included, by default, in the core kerTeX with the ams fonts.
# But we do it using METAFONT as it should.
#
# These are supposed to build whether as is by variation from the TeX
# provided ones. So adjust KERTEXINPUTS accordingly.
#
KERTEXINPUTS="$KERTEX_LIBDIR/fonts/mf;."
export KERTEXINPUTS

cd $TMPDIR/lib/fonts/latex
mkdir pk
mkdir tfm
cd mf
for parm in *[0-9].mf; do
	$KERTEX_BINDIR/mf "\\mode=ljfour; scrollmode; input $parm"
	parm=${parm%.mf}
	$KERTEX_BINDIR/gftopk $parm.600gf
	rm $parm.600gf # pk is sufficient
	mv $parm.600pk $TMPDIR/lib/fonts/latex/pk
	mv $parm.tfm $TMPDIR/lib/fonts/latex/tfm
done

pkg_log "3) Hyphenation..."

# We generate the full languages specifications to be able to pick-up
# the ones (added by their Babel name) put for hyphenation in the format
#
cd "$TMPDIR"
$PKG_UNZIP hyph-utf8.zip
rm hyph-utf8.zip
mkdir -p "$TMPDIR/lib/$PKG_NAME/hyph-utf8/doc/"
cd "hyph-utf8"

# The doc...
cd "doc/generic/hyph-utf8/"
mv CHANGES HISTORY *.pdf *.tex $TMPDIR/lib/$PKG_NAME/hyph-utf8/doc/

# The patterns, retrieving the specifications by the way...
flang="$TMPDIR/all_languages.dat"
echo "english hyphen.tex" >"$flang" # the default; not Babel name
cd ../../../tex/generic/hyph-utf8/patterns/tex/
for file in hyph-*.tex; do
	# Use only new classiclatin
	test "$file" != "hyph-la-x-classic.ec.tex" || continue
	# -no is not to be input directly: no babelname (see nn and nb).
	test "$file" != "hyph-no.tex" || continue
	babelname=$($PKG_SED -n "s/^.*[ 	]babelname:[ 	]*\([a-z][a-z]*\).*\$/\\1/p" $file)
	# file that should not be input directly should not have babelname.
	test "$babelname" && echo "$babelname load$file" 
done >>"$flang"

mv hyph-*.tex "$TMPDIR/lib/$PKG_NAME/hyph-utf8/"

# Quotes (unused, since only for utf8)...
cd ../quote
mv hyph-quote-*.tex "$TMPDIR/lib/$PKG_NAME/hyph-utf8/"

# tex8bit (unused too)...
cd ../tex-8bit
mv *.tex "$TMPDIR/lib/$PKG_NAME/hyph-utf8/"

# The conversions...
cd ../../conversions
mv conv-utf8-*.tex "$TMPDIR/lib/$PKG_NAME/hyph-utf8/"

# The loaders...
cd ../loadhyph
mv loadhyph-*.tex "$TMPDIR/lib/$PKG_NAME/hyph-utf8/"

# Cleaning
cd "$TMPDIR"
rm -fr hyph-utf8

# Add hyphenation special patterns and exceptions not in the main
# tree.
#
cd "$TMPDIR/lib/$PKG_NAME/hyph-utf8/"
for pkg in bghyphen dehyph-exptl dehyph dkhyphen elhyphen fahyph \
	fihyph glhyph nohyph ruhyphen ukrhyph ushyph; do
	$PKG_UNZIP "$TMPDIR/$pkg.zip"
	rm "$TMPDIR/$pkg.zip"
done

pkg_log "4) Adding the required stuff (zipped bundles)..."

# First, the common pattern. But there are interdependencies between
# amsmath and amscls.
#
KERTEXINPUTS="$TMPDIR/lib/$PKG_NAME;.;../amscls;../amsmath" # for docstrip.tex in latex/

cd $TMPDIR/lib/$PKG_NAME/required
for required in amscls amsmath cyrillic firstaid graphics latexbug psnfss tools; do
	$PKG_UNZIP $required.zip
	rm $required.zip
done

for required in amscls amsmath cyrillic firstaid graphics latexbug psnfss tools; do
	cd $required
	case $required in
		amscls|amsmath) for file in *.ins; do $KERTEX_BINDIR/tex $file; done;;
		cyrillic) $KERTEX_BINDIR/tex cyrlatex.ins;;
		graphics) for file in graphics-drivers.ins graphics.ins; do
			$KERTEX_BINDIR/tex $file
			done;;
		psnfss) $KERTEX_BINDIR/tex psfonts.ins;;
		*) $KERTEX_BINDIR/tex $required.ins;;
	esac
	cd ..
done

#===== AMS
pkg_log '\t4.1) AMS special treatment...'
# AMS adds to bibtex.
#
cd amscls/
mkdir -p $TMPDIR/lib/bibtex/ams/
mv *.bst $TMPDIR/lib/bibtex/ams/

#===== PSNFSS
#
pkg_log '\t4.2) Psnfss special treatment...'
cd ../psnfss

mv *.map $TMPDIR/lib/dvips

mkdir -p $TMPDIR/lib/fonts/psnfss/enc
mv *.enc $TMPDIR/lib/fonts/psnfss/enc

# This is included.
#
for bundle in freenfss lw35nfss; do
	$PKG_UNZIP $bundle.zip
	rm $bundle.zip
	mv $bundle/tex/latex/psnfss/*.fd .
	for dir in "adobe/avantgar" "adobe/bookman" "adobe/courier"\
		"adobe/helvetic" "adobe/ncntrsbk" "adobe/palatino"\
		"adobe/symbol"\
		"adobe/times" "adobe/utopia" "adobe/zapfchan"\
		"adobe/zapfding"\
		"bitstrea/charter"\
		"public/pazo"; do
		mkdir -p $TMPDIR/lib/fonts/$dir/tfm
		mkdir -p $TMPDIR/lib/fonts/$dir/vf
		if test -d "$bundle/fonts/tfm/$dir/"; then
			mv $bundle/fonts/tfm/$dir/*.* $TMPDIR/lib/fonts/$dir/tfm
		fi
		if test -d "$bundle/fonts/vf/$dir/"; then
			mv $bundle/fonts/vf/$dir/*.* $TMPDIR/lib/fonts/$dir/vf
		fi
	done
	rm -fr $bundle
done

pkg_log "5) Adding misc (compat?) used stuff (zipped bundles)..."
#
cd $TMPDIR/lib/$PKG_NAME/pkg-misc
for ctanpkg in auxhook bitset bigintcalc etexcmds gettitlestring \
	hycolor hyperref hypdoc infwarerr intcalc \
	kvsetkeys kvdefinekeys kvoptions letltxmacro \
	pdfescape refcount rerunfilecheck uniquecounter url \
	iftex ltxcmds pdftexcmds; do
	$PKG_UNZIP $ctanpkg.zip
	rm $ctanpkg.zip
	cd $ctanpkg
	case $ctanpkg in
		hyperref) $KERTEX_BINDIR/tex $ctanpkg.ins;;
		iftex|url) true;; # nothing to generate
		*) $KERTEX_BINDIR/tex $ctanpkg.dtx;;
	esac
	for fname in README.md ChangeLog.txt manifest.txt; do
		{ test -f $fname && mv $fname "${ctanpkg}_$fname"; } || true
	done
	for dname in doc; do
		if test -d $dname; then
			cd $dname
			for file in *; do
				mv $file "../${ctanpkg}_$file"
			done
			cd ..
			$PKG_RMDIR $dname
		fi
	done
	mv * ..
	cd ..
	$PKG_RMDIR $ctanpkg
done

pkg_log "6) Generating the LaTeX dump..."
#
cd $TMPDIR/lib/$PKG_NAME

# Edit config for ltxcheck. We do not treat specially the curdir: user
# manipulates his namespace via KERTEXINPUTS environment variable.
#
echo '\def\@currdir{./}' >>texsys.cfg

# Adding the desired languages. See cfgguide.pdf in part; but we use
# in fact hyphen.cfg provided by Babel (in the PATH), that, in turn,
# loads a language.dat that we set here from SUPPORTED_LANGUAGES.
#
# If SUPPORTED_LANGUAGES is not set, the default will load hyphen.tex
# i.e. the plain TeX default one ("english").
#
rm -f language.dat
if test "${SUPPORTED_LANGUAGES:-}"; then
	for lang in $SUPPORTED_LANGUAGES; do
		if test $lang = "norwegian"; then
			lang=bokmal # seems to be the standard norwegian
		fi
		grep "^$lang " "$flang" >>language.dat || {
			$PKG_SED 's/ .*$//' "$flang" >&2
			pkg_error "$lang not found; lang must be a babel name in the list above...\n"
		}
	done
fi

KERTEXFONTS="$TMPDIR/lib/fonts/latex;KERTEXSYS"
export KERTEXFONTS
KERTEXINPUTS=".;l3kernel;required/amscls;required/amsmath;required/cyrillic;required/firstaid;required/graphics;required/psnfss;required/tools;$KERTEX_LIBDIR/tex;hyph-utf8;hyph-utf8/bghyphen;hyph-utf8/dehyph;hyph-utf8/dehyph-exptl;hyph-utf8/dkhyphen;hyph-utf8/elhyphen;hyph-utf8/fahyph;hyph-utf8/fihyph;hyph-utf8/glhyph;hyph-utf8/nohyph;hyph-utf8/ruhyphen;hyph-utf8-ukrhyphi;hyph-utf8/ushyph"
cat <<"EOT" | $KERTEX_BINDIR/iniprote
**\input latex.ltx
\dump
EOT

mkdir $TMPDIR/bin/lib/
mv latex.dgst $TMPDIR/bin/lib/$PKG_NAME.dgst

# XXX One day, the kertex pkg system should be MI: just the dump in
# a MI way, and the link to the engine at install time.
#
cp $KERTEX_BINDIR/virprote $TMPDIR/bin/$PKG_NAME

pkg_log "7) Adding the EC fonts (needed for sample2e and recommended)..."
#
cd $TMPDIR/lib/fonts/ec/

# generate driver files.
# replace '$ MF' by 'mf'.
#
$PKG_SED "s!\$ MF!'$KERTEX_BINDIR/mf'!g" ecstdedt.tex >ecstdedt.tex.new && mv  ecstdedt.tex.new ecstdedt.tex
$PKG_SED "s!\$ MF!'$KERTEX_BINDIR/mf'!g" tcstdedt.tex >tcstdedt.tex.new && mv  tcstdedt.tex.new tcstdedt.tex

# Generation uses plain TeX only. No need to adjust KERTEXINPUTS.
#
unset KERTEXINPUTS
cd mf
$KERTEX_BINDIR/tex ../ecstdedt
$KERTEX_BINDIR/tex ../tcstdedt

# generate tfm and gf files
. ./ecfonts.com
. ./tcfonts.com

# pack the generic font files
for file in *gf; do
	$KERTEX_BINDIR/gftopk $file
	rm $file # Since we have the pk, we don't need the gf anymore.
done

# move the tfm files
mkdir ../tfm
mv *.tfm ../tfm

# move the pk files
mkdir ../pk
mv *pk ../pk/

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: latex
VERSION: 2023-11-01-PL1
KERTEX_VERSION: 0.99.22.0
LICENSE: The LaTeX Project Public License 1.3c
DEPENDENCIES: tex/babel
KXPATH:
	fonts latex;ec; 
	fonts bitstrea/charter
	fonts adobe/avantgar
	fonts adobe/bookman
	fonts adobe/courier
	fonts adobe/helvetic
	fonts adobe/ncntrsbk
	fonts adobe/palatino
	fonts adobe/symbol
	fonts adobe/times
	fonts adobe/utopia
	fonts adobe/zapfchan
	fonts adobe/zapfding
	fonts charter
	fonts fpl
	fonts mathpazo
	fonts psnfss
	fonts public/pazo
	fonts utopia
	latex l3kernel;l3backend;required/tools;required/firstaid;required/graphics;required/graphics-cfg;required/cyrillic;required/cyrillic;required/amscls;required/amsmath;required/latexbug;required/psnfss
	latex pkg-misc
	bibtex ams
DVIPS:
p +charter.map
p +fpls.map
p +pazo.map 
p +psnfss.map
p +utopia.map
NOTES:
	- hyph-utf8 has to be completed with hyphenation patterns found in:
	bghyphen dehyph-exptl dehyph dkhyphen elhyphen fahyph fihyph
	glhyph nohyph ruhyphen ukrhyph ushyph
	that are under LaTeX Public License;	
	- SUPPORTED_LANGUAGES, if defined, is a blanks separated string of
	  Babel names of languages whose hyphenation patterns have to be
	  compiled in. If not defined, D.E.K.''s hyphen.tex with language
	  "english" will be used. "english" can also be used in
	  SUPPORTED_LANGUAGES to get the original D.E.K.''s hyphenation
	  patterns, Babel having "ukenglish" and "usenglishmax";
	- at least line10.tfm, linew10.tfm, lcircle10.tfm and lcirclew10.tfm
		are necessary to be able to dump the format; thus we include
		the latex/fonts;
	- dvips.def is not generated anymore by graphics.ins. So it is
		copied here from contrib/graphics-def;
	- a basic configuration for graphics is needed, David Carlisle''s
		graphics-cfg is included too;
	- amscls/amsthdoc.tex needs url.sty;
	- amscls/thmtest.tex needs amsthm.sty;
	- amsmath/doc/amsldoc needs imakeidx.sty;
	- ltxcheck and sample2e need the EC fonts. Hence they are included
	here.
	- latex-lab (optional) is not included for the moment.

SOURCES:
	GET /macros/latex/required/l3kernel.zip
	GET l3backend.zip
	GET /macros/latex/base.zip 
	GET /language/hyph-utf8.zip
	GET hyphenation/bghyphen.zip
	GET dehyph-exptl.zip
	GET dehyph.zip
	GET dkhyphen.zip
	GET elhyphen.zip
	GET fahyph.zip
	GET fihyph.zip
	GET glhyph.zip
	GET nohyph.zip
	GET ruhyphen.zip
	GET ukrhyph.zip
	GET ushyph.zip
	LCD HOME/
	GET /macros/latex/contrib/graphics-def/dvips.def 
	LCD /lib/fonts/latex/
	GET /fonts/latex/README
	GET /fonts/latex/legal.txt
	LCD mf/
	GET mf/ /\.mf$/
	LCD HOME/
	GET /macros/generic/unicode-data/UnicodeData.txt
	GET CaseFolding.txt
	GET SpecialCasing.txt
	GET GraphemeBreakProperty.txt
	LCD HOME/required/
	GET /macros/latex/required/tools.zip
	GET graphics.zip 
	GET cyrillic.zip 
	GET psnfss.zip
	GET firstaid.zip
	GET latexbug.zip
	GET amscls.zip 
	GET amsmath.zip 
	LCD graphics-cfg/
	GET /macros/latex/contrib/graphics-cfg/ /\.[^.].*$/
	LCD HOME/pkg-misc/
	GET ../auxhook.zip
	GET bigintcalc.zip
	GET bitset.zip
	GET etexcmds.zip
	GET gettitlestring.zip
	GET hycolor.zip
	GET hypdoc.zip
	GET hyperref.zip
	GET infwarerr.zip
	GET intcalc.zip
	GET kvdefinekeys.zip
	GET kvoptions.zip
	GET kvsetkeys.zip
	GET letltxmacro.zip
	GET pdfescape.zip
	GET refcount.zip
	GET rerunfilecheck.zip
	GET uniquecounter.zip
	GET url.zip
	GET /macros/generic/iftex.zip
	GET ltxcmds.zip
	GET pdftexcmds.zip
	LCD /lib/fonts/ec/
	GET /fonts/ec/src/ /.*\.txt$/
	GET ./ /.*\.tex$/
	LCD mf/
	GET ./ /.*\.mf$/
	LCD /lib/fonts/utopia/
	GET /fonts/utopia/LICENSE-utopia.txt
	GET README-utopia.txt
	LCD /lib/fonts/utopia/afm
	GET /fonts/utopia/putb8a.afm
	GET putbi8a.afm
	GET putr8a.afm
	GET putri8a.afm
	LCD /lib/fonts/utopia/pfb
	GET /fonts/utopia/putb8a.pfb
	GET putbi8a.pfb
	GET putr8a.pfb
	GET putri8a.pfb
	LCD /lib/fonts/charter/
	GET /fonts/charter/readme.charter 
	LCD /lib/fonts/charter/afm/
	GET /fonts/charter/bchb8a.afm
	GET bchbi8a.afm
	GET bchr8a.afm
	GET bchri8a.afm
	LCD /lib/fonts/charter/pfb/
	GET /fonts/charter/bchb8a.pfb
	GET bchbi8a.pfb
	GET bchr8a.pfb
	GET bchri8a.pfb
	LCD /lib/fonts/fpl/
	GET /fonts/fpl/COPYING 
	GET /fonts/fpl/README 
	LCD /lib/fonts/fpl/afm/
	GET /fonts/fpl/afm/fplbij8a.afm
	GET fplbj8a.afm
	GET fplrc8a.afm
	GET fplrij8a.afm
	LCD /lib/fonts/fpl/pfb/
	GET /fonts/fpl/type1/fplbij8a.pfb
	GET fplbj8a.pfb
	GET fplrc8a.pfb
	GET fplrij8a.pfb
	LCD /lib/fonts/mathpazo/
	GET /fonts/mathpazo/README 
	GET /fonts/mathpazo/gpl.txt 
	LCD /lib/fonts/mathpazo/afm/
	GET /fonts/mathpazo/afm/fplmb.afm
	GET fplmbb.afm
	GET fplmbi.afm
	GET fplmr.afm
	GET fplmri.afm
	LCD /lib/fonts/mathpazo/pfb/
	GET /fonts/mathpazo/type1/fplmb.pfb
	GET fplmbb.pfb
	GET fplmbi.pfb
	GET fplmr.pfb
	GET fplmri.pfb
END:
END_CID

