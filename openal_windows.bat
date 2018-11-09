mkdir build
mkdir build\openal
mkdir build\openal\windows-debug
mkdir build\openal\windows-release

set FLAGS=%FLAGS% -DLIBTYPE=STATIC
REM FLAGS=%FLAGS% -DFORCE_STATIC_VCRT=ON
set FLAGS=%FLAGS% -DALSOFT_UTILS=OFF
set FLAGS=%FLAGS% -DALSOFT_EXAMPLES=OFF
set FLAGS=%FLAGS% -DALSOFT_TESTS=OFF
set FLAGS=%FLAGS% -DALSOFT_AMBDEC_PRESETS=OFF

robocopy openal-soft-openal-soft-1.19.1 openalbuild /E /NFL /NDL /NJH /NJS /NP
cd openalbuild

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% .
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release OpenAL.vcxproj

cd ..

cp openalbuild\Debug\OpenAL32.lib build\openal\windows-debug\openal.lib
cp openalbuild\OpenAL.dir\Debug\OpenAL.pdb build\openal\windows-debug\openal.pdb
cp openalbuild\Debug\common.lib build\openal\windows-debug\common.lib
cp openalbuild\Debug\common.pdb build\openal\windows-debug\common.pdb

cp openalbuild\Release\OpenAL32.lib build\openal\windows-release\openal.lib

rmdir /S /Q openalbuild
