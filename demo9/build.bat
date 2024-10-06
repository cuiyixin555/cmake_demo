::*******************************************************************************
:: MIT License

:: Copyright (c) 2024 CUI Xin

:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files (the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions:

:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.

:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.
::************************************************************************************

@echo off
set config=Release
set msbuild="C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe"
set ProjectName=HelloWorld
set retval=true

:argparse
if not "%1"=="" (
    if "%1"=="help"      (call :help && goto :eof)
    if "%1"=="debug"     (set conf=Debug)
    shift
    goto argparse
)

mkdir %config%
pushd %config%
cmake -DCMAKE_BUILD_TYPE=%config% ..
%msbuild% %ProjectName%".sln" /p:Configuration=%config%
popd %config%
%retval%=false

:help
echo     usage: ./build.bat [debug]
echo.
echo     ./build.bat Release or ./build.bat Debug
echo.
echo     optional flags:
echo         debug    build Debug version driver                (default: Release)
goto :eof

:eof
echo build.bat return value is %retval%