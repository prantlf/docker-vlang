#!/bin/sh

set -ex

MAKE_VFLAGS=
PROD_VFLAGS=
TEST_VFLAGS=
# X68=

# TCCARCH=$(uname -m)
# if [ "$TCCARCH" = "x86_64" ]; then
# 	TCBITS=$(getconf LONG_BIT)
# 	if [ "$TCBITS" = "32" ]; then
#     MAKE_VFLAGS="-cc gcc -d use_bundled_libgc -d use_bundled_libatomic -m32"
#     PROD_VFLAGS="-cc gcc -d use_bundled_libgc -d use_bundled_libatomic -m32"
#     # TEST_VFLAGS="-cc tcc -d use_bundled_libgc -d use_bundled_libatomic -m32"
#     # X68=1
# 	fi
# fi

VFLAGS="$MAKE_VFLAGS" make

./v $PROD_VFLAGS -skip-unused -prod -o v cmd/v
./v $PROD_VFLAGS -skip-unused -prod cmd/tools/vup.v
./v $PROD_VFLAGS -skip-unused -prod cmd/tools/vdoctor.v

./v $TEST_VFLAGS cmd/tools/test_if_v_test_system_works.v
./cmd/tools/test_if_v_test_system_works
# # some tests of formatting floating point numbers do not round to one fixes
# # decimal point and some date computations return 3001
# if [ -z "$X68" ]; then
#   ./v $TEST_VFLAGS -exclude @vlib/math/*.c.v test vlib/math/
#   ./v $TEST_VFLAGS test-self vlib
# fi
# ./v $TEST_VFLAGS -skip-unused test vlib/builtin/ vlib/math vlib/flag/ vlib/os/ vlib/strconv/

rm -rf .[!.] .??* *.md D* G* L* M* bench changelogs0.x doc examples make.bat \
  tutorials vc build.sh cmd/tools/test_if_v_test_system_works
./v -version
