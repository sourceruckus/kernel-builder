#!/bin/sh

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd $srcdir

# only update submodules if we haven't modified any of them
#
# NOTE: Technically, this will attempt to stash/pop local modifications onto
#       the tracked SHA unless we've committed things in the external dirs.
#
if [ -z "$(git diff --submodule --color=never | grep '^  >')" ]; then
    git submodule update --init --recursive || exit 1
fi

autoreconf -v --install || exit 1
cd $ORIGDIR || exit $?

if [ -z "$NOCONFIGURE" ]; then
    $srcdir/configure "$@"
fi
