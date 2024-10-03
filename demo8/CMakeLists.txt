# MIT License

# Copyright (c) 2024 CUI Xin

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Minimum CMake version required
cmake_minimum_required (VERSION 2.8)

# Project Info
project(DEMO8)

set (DEMO8_VERSION_MAJOR 1)
set (DEMO8_VERSION_MINOR 0)

set (CMAKE_INCLUDE_CURRENT_DIR ON)

# checking if system support pow function
include (${CMAKE_ROOT}/Modules/CheckFunctionExists.cmake)
check_function_exists (pow HAVE_POW)

# Add a configuration header file to handle CMake settings for source code
configure_file(
    "${PROJECT_SOURCE_DIR}/config.h.in"
    "${PROJECT_BINARY_DIR}/config.h"
)

# whether adding MathFunctions library
if (NOT HAVE_POW)
  include_directories ("${PROJECT_SOURCE_DIR}/math")
  add_subdirectory (math)
  set (EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)
endif (NOT HAVE_POW)

# Find all source files in current folder
# and save the name to DIR_SRCS variable
aux_source_directory(. DIR_SRCS)

# Specifying the build target
add_executable(DEMO8 ${DIR_SRCS})

# add link library
target_link_libraries(DEMO8 ${EXTRA_LIBS})

# Specifying install path
install (TARGETS DEMO8 DESTINATION bin)
install (FILES "${PROJECT_BINARY_DIR}/config.h" DESTINATION include)

# set gdb setting
set(CMAKE_BUILD_TYPE "Debug")
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")

# Build CPack install packages
include (InstallRequiredSystemLibraries)
set (CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set (CPACK_PACKAGE_VERSION_MAJOR "${DEMO8_VERSION_MAJOR}")
set (CPACK_PACKAGE_VERSION_MINOR "${DEMO8_VERSION_MINOR}")
include (CPack)

# start test
enable_testing()

# testing programing run
add_test (test_run DEMO8 5 2)

# testing info 
add_test (test_usage DEMO8)
set_tests_properties (test_usage PROPERTIES PASS_REGULAR_EXPRESSION "Usage: .* base exponent")

# test 5^2
add_test (test_5_2 DEMO8 5 2)
set_tests_properties(test_5_2 PROPERTIES PASS_REGULAR_EXPRESSION "is 25")

# test 10^5
add_test (test_10_5 DEMO8 10 5)
set_tests_properties(test_10_5 PROPERTIES PASS_REGULAR_EXPRESSION "is 100000")

# TEST 2^10
add_test (test_2_10 DEMO8 2 10)
set_tests_properties(test_2_10 PROPERTIES PASS_REGULAR_EXPRESSION "is 1024")

# define MACRO to simply testing
macro (do_test arg1 arg2 result)
    add_test (test_${arg1}_${arg2} DEMO8 ${arg1} ${arg2})
    set_tests_properties (test_${arg1}_${arg2} PROPERTIES PASS_REGULAR_EXPRESSION ${result})
endmacro (do_test)

do_test (5 2 "is 25")
do_test (10 5 "is 100000")
do_test (2 10 "is 1024")

