cmake_minimum_required(VERSION 3.10)

project("Example Setup")

add_subdirectory(gtest)
enable_testing()

include_directories(gtest/googletest/include)

add_compile_options(-std=c++11)
add_executable( runUnitTests main.cc )
target_link_libraries(runUnitTests gtest gtest_main)
add_test( runUnitTests runUnitTests )
