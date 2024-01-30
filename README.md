# kertex_pkg
Recipes for extensions to the kerTeX TeX typographic system distribution.

kerTeX provides the core (kernel) part of the TeX typographic system:
the engines (in fact, for TeX, now, one: Prote, that is compatible
with TeX, compatible with e-TeX and providing the supplementary
primitives needed by LaTeX): Prote, METAFONT, MetaPost, dvips, BibTeX,
WEB, CWEB, CM and AMS fonts...

Upon this kernel, one can add external packages (like LaTeX).

kerTeX has its own extensions system, meaning that instead of having
to develop a package for every host OS, there is only one "recipe"
to build an extension for a kerTeX host (kerTeX hosted on whatever):
1:N instead of N:N.

kerTeX pkg system is under kertex_T/pkg/ and kertex_T provides also a
script to sketch a (LaTeX contrib macro for now) recipe.

Here are only special recipes developed (the principal being latex to
be found in latex/pkg.sh).

All the recipes are named [<dependency>]/<name>/pkg.sh that gives
<name>[@<dependency>].sh when published. 

