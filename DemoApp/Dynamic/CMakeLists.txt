cmake_minimum_required(VERSION 3.24.0)
project(TestWxWidgets VERSION 0.1.0)

set(wxWidgets_ROOT_DIR "C:/WxWidgets/wxWidgets")
set(wxWidgets_LIB_DIR "${wxWidgets_ROOT_DIR}/lib/vc_x64_dll")

FIND_PACKAGE(wxWidgets)
include(${wxWidgets_USE_FILE})

file(GLOB project_GLOB
    src/*
)

add_executable(TestWxWidgets WIN32 ${project_GLOB})

target_link_libraries(TestWxWidgets PRIVATE ${wxWidgets_LIBRARIES})
target_include_directories(TestWxWidgets PRIVATE ${wxWidgets_INCLUDE_DIRS})

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    file(GLOB dlls_GLOB
        ${wxWidgets_LIB_DIR}/*ud*.dll
    )
else()
    file(GLOB dlls_GLOB
        ${wxWidgets_LIB_DIR}/*.dll
    )
    file(GLOB dllsDebug_GLOB
        ${wxWidgets_LIB_DIR}/*ud*.dll
    )
    list(REMOVE_ITEM dlls_GLOB ${dllsDebug_GLOB})
endif()

add_custom_command(TARGET TestWxWidgets POST_BUILD          # Adds a post-build event to MyTest
    COMMAND ${CMAKE_COMMAND} -E copy_if_different           # which executes "cmake - E copy_if_different..."
        ${dlls_GLOB}                                        # <--this is in-file
        $<TARGET_FILE_DIR:TestWxWidgets>)                   # <--this is out-file path
