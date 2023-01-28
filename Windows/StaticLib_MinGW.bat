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
echo =================== 2. Build sources into static libraries" ===================
echo ------------------- 2.1. Generate CMake Makefiles -------------------
del "CMakeCache.txt"
cmake -G "MinGW Makefiles" -DwxBUILD_SHARED=OFF -DCMAKE_BUILD_TYPE=Debug
if %errorlevel% neq 0 goto:exit

echo.
echo ------------------- 2.2. Build sources (debug) -------------------
cmake --build .
if %errorlevel% neq 0 goto:exit

echo.
echo ------------------- 2.3. Build sources (release) -------------------
cmake -G "MinGW Makefiles" -DwxBUILD_SHARED=OFF -DwxBUILD_DEMOS=ON -DCMAKE_BUILD_TYPE=Release
cmake --build .
if %errorlevel% neq 0 goto:exit

echo.
echo =================== BUILD SUCCESSFUL! ===================
echo.

:exit
pause