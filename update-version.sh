#!/bin/bash

################################################################################
# Update version number across all your plugin files

# Author: Sudar <http://sudarmuthu.com>
#
# License: Beerware ;)
#
# You should invoke this script from the Plugin directory, but you don't need
# to copy this script to every Plugin directory. You can just have one copy
# somewhere and then invoke it from multiple Plugin directories.
#
# Requires ack-grep and perl
#
################################################################################

# Command line parameters
#       $1 - old version (String to be searched for, Should be escaped)
#       $2 - new version (String to be replaced with)

echo "[Info] Replacing $1 with $2"
echo "[Action] Replacing in all places $1 with $2"
ack --ignore-file=is:package-lock.json --ignore-file=is:readme.txt --ignore-file=is:composer.lock --ignore-file=is:package.json --ignore-dir=languages --ignore-dir=vendor --ignore-dir=assets --ignore-dir=.github --ignore-dir=dist --ignore-dir=.tk -l --print0 "$1" | xargs -0 perl -pi -e "/\@since/ || s/$1/$2/g"
echo "[Action] Replacing in all places Stable tag: $1 with Stable tag: $2"
ack --ignore-file=is:package-lock.json --ignore-file=is:composer.lock --ignore-dir=languages --ignore-dir=vendor --ignore-dir=dist -l --print0 "Stable tag: $1" | xargs -0 perl -pi -e "/\@since/ || s/Stable tag: $1/Stable tag: $2/g"

# See the difference
git diff