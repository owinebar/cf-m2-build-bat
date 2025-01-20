# cf-m2-build-bat
Scripts for launching m2-bash scripts from conda-build in windows.

Conda's shell interface is designed with an expectation that
having multiple copies of a shared library in the path is expected
to not cause program failure.  The cygwin posix emulation library
used by MSYS2 is almost guaranteed to fail in mysterious ways
if more than one copy is added to the path before a msys-linked
executable launches another msys-linked executable.

This situation causes problems in conda build if one attempts to
simply execute a bash script from a recipe using m2-bash.
These scripts arrange for the bash script to be launched by
trampolining the bash invocation so no traces of the msys library
in the system conda environment (running the build) are
on the path when the bash executable from the "build" environment
is launched to run "build.sh" from the recipe directory.

See examples directory for batch files to use in your conda recipe.
