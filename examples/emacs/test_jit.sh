#!/usr/bin/bash
set -vxe
$PREFIX/bin/emacs --batch --eval '(batch-native-compile t)' $PREFIX/share/emacs/{{ version }}/lisp/calculator.elc  
