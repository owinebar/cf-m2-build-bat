REM    trampoline_test_bash.bat - Build batch file for "conda build"
REM                               on win-64 trampolining to m2-bash
REM    Copyright 2025 Onnie Lynn Winebarger
REM    This program is free software: you can redistribute it and/or modify
REM    it under the terms of the GNU Affero General Public License as published
REM    by the Free Software Foundation, either version 3 of the License, or
REM    (at your option) any later version.
REM
REM    This program is distributed in the hope that it will be useful,
REM    but WITHOUT ANY WARRANTY; without even the implied warranty of
REM    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM    GNU Affero General Public License for more details.
REM
REM    You should have received a copy of the GNU Affero General Public License
REM    along with this program.  If not, see <https://www.gnu.org/licenses/>.
REM 

set "TEST_SCRIPT=%1"
if "%TEST_SCRIPT%" == "" set "TEST_SCRIPT=./test.sh"


sed -Enf "%~dp0conda_test_env_bat2sh.sed" <conda_test_env_vars.bat >conda_test_env_vars.sh
echo #!/bin/bash >test-win.sh
echo set -x >>test-win.sh
echo cd $(cygpath '%CD%') >>test-win.sh
echo export MSYSTEM=MINGW64 >>test-win.sh
echo . /etc/msystem >>test-win.sh
echo . conda_test_env_vars.sh >>test-win.sh
REM This is such a hack, but installing binaries in $PREFIX/Library/bin is incorrect
REM for MSYS-based shells, as MSYS-2.0.dll will treat it as non-existent when referenced as /bin,
REM and cygpath will translate the explicit full path to /bin
echo mkdir -p ${PREFIX}/Library/mingw64/bin >>test-win.sh
echo cp -f "${PREFIX}/Library/bin"/* "${PREFIX}/Library/mingw64/bin/" >>test-win.sh
REM Use this line for debugging the bash shell invocation
REM echo exec bash -i >>test-win.sh
echo TEST_SCRIPT=%TEST_SCRIPT% >>test-win.sh
echo exec "$(cygpath "${TEST_SCRIPT}")" >>test-win.sh

echo set MSYSTEM=MINGW64 >test-win.bat
echo "%PREFIX%\Library\usr\bin\bash.exe" -lec "$(cygpath '%CD%\test-win.sh')"  >>test-win.bat

REM Have to ensure only one cygwin/MSYS DLL is in use at a time
start /B /W /I cmd /c test-win.bat
