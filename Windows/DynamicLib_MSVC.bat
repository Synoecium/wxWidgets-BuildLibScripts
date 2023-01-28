echo off
echo.
echo =================== 1. Download latest wxWidgets sources from Github ===================
git clone --recurse-submodules https://github.com/wxWidgets/wxWidgets.git
if %errorlevel% neq 0 (
	cd wxWidgets
	git pull
) else (
	cd wxWidgets
)

echo.
echo =================== 2. Build sources into dynamic libraries" ===================
echo ------------------- 2.1. Generate CMake Makefiles -------------------
del "CMakeCache.txt"
cmake -G "Visual Studio 17 2022" -DwxBUILD_SHARED=ON
if %errorlevel% neq 0 goto:exit

echo.
echo ------------------- 2.2. Build sources (debug) -------------------
cmake --build . --config Debug
if %errorlevel% neq 0 goto:exit

echo.
echo ------------------- 2.3. Build sources (release) -------------------
cmake -G "Visual Studio 17 2022" -DwxBUILD_SHARED=ON -DwxBUILD_DEMOS=ON
cmake --build . --config Release
if %errorlevel% neq 0 goto:exit

echo.
echo =================== BUILD SUCCESSFUL! ===================
echo.

:exit
pause