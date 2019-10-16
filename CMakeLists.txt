cmake_minimum_required(VERSION 3.9)

project("Example Setup")

include(CTest)

include(cmake/DownloadProject.cmake)

option(BUILD_TESTS "Build test runner" ON)
option(BUILD_BENCHMARKS "Micro benchmarks" ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)


add_library(example-library ${CMAKE_CURRENT_SOURCE_DIR}/src/library.cpp)

if (BUILD_TESTS)
    download_project(PROJ                googletest
                     GIT_REPOSITORY      https://github.com/google/googletest.git
                     GIT_TAG             master
                     ${UPDATE_DISCONNECTED_IF_AVAILABLE}
    )

    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})

    add_executable(example-test test/main.cpp test/test.cpp)
    target_link_libraries(example-test example-library)
    target_link_libraries(example-test gtest_main)
    add_test(NAME example_test COMMAND example-test)
endif()

if (BUILD_BENCHMARKS)

    option(BENCHMARK_ENABLE_TESTING "" OFF)
    option(BENCHMARK_ENABLE_GTEST_TESTS "" OFF)
    download_project(PROJ                googlebench
                     GIT_REPOSITORY      https://github.com/google/benchmark
                     GIT_TAG             master
                     ${UPDATE_DISCONNECTED_IF_AVAILABLE}
    )

    add_subdirectory(${googlebench_SOURCE_DIR} ${googlebench_BINARY_DIR})

    add_executable(example-bench benchmarks/main.cpp)
    target_link_libraries(example-bench benchmark)
    target_link_libraries(example-bench example-library)
endif()
