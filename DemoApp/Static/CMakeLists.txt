cmake_minimum_required(VERSION 3.24.0)
project(TestWxWidgets VERSION 0.1.0)

set(wxWidgets_ROOT_DIR "C:/WxWidgets/wxWidgets")

FIND_PACKAGE(wxWidgets)
include(${wxWidgets_USE_FILE})

file(GLOB project_GLOB
src/*
)

add_executable(TestWxWidgets WIN32 ${project_GLOB})

target_link_libraries(TestWxWidgets ${wxWidgets_LIBRARIES})
target_include_directories(TestWxWidgets PRIVATE ${wxWidgets_INCLUDE_DIRS})