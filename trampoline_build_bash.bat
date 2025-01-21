REM    trampoline_build_bash.bat - Build batch file for "conda build"
REM                                on win-64 trampolining to m2-bash
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

set BUILD_SCRIPT="%1"
if "%BUILD_SCRIPT%" == "" set "BUILD_SCRIPT=build.sh"

sed -Enf "%~dp0cb_build_env_bat2sh.sed" <build_env_setup.bat >build_env_setup.sh
echo #!/bin/bash >build-win.sh
echo cd $(cygpath '%CD%') >>build-win.sh
echo export MSYSTEM=MINGW64 >>build-win.sh
echo . /etc/msystem >>build-win.sh
echo . build_env_setup.sh >>build-win.sh
REM Use this line for debugging the bash shell invocation
REM echo exec bash -i >>build-win.sh
echo exec "./%BUILD_SCRIPT%" >>build-win.sh

echo set MSYSTEM=MINGW64 >build-win.bat
echo "%BUILD_PREFIX%\Library\usr\bin\bash.exe" -lec "$(cygpath '%CD%\build-win.sh')"  >>build-win.bat

REM Have to ensure only one cygwin/MSYS DLL is in use at a time
REM Use this line for debugging the bash shell invocation
start /B /W /I cmd /c build-win.bat
