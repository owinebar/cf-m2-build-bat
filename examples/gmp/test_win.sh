#!/bin/bash
test -f ${PREFIX}/bin/libgmp-10.dll || exit 1
test -f ${PREFIX}/lib/libgmp.dll.a || exit 1
test -f ${PREFIX}/lib/gmp.lib || exit 1

exec ./test_unix.sh 
