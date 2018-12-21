mkdir build
mkdir build\zstd
mkdir build\zstd\windows-debug
mkdir build\zstd\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DZSTD_MULTITHREAD_SUPPORT=OFF
set FLAGS=%FLAGS% -DZSTD_BUILD_PROGRAMS=OFF
set FLAGS=%FLAGS% -DZSTD_BUILD_SHARED=OFF
REM set FLAGS=%FLAGS% -DZSTD_USE_STATIC_RUNTIME=ON

robocopy zstd-1.3.7 zstdbuild /E /NFL /NDL /NJH /NJS /NP
cd zstdbuild\build\cmake

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% .
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..\..

copy zstdbuild\build\cmake\lib\Debug\zstd_static.lib build\zstd\windows-debug\zstd.lib
copy zstdbuild\build\cmake\lib\libzstd_static.dir\Debug\libzstd_static.pdb build\zstd\windows-debug

copy zstdbuild\build\cmake\lib\Release\zstd_static.lib build\zstd\windows-release\zstd.lib

rmdir /S /Q zstdbuild
