cmake_minimum_required(VERSION 2.8.2)

project(googlebench-download NONE)

include(ExternalProject)
ExternalProject_Add(googlebench
  GIT_REPOSITORY    https://github.com/google/benchmark
  GIT_TAG           master
  SOURCE_DIR        "${CMAKE_CURRENT_BINARY_DIR}/googlebench-src"
  BINARY_DIR        "${CMAKE_CURRENT_BINARY_DIR}/googlebench-build"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
)
