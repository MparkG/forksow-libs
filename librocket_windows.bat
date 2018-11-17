mkdir build
mkdir build\librocket
mkdir build\librocket\windows-debug
mkdir build\librocket\windows-release

set CXXFLAGS=/MP /I..\..\Include /DROCKET_STATIC_LIB /EHsc
set DEBUGCXXFLAGS=%CXXFLAGS% /MDd /Z7 /Zo
set RELEASECXXFLAGS=%CXXFLAGS% /MD /O2

robocopy libRocket librocketbuild /E /NFL /NDL /NJH /NJS /NP
cd librocketbuild

cd Source\Core
cl /c %DEBUGCXXFLAGS% *.cpp
cd ..\Controls
cl /c %DEBUGCXXFLAGS% *.cpp
cd ..\..

lib -OUT:rocket.lib Source\Core\*.obj Source\Controls\*.obj

cd ..

copy librocketbuild\rocket.lib build\librocket\windows-debug

rmdir /S /Q librocketbuild

robocopy libRocket librocketbuild /E /NFL /NDL /NJH /NJS /NP
cd librocketbuild

cd Source\Core
cl /c %RELEASECXXFLAGS% *.cpp
cd ..\Controls
cl /c %RELEASECXXFLAGS% *.cpp
cd ..\..

lib -OUT:rocket.lib Source\Core\*.obj Source\Controls\*.obj

cd ..

copy librocketbuild\rocket.lib build\librocket\windows-release

rmdir /S /Q librocketbuild
