#!/bin/bash
set -xve
test -f ${PREFIX}/bin/libgmp-10.dll
test -f ${PREFIX}/lib/libgmp.dll.a 
test -f ${PREFIX}/lib/gmp.lib

exec ./test_unix.sh 
