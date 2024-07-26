cmake_minimum_required(VERSION 3.25)
project(QtAndroidTemplate)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/dependencies)
include(get_cpm)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

add_subdirectory(dependencies)
add_subdirectory(src)