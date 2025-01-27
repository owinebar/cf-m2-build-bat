#!/usr/bin/bash
set -vxe
$PREFIX/bin/emacs --help
$PREFIX/bin/emacsclient --help
$PREFIX/bin/ctags --help 
$PREFIX/bin/ebrowse --help
$PREFIX/bin/etags --help
$PREFIX/bin/emacs -nw -Q --kill --batch
$PREFIX/bin/emacs -Q --kill --batch
# tree-sitter is not found even when it exists on win-64 currently
#$PREFIX/bin/emacs --batch --eval '(unless (treesit-available-p) (kill-emacs 1))'
# json is not found even when it exists on win-64 currently
#$PREFIX/bin/emacs --batch --eval '(unless (json-available-p) (kill-emacs 1))'

