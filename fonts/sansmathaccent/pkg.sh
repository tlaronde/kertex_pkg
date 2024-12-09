#
# This is a strictly POSIX 1003.2 shell (Bourne shell) script 
# for the addition of Ariel Barton's package for correcting accents
# position when using cmssi (with beamer or sfmath).
#
# No shebang, since there is a bootstrapping problem: this script has
# to run on whatever host the kerTeX system runs on.
# It has to be invoked with whatever Bourne shell like interpreter is
# present on the host.
#
# C) 2024
#   Thierry Laronde <tlaronde@polynum.com>
# Version: 1.0
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
# We simply get and put in place while getting.
#
pkg_get

#===== CUSTOM PROCESSING FINISHED
#
# Time to do whether the build or the install.
#
pkg_do_action

# not reached
exit 0

# Since we have exited above, no need to comment out the CID.

BEGIN_CID
NAME: fonts/sansmathaccent
AUTHOR: 2012, 2013, 2020 Ariel Barton 
DESCRIPTION: Ariel Barton's correction of accents positioning when
	using cmssi (with beamer or sfmath).
VERSION: 2020-01-31
LICENCE: The LaTeX Project Public License 1.3
KERTEX_VERSION: 0.99.23.2
KXPATH:
	fonts sansmathaccent
	latex sansmathaccent
DVIPS:
p +sansmathaccent.map
SOURCES:
	LCD /lib/fonts/sansmathaccent/tfm/
	GET /fonts/sansmathaccent/tfm/ /\.tfm$/
	LCD ../vf/
	GET ../vf/ /\.vf$/
	LCD /lib/latex/sansmathaccent/
	GET ../README
	GET ./ /\.tex$/
	GET ./ /\.sty$/
	GET ./ /\.fd$/
	GET ./ /\.pdf$/
	LCD /lib/dvips/
	GET ./ /\.map$/
END:
END_CID
