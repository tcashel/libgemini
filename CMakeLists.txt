cmake_minimum_required(VERSION 3.16)

# project for CMake
project(LibGeminiProject CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Use ccache if we have it, this will speed up builds
find_program(CCACHE ccache)
if(CCACHE)
    message(STATUS "ccache is being used!")
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE}")
endif()

# Prepare RapidJSON (RapidJSON is a header-only library)
set(RAPIDJSON_INCLUDE_DIR vendor/rapidjson/include)

set(LIBGEMINI_SOURCE_FILES
    src/main.cpp
)

include_directories(${RAPIDJSON_INCLUDE_DIR})
add_subdirectory(vendor/liblifthttp)

add_executable(${PROJECT_NAME} ${LIBGEMINI_SOURCE_FILES})

target_link_libraries(${PROJECT_NAME} PUBLIC lifthttp)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_20)

set(LIFT_BUILD_EXAMPLES ON CACHE INTERNAL "")
set(LIFT_BUILD_TESTS    ON CACHE INTERNAL "")
set(LIFT_CODE_COVERAGE  OFF CACHE INTERNAL "")

set(RAPIDJSON_BUILD_TESTS    OFF CACHE INTERNAL "")
set(RAPIDJSON_BUILD_DOC      OFF CACHE INTERNAL "")
set(RAPIDJSON_BUILD_EXAMPLES OFF CACHE INTERNAL "")

# GNU compiler options
target_compile_options(
    ${PROJECT_NAME} PRIVATE
    -Wall
    -Wextra
    -Werror
    -Weffc++
    -Wpedantic
    -pedantic-errors
    -Wno-unknown-pragmas
)

# setting destination of the build files
set_target_properties(${PROJECT_NAME}
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin"
)

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    message("${PROJECT_NAME} is building Debug")
    target_compile_options(
        ${PROJECT_NAME} PRIVATE
        -O0
        -g
        -gdwarf-2
    )

else() # "Release"
    message("${PROJECT_NAME} is building Release")
    target_compile_options(
        ${PROJECT_NAME} PRIVATE
        -O3
        -g
        -gdwarf-2
    )
endif()