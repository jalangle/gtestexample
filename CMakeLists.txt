cmake_minimum_required(VERSION 3.10)

project("Example Setup")

option(BUILD_TESTS "Build test runner" ON)
option(BUILD_BENCHMARKS "Micro benchmarks" ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(example-library ${CMAKE_CURRENT_SOURCE_DIR}/src/library.cpp)

if (BUILD_TESTS)
    configure_file(cmake/GoogleTest.cmake googletest-download/CMakeLists.txt)
    execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
      RESULT_VARIABLE result
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
    if(result)
      message(FATAL_ERROR "CMake step for googletest failed: ${result}")
    endif()
    execute_process(COMMAND ${CMAKE_COMMAND} --build .
      RESULT_VARIABLE result
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
    if(result)
      message(FATAL_ERROR "Build step for googletest failed: ${result}")
    endif()

    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/googletest-src
                     ${CMAKE_CURRENT_BINARY_DIR}/googletest-build
                     EXCLUDE_FROM_ALL)

    add_executable(example-test test/main.cpp test/test.cpp)
    target_link_libraries(example-test example-library)
    target_link_libraries(example-test gtest_main)
endif()

if (BUILD_BENCHMARKS)
    configure_file(cmake/GoogleBench.cmake googlebench-download/CMakeLists.txt)
    execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
      RESULT_VARIABLE result
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googlebench-download )
    if(result)
      message(FATAL_ERROR "CMake step for googlebench failed: ${result}")
    endif()
    execute_process(COMMAND ${CMAKE_COMMAND} --build .
      RESULT_VARIABLE result
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googlebench-download )
    if(result)
      message(FATAL_ERROR "Build step for googlebench failed: ${result}")
    endif()

    add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/googlebench-src
                     ${CMAKE_CURRENT_BINARY_DIR}/googlebench-build
                     EXCLUDE_FROM_ALL)

    add_executable(example-bench benchmarks/main.cpp)
    target_link_libraries(example-bench benchmark)
    target_link_libraries(example-bench example-library)
endif()
