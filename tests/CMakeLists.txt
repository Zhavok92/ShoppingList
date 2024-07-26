cmake_minimum_required(VERSION 3.25)
project(Tests)

include(FetchContent)

FetchContent_Declare(cpm
    GIT_REPOSITORY https://github.com/cpm-cmake/CPM.cmake.git
    GIT_TAG v0.40.0
)
FetchContent_MakeAvailable(cpm)
list(APPEND CMAKE_MODULE_PATH ${cpm_SOURCE_DIR}/cmake)

include(CPM)

CPMAddPackage(
    NAME catch2
    GITHUB_REPOSITORY catchorg/Catch2
    GIT_TAG v3.6.0 
)
list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/contrib)
include("${Catch2_SOURCE_DIR}/extras/Catch.cmake")

add_subdirectory(unit_tests)