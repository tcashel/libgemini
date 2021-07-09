cmake_minimum_required(VERSION 3.16)

# project for CMake
project(LibGeminiProject CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(LIBGEMINI_SOURCE_FILES
    src/main.cpp
)

add_subdirectory(lib/liblifthttp)

add_executable(${PROJECT_NAME} ${LIBGEMINI_SOURCE_FILES})

target_link_libraries(${PROJECT_NAME} PUBLIC lifthttp)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_20)

set(LIFT_BUILD_EXAMPLES ON CACHE INTERNAL "")
set(LIFT_BUILD_TESTS    ON CACHE INTERNAL "")
set(LIFT_CODE_COVERAGE  OFF CACHE INTERNAL "")

# GNU compiler options
target_compile_options(
    ${PROJECT_NAME} PRIVATE
    -Wall -Wextra -Werror -Weffc++ -Wpedantic -pedantic-errors -Wno-unknown-pragmas
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