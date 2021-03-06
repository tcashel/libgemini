cmake_minimum_required(VERSION 3.16)

# project for CMake
project(LibGeminiProject CXX)

message("CMAKE_C_COMPILER " ${CMAKE_C_COMPILER})
message("CMAKE_CXX_COMPILER " ${CMAKE_CXX_COMPILER})

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Use ccache if we have it, this will speed up builds
find_program(CCACHE ccache)
if(CCACHE)
    message(STATUS "ccache is being used!")
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE}")
endif()

set(LIBGEMINI_SOURCE_FILES
    src/main.cpp
)

set(LIFT_BUILD_EXAMPLES OFF CACHE INTERNAL "")
set(LIFT_BUILD_TESTS    OFF CACHE INTERNAL "")
set(LIFT_CODE_COVERAGE  OFF CACHE INTERNAL "")

add_subdirectory(vendor/liblifthttp)
add_subdirectory(vendor/simdjson)
include_directories(SYSTEM PUBLIC vendor/simdjson/include)
include_directories(inc)

add_executable(${PROJECT_NAME} ${LIBGEMINI_SOURCE_FILES})
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)

# setting destination of the build files
set_target_properties(${PROJECT_NAME}
    PROPERTIES
    LINKER_LANGUAGE CXX
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin"
)

target_link_libraries(${PROJECT_NAME} PUBLIC lifthttp)
target_link_libraries(${PROJECT_NAME} PUBLIC simdjson)

if(${CMAKE_CXX_COMPILER_ID} MATCHES "GNU")
    target_compile_options(
        ${PROJECT_NAME} PRIVATE
        -Wall
        -Wextra
        -Weffc++
        -Werror
        -g
        -gdwarf-2
    )
elseif(${CMAKE_CXX_COMPILER_ID} MATCHES "Clang")
    target_compile_options(
        ${PROJECT_NAME} PRIVATE
        -Wall
        -Wextra
        -Weffc++
        #-Werror
        -Weverything
        -Wpedantic
        #-pedantic-errors
        -Wno-c++98-compat
        -Wno-c++98-compat-pedantic
        -Wno-exit-time-destructors
        -Wno-global-constructors
        -Wno-padded
        -Wno-switch-enum
        -Wno-covered-switch-default
        -Wno-disabled-macro-expansion
        -g
        -gdwarf-2
    )
endif()

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    message("${PROJECT_NAME} is building Debug")
    target_compile_options(
        ${PROJECT_NAME} PRIVATE
        -O0
    )

else() # "Release"
    message("${PROJECT_NAME} is building Release")
    target_compile_options(
        ${PROJECT_NAME} PRIVATE
        -O3
    )
endif()