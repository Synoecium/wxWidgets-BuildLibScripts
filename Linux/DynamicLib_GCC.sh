#!bin/bash
echo ""
echo "=================== 1. Download latest wxWidgets sources from Github ==================="
git clone --recurse-submodules https://github.com/wxWidgets/wxWidgets.git
if [ $? -ne 0 ]; then
	cd wxWidgets
	git pull
else
	cd wxWidgets
fi


echo ""
echo "=================== 2. Build sources into dynamic libraries ==================="
echo "------------------- 2.1. Generate CMake Makefiles -------------------"
rm -f "CMakeCache.txt"
cmake -G "Unix Makefiles" -DwxBUILD_SHARED=ON -DCMAKE_BUILD_TYPE=Debug

if [ $? -ne 0 ] ; then 
	exit $? 
fi

echo ""
echo "------------------- 2.2. Build sources (debug) -------------------"

cmake --build .
if [ $? -ne 0 ] ; then 
	exit $? 
fi

echo ""
echo "------------------- 2.3. Build sources (release) -------------------"
cmake -G "Unix Makefiles" -DwxBUILD_SHARED=ON -DwxBUILD_DEMOS=ON -DCMAKE_BUILD_TYPE=Release
cmake --build .
if [ $? -ne 0 ] ; then 
	exit $? 
fi

echo ""
echo "=================== BUILD SUCCESSFUL! ==================="
echo ""
